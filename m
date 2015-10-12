Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH] Bluetooth: Don't use remote address type to decide IRK persistency
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1444649779-29859-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 12 Oct 2015 22:45:53 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EC24C21F-47BA-4EF3-BC5B-B6D5E9A1E797@holtmann.org>
References: <1444649779-29859-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There are LE devices on the market that start off by announcing their
> public address and then once paired switch to using private address.
> To be interoperable with such devices we should simply trust the fact
> that we're receiving an IRK from them to indicate that they may use
> private addresses in the future. Instead, simply tie the persistency
> to the bonding/no-bonding information the same way as for LTKs and
> CSRKs.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 +-
> net/bluetooth/mgmt.c             | 18 ++----------------
> net/bluetooth/smp.c              | 33 +++++++++++++++++----------------
> 3 files changed, 20 insertions(+), 33 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

