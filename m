Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: Remove deprecated create_singlethread_workqueue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160830171252.GA32272@Karyakshetra>
Date: Wed, 31 Aug 2016 05:48:15 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <B25D5088-AFE6-4012-ABF8-B1B06AA1C49C@holtmann.org>
References: <20160830171252.GA32272@Karyakshetra>
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bhaktipriya,

> The workqueue "workqueue" queues multiple work items viz &qca->ws_awake_rx
> &qca->ws_rx_vote_off, &qca->ws_awake_device, &qca->ws_tx_vote_off which
> require strict execution ordering. Hence, an ordered dedicated workqueue
> has been used to replace the deprecated create_singlethread_workqueue
> instance.
> 
> WQ_MEM_RECLAIM has not been set since the driver is not being used on a
> memory reclaim path.
> 
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
> ---
> drivers/bluetooth/hci_qca.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
