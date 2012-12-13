Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Dec 2012 14:27:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] build: Remove obexd usb plugin
Message-ID: <20121213122711.GA4805@x220>
References: <1355400231-25205-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355400231-25205-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Dec 13, 2012, Luiz Augusto von Dentz wrote:
> This plugin is not longer maintained and used to work only in meego
> times.
> ---
>  Makefile.obexd      |   5 -
>  obexd/plugins/usb.c | 299 ----------------------------------------------------
>  2 files changed, 304 deletions(-)
>  delete mode 100644 obexd/plugins/usb.c

Applied. Thanks.

Johan
