Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 3/4] Bluetooth: Set disc_timeout to 0 when calling hci_chan_del
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1408311704-31747-3-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 17 Aug 2014 17:15:15 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <31729561-D8E7-4CAD-A612-1B7CE39A00A1@holtmann.org>
References: <1408311704-31747-1-git-send-email-johan.hedberg@gmail.com> <1408311704-31747-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The hci_chan_del() function is used in scenarios where we've decided we
> want to get rid of the underlying baseband link. It makes therefore
> sense to force the disc_timeout to 0 so that the disconnection routines
> are immediately scheduled.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

