Return-Path: <cyrus@holtmann.org>
Message-ID: <494862FE.8060805@dtsp.co.nz>
Date: Wed, 17 Dec 2008 15:25:02 +1300
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: "Li, Zhigang" <zhigang.li@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: To enablue DID in coming bluez release
References: <B94C62E7C2870743865418621F040C1303A6354C@pdsmsx502.ccr.corp.intel.com> <1229046931.22285.30.camel@violet.holtmann.net> <B94C62E7C2870743865418621F040C1303A640A8@pdsmsx502.ccr.corp.intel.com> <B94C62E7C2870743865418621F040C1303B80AB8@pdsmsx502.ccr.corp.intel.com> <20081216102928.GA12914@localhost> <B94C62E7C2870743865418621F040C1303B80C0F@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <B94C62E7C2870743865418621F040C1303B80C0F@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain; charset=gb2312
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Typo in main.conf: "verndor"


Li, Zhigang wrote:
> Please check it again.
> Marcel mention it in IRC for VID/PID/VER
>
> --- a/main.c	Tue Dec 16 17:43:24 2008 +0800
> +++ b/main.c	Wed Dec 17 09:57:37 2008 +0800
> @@ -174,6 +174,17 @@ static void parse_config(GKeyFile *confi
>  		main_opts.inqmode = val;
>  	}
>  
> +	str = g_key_file_get_string(config, "General",
> +					"VID/PID/VER", &err);
> +	if (err) {
> +		debug("%s", err->message);
> +		g_clear_error(&err);
> +	} else {
> +		debug("vid/pid/ver=%s", str);
> +		strncpy(main_opts.deviceid, str, sizeof(main_opts.deviceid));
> +		g_free(str);
> +	}
> +
>  	main_opts.link_mode = HCI_LM_ACCEPT;
>  
>  	main_opts.link_policy = HCI_LP_RSWITCH | HCI_LP_SNIFF |
> diff -r 65556502911d main.conf
> --- a/main.conf	Tue Dec 16 17:43:24 2008 +0800
> +++ b/main.conf	Tue Dec 16 17:50:31 2008 +0800
> @@ -28,3 +28,9 @@ OffMode = NoScan
>  # Discover scheduler interval used in Adapter.DiscoverDevices
>  # The value is in seconds. Defaults is 0 to use controller scheduler
>  DiscoverSchedulerInterval = 0
> +
> +
> +# User verndor and product and version information are used in DID profile
> +# ":" to identify the value. FFFF is reserved for VendorId by default.
> +VID/PID/VER = 1234:5678:abcd
> +
>
> Thanks
>
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Johan Hedberg
> Sent: 2008Äê12ÔÂ16ÈÕ 18:29
> To: linux-bluetooth@vger.kernel.org
> Subject: Re: To enablue DID in coming bluez release
>
> Hi,
>
> Couple of comments:
>
> On Tue, Dec 16, 2008, Li, Zhigang wrote:
>   
>>  		main_opts.inqmode = val;
>>  	}
>> +	str = g_key_file_get_string(config, "General",
>>     
>
> Coding style: add empty line after the closing bracket.
>
>   
>> +					"VID/PID/VER", &err);
>>     
>
> Did you agree with this "VID/PID/VER" name with Marcel? I'd have used
> something like "DeviceID", "DeviceIDInfo" or "DIDInfo".
>
>   
>> +		strcpy( main_opts.deviceid,str);
>>     
>
> First, coding style: remove the extra space after the opening
> parenthesis and add the missing one after the comma. Second, you're
> overflowing main_opts.deviceid if the string provided in main.conf is
> longer than 14 characters. So the call should be:
> strncpy(main_opts.deviceid, src, sizeof(main_opts.deviceid));
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> N‹§²æìr¸›yúèšØb²X¬¶Ç§vØ^)Şº{.n+‰·¥Š{±n[¶-)í…æèw*jg¬±¶‰šŠİ¢j/êäz¹Ş–Š™¨è­&)ß¡«a¶Úşø®G«éhæj:+v‰¨Šwè†Ù¥

