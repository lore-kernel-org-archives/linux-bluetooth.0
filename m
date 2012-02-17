Return-Path: <cyrus@holtmann.org>
Message-ID: <1329482050.28848.169.camel@aeonflux>
Subject: Re: [PATCH 1/3] Bluetooth: mgmt: Add address type to link key
 messages
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 13:34:10 +0100
In-Reply-To: <1329481947-19108-1-git-send-email-johan.hedberg@gmail.com>
References: <1329481947-19108-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The latest mgmt API includes an address type wherever there's an address
> present. This patch updates the link key messages to match it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/mgmt.h |    2 +-
>  net/bluetooth/mgmt.c         |    7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


