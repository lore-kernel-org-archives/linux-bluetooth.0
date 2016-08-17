Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BlueZ v3] client: Add better support for managing devices of multiple controllers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1471419377-9522-1-git-send-email-michal.narajowski@codecoup.pl>
Date: Wed, 17 Aug 2016 09:45:17 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <88A4E00C-20B0-47D6-A22A-16D632CE24F5@holtmann.org>
References: <1471419377-9522-1-git-send-email-michal.narajowski@codecoup.pl>
To: =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> Previously devices list was cleared when selecting new default
> controller. Now devices list is preserverd allowing to list and suggest
> devices for default controller even after changing the default
> controller.
> ---
> Makefile.tools |   2 +-
> client/main.c  | 262 +++++++++++++++++++++++++++++++++++++++++----------------
> 2 files changed, 189 insertions(+), 75 deletions(-)
> 
> diff --git a/Makefile.tools b/Makefile.tools
> index 7706dc7..944c8e9 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -10,7 +10,7 @@ client_bluetoothctl_SOURCES = client/main.c \
> 					client/gatt.h client/gatt.c \
> 					monitor/uuid.h monitor/uuid.c
> client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@ \
> -				-lreadline
> +				-lreadline src/libshared-mainloop.la

I have no idea on how this is going to work. It would need to be libshared-glib.la first of all, and second of all, what would you be using in a D-Bus client that justifies using it.

Regards

Marcel

