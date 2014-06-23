Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCHv2] Bluetooth: Remove redundant calls to h5_reset_rx
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403531386-10331-1-git-send-email-loic.poulain@intel.com>
Date: Mon, 23 Jun 2014 16:04:40 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <D3B18699-747A-43A1-92C8-5686CC355D8B@holtmann.org>
References: <1403531386-10331-1-git-send-email-loic.poulain@intel.com>
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
> v2: remove unused h5
> 
> drivers/bluetooth/hci_h5.c | 4 ----
> 1 file changed, 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

