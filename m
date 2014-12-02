Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2] Bluetooth: Track both local and remote L2CAP fixed channel mask
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1417507766-32616-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 2 Dec 2014 08:29:52 +0000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F5FB874F-64EB-4AD7-98A3-35859421985E@holtmann.org>
References: <1417507766-32616-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To pave the way for future fixed channels to be added easily we should
> track both the local and remote mask on a per-L2CAP connection (struct
> l2cap_conn) basis. So far the code has used a global variable in a racy
> way which anyway needs fixing.
> 
> This patch renames the existing conn->fixed_chan_mask that tracked
> the remote mask to conn->remote_fixed_chan and adds a new variable
> conn->local_fixed_chan to track the local mask. Since the HS support
> info is now available in the local mask we can remove the
> conn->hs_enabled variable.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Use "data + 1" instead of "&data[1]"
> 
> include/net/bluetooth/l2cap.h |  4 ++--
> net/bluetooth/l2cap_core.c    | 37 ++++++++++++++++++-------------------
> 2 files changed, 20 insertions(+), 21 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

