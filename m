Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 18:20:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Move arming of discoverable timeout to
 complete handler
Message-ID: <20131015152036.GA22796@x220.p-661hnu-f1>
References: <1381849862-32025-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381849862-32025-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 15, 2013, Marcel Holtmann wrote:
> The discoverable timeout is currently armed from hci_event.c and causes
> some side effects when using HCI commands instead of the management
> interface. To make this clear, only arm the discoverable timeout from
> the management command complete handler.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c |  5 -----
>  net/bluetooth/mgmt.c      | 11 +++++++++--
>  2 files changed, 9 insertions(+), 7 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
