Return-Path: <cyrus@holtmann.org>
Message-ID: <1357762335.1806.56.camel@aeonflux>
Subject: Re: [PATCH 6/8] Bluetooth: Move non-critical sections outside of
 the dev lock
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Jan 2013 12:12:15 -0800
In-Reply-To: <1357738180-4128-7-git-send-email-johan.hedberg@gmail.com>
References: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
	 <1357738180-4128-7-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch fixes sections of code that do not need hci_lock_dev to be
> outside of the lock. Such sections include code that do not touch the
> hdev at all as well as sections which just read a single byte from the
> supported_features value (i.e. all lmp_*_capable() macros).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   46 ++++++++++++++++++----------------------------
>  1 file changed, 18 insertions(+), 28 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


