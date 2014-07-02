Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Jul 2014 20:45:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Introduce unconfigured controller state
Message-ID: <20140702174504.GA23067@t440s.P-661HNU-F1>
References: <1404321033-63920-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404321033-63920-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 02, 2014, Marcel Holtmann wrote:
> With the new unconfigured controller state it is possible to provide a
> fully functional HCI transport, but disable the higher level operations
> that would normally happen. This way userspace can try to configure the
> controller before releases the unconfigured state.
> 
> The internal state is represented by HCI_UNCONFIGURED. This replaces the
> HCI_QUIRK_RAW_DEVICE quirk as internal state representation. This is now
> a real state and drivers can use the quirk to actually trigger this
> state. In the future this will allow a more fine grained switching from
> unconfigured state to configured state for controller inititialization.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |  1 +
>  net/bluetooth/hci_core.c    | 43 ++++++++++++++++++++++++++-----------------
>  net/bluetooth/hci_sock.c    |  8 ++++----
>  net/bluetooth/mgmt.c        |  6 +++---
>  4 files changed, 34 insertions(+), 24 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
