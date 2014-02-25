Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Ignore IRKs with no Identity Address
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393359877-17839-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 25 Feb 2014 12:32:06 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <6122B04E-887A-47A9-AB4B-3B61543CF1A6@holtmann.org>
References: <1393359877-17839-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The Core Specification (4.1) leaves room for sending an SMP Identity
> Address Information PDU with an all-zeros BD_ADDR value. This
> essentially means that we would not have an Identity Address for the
> device and the only means of identifying it would be the IRK value
> itself.
> 
> Due to lack of any known implementations behaving like this it's best to
> keep our implementation as simple as possible as far as handling such
> situations is concerned. This patch updates the Identity Address
> Information handler function to simply ignore the IRK received from such
> a device.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

