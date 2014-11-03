Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Nov 2014 10:28:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Introduce
 HCI_QUIRK_STRICT_DUPLICATE_FILTER
Message-ID: <20141103082802.GA32217@t440s.lan>
References: <1414957944-22818-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414957944-22818-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Nov 02, 2014, Marcel Holtmann wrote:
> Some vendors decide to use a struct duplicate filter policy that only
> filters on Bluetooth device addresses. This means that when the RSSI
> changes, these devices are not reported again. During discovery it is
> useful to actually get the RSSI updates.
> 
> Since this is specific to each controller, add a new quirk setting
> that allows drivers to tell the core what kind of filtering policy
> the controller uses.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Both patches in this set have been applied to bluetooth-next. Thanks.

Btw, I fixed the s/struct/strict/ typo in the message.

Johan
