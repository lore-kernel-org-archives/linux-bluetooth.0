Return-Path: <cyrus@holtmann.org>
Message-ID: <1328798133.28848.26.camel@aeonflux>
Subject: Re: [RFCv3 09/16] Bluetooth: Use chan lock in L2CAP sig commands
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 09 Feb 2012 15:35:33 +0100
In-Reply-To: <1328797057-26331-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328797057-26331-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Convert sk lock to chan lock for L2CAP signalling commands.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   76 +++++++++++++++++++++++++++++++-------------
>  1 files changed, 54 insertions(+), 22 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


