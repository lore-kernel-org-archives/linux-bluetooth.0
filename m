Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Oct 2010 12:28:51 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Anderson Briglia <anderson.briglia@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH 5/6] Bluetooth: Fix initiated LE connections
Message-ID: <20101026092851.GD15050@null>
References: <linux-bluetooth@vger.kernel.org>
 <1287791820-22693-6-git-send-email-anderson.briglia@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287791820-22693-6-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Oct 23, 2010 at 01:56:59AM +0200, ext Anderson Briglia wrote:
> From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> 
> Fix LE connections not being marked as master.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index c7309e4..1a48c6a 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -52,6 +52,7 @@ void hci_le_connect(struct hci_conn *conn)
>  
>  	conn->state = BT_CONNECT;
>  	conn->out = 1;
> +	conn->link_mode |= HCI_LM_MASTER;

conn->out and conn->link_mode are redutant information. The role cannot be changed.

>  
>  	memset(&cp, 0, sizeof(cp));
>  	cp.scan_interval = cpu_to_le16(0x0004);
> -- 
> 1.7.0.4

-- 
Ville
