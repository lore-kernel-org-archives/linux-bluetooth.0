Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Jul 2014 13:43:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Run controller setup after external
 configuration
Message-ID: <20140706104334.GA22860@t440s.Elisa>
References: <1404641476-24971-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404641476-24971-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 06, 2014, Marcel Holtmann wrote:
> When the external configuration triggers the switch to a configured
> controller, it means the setup needs to be run. Controllers that start
> out unconfigured have only run limited set of HCI commands. This is
> not enough for complete operation and thus run the setup procedure
> before announcing the new controller index.
> 
> This introduces HCI_CONFIG flag as companion to HCI_SETUP flag. The
> HCI_SETUP flag is only used once for the initial setup procedure. And
> during that procedure hdev->setup driver callback is called. With the
> new HCI_CONFIG the switch from unconfigured to configured state is
> triggering the same setup procedure just without hdev->setup. This
> is required since bringing a controller back to unconfigured state
> from configured state is possible.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |  1 +
>  net/bluetooth/hci_core.c    | 17 ++++++++++++++---
>  net/bluetooth/hci_sock.c    |  3 ++-
>  net/bluetooth/mgmt.c        | 14 ++++++++++++--
>  4 files changed, 29 insertions(+), 6 deletions(-)

All three patches have been applied to bluetooth-next. Thanks.

Johan
