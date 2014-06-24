Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2] Bluteooth: Convert hci_conn->link_mode into flags
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403618630-7656-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Jun 2014 17:21:29 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B2C0FEF4-8DF7-4259-ABF9-6AC639336F82@holtmann.org>
References: <1403618355-5882-1-git-send-email-johan.hedberg@gmail.com> <1403618630-7656-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Since the link_mode member of the hci_conn struct is a bit field and we
> already have a flags member as well it makes sense to merge these two
> together. This patch moves all used link_mode bits into corresponding
> flags. To keep backwards compatibility with user space we still need to
> provide a get_link_mode() helper function for the ioctl's that expect a
> link_mode style value.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Fix variable tpe in get_link_mode()
> 
> include/net/bluetooth/hci_core.h | 10 +++++++---
> net/bluetooth/hci_conn.c         | 43 ++++++++++++++++++++++++++++++----------
> net/bluetooth/hci_event.c        | 28 +++++++++++++-------------
> net/bluetooth/l2cap_core.c       |  4 ++--
> net/bluetooth/smp.c              | 12 +++++------
> 5 files changed, 62 insertions(+), 35 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

