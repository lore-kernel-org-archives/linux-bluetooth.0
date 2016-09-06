Return-Path: <johan.hedberg@gmail.com>
Date: Tue, 6 Sep 2016 12:21:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix wrong New Settings event when closing HCI
 User Channel
Message-ID: <20160906092148.GA17371@t440s.lan>
References: <1472958826-43347-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472958826-43347-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 04, 2016, Marcel Holtmann wrote:
> When closing HCI User Channel, the New Settings event was send out to
> inform about changed settings. However such event is wrong since the
> exclusive HCI User Channel access is active until the Index Added event
> has been sent.
> 
> @ USER Close: test
> @ MGMT Event: New Settings (0x0006) plen 4
>         Current settings: 0x00000ad0
>           Bondable
>           Secure Simple Pairing
>           BR/EDR
>           Low Energy
>           Secure Connections
> = Close Index: 00:14:EF:22:04:12
> @ MGMT Event: Index Added (0x0004) plen 0
> 
> Calling __mgmt_power_off from hci_dev_do_close requires an extra check
> for an active HCI User Channel.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to bluetooth-next. Thanks.

Johan
