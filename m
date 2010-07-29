Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: host level Support for Atheros AR300x device
From: Marcel Holtmann <marcel@holtmann.org>
To: suraj <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
In-Reply-To: <1280380895-5334-1-git-send-email-suraj@atheros.com>
References: <1280380895-5334-1-git-send-email-suraj@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Jul 2010 23:47:17 -0700
Message-ID: <1280386037.2621.107.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> Implements support for Atheros AR300x Bluetooth chip in
> hciattach application. Supports configuration download
> and power management configure feature.
> ---
>  Makefile.tools         |    1 +
>  tools/hciattach.8      |    6 +
>  tools/hciattach.c      |  120 +++++++
>  tools/hciattach.h      |    3 +
>  tools/hciattach_ar3k.c |  859 ++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 989 insertions(+), 0 deletions(-)
>  create mode 100644 tools/hciattach_ar3k.c
> 
> diff --git a/Makefile.tools b/Makefile.tools
> index 2dbf925..5dc6a1d 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -23,6 +23,7 @@ tools_l2ping_LDADD = lib/libbluetooth.la
>  tools_hciattach_SOURCES = tools/hciattach.c tools/hciattach.h \
>  						tools/hciattach_st.c \
>  						tools/hciattach_ti.c \
> +						tools/hciattach_ar3k.c \
>  						tools/hciattach_tialt.c

why do you sort it this way. Leave ti and tialt next to each and just
attach ar3k at the end.

>  tools_hciattach_LDADD = lib/libbluetooth.la
>  
> diff --git a/tools/hciattach.8 b/tools/hciattach.8
> index 9bd1538..b81e724 100644
> --- a/tools/hciattach.8
> +++ b/tools/hciattach.8
> @@ -66,6 +66,12 @@ specific identifier. Currently supported types are
>  .B any
>  Unspecified HCI_UART interface, no vendor specific options
>  .TP
> +.B ar3kalt
> +Atheros AR300x based serial bluetooth device with power management disabled
> +.TP
> +.B ar3k
> +Atheros AR300x based serial bluetooth device with power management support
> +.TP

We are not doing it this way. Create a proper option of power management
enabled or not.

And it is written Bluetooth.

>  .B ericsson
>  Ericsson based modules
>  .TP

I just hope you tried to sort this alphabetical. Not that the list is
actually alphabetical to begin with.

I actually prefer you just add it after all the other options.

Regards

Marcel


