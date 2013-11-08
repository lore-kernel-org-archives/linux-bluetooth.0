Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Nov 2013 10:48:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 02/11] android/hid: Add a ascii2hex utility
Message-ID: <20131108084831.GA19729@x220.p-661hnu-f1>
References: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1383862220-29968-3-git-send-email-ravikumar.veeramally@linux.intel.com>
 <20131108081018.GA14368@x220.p-661hnu-f1>
 <527CA596.6070602@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <527CA596.6070602@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Fri, Nov 08, 2013, Ravi Kumar Veeramally wrote:
>>> +void ascii2hex(const uint8_t *ascii, int ascii_len, uint8_t *hex)
>>> +{
>>> +	int i;
>>> +
>>> +	if (!ascii || !hex)
>>> +		return;
>>> +
>>> +	for (i = 0; i < ascii_len / 2; i++)
>>> +		sscanf((char *) &ascii[i * 2], "%02x",
>>> +						(unsigned int *) &hex[i]);
>>> +
>>> +}
>
>> I'd just keep this static inside the HID HAL since that seems to be
>> the only user for it. Actually I'm not even convinced that it's worth
>> to have this as a separate function since you only have two users and
>> essentially the function is just two lines (the if-statement is
>> redundant).
>
> Ok, I will keep it as static. Do you want me to keep in HID HAL or HID
> daemon?

The daemon is where you were doing the conversion now as well, so no
need to change that (sorry about being unclear when I said "HID HAL").

>> Also, the function name isn't quite right. You're converting from hex
>> to binary
> 
>  We are converting to hex right? correct me If I am wrong.

No, we're converting from hex to binary.

>>. Not from ascii to hex (hex notation is already using
>>the ascii character set). Also, do consider the point from Jerzy about
>>the format specifier.
>>
>  Ok, I will fix Jerzy's suggestion also.
>
> Apart from this patch, do you have any comments on rest of the
> patches?

Only the ones I already sent.

Johan
