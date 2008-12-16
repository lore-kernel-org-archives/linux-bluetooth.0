Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Dec 2008 12:29:28 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: To enablue DID in coming bluez release
Message-ID: <20081216102928.GA12914@localhost>
References: <B94C62E7C2870743865418621F040C1303A6354C@pdsmsx502.ccr.corp.intel.com> <1229046931.22285.30.camel@violet.holtmann.net> <B94C62E7C2870743865418621F040C1303A640A8@pdsmsx502.ccr.corp.intel.com> <B94C62E7C2870743865418621F040C1303B80AB8@pdsmsx502.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B94C62E7C2870743865418621F040C1303B80AB8@pdsmsx502.ccr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Couple of comments:

On Tue, Dec 16, 2008, Li, Zhigang wrote:
>  		main_opts.inqmode = val;
>  	}
> +	str = g_key_file_get_string(config, "General",

Coding style: add empty line after the closing bracket.

> +					"VID/PID/VER", &err);

Did you agree with this "VID/PID/VER" name with Marcel? I'd have used
something like "DeviceID", "DeviceIDInfo" or "DIDInfo".

> +		strcpy( main_opts.deviceid,str);

First, coding style: remove the extra space after the opening
parenthesis and add the missing one after the comma. Second, you're
overflowing main_opts.deviceid if the string provided in main.conf is
longer than 14 characters. So the call should be:
strncpy(main_opts.deviceid, src, sizeof(main_opts.deviceid));

Johan
