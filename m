Return-Path: <pbrobinson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <115EE599-9710-437B-9AA8-C4CD8360EF3F@holtmann.org>
References: <BAA83E9E-B9BF-48AD-9955-20B599AFA52C@holtmann.org>
 <CALeDE9PaZvfEwSBOuELNbJxBjR3DfWj61rEBMhYTAF6DJd+bcA@mail.gmail.com>
 <00A3687E-050A-469F-98B0-C42F872EFE1C@holtmann.org> <CALeDE9Mn9KdvJ7kFK9=86FswmckabFLWryDHkmujsDh9Xow1iQ@mail.gmail.com>
 <115EE599-9710-437B-9AA8-C4CD8360EF3F@holtmann.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 19 Sep 2017 10:49:11 +0100
Message-ID: <CALeDE9NW+4xkGCD5kKsN-41ctPJ6PNp63jQ61Q7dUQMALG3Ojg@mail.gmail.com>
Subject: Re: Fedora 27 kernel and RPi3 Bluetooth oops
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, Loic Poulain <loic.poulain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 19, 2017 at 10:44 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Peter,
>
>>>>> the latest Fedora 27 kernel which has all the RPi3 patches applied do=
esn=E2=80=99t actually work. It provides this backlog.
>>>>>
>>>>> [  229.162921] CPU: 1 PID: 582 Comm: kworker/u9:1 Not tainted 4.13.2-=
300.fc27.armv7hl #1
>>>>> [  229.171285] Hardware name: Generic DT based system
>>>>> [  229.176774] Workqueue: hci0 hci_cmd_work [bluetooth]
>>>>> [  229.176774] Workqueue: hci0 hci_cmd_work [bluetooth]
>>>>> [  229.182117] [<c0312af4>] (unwind_backtrace) from [<c030d264>] (sho=
w_stack+0x18/0x1c)
>>>>> [  229.190374] [<c030d264>] (show_stack) from [<c0b66174>] (dump_stac=
k+0xa0/0xd8)
>>>>> [  229.198122] [<c0b66174>] (dump_stack) from [<c03aeaec>] (register_=
lock_class+0x298/0x514)
>>>>> [  229.206835] [<c03aeaec>] (register_lock_class) from [<c03b1f9c>] (=
__lock_acquire+0xe4/0x1608)
>>>>> [  229.215952] [<c03b1f9c>] (__lock_acquire) from [<c03b3fd0>] (lock_=
acquire+0x280/0x2dc)
>>>>> [  229.224386] [<c03b3fd0>] (lock_acquire) from [<c0b80ba4>] (_raw_re=
ad_lock+0x4c/0x5c)
>>>>> [  229.232740] [<c0b80ba4>] (_raw_read_lock) from [<bf47903c>] (hci_u=
art_tx_wakeup+0x1c/0x98 [hci_uart])
>>>>> [  229.242725] [<bf47903c>] (hci_uart_tx_wakeup [hci_uart]) from [<bf=
47a0e0>] (hci_uart_send_frame+0x54/0x6c [hci_uart])
>>>>> [  229.254485] [<bf47a0e0>] (hci_uart_send_frame [hci_uart]) from [<b=
f3cb260>] (hci_send_frame+0xc8/0xf4 [bluetooth])
>>>>> [  229.266157] [<bf3cb260>] (hci_send_frame [bluetooth]) from [<bf3cb=
334>] (hci_cmd_work+0xa8/0x124 [bluetooth])
>>>>> [  229.277005] [<bf3cb334>] (hci_cmd_work [bluetooth]) from [<c036f15=
4>] (process_one_work+0x43c/0x83c)
>>>>> [  229.286689] [<c036f154>] (process_one_work) from [<c0370934>] (wor=
ker_thread+0x290/0x40c)
>>>>> [  229.295355] [<c0370934>] (worker_thread) from [<c0376784>] (kthrea=
d+0x14c/0x168)
>>>>> [  229.303195] [<c0376784>] (kthread) from [<c03080d0>] (ret_from_for=
k+0x14/0x24)
>>>>>
>>>>> It results in the first HCI command going through and then every othe=
r failing.
>>>>>
>>>>> =3D Index Info: 00:00:00:00:00:00 (Broadcom Corporation)
>>>>> < HCI Command: Broadcom Update UART Baud Rate (0x3f|0x0018) plen 6
>>>>>       Encoded baud rate: Not used (0x0000)
>>>>>       Explicit baud rate: 2000000 Mbps
>>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>>     Broadcom Update UART Baud Rate (0x3f|0x0018) ncmd 1
>>>>>       Status: Success (0x00)
>>>>> < HCI Command: Reset (0x03|0x0003) plen 0
>>>>>
>>>>> The HCI Reset command actually times out.
>>>>>
>>>>> [  231.349802] Bluetooth: hci0 command 0x0c03 tx timeout
>>>>>
>>>>> What we really need is some kernel specific debug tracing when driver=
 change baud rate etc. to show up in btmon. Drivers need the capability to =
insert HCI transport level specifics into monitoring interface.
>>>>
>>>> Thanks for noticing this, I've have that exact backlog sitting there
>>>> to send out but I'd just not got to it yet, let me know if there's
>>>> anything that needs tweaking on the Fedora side or patch.
>>>
>>> does it actually work for you? I didn=E2=80=99t get it running with the=
 F27 kernel. I had issues with the initial baud rate using btattach in some=
 cases. Does this go away if you use 115200 as max baud rate?
>>
>> No, not yet, I got to the point it would see an interface but that
>> didn't have a MAC address, the patch series has also done something
>> weird with serial consoles that I need to debug. I was wondering if it
>> still needs the newer firmware rev that various distros have pulled
>> in.
>
> is that the AA:AA:AA.. address? If so, we really need to blacklist that o=
ne and mark it with quirk for invalid BD_ADDR. However I am not even gettin=
g that far since the command above is the first command send to the hardwar=
e.

No, it's all zeros, I'll try and spend some time on it this afternoon
to reproduce what I was getting.

Peter
