Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v6 2/4] Bluetooth: Fix LE responder/initiator address setting
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395685313-26085-2-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 24 Mar 2014 13:31:31 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C2E036E1-A5F4-43E8-88A9-E26A08472C9C@holtmann.org>
References: <1395685313-26085-1-git-send-email-johan.hedberg@gmail.com> <1395685313-26085-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Once directed advertising is brought into the picture simply the lack of
> an hci_conn object when an le_conn_complete event occurs is no longer a
> reliable indication that the responder & initiator values need to be
> set based on our advertising address type.
> 
> This patch moves the code for setting these values outside of the
> "if (!conn)" branch and ensures that they get set for any connection
> where we are in the slave role.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 26 ++++++++++++++------------
> 1 file changed, 14 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

