Return-Path: <cyrus@holtmann.org>
Message-ID: <1358856284.7365.14.camel@aeonflux>
Subject: Re: [PATCH 1/3] Bluetooth: Add LE Local Features reading support
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 22 Jan 2013 04:04:44 -0800
In-Reply-To: <1358856121-1928-1-git-send-email-johan.hedberg@gmail.com>
References: <1358856121-1928-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To be able to make the appropriate decisions for some LE procedures we
> need to know the LE features that the local controller supports.
> Therefore, it's important to have the LE Read Local Supported Features
> HCI comand as part of the HCI init sequence.
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


