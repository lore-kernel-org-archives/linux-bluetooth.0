Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZL-+VJ0vkbM42Ea62FjuHATnorN6X15jZ1hOdkVC9zu+A@mail.gmail.com>
References: <CADEbe8No6u7Bw3scdyZqApxx9JUNxYrEOGxGJ_2gnFGNpvJ4Xg@mail.gmail.com>
	<CABBYNZL-+VJ0vkbM42Ea62FjuHATnorN6X15jZ1hOdkVC9zu+A@mail.gmail.com>
Date: Thu, 19 May 2016 09:45:41 -0700
Message-ID: <CADEbe8ObHyjL0ythdnkRDyYDLAxgZmC3bFSDqVKo_1ywpZ6zJQ@mail.gmail.com>
Subject: Re: Create Connection Cancel after 2 seconds
From: Aaron Okano <aaron@thetileapp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, May 19, 2016 at 6:40 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Aaron,
>
> On Thu, May 19, 2016 at 1:55 AM, Aaron Okano <aaron@thetileapp.com> wrote:
>> Hello all!
>>
>> I am using a Raspberry Pi 3 to scan for and connect to BLE devices
>> using the BlueZ DBus API. However, I frequently receive the error:
>>
>>     GDBus.Error:org.bluez.Error.Failed: Software caused connection abort
>>
>> This appears to be because the connection request is cancelled after 2
>> seconds. Below is the relevant btmon dump:
>>
>> < HCI Command: LE Create Connection (0x08|0x000d) plen 25      [hci0] 58.198376
>>         Scan interval: 60.000 msec (0x0060)
>>         Scan window: 60.000 msec (0x0060)
>>         Filter policy: White list is not used (0x00)
>>         Peer address type: Random (0x01)
>>         Peer address: E3:2E:9A:D6:29:93 (Static)
>>         Own address type: Public (0x00)
>>         Min connection interval: 50.00 msec (0x0028)
>>         Max connection interval: 70.00 msec (0x0038)
>>         Connection latency: 0x0000
>>         Supervision timeout: 420 msec (0x002a)
>>         Min connection length: 0.000 msec (0x0000)
>>         Max connection length: 0.000 msec (0x0000)
>>> HCI Event: Command Status (0x0f) plen 4                      [hci0] 58.199341
>>       LE Create Connection (0x08|0x000d) ncmd 1
>>         Status: Success (0x00)
>> < HCI Command: LE Create Connection Ca.. (0x08|0x000e) plen 0  [hci0] 60.198208
>>> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 60.239715
>>       LE Create Connection Cancel (0x08|0x000e) ncmd 1
>>         Status: Success (0x00)
>>> HCI Event: LE Meta Event (0x3e) plen 19                      [hci0] 60.239957
>>       LE Connection Complete (0x01)
>>         Status: Unknown Connection Identifier (0x02)
>>         Handle: 64
>>         Role: Master (0x00)
>>         Peer address type: Random (0x01)
>>         Peer address: E3:2E:9A:D6:29:93 (Static)
>>         Connection interval: 67.50 msec (0x0036)
>>         Connection latency: 0.00 msec (0x0000)
>>         Supervision timeout: 420 msec (0x002a)
>>         Master clock accuracy: 0x00
>> @ Connect Failed: E3:2E:9A:D6:29:93 (2) status 0x02
>>
>>
>> It seems that this is expected behavior:
>> http://marc.info/?l=linux-bluetooth&m=144830298701744&w=2
>>
>> It is possible to decrease the probability of the error by making the
>> advertising interval of the device smaller, but I would prefer a fix
>> that can be implemented on the Raspberry Pi instead. Is it possible to
>> adjust the 2 second parameter? If not, are there any workarounds that
>> can mitigate the connection delays caused by the error? I am currently
>> re-issuing the connection request when I receive the error, but it
>> takes much more than 2 seconds for the error to be received, and also
>> it often takes several connection attempts before one is successful.
>
> 2 seconds is quite a big window to connect and we do that because LE
> Create Connection blocks the baseband since the controller will
> probably be scanning in the meantime, but if that is given that much
> problem we could probably attempt to increase it a little bit, maybe
> 5-6 seconds like we used to have as page timeout.

6 seconds should be enough for me. However, it seems a bit arbitrary,
and could still
be too small for some devices, considering the Bluetooth spec allows advertising
intervals of up to 10.24 seconds. Is it not possible to have a timeout
of, say, 60
seconds? I am not familiar with the internals of the BlueZ stack, so
if this is not
possible, then that is fine with me.

>> Here also is further information about my setup:
>> * BlueZ 5.39, with patches for hciattach that are required for the
>> Raspberry Pi 3
>> * Kernel 4.4.9-v7+
>> * Ubuntu 16.04
>>
>>
>> Thanks,
>> Aaron Okano
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
