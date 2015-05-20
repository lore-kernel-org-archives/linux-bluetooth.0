Return-Path: <cyrus@holtmann.org>
Message-ID: <555CCA62.10809@qca.qualcomm.com>
Date: Wed, 20 May 2015 10:54:42 -0700
From: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
MIME-Version: 1.0
To: Chan-yeol Park <chanyeol.park@samsung.com>, Marcel Holtmann
	<marcel@holtmann.org>
CC: <chanyeol.park@gmail.com>, <linux-bluetooth@vger.kernel.org>,
	<Kim@samsung.com>, "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
Subject: Re: [PATCH] Bluetooth: btusb: Support for QCA61x4 on Samsung
References: <1432017670-6024-1-git-send-email-chanyeol.park@samsung.com> <D5B20D85-8B5F-4694-8B5E-2BFC670BE85C@holtmann.org> <555C7F93.9080901@samsung.com> <555C819A.40600@samsung.com>
In-Reply-To: <555C819A.40600@samsung.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

On 05/20/15 05:44, Chan-yeol Park wrote:
> Hi Marcel,
>
> On 05/20/2015 09:35 PM, Chan-yeol Park wrote:
>> Hi Marcel,
>> On 05/20/2015 03:21 AM, Marcel Holtmann wrote:
>>>
>>> Hi Chan-yeol,
>>>>
>>>> The previous commit(3267c88) regressed QCA61x4 BT on Samsung because its device info is missed in qca_devices_table[], so btusb_open() return error unexpectedly.
>>>
>>> how does this regress. We never had QCA module support in the first place. The patch looks good, I was just wondering what the regression will be here?
>> My environment was virtual box on windows.
>> I guess windows download QC firmware successfully, so without firmware handling in the linux I could use bluetooth adapter.
>>
I didn't realize ROME v2.0 was out to the market. Where did you get this module? Does it built-in on your laptop?

Your patch looks good, however, I need your confirmation that it will work on your board since I don't have ROME v2.0 HW. I'll send you ROME v2.0 FW files for you and will upstream it to linux-firmware.git if it works.
 
>> Until now , I fail to find the exact firmware , "qca/rampatch_usb_*.bin" for QCA61x4.
>> I just saw the mail that Kyle McMartin reject firmware patches made by Ben Young Tae Kim.
>> Could you tell where I can get it?
>>
>> Actually my wifi QCA61x4 does not work well..
QCA61x4 WiFi will use 'ATH10k' driver. Did you enable this module compiled on your kernel tree?
>>
> I am sending this mail again because previous mail is not sent to bluetooth-next due to HTML format.
>
> Thanks
> Chanyeol
>

Thanks
-- Ben Kim
