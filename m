Return-Path: <cyrus@holtmann.org>
Message-ID: <53542641.9050607@gmail.com>
Date: Sun, 20 Apr 2014 23:55:45 +0400
From: Dmitry Grebennikov <dmitry.ew@gmail.com>
MIME-Version: 1.0
To: Mail Delivery Subsystem <mailer-daemon@googlemail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: bluetooth support of intel 7260ac adapter
References: <001a1134de9659277104f77e80cf@google.com>
In-Reply-To: <001a1134de9659277104f77e80cf@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Also, hciconfig output:
$  sudo hcitool scan
Device is not available: No such device
$  sudo hciconfig hci0 up
Can't get device info: No such device
$  sudo hciconfig hci0 unblock
Can't get device info: No such device

Thanks.

> On 20.04.2014 23:07, Marcel Holtmann wrote:
>> Hi Dmitry,
>>
>>> Could you help me please to make my intel 7260ac wifi+bt adapter
>>> work correctly?
>>>
>>> I bought it recently and installed in my laptop. Wifi works
>>> perfectly (iwlwifi + firmware), while bluetooth controller isn't
>>> detected with lspci, lshw completely.
>>>
>>> I found that Tedd Ho-Jeong An released bluetooth firmware for this
>>> card.
>>> So I installed linux-firmware-git package, which contain needed
>>> intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq file.
>>> I wrote to load btusb module in /etc/modules-load/
>>> I don't know how to force btusb driver to load firmware file.
>>> What could be the problem with detection only wireless network
>>> controller, but not bluetooth?
>> the Bluetooth controller would show up as USB device. So you should
>> look with lsusb. And check rfkill if you have a platform Bluetooth
>> switch that will enable/disable the Bluetooth controller.
>>
>> Regards
>>
>> Marcel
>>
> Thanks for answer.
> I attach lsusb output, there are two rows with Intel Corp. Integrated
> Rate Matching Hub, but I don't think it's what needed.
> That is the problem that there is no bluetooth adapter in rfkill:
>> # rfkill list
>> 2: samsung-wlan: Wireless LAN
>>          Soft blocked: no
>>          Hard blocked: no
>> 3: phy1: Wireless LAN
>>          Soft blocked: no
>>          Hard blocked: no
> Dmitry Grebennikov


