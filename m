Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 1/3] Bluetooth: Track number of added devices with HCI_AUTO_CONN_REPORT
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404330122-18770-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 3 Jul 2014 09:45:46 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F97DDF23-7BBC-4DB9-9755-CA8C48F7F32F@holtmann.org>
References: <1404330122-18770-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To be able to make the right choice of whether to start passive scanning
> or to send out a mgmt_device_found event we need to know if there are
> any devices in the le_conn_params list with the auto_connect value set
> to HCI_AUTO_CONN_REPORT. This patch adds a counter for this kind of
> devices.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_core.c         | 17 +++++++++++++++--
> 2 files changed, 16 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

