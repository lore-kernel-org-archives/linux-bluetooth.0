Return-Path: <cyrus@holtmann.org>
Message-ID: <1328798401.28848.31.camel@aeonflux>
Subject: Re: [RFCv3 14/16] Bluetooth: Change locking logic in security_cfm
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 09 Feb 2012 15:40:01 +0100
In-Reply-To: <1328797057-26331-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328797057-26331-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Change bh_ locking functions to mutex_locks since we can now sleep.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   15 ++++++++++-----
>  1 files changed, 10 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


