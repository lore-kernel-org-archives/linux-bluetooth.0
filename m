Return-Path: <cyrus@holtmann.org>
Message-ID: <1323093355.26198.53.camel@aeonflux>
Subject: Re: [RFCv1 1/3] Bluetooth: Add HCI Read Data Block Size function
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 05 Dec 2011 14:55:55 +0100
In-Reply-To: <1323089704-1005-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323089704-1005-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1323089704-1005-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Implement block size read function. Use different variables for
> packet-based and block-based flow control.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h      |    8 ++++++++
>  include/net/bluetooth/hci_core.h |    5 +++++
>  net/bluetooth/hci_event.c        |   26 ++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


