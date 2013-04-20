Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v6] Bluetooth: Add support for Intel Bluetooth device [8087:07dc]
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <4621368.dgD9J29ZcX@tedd-ubuntu>
Date: Fri, 19 Apr 2013 18:49:13 -0700
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@intel.com,
	don.fry@intel.com, gustavo@padovan.org
Message-Id: <FBC34292-174F-4375-8980-2B32E6D76DD8@holtmann.org>
References: <227727795.ov4BGilfep@tedd-ubuntu> <6F77B4B7-2A24-4FD4-A833-FF2CCC715DD3@holtmann.org> <4621368.dgD9J29ZcX@tedd-ubuntu>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

>>> +struct intel_version {
>>> +	u8	status;
>>> +	u8	hw_platform;
>>> +	u8	hw_variant;
>>> +	u8	hw_revision;
>>> +	u8	fw_variant;
>>> +	u8	fw_revision;
>>> +	u8	fw_build_num;
>>> +	u8	fw_build_ww;
>>> +	u8	fw_build_yy;
>>> +	u8	fw_patch_num;
>>> +} __packed;
>> 
>> I just realized that you might not need to use tabs here to align the names. You can just use one space in between. However here I am not even sure what the official net/ coding style is.
> 
> I checked hci.h as an example but it wasn't consistent. some place used tab but some place used space(?) to align. 
> I will change to space here.

since they are all u8, I think a single space is enough.

>>> +	/* If there is a command that loads a patch in the firmware
>>> +	 * file, then enable the patch upon success, otherwise just
>>> +	 * disable the manufacturer mode, for example patch activation
>>> +	 * is not required when the default firmware patch file is used
>>> +	 * because there are no patch data to load.
>>> +	 */
>>> +	if (*disable_patch && __constant_le16_to_cpu(cmd->opcode) == 0xfc8e)
>> 
>> This has to be the other way around.
>> 
>> 		cmd->opcode == __constant_cpu_to_le16(0xfc8e)
>> 
>> Or you need to use le16_to_cpu(cmd->opcode) like you do below. It is just an optimization to use the constant version on a real constant.
> 
> That's what I was a little confused. I will use the second method (le16_to_cpu(cmd->opcode)) to align with other code below.

The __constant_cpu_to_le16() will be optimized at compile time, while the other will be at runtime. So whenever you can use __constant_* it is preferred. I am pretty much okay with both.

That said, you could introduce a u16 opcode and then assign it le16_to_cpu(cmd->opcode) once and then keep using the local opcode variable. It is not that this really matters, I am just saying.

Regards

Marcel

