Return-Path: <cyrus@holtmann.org>
Message-ID: <1329482079.28848.170.camel@aeonflux>
Subject: Re: [PATCH 2/3] Bluetooth: mgmt: Add address type to PIN code
 messages
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 13:34:39 +0100
In-Reply-To: <1329481947-19108-2-git-send-email-johan.hedberg@gmail.com>
References: <1329481947-19108-1-git-send-email-johan.hedberg@gmail.com>
	 <1329481947-19108-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The latest mgmt API includes address types for all messages containing
> an address. This patch updates the PIN code messages to match this.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/mgmt.h |    8 ++++----
>  net/bluetooth/mgmt.c         |   22 +++++++++++++---------
>  2 files changed, 17 insertions(+), 13 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


