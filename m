Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Jul 2014 00:38:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Ignore ADV_DIRECT_IND attempts from
 unknown devices
Message-ID: <20140723213844.GA9455@t440s.P-661HNU-F1>
References: <1406145323-42940-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406145323-42940-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 23, 2014, Marcel Holtmann wrote:
> Unconditionally connecting to devices sending ADV_DIRECT_IND when
> the controller is in CONNECTABLE mode is a feature that is not
> fully working. The background scanning trigger for this has been
> removed, but the statement allowing it to happen in case some
> other part triggers is still present. So remove that code part
> as well to avoid unwanted connections.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c | 6 ------
>  1 file changed, 6 deletions(-)

Both of these patches have been applied to bluetooth-next. Thanks.

Johan
