Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Apr 2013 07:04:19 +0900
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	don.fry@intel.com
Subject: Re: [RFC] Bluetooth: Add support for Intel Bluetooth device
 [8087:07dc]
Message-ID: <20130410220419.GA17338@x220>
References: <1640417.GJq4DRhhap@tedd-ubuntu>
 <6C02E13F-AA1A-43B9-891F-8B42F9111DD8@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6C02E13F-AA1A-43B9-891F-8B42F9111DD8@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Apr 10, 2013, Marcel Holtmann wrote:
> > +	const u8		*patch_curr;
> > +	char			pfile[32];
> > +	u8			*m_off_code;
> > +
> > +	u8 m_on[] = { 0x01, 0x00 };
> > +	u8 m_off_1[] = { 0x00, 0x01 };
> > +	u8 m_off_2[] = { 0x00, 0x02 };
> 
> Shouldn't this be __u8. Johan, any preference. I know that I used __u8
> for the bcm92035 vendor command.

To my understanding __u8 (and __u16 and __u32 too) are intended for code
that's to be shared with user space (e.g. our upcoming uapi header
file(s)). Anything else should just use u8. At least this is what I
discovered after some research when I get more heavily involved with
kernel development a few years ago.

Johan
