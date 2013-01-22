Return-Path: <cyrus@holtmann.org>
Message-ID: <1358856331.7365.16.camel@aeonflux>
Subject: Re: [PATCH 3/3] Bluetooth: Add support for reading LE supported
 states
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 22 Jan 2013 04:05:31 -0800
In-Reply-To: <1358856121-1928-3-git-send-email-johan.hedberg@gmail.com>
References: <1358856121-1928-1-git-send-email-johan.hedberg@gmail.com>
	 <1358856121-1928-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The LE supported states indicate the states and state combinations that
> the link layer supports. This is important information for knowing what
> operations are possible when dealing with multiple connected devices.
> This patch adds reading of the supported states to the HCI init
> sequence.
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


