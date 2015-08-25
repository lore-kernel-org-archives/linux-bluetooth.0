Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: hci_h4: Fix zero len data packet reception issue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440435477-25188-1-git-send-email-loic.poulain@intel.com>
Date: Tue, 25 Aug 2015 08:02:04 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <D2FBD3B4-9942-428D-B360-54E1F54CFF24@holtmann.org>
References: <1440435477-25188-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Packets with a variable len equal to zero were not received.
> Since no more data expected (and input buffer entirely consumed), we
> need to complete/forward the packet immediately instead of waiting for
> more data.
> 
> Fix this by completing the packet on !dlen.
> happening if two cases:
>    - no variable data len
>    - variable data len is zero.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_h4.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)

I updated the commit message slightly and then applied the patch to bluetooth-next tree.

Regards

Marcel

