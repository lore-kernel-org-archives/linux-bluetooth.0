Return-Path: <cyrus@holtmann.org>
Message-ID: <1329468606.28848.140.camel@aeonflux>
Subject: Re: [RFC 3/4] Bluetooth: Merge INQUIRY and LE_SCAN discovery states
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 09:50:06 +0100
In-Reply-To: <1329429041-30715-4-git-send-email-andre.guedes@openbossa.org>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
	 <1329429041-30715-4-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch merges DISCOVERY_INQUIRY and DISCOVERY_LE_SCAN states
> into a new state called DISCOVERY_FINDING.
> 
> From the discovery perspective, we are pretty much worried about
> to know just if we are finding devices than what exactly phase of
> "finding devices" (inquiry or LE scan) we are currently running.
> Besides, to know if the controller is performing inquiry or LE scan
> we should check HCI_INQUIRY or HCI_LE_SCAN bits in hdev flags.
> 
> Moreover, merging this two states will simplify the discovery state
> machine and will keep interleaved discovery implementation simpler.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    3 +--
>  net/bluetooth/hci_core.c         |    6 ++----
>  net/bluetooth/hci_event.c        |    6 +++---
>  net/bluetooth/mgmt.c             |    2 +-
>  4 files changed, 7 insertions(+), 10 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


