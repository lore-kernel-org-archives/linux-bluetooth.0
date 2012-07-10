Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jul 2012 18:18:18 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] hog: fix build with --disable-gatt
Message-ID: <20120710211818.GA4436@x220>
References: <1341954812-10255-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1341954812-10255-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João Paulo,

On Tue, Jul 10, 2012, João Paulo Rechi Vita wrote:
> To be able to build HoG only if gatt and input are enabled it needs
> a separate plugin manager.
> ---
>  Makefile.am                  |    3 +-
>  profiles/input/hog_manager.c |   93 ++++++++++++++++++++++++++++++++++++++++++
>  profiles/input/main.c        |   21 ----------
>  profiles/input/manager.c     |   35 ----------------
>  profiles/input/manager.h     |    3 --
>  5 files changed, 95 insertions(+), 60 deletions(-)
>  create mode 100644 profiles/input/hog_manager.c

Applied. Thanks.

Johan
