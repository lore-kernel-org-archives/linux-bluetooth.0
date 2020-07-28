Return-Path: <SRS0=dFGF=BH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883F3C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 06:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C53820829
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 06:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgG1G6b convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:58:31 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48544 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgG1G6b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 02:58:31 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 56BFCCECCC;
        Tue, 28 Jul 2020 09:08:31 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Bluez PATCH] main: adding configurable eir_max_name_len
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200727173720.2700327-1-alainm@chromium.org>
Date:   Tue, 28 Jul 2020 08:58:29 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <17DA93F5-AB77-4C40-A5F2-38D8FE6C98A3@holtmann.org>
References: <20200727173720.2700327-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change adds support for a configurable eir_max_name_len for
> platforms which requires a larger than 48 bytes complete name in EIR.
> 
> From bluetoothctl:
> [bluetooth]# system-alias
> 012345678901234567890123456789012345678901234567890123456789
> Changing 012345678901234567890123456789012345678901234567890123456789
> succeeded
> [CHG] Controller DC:71:96:69:02:89 Alias:
> 012345678901234567890123456789012345678901234567890123456789
> 
> From btmon:
> < HCI Command: Write Local Name (0x03|0x0013) plen 248             #109
> [hci0] 88.567990
>         Name:
> 012345678901234567890123456789012345678901234567890123456789
>> HCI Event: Command Complete (0x0e) plen 4                             
>    #110 [hci0] 88.663854
>       Write Local Name (0x03|0x0013) ncmd 1
>         Status: Success (0x00)
> @ MGMT Event: Local Name Changed (0x0008) plen 260               
> {0x0004} [hci0] 88.663948
>         Name:
> 012345678901234567890123456789012345678901234567890123456789
>         Short name:
> < HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241 
>         FEC: Not required (0x00)
>         Name (complete):
> 012345678901234567890123456789012345678901234567890123456789
>         TX power: 12 dBm
>         Device ID: Bluetooth SIG assigned (0x0001)
>           Vendor: Google (224)
>           Product: 0xc405
>           Version: 0.5.6 (0x0056)
>         16-bit Service UUIDs (complete): 7 entries
>           Generic Access Profile (0x1800)
>           Generic Attribute Profile (0x1801)
>           Device Information (0x180a)
>           A/V Remote Control (0x110e)
>           A/V Remote Control Target (0x110c)
>           Handsfree Audio Gateway (0x111f)
>           Audio Source (0x110a)
>> HCI Event: Command Complete (0x0e) plen 4                           
>       Write Extended Inquiry Response (0x03|0x0052) ncmd 1
>         Status: Success (0x00)
> 
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> doc/mgmt-api.txt |  1 +
> src/adapter.c    | 10 +++++++++-
> src/hcid.h       |  1 +
> src/main.c       |  5 +++++
> src/main.conf    |  5 +++++
> 5 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index ca0d38469..1bc0f0c12 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3279,6 +3279,7 @@ Read Default System Configuration Command
> 		0x0019	LE Connection Latency
> 		0x001a	LE Connection Supervision Timeout
> 		0x001b	LE Autoconnect Timeout
> +		0x001c	Max EIR Name Length

we can certainly do this, but I prefer that do this for LE and BR/EDR and name it that way as well.

> 
> 	This command can be used at any time and will return a list of
> 	supported default parameters as well as their current value.
> diff --git a/src/adapter.c b/src/adapter.c
> index 5e896a9f0..3adc67b63 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2375,7 +2375,7 @@ static bool parse_pathloss(DBusMessageIter *value,
> 	return true;
> }
> 
> -static bool parse_transport(DBusMessageIter *value, 
> +static bool parse_transport(DBusMessageIter *value,
> 					struct discovery_filter *filter)
> {
> 	char *transport_str;
> @@ -4435,6 +4435,14 @@ static void load_default_system_params(struct btd_adapter *adapter)
> 		len += sizeof(params[i].u16);
> 	}
> 
> +	if (main_opts.default_params.eir_max_name_len) {
> +		params[i].entry.type = 0x001c;
> +		params[i].entry.length = sizeof(params[i].u16);
> +		params[i].u16 = main_opts.default_params.eir_max_name_len;
> +		++i;
> +		len += sizeof(params[i].u16);
> +	}
> +

Do you really want to keep it as uint16_t or is that just laziness since changing the kernel to support anything other than uint16_t is complicated?

On a side note, you need to provide a uint16_t value in little endian to the MGMT wire protocol.

> 	err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
> 			adapter->dev_id, len, params, NULL, NULL, NULL);
> 	if (!err)
> diff --git a/src/hcid.h b/src/hcid.h
> index 5f249ebf9..c9b59a374 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -93,6 +93,7 @@ struct main_opts {
> 		uint16_t	le_conn_latency;
> 		uint16_t	le_conn_lsto;
> 		uint16_t	le_autoconnect_timeout;
> +		uint16_t	eir_max_name_len;
> 	} default_params;
> 
> 
> diff --git a/src/main.c b/src/main.c
> index ec7a9fbd7..74876e01d 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -123,6 +123,7 @@ static const char *controller_options[] = {
> 	"LEConnectionLatency",
> 	"LEConnectionSupervisionTimeout",
> 	"LEAutoconnecttimeout",
> +	"EirMaxNameLength",
> 	NULL
> };
> 
> @@ -433,6 +434,10 @@ static void parse_controller_config(GKeyFile *config)
> 		  &main_opts.default_params.le_autoconnect_timeout,
> 		  0x0001,
> 		  0x4000},
> +		{ "EirMaxNameLength",
> +		  &main_opts.default_params.eir_max_name_len,
> +		  0x0001,
> +		  0x00EE},
> 	};
> 	uint16_t i;
> 
> diff --git a/src/main.conf b/src/main.conf
> index f41203b96..7ecac5930 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -148,6 +148,11 @@
> #LEConnectionSupervisionTimeout=
> #LEAutoconnecttimeout=
> 
> +# EIR Max Name. This is the maximum length for the COMPLETE_NAME EIR section.
> +# If the name length exceeds this size, a SHORT_NAME section is used.
> +# Default: 48
> +#EirMaxNameLength = 48
> +
> [GATT]
> # GATT attribute cache.
> # Possible values:

Regards

Marcel

