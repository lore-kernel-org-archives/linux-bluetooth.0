Return-Path: <cyrus@holtmann.org>
Message-ID: <1329482109.28848.171.camel@aeonflux>
Subject: Re: [PATCH 3/3] Bluetooth: mgmt: Add address type to confirm name
 command
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 13:35:09 +0100
In-Reply-To: <1329481947-19108-3-git-send-email-johan.hedberg@gmail.com>
References: <1329481947-19108-1-git-send-email-johan.hedberg@gmail.com>
	 <1329481947-19108-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The latest mgmt API includes an address type for all messages containing
> an address. This patch updates the confirm name command to match this.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/mgmt.h |    4 ++--
>  net/bluetooth/mgmt.c         |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


