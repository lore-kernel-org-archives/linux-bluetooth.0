Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Jun 2014 15:50:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use struct delayed_work for HCI command
 timeout
Message-ID: <20140616125021.GA16741@t440s.lan>
References: <1402914656-27769-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402914656-27769-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jun 16, 2014, Marcel Holtmann wrote:
> Since the whole HCI command, event and data packet processing has been
> migrated to use workqueues instead of tasklets, it makes sense to use
> struct delayed_work instead of struct timer_list for the timeout
> handling. This patch converts the hdev->cmd_timer to use workqueue
> as well.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  2 +-
>  net/bluetooth/hci_core.c         | 17 +++++++++--------
>  net/bluetooth/hci_event.c        |  4 ++--
>  3 files changed, 12 insertions(+), 11 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
