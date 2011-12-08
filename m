Return-Path: <cyrus@holtmann.org>
Message-ID: <1323356113.1965.44.camel@aeonflux>
Subject: Re: [PATCHv1 6/6] Bluetooth: Process num completed data blocks event
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 08 Dec 2011 16:55:13 +0200
In-Reply-To: <1323348786-18134-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323348786-18134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1323348786-18134-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Adds support for Number Of Completed Data Blocks Event. Highly
> modified version of Code Aurora code.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h |   13 +++++++++
>  net/bluetooth/hci_event.c   |   58 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


