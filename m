Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Oct 2015 08:23:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Rename bt_cb()->req into bt_cb()->hci
Message-ID: <20151026062316.GB23647@t440s.P-661HNU-F1>
References: <1445809553-44582-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445809553-44582-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 25, 2015, Marcel Holtmann wrote:
> The SKB context buffer for HCI request is really not just for requests,
> information in their are preserved for the whole HCI layer. So it makes
> more sense to actually rename it into bt_cb()->hci and also call it then
> struct hci_ctrl.
> 
> In addition that allows moving the decoded opcode for outgoing packets
> into that struct. So far it was just consuming valuable space from the
> main shared items. And opcode are not valid for L2CAP packets.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/bluetooth.h | 14 +++++++-------
>  net/bluetooth/hci_core.c          | 18 +++++++++---------
>  net/bluetooth/hci_event.c         |  4 ++--
>  net/bluetooth/hci_request.c       | 10 +++++-----
>  net/bluetooth/hci_sock.c          |  2 +-
>  5 files changed, 24 insertions(+), 24 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
