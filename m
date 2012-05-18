Return-Path: <cyrus@holtmann.org>
Message-ID: <1337309726.5970.284.camel@aeonflux>
Subject: Re: [PATCH BlueZ v6 03/15] Constify GDBus method tables
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 17 May 2012 19:55:26 -0700
In-Reply-To: <1337278812-4837-4-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337278812-4837-1-git-send-email-lucas.demarchi@profusion.mobi>
	 <1337278812-4837-4-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> Constify method tables with the following command:
> 
> find . -name '*.[ch]' -exec \
> 	     sed -i 's/\(GDBusMethodTable .* =\)/const \1/g' {} \;
> ---
>  attrib/client.c           |    4 ++--
>  audio/control.c           |    2 +-
>  audio/device.c            |    2 +-
>  audio/gateway.c           |    2 +-
>  audio/headset.c           |    2 +-
>  audio/media.c             |    2 +-
>  audio/sink.c              |    2 +-
>  audio/source.c            |    2 +-
>  audio/telephony-dummy.c   |    2 +-
>  audio/telephony-maemo5.c  |    2 +-
>  audio/transport.c         |    2 +-
>  gdbus/object.c            |    2 +-

no. As I said before, I want gdbus/ and other separated.

Regards

Marcel


