Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Oct 2013 23:59:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix endless loop with HCI_QUIRK_RESET_ON_CLOSE
Message-ID: <20131011205941.GA29176@x220.p-661hnu-f1>
References: <1381509852-64080-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381509852-64080-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 11, 2013, Marcel Holtmann wrote:
> Really early versions of the Bluetooth specification were unclear
> with the behavior of HCI Reset for USB devices. They assumed that
> also an USB reset needs to be issued. Later Bluetooth specifications
> cleared this out and it is safe to call HCI Reset without affecting
> the transport.
> 
> For old devices that misbehave, the HCI_QUIRK_RESET_ON_CLOSE quirk
> was introduced to postpone the HCI Reset until the device was no
> longer in use.
> 
> One of these devices is the Digianswer BPA-105 Bluetooth Protocol
> Analyzer. The only problem now is that with the quirk set, the
> HCI Reset is also executed at the end of the setup phase. So the
> controller gets configured and then it disconnects from the USB
> bus, connects again, gets configured and of course disconnects
> again. This game goes on forever.
> 
> For devices that need HCI_QUIRK_RESET_ON_CLOSE it is important
> that the HCI Reset is not executed after the setup phase. In
> specific when HCI_AUTO_OFF is set, do not call HCI Reset when
> closing the device.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to bluetooth-next. Thanks.

Johan
