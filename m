Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Dec 2014 09:22:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix generation of non-resolvable private
 addresses
Message-ID: <20141208072220.GA20485@t440s>
References: <1417979597-27993-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417979597-27993-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Dec 07, 2014, Marcel Holtmann wrote:
> When the host decides to use a non-resolvable private address, it
> must ensure that this generated address does not match the public
> address of the controller. Add an extra check to ensure this required
> behavior.
> 
> In addition rename the variable from urpa to nrpa and fix all of the
> comments in the code that use the term unresolvable instead of the
> term non-resolvable as used in the Bluetooth specification.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_conn.c |  2 +-
>  net/bluetooth/hci_core.c | 24 ++++++++++++++++++------
>  net/bluetooth/mgmt.c     |  2 +-
>  3 files changed, 20 insertions(+), 8 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
