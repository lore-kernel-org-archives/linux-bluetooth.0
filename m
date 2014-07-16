Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/3] Bluetooth: Add a role parameter to hci_conn_add()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405500969-17578-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Jul 2014 12:01:22 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <548ECC5A-889B-4366-ADD1-C2D69FAF6E1B@holtmann.org>
References: <1405500969-17578-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We need to be able to track slave vs master LE connections in
> hci_conn_hash, and to be able to do that we need to know the role of the
> connection by the time hci_conn_add_has() is called. This means in
> practice the hci_conn_add() call that creates the hci_conn_object.
> 
> This patch adds a new role parameter to hci_conn_add() function to give
> the object its initial role value, and updates the callers to pass the
> appropriate role to it. Since the function now takes care of
> initializing both conn->role and conn->out values we can remove some
> other unnecessary assignments.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  3 ++-
> net/bluetooth/amp.c              |  4 ++--
> net/bluetooth/hci_conn.c         | 17 +++++++++--------
> net/bluetooth/hci_event.c        | 17 ++++++-----------
> 4 files changed, 19 insertions(+), 22 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

