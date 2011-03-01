Return-Path: <cyrus@holtmann.org>
Message-ID: <4D6C950F.9060403@atheros.com>
Date: Tue, 1 Mar 2011 12:11:19 +0530
From: Bala Shanmugam <sbalashanmugam@atheros.com>
MIME-Version: 1.0
To: Shanmugamkamatchi Balashanmugam
	<Shanmugamkamatchi.Balashanmugam@Atheros.com>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] linux-firmware: Add patch and sysconfig files for AR3012.
References: <1297248851-14996-1-git-send-email-sbalashanmugam@atheros.com> <4D5A4625.4060104@atheros.com>
In-Reply-To: <4D5A4625.4060104@atheros.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On 2/15/2011 2:53 PM, Shanmugamkamatchi Balashanmugam wrote:
> Hi David,
>
> On 2/9/2011 4:24 PM, Shanmugamkamatchi Balashanmugam wrote:
>> Signed-off-by: Bala Shanmugam<sbalashanmugam@atheros.com>
>> ---
>>    WHENCE                       |    9 +++++++++
>>    ar3k/AthrBT_0x01020001.dfu   |  Bin 0 ->   55244 bytes
>>    ar3k/ramps_0x01020001_26.dfu |  Bin 0 ->   1224 bytes
>>    3 files changed, 9 insertions(+), 0 deletions(-)
>>    create mode 100644 ar3k/AthrBT_0x01020001.dfu
>>    create mode 100644 ar3k/ramps_0x01020001_26.dfu
>>
>> diff --git a/WHENCE b/WHENCE
>> index 1cbd0a6..2de0bea 100644
>> --- a/WHENCE
>> +++ b/WHENCE
>> @@ -1534,3 +1534,12 @@ Driver: vt6656 - VIA VT6656 USB wireless driver
>>    File: vntwusb.fw
>>
>>    Licence: Redistributable. See LICENCE.via_vt6656 for details.
>> +
>> +--------------------------------------------------------------------------
>> +
>> +Driver: DFU Driver for Atheros bluetooth chipset AR3012
>> +
>> +File: ar3k/AthrBT_0x01020001.dfu
>> +File: ar3k/ramps_0x01020001_26.dfu
>> +
> Driver changes for AR3012 have been upstreamed.
> Can you please upstream above patch?
>
> Regards,
> Bala.
Can you please upstream this patch.
We have few releases waiting.
If you have any concerns in upstreaming it, please let me know.

Regards,
Bala.
