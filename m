Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Jan 2015 10:15:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add opcode parameter to hci_req_complete_t
 callback
Message-ID: <20150114081546.GD19106@t440s.P-661HNU-F1>
References: <1421013044-8613-1-git-send-email-marcel@holtmann.org>
 <20150112092404.GA4548@t440s.lan>
 <82D39EC7-4302-4C2B-A295-0FDC7B3C0EBC@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <82D39EC7-4302-4C2B-A295-0FDC7B3C0EBC@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 12, 2015, Marcel Holtmann wrote:
> >> When hci_req_run() calls its provided complete function and one of the
> >> HCI commands in the sequence fails, then provide the opcode of failing
> >> command. In case of success HCI_OP_NOP is provided since all commands
> >> completed.
> >> 
> >> This patch fixes the prototype of hci_req_complete_t and all its users.
> >> 
> >> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >> ---
> >> include/net/bluetooth/bluetooth.h |  2 +-
> >> net/bluetooth/hci_conn.c          |  2 +-
> >> net/bluetooth/hci_core.c          |  9 ++++----
> >> net/bluetooth/hci_request.c       |  3 ++-
> >> net/bluetooth/mgmt.c              | 44 ++++++++++++++++++++++-----------------
> >> 5 files changed, 34 insertions(+), 26 deletions(-)
> > 
> > Applied to bluetooth-next. Thanks.
> > 
> > Would it make sense to also change the return value of the callback from
> > void to bool. That way the callback could let the request handling code
> > know whether to proceed even after a single command failure or to abort
> > the request.
> 
> do we need this actually? Is there a case where we can continue if one
> of the commands fails.

I was mainly thinking of the various quirks we have for not issuing
certain commands for adapters that don't properly support them - another
way would be to simply ignore the errors from failing commands and
proceed with the init sequence anyway. But you're right, this may not be
a very useful feature.

> I think what we actually need is to have a way to revert the actions
> taken by an earlier command. So if a command in sequence configured
> something, we might want to revert that action when a later command
> fails.

In theory sounds like a nice feature, but doubt this will work out very
well in the end, at least not in a generic way. If an HCI command fails
there's no guarantee that the "undo" HCI command wont fail too.

Johan
