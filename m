Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 19:17:28 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 8/8] Bluetooth: Use lmp_no_flush_capable where applicable
Message-ID: <20120724221728.GK20029@joana>
References: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
 <1343153033-898-8-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343153033-898-8-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2012-07-24 15:03:53 -0300]:

> This patch replaces all LMP_NO_FLUSH bit checking by the helper
> macro lmp_no_flush_capable.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All 8 patches have been applied to bluetooth-next. Thanks.

	Gustavo
