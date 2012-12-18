Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Dec 2012 17:22:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4] hog: Merge hog_manager.c code into hog_device.c
Message-ID: <20121218152220.GA16149@x220>
References: <1355841681-2589-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355841681-2589-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Dec 18, 2012, Andre Guedes wrote:
> This patch merges hog_manager.c code into hog_device.c and removes
> hog_manager.c file. hog_manager.c is a very small file, so there is
> no need to keep it separated.
> ---
>  Makefile.plugins             |   6 +-
>  profiles/input/hog_device.c  | 117 +++++++++++++++++++++++++++++++
>  profiles/input/hog_manager.c | 161 -------------------------------------------
>  3 files changed, 120 insertions(+), 164 deletions(-)
>  delete mode 100644 profiles/input/hog_manager.c

All patches in this set have been applied. Thanks.

Johan
