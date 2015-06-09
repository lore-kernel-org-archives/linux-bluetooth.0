Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2 1/2] Bluetooth: Don't call shutdown when leaving user channel
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433843190-4252-1-git-send-email-loic.poulain@intel.com>
Date: Tue, 9 Jun 2015 11:48:36 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DF05E952-063E-421E-8ECE-99C59E69280B@holtmann.org>
References: <1433843190-4252-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Don't interfere with the user channel exclusive access.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: Rebase on d24d81444f8 (HCI_UP test)
> net/bluetooth/hci_core.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

