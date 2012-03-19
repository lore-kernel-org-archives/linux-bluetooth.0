Return-Path: <cyrus@holtmann.org>
Message-ID: <1332178697.14217.212.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: mgmt: Fix timeout type
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 19 Mar 2012 10:38:17 -0700
In-Reply-To: <1332142951-20703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332142951-20703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Silence sparse warnings:
> net/bluetooth/mgmt.c:865:19: warning: cast to restricted __le16
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/mgmt.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


