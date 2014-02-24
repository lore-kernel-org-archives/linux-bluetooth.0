Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Feb 2014 08:49:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Use unresolvable private address for
 active scanning
Message-ID: <20140224064927.GB16823@x220.p-661hnu-f1>
References: <1393215955-3907-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393215955-3907-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Feb 23, 2014, Marcel Holtmann wrote:
> When running active scanning during LE discovery, do not reveal the own
> identity to the peer devices. In case LE privacy has been enabled, then
> a resolvable private address is used. If the LE privacy option is off,
> then use an unresolvable private address.
> 
> The public address or static random address is never used in active
> scanning anymore. This ensures that scan request are send using a
> random address.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  3 ++-
>  net/bluetooth/hci_conn.c         |  2 +-
>  net/bluetooth/hci_core.c         | 18 +++++++++++++++++-
>  net/bluetooth/mgmt.c             |  8 ++++++--
>  4 files changed, 26 insertions(+), 5 deletions(-)

Both patches have been applied. Thanks.

Johan
