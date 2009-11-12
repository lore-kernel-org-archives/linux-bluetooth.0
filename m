Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Nov 2009 13:13:57 +0100
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Cc: Susanne Goldammer <susanne.goldammer@gmx.de>
Subject: Re: Make bluetoothd start w/o SDP Server
Message-ID: <20091112131357.1106213e@strolchi.home.s3e.de>
In-Reply-To: <4AFBD3B6.6020706@gmx.de>
References: <4AF9721B.3010405@gmx.de>
	<1257861916.10888.1372.camel@localhost.localdomain>
	<4AF97659.2050807@gmx.de>
	<4AFBD3B6.6020706@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Susanne,

On Thu, 12 Nov 2009 10:21:58 +0100
Susanne Goldammer <susanne.goldammer@gmx.de> wrote:

> Hi all,
> 
> I would like to explain in more detail why I use this option to start
> bluetoothd without its own SDP-Server.

Thanks for the explanation, now I understand the purpose of the patch
(debug option for regression tests) and, given that it is pretty low
overhead, I think it is a good Idea.

I'm commenting on the patch inline.

> diff -r -u bluez-4.51/debian/changelog
> bluez-4.51_patched/debian/changelog 
> --- bluez-4.51/debian/changelog    2009-11-10 09:57:06.000000000 +0100
> +++ bluez-4.51_patched/debian/changelog    2009-11-10 09:55:43.000000000 +0100

a) The bluez source does not contain a debian directory and thus no
debian/changelog file.

b) bluez is now at version 4.57. Please provide a patch againt current
git.

> @@ -1,3 +1,11 @@
> +bluez (4.51-0ubuntu2-1) karmic; urgency=low
> +
> +  * patch orig source with 4.51.diff.gz provided by ubuntu
> +  * patch bluetoothd so we are able to start without sdp server
> +
> + -- Susanne Goldammer <susanne.goldammer@gmx.de>  Tue, 10 Nov 2009
> 10:00:24 +0200
> +
> +
>  bluez (4.51-0ubuntu2) karmic; urgency=low
>  
>    * debian/patches/01_lower_sink_ranking.patch:
> Nur in bluez-4.51/scripts: bluetooth.rules.
> diff -r -u bluez-4.51/src/main.c bluez-4.51_patched/src/main.c
> --- bluez-4.51/src/main.c    2009-08-01 21:47:07.000000000 +0200
> +++ bluez-4.51_patched/src/main.c    2009-11-10 09:47:29.000000000
> +0100 @@ -292,6 +292,8 @@
>  static gboolean option_detach = TRUE;
>  static gboolean option_debug = FALSE;
>  static gboolean option_udev = FALSE;
> +static gboolean option_runsdp = TRUE;
> +
>  
>  static guint last_adapter_timeout = 0;
>  
> @@ -331,6 +333,9 @@
>                  "Enable debug information output" },
>      { "udev", 'u', 0, G_OPTION_ARG_NONE, &option_udev,
>                  "Run from udev mode of operation" },
> +        { "nosdp", 'S', G_OPTION_FLAG_REVERSE,
> +                        G_OPTION_ARG_NONE, &option_runsdp,
> +                        "Don't run SDP service (debuggin option)" },

Your patch is whitespace-damaged (bluez source uses tabs for
indentation, not spaces) and thus does not apply at all.
In case your mailer mangles the patch and everything else fails, then
send it as an attachment (plain text, still).

>      { NULL },
>  };
>  
> @@ -416,7 +421,14 @@
>          }
>      }
>  
> -    start_sdp_server(mtu, main_opts.deviceid, SDP_SERVER_COMPAT);
> +        if (option_runsdp != 0) {
> +               start_sdp_server(mtu, main_opts.deviceid,
> SDP_SERVER_COMPAT);
> +        }
> +        else {
> +               /* see scp-server.c: start_sdp_server() ->
> init_server() */
> +               register_public_browse_group();
> +               register_server_service();
> +        }
>  
>      /* Loading plugins has to be done after D-Bus has been setup
> since
>       * the plugins might wanna expose some paths on the bus. However
> the @@ -445,7 +457,13 @@
>  
>      plugin_cleanup();
>  
> -    stop_sdp_server();
> +    if (option_runsdp != 0) {

Coding style: no curly braces around single line conditionals.

> +        stop_sdp_server();
> +    }
> +    else {

again, no curly braces

> +        /* see scp-server.c: stop_sdp_server() */

scp-server.c?

> +        sdp_svcdb_reset();

I don't know the internals, so maybe explaining shortly why this is
needed even when no SDP service was running is a good idea (but maybe
this is elaborated in great detail in sdpd-server.c comments already,
then the comment above may be fine.

> +    }


Have fun :-)

	seife
-- 
Stefan Seyfried

"You sure you software suspend guys haven't been hanging out with the
 IDE maintainers?"                                     -- Rob Landley
