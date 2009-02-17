Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Feb 2009 23:57:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] sbc: provide implementation info as a readable string
Message-ID: <20090217215755.GA10933@jh-x301>
References: <1234792791-5797-1-git-send-email-marcandre.lureau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1234792791-5797-1-git-send-email-marcandre.lureau@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Feb 16, 2009, Marc-André Lureau wrote:
> This is mainly useful for logging and debugging.
> ---
>  sbc/sbc.c                 |   14 ++++++++++++++
>  sbc/sbc.h                 |    1 +
>  sbc/sbc_primitives.c      |    1 +
>  sbc/sbc_primitives.h      |    1 +
>  sbc/sbc_primitives_mmx.c  |    1 +
>  sbc/sbc_primitives_neon.c |    1 +
>  6 files changed, 19 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
