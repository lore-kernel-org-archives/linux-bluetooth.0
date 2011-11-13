Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Automake AM_CFLAGS, AM_LDFLAGS fixups
From: Marcel Holtmann <marcel@holtmann.org>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 13 Nov 2011 13:49:53 +0900
In-Reply-To: <1321141730-20943-1-git-send-email-alon.barlev@gmail.com>
References: <1321141730-20943-1-git-send-email-alon.barlev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321159796.15441.448.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alon,

> Reference: "Flag Variables Ordering"[1]
> 
> In automake, if you modify CFLAGS or LDFLAGS of a target you
> actually override the autoconf supplied flags. This is highly
> none standard and may lead to undesired results, as some
> targets will be compiled with the autoconf supplied flags and
> some won't.
> 
> This patch adds AM_CFLAGS to any flags overridden.
> 
> Some notes:
> 
> 1. Remove none common flags:
> 	-DBLUETOOTH_PLUGIN_BUILTIN -DPLUGINDIR=\""$(build_plugindir)"\"
> Moved to bluetoothd only, as BLUETOOTH_PLUGIN_BUILTIN should
> effect only sources compiled within it.
> And PLUGINDIR is used only by the daemon.
> 
> 2. More targets now will be compiled with:
> 	@DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@
> If this is a problem I will add these to specific
> targets.
> 
> 3. I am not sure there is a reason to set specific
> trivial CFLAGS for simple includes in target specific. Simpler
> is to put all at AM_CFLAGS.
> 
> 4. All @XXX_XXFLAGS@ can actually be used as make macros
> $(XXX_XXFLAGS),
> Since AC_SUBST are automatically generated as make
> macros.

I redid this patch since I needed to add SHORTNAME to not turn the build
output into some ugly mess.

> 5. Why don't you split up the Makefile.am into smaller
> by directory/library? It would be easier to control the
> setup.

We are using non-recursive build on purpose.

Regards

Marcel


