Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Nov 2011 12:40:29 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Rename mgmt_inquiry_failed()
Message-ID: <20111109144028.GJ25584@joana>
References: <1320792002-31151-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320792002-31151-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2011-11-08 19:40:01 -0300]:

> This patch renames the function mgmt_inquiry_failed() to
> mgmt_start_discovery_failed(). This function is more related
> to MGMT_OP_START_DISCOVERY command handling than to inquiry.
> Besides, this functions will be reused by LE based discovery
> procedures in case of failure.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_event.c        |    2 +-
>  net/bluetooth/mgmt.c             |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

It doesn't apply anymore, please rebase on top of bluetooth-next and resend.
Thanks.

	Gustavo
