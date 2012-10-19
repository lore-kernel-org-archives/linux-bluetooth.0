Return-Path: <cyrus@holtmann.org>
Message-ID: <1350667534.1785.6.camel@aeonflux>
Subject: Re: [PATCH 6/6] Bluetooth: Read adversiting channel TX power during
 init sequence
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 19 Oct 2012 10:25:34 -0700
In-Reply-To: <1350666911-6334-7-git-send-email-johan.hedberg@gmail.com>
References: <1350666911-6334-1-git-send-email-johan.hedberg@gmail.com>
	 <1350666911-6334-7-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds the reading of the LE advertising channel TX power to
> the HCI init sequence of LE-capable controllers. This data will be used
> e.g. for inclusion in the advertising data packets when advertising is
> enabled.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h      |    6 ++++++
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_event.c        |   20 ++++++++++++++++++++
>  3 files changed, 28 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


