Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH] Bluetooth: Remove unnecessary 'send' parameter from smp_failure()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383729897-28492-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 6 Nov 2013 21:17:40 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <61396A6F-CC67-4994-834E-1BF45F07BB5E@holtmann.org>
References: <1383729897-28492-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The send parameter has only been used for determining whether to send a
> Pairing Failed PDU or not. However, the function can equally well use
> the already existing reason parameter to make this choice and send the
> PDU whenever a non-zero value was passed.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

