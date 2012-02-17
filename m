Return-Path: <cyrus@holtmann.org>
Message-ID: <1329467629.28848.126.camel@aeonflux>
Subject: Re: [PATCH 1/4] Bluetooth: Remove unused member from cmd_lookup
 struct
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 09:33:49 +0100
In-Reply-To: <1329434578-5928-1-git-send-email-johan.hedberg@gmail.com>
References: <1329434578-5928-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The val member of cmd_lookup isn't used anywhere so it can be removed.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


