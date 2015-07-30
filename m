Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH 2/3] Bluetooth: Move amp assoc read/write completed callback to amp.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1437729050-16750-1-git-send-email-arron.wang@intel.com>
Date: Thu, 30 Jul 2015 13:38:05 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2D5AAEDF-D2D5-4777-B5B9-956DD093FA86@holtmann.org>
References: <1437729050-16750-1-git-send-email-arron.wang@intel.com>
To: Arron Wang <arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arron,

> To avoid amp module hooks from hci_event.c
> 
> Signed-off-by: Arron Wang <arron.wang@intel.com>
> ---
> net/bluetooth/amp.c       |   81 ++++++++++++++++++++++++++++++++++++++++++---
> net/bluetooth/hci_event.c |   59 ---------------------------------
> 2 files changed, 77 insertions(+), 63 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

