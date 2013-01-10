Return-Path: <cyrus@holtmann.org>
Message-ID: <1357862057.1806.76.camel@aeonflux>
Subject: Re: [PATCH neard 2/2] build: Do not use deprecated AM_CONFIG_HEADER
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, linux-nfc@lists.01.org
Date: Thu, 10 Jan 2013 15:54:17 -0800
In-Reply-To: <1357831094-13513-2-git-send-email-lucas.demarchi@profusion.mobi>
References: <1357831094-13513-1-git-send-email-lucas.demarchi@profusion.mobi>
	 <1357831094-13513-2-git-send-email-lucas.demarchi@profusion.mobi>
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

Regards

Marcel


