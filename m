Return-Path: <cyrus@holtmann.org>
Message-ID: <1323900588.1965.61.camel@aeonflux>
Subject: Re: [PATCH 4/7] Bluetooth: Move EIR and CoD update functions to a
 better position
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 14 Dec 2011 23:09:48 +0100
In-Reply-To: <1323899524-13653-5-git-send-email-johan.hedberg@gmail.com>
References: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
	 <1323899524-13653-5-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Due to the upcoming addition of a service cache timer the functions to
> update the EIR and CoD need to be higher up in mgmt.c in order to avoid
> unnecessary forward-declarations. This patch simply moves code around
> without any other changes in order to make subsequent patches more
> readable.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |  346 +++++++++++++++++++++++++-------------------------
>  1 files changed, 173 insertions(+), 173 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


