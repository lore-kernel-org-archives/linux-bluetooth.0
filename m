Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add -v and -d options to l2ping
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090107021925.0B49537A5CE@localhost>
References: <20090107021925.0B49537A5CE@localhost>
Content-Type: text/plain
Date: Sun, 18 Jan 2009 16:56:28 +0100
Message-Id: <1232294188.5095.30.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> --- a/tools/l2ping.c	2008-08-29 15:42:24.000000000 -0700
> +++ b/tools/l2ping.c	2009-01-06 17:26:29.000000000 -0800
> @@ -51,6 +51,7 @@
>  static int count   = -1;
>  static int timeout = 10;
>  static int reverse = 0;
> +static int verify = 0;

patch has been applied, but I need another one from you that updates the
manpage for l2ping. They always come together. Please remember that.

Regards

Marcel


