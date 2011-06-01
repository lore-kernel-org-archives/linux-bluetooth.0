Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Jun 2011 16:38:30 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] Bluetooth: Set 'peer_addr_type' in hci_le_connect()
Message-ID: <20110601193830.GD2564@joana>
References: <1306862457-20310-1-git-send-email-andre.guedes@openbossa.org>
 <1306862457-20310-4-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306862457-20310-4-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2011-05-31 14:20:57 -0300]:

> Set the 'peer_addr_type' field of the LE Create Connection command
> sent in hci_le_connect().
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> Acked-by: Ville Tervo <ville.tervo@nokia.com>
> ---
>  net/bluetooth/hci_conn.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

All four patches applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
