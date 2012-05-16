Return-Path: <cyrus@holtmann.org>
Message-ID: <1337211803.5970.274.camel@aeonflux>
Subject: Re: [PATCH BlueZ v5 09/13] gdbus: remove signatures from tables
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 16 May 2012 16:43:23 -0700
In-Reply-To: <1337211193-18230-10-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337211193-18230-1-git-send-email-lucas.demarchi@profusion.mobi>
	 <1337211193-18230-10-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

>  attrib/client.c           |   12 +++++-----
>  audio/control.c           |   18 +++++++--------
>  audio/device.c            |   13 +++++------
>  audio/gateway.c           |   16 ++++++-------
>  audio/headset.c           |   55 +++++++++++++++++++++------------------------
>  audio/media.c             |    8 +++----
>  audio/sink.c              |   25 +++++++++------------
>  audio/source.c            |   14 +++++-------
>  audio/telephony-dummy.c   |   18 +++++++--------
>  audio/telephony-maemo5.c  |    2 +-
>  audio/transport.c         |   10 ++++-----
>  gdbus/gdbus.h             |    3 ---
>  gdbus/object.c            |    2 +-

you can not intermix this. I want gdbus/ patches separated.

> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> index 610cb19..e9e8929 100644
> --- a/gdbus/gdbus.h
> +++ b/gdbus/gdbus.h
> @@ -91,8 +91,6 @@ typedef struct {
>  
>  typedef struct {
>  	const char *name;
> -	const char *signature;
> -	const char *reply;
>  	GDBusMethodFunction function;
>  	GDBusMethodFlags flags;
>  	unsigned int privilege;
> @@ -102,7 +100,6 @@ typedef struct {
>  
>  typedef struct {
>  	const char *name;
> -	const char *signature;
>  	GDBusSignalFlags flags;
>  	const GDBusArgInfo *args;
>  } GDBusSignalTable;

instead of removing these, why don't we make them NULL and start
using .function and .flags syntax for the method/signal tables as a
first step.

Regards

Marcel


