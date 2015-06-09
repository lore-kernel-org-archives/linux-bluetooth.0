Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v3 2/2] Bluetooth: Move SCO support under BT_BREDR config option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433843243-11668-2-git-send-email-arron.wang@intel.com>
Date: Tue, 9 Jun 2015 13:43:16 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7668F1BB-60FA-4E9D-9A67-1FF0FF0923F8@holtmann.org>
References: <1433843243-11668-1-git-send-email-arron.wang@intel.com> <1433843243-11668-2-git-send-email-arron.wang@intel.com>
To: Arron Wang <arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arron,

> SCO/eSCO link is supported by BR/EDR controller, it is
> suitable to move them under BT_BREDR config option
> 
> Signed-off-by: Arron Wang <arron.wang@intel.com>
> ---
> include/net/bluetooth/bluetooth.h |   11 +++++++++++
> include/net/bluetooth/hci_core.h  |   12 ++++++++++++
> net/bluetooth/Makefile            |    3 ++-
> 3 files changed, 25 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

