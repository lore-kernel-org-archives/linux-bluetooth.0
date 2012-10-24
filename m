Return-Path: <cyrus@holtmann.org>
Message-ID: <1351103142.1785.70.camel@aeonflux>
Subject: Re: [PATCH 6/7] Bluetooth: Add flag for LE GAP Peripheral role
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 24 Oct 2012 11:25:42 -0700
In-Reply-To: <1351102323-4654-7-git-send-email-johan.hedberg@gmail.com>
References: <1351102323-4654-1-git-send-email-johan.hedberg@gmail.com>
	 <1351102323-4654-7-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds a flag to be used for LE GAP Peripheral role. In this
> role undirected advertising will be enabled and operations not allowed
> in Peripheral role (such as scanning and initiating connections) will be
> disallowed.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h |    1 +
>  1 file changed, 1 insertion(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


