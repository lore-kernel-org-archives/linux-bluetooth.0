Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [RFC] Bluetooth: Add support for Intel Bluetooth device [8087:07dc]
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130410220419.GA17338@x220>
Date: Wed, 10 Apr 2013 15:09:55 -0700
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	don.fry@intel.com
Message-Id: <5C338FDA-422A-4600-8DCF-43065D3EB6EA@holtmann.org>
References: <1640417.GJq4DRhhap@tedd-ubuntu> <6C02E13F-AA1A-43B9-891F-8B42F9111DD8@holtmann.org> <20130410220419.GA17338@x220>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> +	const u8		*patch_curr;
>>> +	char			pfile[32];
>>> +	u8			*m_off_code;
>>> +
>>> +	u8 m_on[] = { 0x01, 0x00 };
>>> +	u8 m_off_1[] = { 0x00, 0x01 };
>>> +	u8 m_off_2[] = { 0x00, 0x02 };
>> 
>> Shouldn't this be __u8. Johan, any preference. I know that I used __u8
>> for the bcm92035 vendor command.
> 
> To my understanding __u8 (and __u16 and __u32 too) are intended for code
> that's to be shared with user space (e.g. our upcoming uapi header
> file(s)). Anything else should just use u8. At least this is what I
> discovered after some research when I get more heavily involved with
> kernel development a few years ago.

then you might have to tweak my other patch a little to fix this for BCM92035 setup routine.

Regards

Marcel

