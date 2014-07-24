Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Jul 2014 11:04:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/client: Fix double close issue
Message-ID: <20140724080430.GE6356@t440s.lan>
References: <1406115301-18812-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406115301-18812-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Jul 23, 2014, Andrei Emeltchenko wrote:
> File is closed inside reading thread. Fixes:
> ...
> Error in
> `.../bluez/android/haltest':
> double free or corruption (!prev): 0x000000000065a5e0 ***
> 
> Program received signal SIGABRT, Aborted.
> ...
> ---
>  android/client/if-sco.c | 2 ++
>  1 file changed, 2 insertions(+)

All four patches have been applied. Thanks.

Johan
