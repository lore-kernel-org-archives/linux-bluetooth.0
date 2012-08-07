Return-Path: <cyrus@holtmann.org>
Message-ID: <5020E853.3030907@qca.qualcomm.com>
Date: Tue, 7 Aug 2012 15:35:07 +0530
From: Mohammed Shafi Shajakhan <mohammed@qca.qualcomm.com>
MIME-Version: 1.0
To: Yevgeniy Melnichuk <yevgeniy.melnichuk@googlemail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>,
	<gustavo@padovan.org>
Subject: Re: [PATCH] Bluetooth: Add support for Sony Vaio T-Series
References: <1343906361-2747-1-git-send-email-mohammed@qca.qualcomm.com> <1343934984.2083.3.camel@aeonflux> <501F5B95.2070001@qca.qualcomm.com>
In-Reply-To: <501F5B95.2070001@qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yevgeniy,


On Monday 06 August 2012 11:22 AM, Mohammed Shafi Shajakhan wrote:
> Hi Marcel/Yevgeniy,
>
>>
>>> Add Sony Vaio T-Series Bluetooth Module( 0x489:0xE036) to
>>> the blacklist of btusb module and add it to the ath3k module.
>>
>> include part of /sys/kernel/debug/usb/devices in the commit message.
>> This is nothing new to you guys. I requested it multiple times.
>>
>
> I don't have this exact device to be sure, was just helping Yevgeniy to
> send the patch and he has it.
>
> Yevgeniy, please provide the data Marcel had asked for us.
>
>


please provide the output of cat /sys/kernel/debug/usb/devices. I will 
snip out the relevant lsusb output for our device send a v2 patch this.
thanks!

-- 
thanks,
shafi
