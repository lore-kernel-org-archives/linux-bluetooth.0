Return-Path: <cyrus@holtmann.org>
Date: Sat, 20 Dec 2014 23:02:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Create debugfs directory for each connection
 handle
Message-ID: <20141220210212.GA20741@t440s.P-661HNU-F1>
References: <1419092021-32209-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419092021-32209-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Dec 20, 2014, Marcel Holtmann wrote:
> For every internal representation of a Bluetooth connection which is
> identified by hci_conn, create a debugfs directory with the handle
> number as directory name.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_conn.c         |  3 +++
>  net/bluetooth/hci_debugfs.c      | 12 ++++++++++++
>  net/bluetooth/hci_debugfs.h      |  1 +
>  net/bluetooth/hci_event.c        |  5 +++++
>  5 files changed, 22 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
