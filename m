Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD0=r8yi3ikUWu50YfuYP_ORuYK4LFKiEmkKjK5T9WpC37yGSQ@mail.gmail.com>
References: <CAD0=r8zhd6g4eNvdLW6K0sQ99qHAkv5dhm42G9fOqoB2OEY6BA@mail.gmail.com>
	<B9062355-3892-4C8B-AEB8-60A5999CDF99@holtmann.org>
	<CAD0=r8yi3ikUWu50YfuYP_ORuYK4LFKiEmkKjK5T9WpC37yGSQ@mail.gmail.com>
Date: Sat, 31 Oct 2015 23:51:41 -0700
Message-ID: <CAD0=r8wH-P9=gbW4616=itWp4p+AZ290nfpn9cQmJ0XZ3932pA@mail.gmail.com>
Subject: Re: [RFC] Fix scan enable/disable kernel issue for opening socket
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 30, 2015 at 11:51 PM, Jakub Pawlowski <jpawlowski@google.com> w=
rote:
> Hi Marcel,
>
> On Fri, Oct 30, 2015 at 8:56 PM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
>> Hi Jakub,
>>
>>> Issue (on all kernels, including bluetooth-next and latest 4.3 kernel):
>>> 1. in bluetoothd pair to two BLE devices using random address
>>> (AA:BB:CC:DD:EE:FF and FF:EE:DD:CC:BB:AA), that don't use autoconnect.
>>> 2. Make sure all those devices don't advertise.
>>> 3. call Device1.Connect() on both devices at same time, with scan
>>> initially disabled.
>>> 4. Second request will fail right away, instead of timeout in 45
>>> seconds (if it doesn't fail repeat, it's a race condition and happens
>>> once every time, trying with more, i.e. 5 devices at same time gives
>>> bigger change).
>>>
>>> When calling Device1.Connect() twice, bluetoothd will try to open two
>>> sockets, each to different random address device.
>>> 1 Inside kernel, for first socket, scan state is checked,and
>>> HCI_OP_SET_SCAN_ENABLE is scheduled, but not yet executed.
>>> 2. Same happens for second socket - current scan state is checked, and
>>> HCI_OP_SET_SCAN_ENABLE is scheduled.
>>> 3. Now both HCI_OP_SET_SCAN_ENABLE are executed, second will fail,
>>> because first one already enabled scan.
>>
>> I think that is the fundamental problem here. The state machine is bogus=
. I said this many time before, in general the scanning needs to be disable=
d first, whitelist re-programmed and then scanning resumed. The fact that a=
n L2CAP connect() for ATT might be triggered at the same time is really not=
 any reason to not have a proper state machine behind this.
>>
>
> The state machine is good, it properly checks all conditions and
> schedule commands that are correct at THAT time, but they're being
> send to controller later, at different moment in time, at which they
> might no longer be correct, because of other commands that were
> executed in mean time.
>
>>> To solve this kind of issues, I want to propose adding inside kernel
>>> virtual HCI commands, that might be scheduled in hci_request. Virtual
>>> HCI command will be able to do some very basic check (i.e. check scan
>>> state) and might cause real HCI command to be issued.
>>>
>>> Commands I'd like to add:
>>> VIRT_HCI_SCAN_DISABLE_START - check scan state, remember it, and send
>>> HCI_OP_SET_SCAN_ENABLE(enable=3Dfalse) if it was enabled
>>> VIRT_HCI_SCAN_DISABLE_STOP - bring scan state back to state remembered
>>> in VIRT_HCI_SCAN_DISABLE_START
>>> Those commands must be both scheduled in hci_request, having only one
>>> of them in hci_request would be error.
>>>
>>> VIRT_HCI_SCAN_ENABLE - this command will check current scan state, and
>>> send HCI_OP_SET_SCAN_ENABLE(enable=3Dtrue) if scan was disabled
>>> VIRT_HCI_SCAN_DISABLE - this command will check current scan state,
>>> and send HCI_OP_SET_SCAN_ENABLE(enable=3Dfalse) if scan was enabled
>>
>> This approach does not sound right at all. And honestly I do not see a n=
eed for adding such a complex overhead. It is like fixing symptoms. What we=
 need to fix is the root cause.
>
> So after all playing I've done with that right now, only one command
> was needed, HCI_OP_VIRT_LE_SCAN_DISABLED - it solves all problems so
> far.
>
>>
>> And what I like to see is that we actually have mgmt-tester and l2cap-te=
ster test cases first that expose this issue. Then we can ensure that we ne=
ver break this behavior anymore.
>
> I'll add mgmt-tester test case for that. Going through it will explain
> the problem much better.
> Hope that when going through it you'll either get convinced that it's
> really needed, or proof me wrong.

So way to reproduce the problem is like that:

tools/l2test -V le_public -m 11:22:33:44:55:66 22:33:44:55:66:77

It'll try to add to white list during scanning, which will result in
"Command Disallowed"

> HCI Event: Command Complete (0x0e) plen 4                          [hci0]=
 57.987306
      LE Add Device To White List (0x08|0x0011) ncmd 1
        Status: Command Disallowed (0x0c)

here are full logs from executing at my machine: ix.io/lKo

I tried to write a test case for that, but when running against vhci I
was unable to reproduce, will work more on that.

Here's explanation why this fail:

connection to 11:22:33:44:55:66 - lines starting with ***
connection to 11:22:33:44:55:66 - lines starting with &&&

Initially scan, and background scan is off.
*** l2cap_chan_connect: locks hdev, and call hci_connect_le_scan,
which call hci_update_background_scan
*** hci_update_background_scan check scan state (scan is off) so scan
disabling is not scheduled
*** schedule ADD TO WHITELIST in req1
*** schedule SET SCAN PARAMS in req1
*** schedule SET_SCAN_ENABLE in req1
*** schedule req1 for execution
*** unlocks hdev in l2cap_chan_connect

&&& l2cap_chan_connect: locks hdev, and call hci_connect_le_scan,
which call hci_update_background_scan
&&& hci_update_background_scan check scan state (scan is off) so scan
disabling is not scheduled
&&& schedule ADD TO WHITELIST in req2
&&& schedule SET SCAN PARAMS in req2
&&& schedule SET_SCAN_ENABLE in req2
&&& schedule req2 for execution
&&& unlocks hdev in l2cap_chan_connect

*** req1 is succesfully executed, leaves controller scanning
&&& req2 is starting execution (it assumed scan is off during
scheduling), first command - ADD TO WHITELIST fails to be properly
executed


does this make more sense now ? If my solution with "virtual" command
is wrong, how should I fix that ?
It's not only two "connect" commands interfering with each other, it
can be "connect" and some mgmt command that is trying to update
background scan, like "add device".

Jakub

>
> Jakub
>
>>
>> Regards
>>
>> Marcel
>>
