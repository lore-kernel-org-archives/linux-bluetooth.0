Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Use continuous scanning when creating LE connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1449139520-950-1-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 5 Dec 2015 08:17:48 -1000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F5026938-1042-47B4-96E2-44EDC638D5AC@holtmann.org>
References: <1449139520-950-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> All LE connections are now triggered through a preceding passive scan
> and waiting for a connectable advertising report. This means we've got
> the best possible guarantee that the device is within range and should
> be able to request the controller to perform continuous scanning. This
> way we minimize the risk that we miss out on any advertising packets.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@vger.kernel.org # 4.3+
> ---
> net/bluetooth/hci_conn.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

