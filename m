Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Jul 2014 22:41:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: Add support for Unconfigured Index
 Added events
Message-ID: <20140702194135.GA18307@t440s.P-661HNU-F1>
References: <1404329455-32929-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404329455-32929-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 02, 2014, Marcel Holtmann wrote:
> When a controller is in unconfigured state it is currently hidden
> from the management interface. This change now announces the new
> controller with an Unconfigured Index Added event and allows clients
> to easily detect the controller.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/mgmt.h |  2 ++
>  net/bluetooth/hci_core.c     | 17 ++++++++++-------
>  net/bluetooth/hci_sock.c     |  9 +++------
>  net/bluetooth/mgmt.c         | 12 +++++++++++-
>  4 files changed, 26 insertions(+), 14 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
