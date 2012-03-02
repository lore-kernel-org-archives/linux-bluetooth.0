Return-Path: <cyrus@holtmann.org>
Message-ID: <1330650944.3392.111.camel@aeonflux>
Subject: Re: [PATCH 1/3] Bluetooth: Fix clearing of HCI_PENDING_CLASS flag
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 01 Mar 2012 17:15:44 -0800
In-Reply-To: <1330650900-11420-1-git-send-email-johan.hedberg@gmail.com>
References: <1330650900-11420-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When doing reset HCI_PENDING_CLASS is one of the flags that should be
> cleared (since it's used for a pending HCI command and a reset clear all
> pending commands).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


