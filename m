Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1321170050-18323-1-git-send-email-alon.barlev@gmail.com>
References: <1321159852.15441.449.camel@aeonflux>
	<1321170050-18323-1-git-send-email-alon.barlev@gmail.com>
Date: Wed, 16 Nov 2011 20:38:47 +0200
Message-ID: <CAOazyz1gyTFsnoRBaWSShUi+GLw3enZ_U=UGYNJxVBH4gbDVVg@mail.gmail.com>
Subject: Re: [PATCH] Automake - do not override LDFLAGS
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Nov 13, 2011 at 9:40 AM, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> Add AM_LDFLAGS to every _LDFLAGS, so that autoconf's
> LDFLAGS won't be overridden.
> ---
>  Makefile.am |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>

Hello,
Any comment?
If we fixed the CFLAGS, good to have the LDFLAGS synced.
Thanks!
