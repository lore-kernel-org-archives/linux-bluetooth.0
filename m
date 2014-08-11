Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Aug 2014 10:34:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Fix using uninitialized variable
Message-ID: <20140811073408.GA22636@t440s>
References: <1407741422-30755-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407741422-30755-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Aug 11, 2014, Andrei Emeltchenko wrote:
> Fix typo not initializing variable. Silence warnings:
> 
> ...
> /android/tester-hdp.c: 71 in create_app()
> /android/tester-hdp.c: 97 in create_app()
> ...
> >>>     Using uninitialized value "mdep2". Field
> >>>     "mdep2.mdep_description" is uninitialized.
> 71              reg->mdep_cfg[1] = mdep2;
> ...
> >>>     Using uninitialized value "mdep2". Field
> >>>     "mdep2.mdep_description" is uninitialized.
> 97              reg->mdep_cfg[1] = mdep2;
> ...
> ---
>  android/tester-hdp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
