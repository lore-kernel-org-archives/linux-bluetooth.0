Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Oct 2013 17:58:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Store source address of HCI connections
Message-ID: <20131013145843.GC23382@x220.p-661hnu-f1>
References: <1381667042-46368-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381667042-46368-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 13, 2013, Marcel Holtmann wrote:
> The source addressed was based on the public address of the HCI device,
> but with LE connections this not always the case. For example single
> mode LE-only controllers would use a static random address. And this
> address is configured by userspace.
> 
> To not complicate the lookup of what kind of address is in use, store
> the correct source address for each HCI connection.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 1 +
>  net/bluetooth/hci_conn.c         | 7 +++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)

All four patches in this set have been applied to bluetooth-next. Thanks.

Johan
