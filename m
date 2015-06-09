Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v2] Bluetooth: Fix encryption key size handling for LTKs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433776479-20712-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 9 Jun 2015 09:11:05 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <68C545EE-2ED7-4EBF-B458-B11B49FC43A0@holtmann.org>
References: <1433776479-20712-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The encryption key size for LTKs is supposed to be applied only at the
> moment of encryption. When generating a Link Key (using LE SC) from
> the LTK the full non-shortened value should be used. This patch
> modifies the code to always keep the full value around and only apply
> the key size when passing the value to HCI.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 +-
> net/bluetooth/hci_conn.c         |  4 ++--
> net/bluetooth/hci_event.c        |  3 ++-
> net/bluetooth/smp.c              | 15 +++------------
> 4 files changed, 8 insertions(+), 16 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

