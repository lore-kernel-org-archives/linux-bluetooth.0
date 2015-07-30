Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH 3/3] Bluetooth: Move create/accept phy link completed callback to amp.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1437729061-16787-1-git-send-email-arron.wang@intel.com>
Date: Thu, 30 Jul 2015 13:38:04 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9C481BFC-849C-4C14-A54A-6C08314E3E9D@holtmann.org>
References: <1437729061-16787-1-git-send-email-arron.wang@intel.com>
To: Arron Wang <arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arron,

> To avoid amp module hooks from hci_event.c
> 
> Signed-off-by: Arron Wang <arron.wang@intel.com>
> ---
> net/bluetooth/amp.c       |   53 +++++++++++++++++++++++++++++++++++++++++++--
> net/bluetooth/hci_event.c |   49 -----------------------------------------
> 2 files changed, 51 insertions(+), 51 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

