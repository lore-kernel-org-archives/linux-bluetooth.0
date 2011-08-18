Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC v2 1/5] Bluetooth: Only schedule LE tx links if LE-capable
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1313627847.10336.9.camel@THOR>
Date: Thu, 18 Aug 2011 19:12:21 -0300
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <57D8EDBC-C4C6-423F-89F0-E1D1A5F6FCA8@openbossa.org>
References: <1313627847.10336.9.camel@THOR>
To: Peter Hurley <peter@hurleysoftware.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Aug 17, 2011, at 9:37 PM, Peter Hurley wrote:

> Only perform tx scheduling for LE links if the host controller
> is LE-capable.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
> net/bluetooth/hci_core.c |    4 +++-
> 1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 815269b..47a31fa 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1995,7 +1995,9 @@ static void hci_tx_task(unsigned long arg)
> 
> 	hci_sched_esco(hdev);
> 
> -	hci_sched_le(hdev);
> +	/* Only schedule le links if device is le-capable */
> +	if (lmp_le_capable(hdev))
> +		hci_sched_le(hdev);


You may use lmp_host_le_capable macro here since it tells you if
the _host_ supports LE (lmp_le_capable macro tells you if the
_controller_ supports LE).

BR,
Andre
