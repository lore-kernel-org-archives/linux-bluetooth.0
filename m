Return-Path: <cyrus@holtmann.org>
Date: Sat, 17 Oct 2015 17:17:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Bluetooth: Add new quirk for non-persistent
 diagnostic settings
Message-ID: <20151017141710.GA25656@t440s.P-661HNU-F1>
References: <1445090428-75287-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445090428-75287-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 17, 2015, Marcel Holtmann wrote:
> If the diagnostic settings are not persistent over HCI Reset, then this
> quirk can be used to tell the Bluetoth core about it. This will ensure
> that the settings are programmed correctly when the controller is
> powered up.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |  9 +++++++++
>  net/bluetooth/hci_core.c    | 19 +++++++++++++++++++
>  2 files changed, 28 insertions(+)

All three patches have been applied to bluetooth-next. Thanks.

Johan
