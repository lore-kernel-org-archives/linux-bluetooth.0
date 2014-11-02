Return-Path: <cyrus@holtmann.org>
Date: Sun, 2 Nov 2014 09:59:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Check status of command complete for HCI_Reset
Message-ID: <20141102075937.GA20526@t440s.P-661HNU-F1>
References: <1414892758-77105-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414892758-77105-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Nov 02, 2014, Marcel Holtmann wrote:
> When the HCI_Reset command returns, the status needs to be checked. It
> is unlikely that HCI_Reset actually fails, but when it fails, it is a
> bad idea to reset all values since the controller will have not reset
> its values in that case.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
