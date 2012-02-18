Return-Path: <cyrus@holtmann.org>
Message-ID: <1329547132.28848.193.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Set DISCOVERY_STOPPED if controller resets
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 18 Feb 2012 07:38:52 +0100
In-Reply-To: <1329520360-16874-1-git-send-email-andre.guedes@openbossa.org>
References: <1329520360-16874-1-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> If controller is reset during the discovery procedure, Start
> Discovery command stops working. This can be easily reproduced
> by running "hciconfig hci0 reset" while discovering devices,
> for instance.
> 
> We should force discovery state to DISCOVERY_STOPPED in case we
> receive a reset command complete event. Otherwise we may stuck
> in one of the active discovery states (DISCOVERY_INQUIRY,
> DISCOVERY_LE_SCAN and DISCOVERY_RESOLVING) and subsequent Start
> Discovery commands will simply fail.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


