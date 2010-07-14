Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v7 1/4] add one more buffer for stream reassembly
From: Marcel Holtmann <marcel@holtmann.org>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
In-Reply-To: <1279092739-4623-1-git-send-email-suraj@atheros.com>
References: <1279092739-4623-1-git-send-email-suraj@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Jul 2010 09:41:54 -0300
Message-ID: <1279111314.6282.46.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> Additional reassembly buffer to keep track of stream reasembly
> 
> Signed-off-by: Suraj Sumangala <suraj@atheros.com>
> ---
>  include/net/bluetooth/hci_core.h |    4 ++--
>  net/bluetooth/hci_core.c         |    6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

I am failing to apply this patch against bluetooth-next-2.6 tree. Can
you please ensure they apply cleanly.

Regards

Marcel


