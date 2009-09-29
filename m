Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix parallel build
From: Marcel Holtmann <marcel@holtmann.org>
To: Adam =?UTF-8?Q?Go=C5=82=C4=99biowski?= <adamg@pld-linux.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1253617145-190991-1-git-send-email-adamg@pld-linux.org>
References: <1253617145-190991-1-git-send-email-adamg@pld-linux.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 29 Sep 2009 12:55:09 -0700
Message-Id: <1254254109.2659.91.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

> Since src/bluetoothd needs libbluetooth, add it to its dependencies.
> Parallel build tested with make -j16.
> 
> Signed-off-by: Adam Gołębiowski <adamg@pld-linux.org>
> ---
>  Makefile.am |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

actually I already applied this patch.

Regards

Marcel


