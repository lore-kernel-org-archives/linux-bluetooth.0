Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v2 1/4] add restart_le_scan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414607071-9801-1-git-send-email-jpawlowski@google.com>
Date: Sun, 2 Nov 2014 11:42:47 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7D190559-F7EA-4A3B-BF1F-EB53D1715049@holtmann.org>
References: <1414607071-9801-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

the patch subject needs to start with Bluetooth:

> Currently there is no way to restart le scan. It's needed in
> preparation for new service scan method. The way it work: it disable,
> and then enable le scan on controller. During this restart special flag
> is set to make sure we won't remove disable scan work from workqueue.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> include/net/bluetooth/hci.h      |  1 +
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_core.c         | 42 ++++++++++++++++++++++++++++++++++++++++
> net/bluetooth/hci_event.c        |  9 ++++++---
> 4 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 6e8f249..b15d240 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -194,6 +194,7 @@ enum {
> 	HCI_FAST_CONNECTABLE,
> 	HCI_BREDR_ENABLED,
> 	HCI_LE_SCAN_INTERRUPTED,
> +	HCI_LE_SCAN_RESTARTING,
> };
> 
> /* A mask for the flags that are supposed to remain when a reset happens
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b8685a7..3c585885 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -334,6 +334,7 @@ struct hci_dev {
> 	unsigned long		dev_flags;
> 
> 	struct delayed_work	le_scan_disable;
> +	struct delayed_work	le_scan_restart;

So I wonder if we need le_scan_restart delayed_work here. We might be able to just put that into le_scan_disable one using the HCI_LE_SCAN_RESTART flag.

That said, I like to get this working also with the regular discovery procedure. It is just that there every found device will trigger the restart, while in the service discovery it is only the ones we care about. So we should expose an general mechanism here.

I do not have figured every single detail our here, but that is where I like to go with this.

Regards

Marcel

