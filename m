Return-Path: <cyrus@holtmann.org>
Message-id: <555C819A.40600@samsung.com>
Date: Wed, 20 May 2015 21:44:10 +0900
From: Chan-yeol Park <chanyeol.park@samsung.com>
MIME-version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: chanyeol.park@gmail.com, ytkim@qca.qualcomm.com,
	linux-bluetooth@vger.kernel.org, Kim@samsung.com,
	Ben Young Tae <ytkim@qca.qualcomm.com>
Subject: Re: [PATCH] Bluetooth: btusb: Support for QCA61x4 on Samsung
References: <1432017670-6024-1-git-send-email-chanyeol.park@samsung.com>
 <D5B20D85-8B5F-4694-8B5E-2BFC670BE85C@holtmann.org>
 <555C7F93.9080901@samsung.com>
In-reply-to: <555C7F93.9080901@samsung.com>
Content-type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 05/20/2015 09:35 PM, Chan-yeol Park wrote:
> Hi Marcel,
> On 05/20/2015 03:21 AM, Marcel Holtmann wrote:
>>
>> Hi Chan-yeol,
>>>
>>> The previous commit(3267c88) regressed QCA61x4 BT on Samsung because 
>>> its device info is missed in qca_devices_table[], so btusb_open() 
>>> return error unexpectedly.
>>
>> how does this regress. We never had QCA module support in the first 
>> place. The patch looks good, I was just wondering what the regression 
>> will be here?
> My environment was virtual box on windows.
> I guess windows download QC firmware successfully, so without firmware 
> handling in the linux I could use bluetooth adapter.
>
> Until now , I fail to find the exact firmware , 
> "qca/rampatch_usb_*.bin" for QCA61x4.
> I just saw the mail that Kyle McMartin reject firmware patches made by 
> Ben Young Tae Kim.
> Could you tell where I can get it?
>
> Actually my wifi QCA61x4 does not work well..
I am sending this mail again because previous mail is not sent to 
bluetooth-next due to HTML format.

Thanks
Chanyeol

