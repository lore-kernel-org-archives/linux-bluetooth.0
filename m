Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Drop LE connections for blocked devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404282982-26114-2-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 2 Jul 2014 09:08:45 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6E10CD3D-83F1-4D76-9307-06F4137EC627@holtmann.org>
References: <1404282982-26114-1-git-send-email-johan.hedberg@gmail.com> <1404282982-26114-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Unlike BR/EDR we cannot reject LE connections of blocked devices but
> have to do it as soon as we get a LE Connection Complete event. The
> patch adds a blacklist check to the hci_le_conn_complete_evt function
> and drops all connections for blocked devices.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

