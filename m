Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Nov 2011 15:41:36 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: mgmt_stop_discovery_failed()
Message-ID: <20111116174133.GB16865@joana>
References: <1320869667-1373-1-git-send-email-andre.guedes@openbossa.org>
 <1320869667-1373-2-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320869667-1373-2-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2011-11-09 17:14:26 -0300]:

> This patches creates mgmt_stop_discovery_failed() which removes
> pending MGMT_OP_STOP_DISCOVERY commands and sends proper command
> status events.
> 
> This patch also fixes the MGMT_OP_STOP_DISCOVERY command leak in
> case cancel inquiry fails.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_event.c        |    6 +++++-
>  net/bluetooth/mgmt.c             |   15 +++++++++++++++
>  3 files changed, 21 insertions(+), 1 deletions(-)

Patches 1 and 2 have been applied, patch 3 doesn't apply anymore. Thanks.

	Gustavo
