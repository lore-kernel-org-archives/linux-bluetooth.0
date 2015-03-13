Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Mar 2015 19:31:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Merge hdev->dbg_flags fields into
 hdev->dev_flags
Message-ID: <20150313173107.GA10881@t440s.P-661HNU-F1>
References: <1426267235-30299-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426267235-30299-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 13, 2015, Marcel Holtmann wrote:
> With the extension of hdev->dev_flags utilizing a bitmap now, the space
> is no longer restricted. Merge the hdev->dbg_flags into hdev->dev_flags
> to save space on 64-bit architectures. On 32-bit architectures no size
> reduction happens.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      | 14 +++++---------
>  include/net/bluetooth/hci_core.h |  1 -
>  net/bluetooth/hci_core.c         |  8 ++++----
>  net/bluetooth/hci_debugfs.c      |  6 +++---
>  net/bluetooth/hci_request.c      |  2 +-
>  net/bluetooth/l2cap_core.c       |  2 +-
>  net/bluetooth/mgmt.c             |  2 +-
>  net/bluetooth/smp.c              | 10 +++++-----
>  8 files changed, 20 insertions(+), 25 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
