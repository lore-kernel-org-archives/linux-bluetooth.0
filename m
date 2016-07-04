Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Configure supervision timeout
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+ZaN3-R3nC_NLyeio1RO0zqC80f1EQSBgnzCiaGsqLsOModDg@mail.gmail.com>
Date: Mon, 4 Jul 2016 19:33:19 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <619B9A32-0666-4DC4-8B87-ACBBB30340C5@holtmann.org>
References: <CA+ZaN38pJ-2FM9t8c+sOT+ViXvYA79YgUe=ispYKVQwZiQW0ZQ@mail.gmail.com> <370D4E27-437D-4AFC-A463-B4AB8599CEB5@holtmann.org> <CA+ZaN3-R3nC_NLyeio1RO0zqC80f1EQSBgnzCiaGsqLsOModDg@mail.gmail.com>
To: Seulki Shin <sskcorea@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Seulki,

> Thanks a lot for sharing valuable information.
> 
> On Tue, Jun 28, 2016 at 11:36 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Seulki,
>> 
>>> Recently, I have noticed supervision timeout is not enough to pair devices.
>>> 
>>> How can I configure supervision timeout? Is there any configuration file?
>>> 
>>> First, I have checked "main.conf" but I couldn't find any related properties.
>>> I also found /sys/kernel/debug/bluetooth/hci0 has a bunch of system settings.
>>> But I am not sure editing those files is a right approach.
>> 
>> the supervision timeout will trigger if the baseband will not even ack packets. A longer timeout is most likely not going to help you either to pair. Why do you think it would?
>> 
>> Can you provide btmon traces to see why a disconnect is happening?
>> 
>> Regards
>> 
>> Marcel
>> 
> 
> 1. I thought Supervision timeout was setting up too short like below. (420msec)
> 
> < HCI Command: LE Create Connection (0x08|0x000d) plen 25    [hci0] 1360.262067
>        Scan interval: 60.000 msec (0x0060)
>        Scan window: 30.000 msec (0x0030)
>        Filter policy: White list is not used (0x00)
>        Peer address type: Public (0x00)
>        Peer address: 00:22:D0:8D:22:6D (Polar Electro Oy)
>        Own address type: Public (0x00)
>        Min connection interval: 50.00 msec (0x0028)
>        Max connection interval: 70.00 msec (0x0038)
>        Connection latency: 0x0000
>        Supervision timeout: 420 msec (0x002a)
>        Min connection length: 0.000 msec (0x0000)
>        Max connection length: 0.000 msec (0x0000)
> 
> 2. I found Attribute Not Found error message which had not been noticed before.
> 
> < ACL Data TX: Handle 128 flags 0x00 dlen 11                 [hci0] 1363.521878
>      ATT: Read By Type Request (0x08) len 6
>        Handle range: 0x000e-0x000f
>        Attribute type: Characteristic (0x2803)
>> HCI Event: Number of Completed Packets (0x13) plen 5       [hci0] 1363.591184
>        Num handles: 1
>        Handle: 128
>        Count: 1
>> ACL Data RX: Handle 128 flags 0x02 dlen 9                  [hci0] 1363.660998
>      ATT: Error Response (0x01) len 4
>        Read By Type Request (0x08)
>        Handle: 0x000e
>        Error: Attribute Not Found (0x0a)
> < ACL Data TX: Handle 128 flags 0x00 dlen 9                  [hci0] 1363.661926
>      ATT: Find Information Request (0x04) len 4
>        Handle range: 0x000f-0x000f
>> HCI Event: Number of Completed Packets (0x13) plen 5       [hci0] 1363.730944
>        Num handles: 1
>        Handle: 128
>        Count: 1
> 
> 3. Because of Connection Timeout message, I suspected supervision timeout.
> 
>> HCI Event: Disconnect Complete (0x05) plen 4               [hci0] 1364.131002
>        Status: Success (0x00)
>        Handle: 128
>        Reason: Connection Timeout (0x08)
> @ Device Disconnected: 00:22:D0:8D:22:6D (1) reason 1

this reason is odd. However I highly doubt that it is because of the link supervision timeout. If so, then something else is going really wrong. Check the messages from SMP on what is going on. Meaning, does it actually try to pair or is the remote stack crashing somehow.

Regards

Marcel

