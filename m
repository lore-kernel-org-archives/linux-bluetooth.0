Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Apr 2015 08:53:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Read LE remote features during connection
 establishment
Message-ID: <20150409055352.GA12925@t440s.P-661HNU-F1>
References: <1428509127-12882-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428509127-12882-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Apr 08, 2015, Marcel Holtmann wrote:
> When establishing a Bluetooth LE connection, read the remote used
> features mask to determine which features are supported. This was
> not really needed with Bluetooth 4.0, but since Bluetooth 4.1 and
> also 4.2 have introduced new optional features, this becomes more
> important.
> 
> This works the same as with BR/EDR where the connection enters the
> BT_CONFIG stage and hci_connect_cfm call is delayed until the remote
> features have been retrieved. Only after successfully receiving the
> remote features, the connection enters the BT_CONNECTED state.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |  13 ++++++
>  net/bluetooth/hci_event.c   | 107 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 118 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
