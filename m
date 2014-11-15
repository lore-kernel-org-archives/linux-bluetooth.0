Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH 0/4] Bluetooth: More lockdep warning fixes with the help of RCU
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415882270-5621-1-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 15 Nov 2014 09:55:15 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CD2E8ED3-187F-4281-8F98-D2968DDAC85B@holtmann.org>
References: <1415882270-5621-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch set converts the LTK and IRK lists to use RCU which
> eliminates the need to always hold the hdev lock while accessing these
> lists. This helps us fix more lockdep warnings arising from hdev locking
> in smp.c.
> 
> What this patch set doesn't fix is the general problem of the SMP
> context holding references to list entries without any guarantee that
> those references stay valid if some other thread goes and removes the
> entries. For this the proper fix would probably be to introduce kref for
> the entries to ensure that external references stay valid. However,
> since that requires considerably more code it's better to first merge
> most lists into a single "remote device info" list that's protected both
> by kref and RCU.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (4):
>      Bluetooth: Convert LTK list to RCU
>      Bluetooth: Convert IRK list to RCU
>      Bluetooth: Remove unnecessary hdev locking in smp.c
>      Bluetooth: Add debug logs to help track locking issues
> 
> include/net/bluetooth/hci_core.h |  2 +
> net/bluetooth/hci_core.c         | 88 ++++++++++++++++++++++----------------
> net/bluetooth/hci_event.c        |  4 +-
> net/bluetooth/l2cap_core.c       |  3 +-
> net/bluetooth/l2cap_sock.c       | 10 ++++-
> net/bluetooth/smp.c              | 27 ++++--------
> 6 files changed, 75 insertions(+), 59 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

