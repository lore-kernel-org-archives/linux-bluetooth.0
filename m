Return-Path: <cyrus@holtmann.org>
Message-ID: <1329840581.2049.17.camel@aeonflux>
Subject: Re: [PATCH 2/9] Bluetooth: mgmt: Fix set_local_name and
 set_dev_class powered checks
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 21 Feb 2012 17:09:41 +0100
In-Reply-To: <1329840005-4977-2-git-send-email-johan.hedberg@gmail.com>
References: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
	 <1329840005-4977-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Both the Set Local Name and the Set Device Class commands should fail if
> the adapter is not powered on.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


