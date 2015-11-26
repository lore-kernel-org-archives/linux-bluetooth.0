Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 1/2] Bluetooth: Simplify read_adv_features code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448532959-21912-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 26 Nov 2015 06:50:35 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8A942A44-A5CB-4EEC-A9DF-A46072A88D77@holtmann.org>
References: <1448532959-21912-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The code in the Read Advertising Features mgmt command handler is
> unnecessarily complicated. Clean it up and remove unnecessary
> variables & branches.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 28 ++++++++--------------------
> 1 file changed, 8 insertions(+), 20 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

