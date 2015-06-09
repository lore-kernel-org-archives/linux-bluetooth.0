Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2] bluetooth: hci_bcsp: Clean up code Fix
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150609114203.GA19310@ubuntu>
Date: Tue, 9 Jun 2015 13:45:27 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <0E6C9915-753D-4CC3-94E4-6EB73B269376@holtmann.org>
References: <20150609114203.GA19310@ubuntu>
To: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prasanna,

> From: Prasanna Karthik <mkarthi3@visteon.com>
> 
> Fix for spaces prohibited around that '->' reported by checkpatch and space prohibited
> between function name and open parenthesis '('
> 
> Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
> 
> ---
> V2: Reverted back Indentation,Now patch only has above fix
> ---
> ---
> drivers/bluetooth/hci_bcsp.c |   16 ++++++++--------
> 1 files changed, 8 insertions(+), 8 deletions(-)

the patch does not apply cleanly with git am.

Applying: bluetooth: hci_bcsp: Clean up code Fix
/data/kernel/maintainer-bluetooth-next/.git/rebase-apply/patch:17: trailing whitespace.
			if ((bcsp->rx_skb->data[0] & 0x40) != 0 && 
/data/kernel/maintainer-bluetooth-next/.git/rebase-apply/patch:26: trailing whitespace.
			if ((bcsp->rx_skb->data[0] & 0x40) != 0 && 
/data/kernel/maintainer-bluetooth-next/.git/rebase-apply/patch:37: trailing whitespace.
			if ((bcsp->rx_skb->data[0] & 0x40) != 0 && 
fatal: 3 lines add whitespace errors.
Patch failed at 0001 bluetooth: hci_bcsp: Clean up code Fix

Regards

Marcel

