Return-Path: <cyrus@holtmann.org>
Message-ID: <1357277375.19248.128.camel@aeonflux>
Subject: Re: [PATCH BlueZ 1/3] build: Do not use deprecated AM_CONFIG_HEADER
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Thu, 03 Jan 2013 21:29:35 -0800
In-Reply-To: <1357262465-19231-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1357262465-19231-1-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> The long-obsoleted AM_CONFIG_HEADER macro was removed in automake 1.13.
> Use AC_CONFIG_HEADERS instead.
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied.

For extra credits, you could update the other projects as well.

Regards

Marcel


