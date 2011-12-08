Return-Path: <cyrus@holtmann.org>
Message-ID: <1323356083.1965.43.camel@aeonflux>
Subject: Re: [PATCHv1 5/6] Bluetooth: Correct packet len calculation
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 08 Dec 2011 16:54:43 +0200
In-Reply-To: <1323348786-18134-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323348786-18134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1323348786-18134-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Remove unneeded skb_pull and correct packet length calculation
> removing magic number. Move BT_DBG after len check otherwise
> it could possibly access wrong memory.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_event.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


