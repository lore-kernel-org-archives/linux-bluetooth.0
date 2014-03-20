Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Fix passkey endianess in user_confirm and notify_passkey
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395296294-8686-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 19 Mar 2014 23:25:05 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C63D98CC-E283-4F2F-8A0A-33FB443F8DE7@holtmann.org>
References: <1395296294-8686-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The passkey_notify and user_confirm functions in mgmt.c were expecting
> different endianess for the passkey, leading to a big endian bug and
> sparse warning in recently added SMP code. This patch converts both
> functions to expect host endianess and do the conversion to little
> endian only when assigning to the mgmt event struct.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 2 +-
> net/bluetooth/hci_event.c        | 4 ++--
> net/bluetooth/mgmt.c             | 4 ++--
> net/bluetooth/smp.c              | 2 +-
> 4 files changed, 6 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

