Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Add retransmission effort into SCO parameter table
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1411587706-25498-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 24 Sep 2014 22:16:29 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <56222D5A-34D5-422C-BC39-706F2D593551@holtmann.org>
References: <1411587706-25498-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> It is expected that new parameter combinations will have the
> retransmission effort value different between some entries (mainly
> because of the new S4 configuration added by HFP 1.7), so it makes sense
> to move it into the table instead of having it hard coded based on the
> selected SCO_AIRMODE_*.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c | 23 +++++++++++------------
> 1 file changed, 11 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

