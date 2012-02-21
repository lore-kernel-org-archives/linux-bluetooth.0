Return-Path: <cyrus@holtmann.org>
Message-ID: <1329840933.2049.23.camel@aeonflux>
Subject: Re: [PATCH 5/9] Bluetooth: mgmt: Add convenience function for
 sending New Settings
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 21 Feb 2012 17:15:33 +0100
In-Reply-To: <1329840005-4977-5-git-send-email-johan.hedberg@gmail.com>
References: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
	 <1329840005-4977-5-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The New Settings event needs to be sent from quite many places so it
> makes sense to have a convenience function for it to simplify the code.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   96 +++++++++++++++++++++++---------------------------
>  1 files changed, 44 insertions(+), 52 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


