Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Mar 2015 18:37:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use DECLARE_BITMAP for hdev->dev_flags field
Message-ID: <20150313163705.GA2959@t440s.P-661HNU-F1>
References: <1426262657-5457-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426262657-5457-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 13, 2015, Marcel Holtmann wrote:
> The hdev->dev_flags field has outgrown itself on 32-bit systems. So
> instead of hacking around it, switch to using DECLARE_BITMAP.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      |  7 +------
>  include/net/bluetooth/hci_core.h | 24 +++++++++++++++---------
>  net/bluetooth/hci_core.c         |  2 +-
>  net/bluetooth/hci_event.c        |  2 +-
>  4 files changed, 18 insertions(+), 17 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
