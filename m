Return-Path: <cyrus@holtmann.org>
Message-ID: <1329468633.28848.141.camel@aeonflux>
Subject: Re: [RFC 2/4] Bluetooth: Track discovery type
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 09:50:33 +0100
In-Reply-To: <1329429041-30715-3-git-send-email-andre.guedes@openbossa.org>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
	 <1329429041-30715-3-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds to struct discovery_state the field 'type' so that
> we can track the discovery type the device is performing.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |    2 ++
>  net/bluetooth/mgmt.c             |    4 +++-
>  3 files changed, 6 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


