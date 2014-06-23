Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Remove redundant calls to h5_reset_rx
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403530187-9851-1-git-send-email-loic.poulain@intel.com>
Date: Mon, 23 Jun 2014 15:37:39 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <E0DD92CE-4808-4204-8C84-772EB9FEDF53@holtmann.org>
References: <1403530187-9851-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> h5_reset_rx is unconditionally called at the end of
> h5_complete_rx_pkt, no need to call it anymore after
> that.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_h5.c | 2 --
> 1 file changed, 2 deletions(-)

you need to fix this:

  CC      drivers/bluetooth/hci_h5.o
drivers/bluetooth/hci_h5.c: In function ‘h5_rx_crc’:
drivers/bluetooth/hci_h5.c:358:13: warning: unused variable ‘h5’ [-Wunused-variable]
  struct h5 *h5 = hu->priv;
             ^
Regards

Marcel

