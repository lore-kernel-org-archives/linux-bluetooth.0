Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Jun 2014 22:21:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gitignore: Add cscope files
Message-ID: <20140605192143.GA13789@t440s.P-661HNU-F1>
References: <1391812080-19529-1-git-send-email-andre.guedes@openbossa.org>
 <1391812080-19529-3-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391812080-19529-3-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, Feb 07, 2014, Andre Guedes wrote:
> ---
>  .gitignore | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index b86deae..fe6636e 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -121,3 +121,7 @@ android/android-tester
>  android/ipc-tester
>  android/bluetoothd-snoop
>  android/test-ipc
> +
> +cscope.in.out
> +cscope.out
> +cscope.po.out

Applied. Thanks.

Johan
