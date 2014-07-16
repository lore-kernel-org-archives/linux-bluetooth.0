Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 3/3] Bluetooth: Use explicit role instead of a bool in function parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405500148-12370-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Jul 2014 11:09:53 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7F910050-273C-456F-9C44-BB45FC168F02@holtmann.org>
References: <1405500148-12370-1-git-send-email-johan.hedberg@gmail.com> <1405500148-12370-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To make the code more understandable it makes sense to use the new HCI
> defines for connection role instead of a "bool master" parameter. This
> makes it immediately clear when looking at the function calls what the
> last parameter is describing.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  6 +++---
> net/bluetooth/hci_conn.c         |  7 ++++---
> net/bluetooth/hci_core.c         | 19 +++++++++++--------
> net/bluetooth/hci_event.c        |  5 ++---
> net/bluetooth/l2cap_core.c       |  9 ++++++---
> net/bluetooth/mgmt.c             |  4 ++--
> net/bluetooth/smp.c              |  4 ++--
> 7 files changed, 30 insertions(+), 24 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

