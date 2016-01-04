Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm/rfkill-gpio: move all Broadcom ACPI IDs to BCM HCI driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1451910202-42401-2-git-send-email-heikki.krogerus@linux.intel.com>
Date: Mon, 4 Jan 2016 10:25:09 -0800
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <66EB4683-553C-4647-AE36-A3F1826019B7@holtmann.org>
References: <1451910202-42401-1-git-send-email-heikki.krogerus@linux.intel.com> <1451910202-42401-2-git-send-email-heikki.krogerus@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Heikki,

> The IDs should all be for Broadcom BCM43241 module, and
> hci_bcm is now the proper driver for them. This removes one
> of two different ways of handling PM with the module.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> ---
> drivers/bluetooth/hci_bcm.c | 4 ++++
> net/rfkill/rfkill-gpio.c    | 4 ----
> 2 files changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

