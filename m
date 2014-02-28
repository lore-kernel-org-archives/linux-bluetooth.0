Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Feb 2014 09:32:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Make hci_blacklist_clear function static
Message-ID: <20140228073238.GA30118@localhost.P-661HNU-F1>
References: <1393558554-42295-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393558554-42295-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Feb 27, 2014, Marcel Holtmann wrote:
> The hci_blacklist_clear function is not used outside of hci_core.c and
> can be made static.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 1 -
>  net/bluetooth/hci_core.c         | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
