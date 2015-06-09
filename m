Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v3 1/2] Bluetooth: Make l2cap_recv_acldata() and sco_recv_scodata() return void
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433843243-11668-1-git-send-email-arron.wang@intel.com>
Date: Tue, 9 Jun 2015 13:43:18 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9B9BF494-89E9-4CC3-A919-91444F0F80A9@holtmann.org>
References: <1433843243-11668-1-git-send-email-arron.wang@intel.com>
To: Arron Wang <arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arron,

> The return value of l2cap_recv_acldata() and sco_recv_scodata()
> are not used, then change it to return void
> 
> Signed-off-by: Arron Wang <arron.wang@intel.com>
> ---
> include/net/bluetooth/hci_core.h |    4 ++--
> net/bluetooth/l2cap_core.c       |    5 ++---
> net/bluetooth/sco.c              |    5 ++---
> 3 files changed, 6 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

