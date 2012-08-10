Return-Path: <cyrus@holtmann.org>
Message-ID: <1344578203.1780.5.camel@aeonflux>
Subject: Re: [PATCH BlueZ v3 1/3] rfcomm: Fix checking return value instead
 of errno
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 09 Aug 2012 22:56:43 -0700
In-Reply-To: <1344544143-12805-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1344544143-12805-1-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> We were checking by a positive return value instead of checking by -1
> and errno. However when there's no support for TTY kernel returns
> EOPNOTSUPP as usual, which in the end will have a return value of -1
> and errno will be set to EOPNOTSUPP.
> ---
>  tools/rfcomm.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

all 3 patches have been applied.

Regards

Marcel


