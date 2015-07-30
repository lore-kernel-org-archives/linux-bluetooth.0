Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH 1/3] Bluetooth: Move get info completed callback to a2mp.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1437729016-16715-1-git-send-email-arron.wang@intel.com>
Date: Thu, 30 Jul 2015 13:38:09 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BBDCBDA4-2BC8-430E-9350-5C65395AC8EB@holtmann.org>
References: <1437729016-16715-1-git-send-email-arron.wang@intel.com>
To: Arron Wang <arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arron,

> To avoid a2mp module hooks from hci_event.c and send
> getinfo response operation only required by a2mp module,
> we can move this callback to a2mp.c
> 
> Signed-off-by: Arron Wang <arron.wang@intel.com>
> ---
> net/bluetooth/a2mp.c      |   17 ++++++++++++++++-
> net/bluetooth/hci_event.c |    5 +----
> 2 files changed, 17 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

