Return-Path: <cyrus@holtmann.org>
Date: Sun, 22 Jun 2014 09:38:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use separate dbg_flags to special debugfs
 options
Message-ID: <20140622063424.GA21952@t440s.P-661HNU-F1>
References: <1403319197-5145-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403319197-5145-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jun 21, 2014, Marcel Holtmann wrote:
> All the special settings configured via debugfs are either developer
> only options or temporary solutions. To not clutter the standard flags,
> move them to their own dbg_flags entry.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      | 12 +++++++++---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 24 ++++++++++++------------
>  net/bluetooth/mgmt.c             |  4 ++--
>  4 files changed, 24 insertions(+), 17 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
