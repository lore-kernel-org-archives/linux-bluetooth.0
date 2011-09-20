Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 10/14] Bluetooth: Add 'eir_len' param to
 mgmt_device_found()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Sep 2011 14:47:35 +0200
In-Reply-To: <1316468136-12472-11-git-send-email-andre.guedes@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org>
	 <1316468136-12472-11-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316522856.1937.88.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds a new parameter to mgmt_device_found() to inform
> the length of 'eir' pointer.
> 
> EIR data from LE advertising report event doesn't have a fixed length
> as EIR data from extended inquiry result event does. We needed to
> change mgmt_device_found() so it copies 'eir_len' bytes instead of
> HCI_MAX_EIR_LENGTH.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_event.c        |    9 +++++----
>  net/bluetooth/mgmt.c             |    7 +++++--
>  3 files changed, 11 insertions(+), 7 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


