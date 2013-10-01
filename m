Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC 1/3] Bluetooth: Introduce a new HCI_BREDR_ENABLED flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380640922-18647-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Oct 2013 17:59:07 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <04EAE0FF-854E-4B0B-9597-EA3B41A60440@holtmann.org>
References: <1380640922-18647-1-git-send-email-johan.hedberg@gmail.com> <1380640922-18647-2-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To allow treating dual-mode (BR/EDR/LE) controllers as single-mode ones
> (LE-only) we want to introduce a new HCI_BREDR_ENABLED flag to track
> whether BR/EDR is enabled or not (previously we simply looked at the
> feature bit with lmp_bredr_enabled).
> 
> This patch add the new flag and updates the relevant places to test
> against it instead of using lmp_bredr_enabled. The flag is by default
> enabled when registering an adapter and only cleared if necessary once
> the local features have been read during the HCI init procedure.
> 
> We cannot completely block BR/EDR usage in case user space uses raw HCI
> sockets but the patch tries to block this in places where possible, such
> as the various BR/EDR specific ioctls.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/hci_conn.c    |  3 +++
> net/bluetooth/hci_core.c    | 21 +++++++++++++++++++--
> net/bluetooth/mgmt.c        | 24 +++++++++++++-----------
> 4 files changed, 36 insertions(+), 13 deletions(-)

unless you missed a spot, this patch looks pretty much correct.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

