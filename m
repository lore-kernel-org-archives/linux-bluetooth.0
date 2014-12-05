Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Dec 2014 14:39:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: Fix discovery filter when no RSSI is
 available
Message-ID: <20141205123952.GA24214@t440s.lan>
References: <1417781015-32911-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417781015-32911-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Dec 05, 2014, Marcel Holtmann wrote:
> When no RSSI value is available then make sure that the result is
> filtered out when the RSSI threshold filter is active.
> 
> This means that all Bluetooth 1.1 or earlier devices will not
> report any results when using a RSSI threshold filter.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c | 5 +++--
>  net/bluetooth/mgmt.c      | 9 ++++++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)

Both patches have been applied. Thanks.

Johan
