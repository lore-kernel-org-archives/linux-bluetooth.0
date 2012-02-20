Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Feb 2012 14:48:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove HCI notifier handling
Message-ID: <20120220124827.GA9178@x220.ger.corp.intel.com>
References: <1329739805-16235-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329739805-16235-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Feb 20, 2012, Marcel Holtmann wrote:
> The HCI notifier handling was never used outside of Bluetooth core layer
> and thus remove it and replace it with direct function calls. Also move
> the stack internal event generation into the HCI socket layer.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |    7 +--
>  net/bluetooth/hci_conn.c         |    1 -
>  net/bluetooth/hci_core.c         |   16 +-----
>  net/bluetooth/hci_event.c        |   29 ----------
>  net/bluetooth/hci_sock.c         |  105 ++++++++++++++++++++++----------------
>  5 files changed, 64 insertions(+), 94 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
