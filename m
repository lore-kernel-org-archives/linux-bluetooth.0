Return-Path: <cyrus@holtmann.org>
Message-ID: <1328285313.2062.41.camel@aeonflux>
Subject: Re: [RFCv2 06/10] Bluetooth: Add locked and unlocked state_change
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 03 Feb 2012 08:08:33 -0800
In-Reply-To: <1328279789-10870-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328279789-10870-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Split to locked and unlocked versions of l2cap_state_change helping
> to remove socket locks from l2cap code.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   39 +++++++++++++++++++++++----------------
>  1 files changed, 23 insertions(+), 16 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


