Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Jan 2015 21:45:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Fix dependency for BR/EDR Secure
 Connections mode on SSP
Message-ID: <20150122194522.GA27250@t440s.P-661HNU-F1>
References: <1421954122-15727-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421954122-15727-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jan 22, 2015, Marcel Holtmann wrote:
> The BR/EDR Secure Connections feature should only be enabled when the
> Secure Simple Pairing mode has been enabled first. However since secure
> connections is feature that is valid for BR/EDR and LE, this needs
> special handling.
> 
> When enabling secure connections on a LE only configured controller,
> thent the BR/EDR side should not be enabled in the controller. This
> patches makes the BR/EDR Secure Connections feature depending on
> enabling Secure Simple Pairing mode first.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c |  5 ++++-
>  net/bluetooth/mgmt.c     | 14 ++++++++------
>  2 files changed, 12 insertions(+), 7 deletions(-)

All three patches have been applied to bluetooth-next. Thanks.

Johan
