Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Oct 2013 00:21:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Move skb->dev assignment for hdev->send into
 central place
Message-ID: <20131010222126.GB4228@x220.p-661hnu-f1>
References: <1381436787-50948-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381436787-50948-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 10, 2013, Marcel Holtmann wrote:
> The assignement of skb->dev is done all over the place. So it makes it
> hard to eventually get rid of it. Move it all in one central place so
> it gets assigned right before calling hdev->send driver callback.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 25 ++++++++++---------------
>  net/bluetooth/hci_sock.c |  2 --
>  2 files changed, 10 insertions(+), 17 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
