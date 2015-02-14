Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v3 4/4] core: Add support for Multi Profile Specification
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1423928093-21850-1-git-send-email-szymon.janc@tieto.com>
Date: Sat, 14 Feb 2015 11:59:24 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3DB13CBB-FB88-4BAE-956C-EBACE9D85C05@holtmann.org>
References: <1423918946-14332-4-git-send-email-szymon.janc@tieto.com> <1423928093-21850-1-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This adds new main.conf configure option named MultiProfile. It allows
> to enable MPSD and MPMD scenarios for MPS. By default MPS is disabled.
> ---
> V3: - fixed string checks when parsing option
>    - added MultiProfile to list of known options
> 
> src/main.c    | 23 +++++++++++++++++++++++
> src/main.conf |  5 +++++
> 2 files changed, 28 insertions(+)
> 
> diff --git a/src/main.c b/src/main.c
> index b3140d0..0af3ed9 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -69,6 +69,9 @@
> struct main_opts main_opts;
> static GKeyFile *main_conf;
> 
> +static bool mps_mpsd = false;
> +static bool mps_mpmd = false;
> +
> static const char * const supported_options[] = {
> 	"Name",
> 	"Class",
> @@ -81,6 +84,7 @@ static const char * const supported_options[] = {
> 	"NameResolving",
> 	"DebugKeys",
> 	"ControllerMode",
> +	"MultiProfile",
> };
> 
> GKeyFile *btd_get_main_conf(void)
> @@ -307,6 +311,22 @@ static void parse_config(GKeyFile *config)
> 		main_opts.mode = get_mode(str);
> 		g_free(str);
> 	}
> +
> +	str = g_key_file_get_string(config, "General", "MultiProfile", &err);
> +	if (err) {
> +		g_clear_error(&err);
> +	} else {
> +		DBG("MultiProfile=%s", str);
> +
> +		if (!strcmp(str, "mpsd")) {
> +			mps_mpsd = true;
> +		} else if (!strcmp(str, "mpmd")) {
> +			mps_mpsd = true;
> +			mps_mpmd = true;
> +		}
> +
> +		g_free(str);
> +	}
> }
> 
> static void init_defaults(void)
> @@ -599,6 +619,9 @@ int main(int argc, char *argv[])
> 		register_device_id(main_opts.did_source, main_opts.did_vendor,
> 				main_opts.did_product, main_opts.did_version);
> 
> +	if (mps_mpsd)
> +		register_mps(mps_mpmd);
> +
> 	/* Loading plugins has to be done after D-Bus has been setup since
> 	 * the plugins might wanna expose some paths on the bus. However the
> 	 * best order of how to init various subsystems of the Bluetooth
> diff --git a/src/main.conf b/src/main.conf
> index d4d6ab0..a8f37f0 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -52,6 +52,11 @@
> # Possible values: "dual", "bredr", "le"
> #ControllerMode = dual
> 
> +# Enables Multi Profile Specification support. This allows to specify if
> +# system supports only MPSD or both MPSD/MPMD scenarios.
> +# Possible values: "mpsd", "mpmd"
> +#MultiProfile = mpsd
> +

actually the commented out entry should be the default. So you need off, mpsd and mpmd here. However since these stand for single device and multiple device, then why not actually name it in plain English.

So "off", "single" and "multiple" with "off" being the default. And then have the text refer to Multiple Profile Single Device (MPSD) and Multiple Profile Multiple Devices (MPMD). So that specification readers know what each option maps to.

Regards

Marcel

