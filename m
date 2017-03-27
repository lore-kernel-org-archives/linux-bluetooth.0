Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] Bluetooth: Change initial min and max interval
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170223141702.32390-1-jonashg@axis.com>
Date: Mon, 27 Mar 2017 16:24:58 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5FC2D3D4-F74B-4B15-B4E6-50B9CEC4FBD0@holtmann.org>
References: <20170223141702.32390-1-jonashg@axis.com>
To: jonas.holmberg@axis.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jonas,

> Use the initial connection interval recommended in Bluetooth
> Specification v4.2 (30ms - 50ms).
> 
> Signed-off-by: Jonas Holmberg <jonashg@axis.com>
> ---
> net/bluetooth/hci_core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

