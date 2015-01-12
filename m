Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Jan 2015 11:24:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add opcode parameter to hci_req_complete_t
 callback
Message-ID: <20150112092404.GA4548@t440s.lan>
References: <1421013044-8613-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421013044-8613-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jan 11, 2015, Marcel Holtmann wrote:
> When hci_req_run() calls its provided complete function and one of the
> HCI commands in the sequence fails, then provide the opcode of failing
> command. In case of success HCI_OP_NOP is provided since all commands
> completed.
> 
> This patch fixes the prototype of hci_req_complete_t and all its users.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/bluetooth.h |  2 +-
>  net/bluetooth/hci_conn.c          |  2 +-
>  net/bluetooth/hci_core.c          |  9 ++++----
>  net/bluetooth/hci_request.c       |  3 ++-
>  net/bluetooth/mgmt.c              | 44 ++++++++++++++++++++++-----------------
>  5 files changed, 34 insertions(+), 26 deletions(-)

Applied to bluetooth-next. Thanks.

Would it make sense to also change the return value of the callback from
void to bool. That way the callback could let the request handling code
know whether to proceed even after a single command failure or to abort
the request.

Johan
