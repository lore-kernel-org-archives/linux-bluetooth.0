Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Sep 2013 18:09:12 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Fix encryption key size for peripheral
 role
Message-ID: <20130901170912.GL7440@joana>
References: <1375298729-23513-1-git-send-email-andre.guedes@openbossa.org>
 <1375298729-23513-2-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375298729-23513-2-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

2013-07-31 Andre Guedes <andre.guedes@openbossa.org>:

> This patch fixes the connection encryption key size information when
> the host is playing the peripheral role. We should set conn->enc_key_
> size in hci_le_ltk_request_evt, otherwise it is left uninitialized.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 2 ++
>  1 file changed, 2 insertions(+)

Patches have been applied to bluetooth.git. Thanks.

	Gustavo
