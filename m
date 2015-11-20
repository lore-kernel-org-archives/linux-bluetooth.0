Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLYQ0_v1b1FodejP+eUMPsi_afEOh-jrsFS9WauHO99_w@mail.gmail.com>
References: <CAKafyqpQwmUOHwH8j68kkni_k8F4pKAKE674w1pvAuL91GjrAw@mail.gmail.com>
	<CABBYNZLDkFBz3TMEyOCZdbfberwA_Z9FEBwbDhAWQxbpSZ4XBA@mail.gmail.com>
	<CAKafyqp3Sy3gDcxtWwpHttRB1-8k=CYzmSN8+KDk9ec6x=OLQg@mail.gmail.com>
	<CABBYNZLYQ0_v1b1FodejP+eUMPsi_afEOh-jrsFS9WauHO99_w@mail.gmail.com>
Date: Fri, 20 Nov 2015 17:22:05 +0530
Message-ID: <CAKafyqq56OqMo9YYRvUixx0hvnFYG4z9Y=fROibAdHqmgW+rDw@mail.gmail.com>
Subject: Re: HoG: Report Map Sharing is not Happening all the time.
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Nov 20, 2015 at 1:47 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Prabhu,
>
> On Fri, Nov 20, 2015 at 6:52 AM, Prabhu Chawandi <foss.chaws@gmail.com> wrote:
>> Hi Luiz,
>>
>> On Thu, Nov 19, 2015 at 6:45 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Prabhu,
>>>
>>> On Thu, Nov 19, 2015 at 8:33 AM, Prabhu Chawandi <foss.chaws@gmail.com> wrote:
>>>> Hi All,
>>>>
>>>>   In My bluetooth Smart Keyboard sometimes though connection is
>>>> established key presses were not being received by application. I
>>>> tried running 'evtest' /dev/input/eventX node was not created when the
>>>> issue was seen. After some debug I found the Report Maps were not
>>>> shared. [i dint see the log when run bluetoothd -d
>>>>
>>>> 1. Is it necessary to share report map all the time system is reboot ?
>>>> 2. is the Report map not cached ? or Cached which system failed to pick ?
>>>
>>> The report map is lost every time you restart bluetoothd, that is
>>> because we only cache attribute handles but not theirs values since it
>>> would be way too expensive the read and store everything, so what
>>> happens is that during the first time you connect to a HoG peripheral
>>> bluetoothd will attempt to read the report map and create the input
>>> device but perhaps there is something causing a problem in your case.
>>>
>>>> Please let me know your views.
>>>>
>>>> many thanks,
>>>> Prabhu Chawandi
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>>
>> I went through the hcidump
>>
>> I saw multiple connection and disconnection sequence. In the hcidump
>> its saying connection timed out[not sure about the reason]
>>
>> When disconnection  happens
>> < ACL data: handle 68 flags 0x00 dlen 11
>>     ATT: Read By Type req (0x08)
>>       start 0x0011, end 0x0030
>>       type-uuid 0x2803
>>> HCI Event: Disconn Complete (0x05) plen 4
>>     status 0x00 handle 68 reason 0x08
>>     Reason: Connection Timeout
>
> This is probably why it doesn't work, there is a timeout before the
> discovery completes, very likely either the local controller or the
> remote device is not working properly.
>
>>
>> Supervisory timeout in peripheral is 20.5 Seconds is it not fine ?
>> Please let me know is there any parameter I need to configure
>> [timeouts] for me ?
>>
>> After some attempts connection is successful, but I see no report map
>> is requested by bluez.
>>
>> < HCI Command: LE Connection Update (0x08|0x0013) plen 14
>>> HCI Event: Command Status (0x0f) plen 4
>>     LE Connection Update (0x08|0x0013) status 0x00 ncmd 0
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 68 packets 1
>>> HCI Event: Command Status (0x0f) plen 4
>>     Unknown (0x00|0x0000) status 0x00 ncmd 1
>>> HCI Event: LE Meta Event (0x3e) plen 10
>>     LE Connection Update Complete
>>       status 0x00 handle 68
>>       interval 12.50ms, latency 125.00ms, superv. timeout 20500.00ms
>
> What version of BlueZ are you running? Can you disclose what device is
> it that you are trying to make it work?
>
>
> --
> Luiz Augusto von Dentz

  I recently bought CSR uEnergy kit [CSR 8010] for my self study of
BLE, which has touch attached. So  I made it composite device - touch
pad, kbd and consumer.
First time paring and connection is perfect. But when reboot and try
to connect i see multiple disconnection and one final attempt will
succeed.
I tried with CSR and trendnet controllers, still I see the above
connection timeout issue. I even tried making it uidevice [touch pad
only, consumer only] still I saw it.  So I thought I might need to
configure connection timeout. I did the same on my kit from 8 second
to 20.5 seconds still I saw it ?
Could you please tell me what might be going wrong ? Where can I
change the connection timeout in bluez ?

I am using Bluez-5.35. Looking forward for your inputs on it.
