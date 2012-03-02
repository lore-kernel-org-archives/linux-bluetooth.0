Return-Path: <cyrus@holtmann.org>
Message-ID: <1330651001.3392.113.camel@aeonflux>
Subject: Re: [PATCH 3/3] Bluetooth: mgmt: Add new error code for invalid
 index
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 01 Mar 2012 17:16:41 -0800
In-Reply-To: <1330650900-11420-3-git-send-email-johan.hedberg@gmail.com>
References: <1330650900-11420-1-git-send-email-johan.hedberg@gmail.com>
	 <1330650900-11420-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The index is part of the command header and not its parameters so it
> makes sense to distinguish this from the invalid parameters error.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/mgmt.h |    1 +
>  net/bluetooth/mgmt.c         |    6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


