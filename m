Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Jul 2014 11:42:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/hal-sco: Remove unneeded check
Message-ID: <20140721084247.GA24049@t440s.lan>
References: <1405694130-6277-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405694130-6277-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jul 18, 2014, Andrei Emeltchenko wrote:
> rsp_len cannot be NULL since it checked for NULL in the beginning of the
> function.
> ---
>  android/hal-sco.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Both patches have been applied. Thanks.

Johan
