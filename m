Return-Path: <cyrus@holtmann.org>
Message-ID: <1328285189.2062.39.camel@aeonflux>
Subject: Re: [RFCv2 04/10] Bluetooth: Revert to mutexes from RCU list
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 03 Feb 2012 08:06:29 -0800
In-Reply-To: <1328279789-10870-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328279789-10870-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
>  net/bluetooth/l2cap_core.c |  110 ++++++++++++++++++++++---------------------
>  1 files changed, 56 insertions(+), 54 deletions(-)

I don't see anything wrong with this patch, but I am waiting for Ulisses
to take a look as well.

Regards

Marcel


