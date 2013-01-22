Return-Path: <cyrus@holtmann.org>
Message-ID: <1358856309.7365.15.camel@aeonflux>
Subject: Re: [PATCH 2/3] Bluetooth: Add support for reading LE White List
 Size
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 22 Jan 2013 04:05:09 -0800
In-Reply-To: <1358856121-1928-2-git-send-email-johan.hedberg@gmail.com>
References: <1358856121-1928-1-git-send-email-johan.hedberg@gmail.com>
	 <1358856121-1928-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The LE White List Size is necessary to be known before attempting to
> feed the controller with any addresses intended for the white list. This
> patch adds the necessary HCI command sending to the HCI init sequence.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h      |    6 ++++++
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_event.c        |   20 ++++++++++++++++++++
>  3 files changed, 27 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


