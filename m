Return-Path: <cyrus@holtmann.org>
Message-ID: <1328797634.28848.21.camel@aeonflux>
Subject: Re: [RFCv3 02/16] Bluetooth: Revert to mutexes from RCU list
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 09 Feb 2012 15:27:14 +0100
In-Reply-To: <1328797057-26331-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328797057-26331-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Usage of RCU list looks not reasonalbe for a number of reasons:
> our code sleep and we have to use socket spinlocks, some parts
> of code are updaters thus we need to use mutexes anyway.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |  108 ++++++++++++++++++++++----------------------
>  1 files changed, 54 insertions(+), 54 deletions(-)

I am fine with this, but I wanna get an ack from Ulisses as well.

Regards

Marcel


