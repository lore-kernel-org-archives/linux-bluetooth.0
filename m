Return-Path: <cyrus@holtmann.org>
Subject: RE: To enablue DID in coming bluez release
From: Marcel Holtmann <marcel@holtmann.org>
To: "Li, Zhigang" <zhigang.li@intel.com>
Cc: Johan Hedberg <johan.hedberg@nokia.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <B94C62E7C2870743865418621F040C1303B80C87@pdsmsx502.ccr.corp.intel.com>
References: <B94C62E7C2870743865418621F040C1303A6354C@pdsmsx502.ccr.corp.intel.com>
	 <1229046931.22285.30.camel@violet.holtmann.net>
	 <B94C62E7C2870743865418621F040C1303A640A8@pdsmsx502.ccr.corp.intel.com>
	 <B94C62E7C2870743865418621F040C1303B80AB8@pdsmsx502.ccr.corp.intel.com>
	 <20081216102928.GA12914@localhost> <1229481492.10889.1.camel@violet>
	 <B94C62E7C2870743865418621F040C1303B80C87@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain
Date: Wed, 17 Dec 2008 20:59:13 +0100
Message-Id: <1229543953.10889.16.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zhigang,

so first things first. NO top-posting on this mailing list.

> Updated:
> --- a/main.c	Tue Dec 16 17:43:24 2008 +0800
> +++ b/main.c	Wed Dec 17 11:57:47 2008 +0800
> @@ -174,6 +174,17 @@ static void parse_config(GKeyFile *confi
>  		main_opts.inqmode = val;
>  	}
>  
> +	str = g_key_file_get_string(config, "General",
> +					"DeviceID", &err);
> +	if (err) {
> +		debug("%s", err->message);
> +		g_clear_error(&err);
> +	} else {
> +		debug("deviceid=%s", str);
> +		strncpy(main_opts.deviceid, str, sizeof(main_opts.deviceid));
> +		g_free(str);
> +	}
> +
>  	main_opts.link_mode = HCI_LM_ACCEPT;
>  
>  	main_opts.link_policy = HCI_LP_RSWITCH | HCI_LP_SNIFF |

I always need patches against the latest GIT tree. Otherwise I can't
merge them and submitting them in a proper format helps me to apply
them.

> diff -r 65556502911d main.conf
> --- a/main.conf	Tue Dec 16 17:43:24 2008 +0800
> +++ b/main.conf	Tue Dec 17 11:57:51 2008 +0800
> @@ -28,3 +28,9 @@ OffMode = NoScan
>  # Discover scheduler interval used in Adapter.DiscoverDevices
>  # The value is in seconds. Defaults is 0 to use controller scheduler
>  DiscoverSchedulerInterval = 0
> +
> +
> +# User verndor and product and version information are used in DID profile
> +# ":" to identify the value. FFFF is reserved for VendorId by default.
> +DeviceID = 1234:5678:abcd

So the option should be commented out by default since otherwise every
installation now uses vendor id 1234 and that is actually a valid one.
Also the description above makes no sense.

I committed a patch by myself to the GIT tree now that should fix this.
However there is one thing missing. The DID supports USB based vendor
ids and Bluetooth based ones. So we need to support both. Feel free to
come up with something.

Regards

Marcel


