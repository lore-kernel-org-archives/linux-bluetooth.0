Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Allow using obexd without systemd in the user session
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381592725-28212-1-git-send-email-scampa.giovanni@gmail.com>
Date: Sat, 12 Oct 2013 18:08:33 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Giovanni Campagna <gcampagna@src.gnome.org>
Message-Id: <0262656B-5656-422C-B12D-C6BF7239AA11@holtmann.org>
References: <1381592725-28212-1-git-send-email-scampa.giovanni@gmail.com>
To: Giovanni Campagna <scampa.giovanni@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Giovanni,

> Not all sessions run systemd --user (actually, the majority
> doesn't), so the dbus daemon must be able to spawn obexd
> directly, and to do so it needs the full path of the daemon.
> ---
> Makefile.obexd                      | 4 ++--
> obexd/src/org.bluez.obex.service    | 4 ----
> obexd/src/org.bluez.obex.service.in | 4 ++++
> 3 files changed, 6 insertions(+), 6 deletions(-)
> delete mode 100644 obexd/src/org.bluez.obex.service
> create mode 100644 obexd/src/org.bluez.obex.service.in
> 
> diff --git a/Makefile.obexd b/Makefile.obexd
> index d5377cb..751e0e5 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -2,12 +2,12 @@
> if SYSTEMD
> systemduserunitdir = @SYSTEMD_USERUNITDIR@
> systemduserunit_DATA = obexd/src/obex.service
> +endif
> 
> dbussessionbusdir = @DBUS_SESSIONBUSDIR@
> dbussessionbus_DATA = obexd/src/org.bluez.obex.service
> -endif
> 
> -EXTRA_DIST += obexd/src/obex.service.in obexd/src/org.bluez.obex.service
> +EXTRA_DIST += obexd/src/obex.service.in obexd/src/org.bluez.obex.service.in
> 
> obex_plugindir = $(libdir)/obex/plugins
> 
> diff --git a/obexd/src/org.bluez.obex.service b/obexd/src/org.bluez.obex.service
> deleted file mode 100644
> index a538088..0000000
> --- a/obexd/src/org.bluez.obex.service
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -[D-BUS Service]
> -Name=org.bluez.obex
> -Exec=/bin/false
> -SystemdService=dbus-org.bluez.obex.service
> diff --git a/obexd/src/org.bluez.obex.service.in b/obexd/src/org.bluez.obex.service.in
> new file mode 100644
> index 0000000..9c815f2
> --- /dev/null
> +++ b/obexd/src/org.bluez.obex.service.in
> @@ -0,0 +1,4 @@
> +[D-BUS Service]
> +Name=org.bluez.obex
> +Exec=@libexecdir@/obexd
> +SystemdService=dbus-org.bluez.obex.service

that is something your distro specific package should be fixing if that is needed. The focus is on integration with systemd and nothing else. You can use --disable-systemd and provide your own set of D-Bus service files.

Regards

Marcel

