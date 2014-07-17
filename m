Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix using uninitialized variable when pairing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405587393-3058-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 17 Jul 2014 11:39:39 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <88581352-3AA9-4552-9801-86B68B6C3A62@holtmann.org>
References: <1405587393-3058-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Commit 6c53823ae0e10e723131055e1e65dd6a328a228e reshuffled the way the
> authentication requirement gets set in the hci_io_capa_request_evt()
> function, but at the same time it failed to update an if-statement where
> cp.authentication is used before it has been initialized. The correct
> value the code should be looking for in this if-statement is
> conn->auth_type.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

