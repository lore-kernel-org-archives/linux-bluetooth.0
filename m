Return-Path: <cyrus@holtmann.org>
Subject: Re: To enablue DID in coming bluez release
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@nokia.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20081216102928.GA12914@localhost>
References: <B94C62E7C2870743865418621F040C1303A6354C@pdsmsx502.ccr.corp.intel.com>
	 <1229046931.22285.30.camel@violet.holtmann.net>
	 <B94C62E7C2870743865418621F040C1303A640A8@pdsmsx502.ccr.corp.intel.com>
	 <B94C62E7C2870743865418621F040C1303B80AB8@pdsmsx502.ccr.corp.intel.com>
	 <20081216102928.GA12914@localhost>
Content-Type: text/plain
Date: Wed, 17 Dec 2008 03:38:12 +0100
Message-Id: <1229481492.10889.1.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Couple of comments:
> 
> On Tue, Dec 16, 2008, Li, Zhigang wrote:
> >  		main_opts.inqmode = val;
> >  	}
> > +	str = g_key_file_get_string(config, "General",
> 
> Coding style: add empty line after the closing bracket.
> 
> > +					"VID/PID/VER", &err);
> 
> Did you agree with this "VID/PID/VER" name with Marcel? I'd have used
> something like "DeviceID", "DeviceIDInfo" or "DIDInfo".

I think "DeviceID" sounds reasonable. Lets use that one.

Regards

Marcel


