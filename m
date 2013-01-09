Return-Path: <cyrus@holtmann.org>
Message-ID: <1357762110.1806.53.camel@aeonflux>
Subject: Re: [PATCH 4/8] Bluetooth: Fix accepting set_dev_class for
 non-BR/EDR controllers
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Jan 2013 12:08:30 -0800
In-Reply-To: <1357738180-4128-5-git-send-email-johan.hedberg@gmail.com>
References: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
	 <1357738180-4128-5-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The concept of Class of Device only exists for BR/EDR controllers. The
> mgmt_set_dev_class command should therefore return a proper "not
> supported" error if it is attempted for a controller that doesn't
> support BR/EDR (e.g. a single mode LE-only one).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


