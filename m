Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v7 5/8] Bluetooth: Use voice setting in incoming SCO connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1368725646-4593-6-git-send-email-frederic.dalleau@linux.intel.com>
Date: Fri, 17 May 2013 10:51:58 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E5F5E079-A231-424B-BA4D-83D2DCBE3267@holtmann.org>
References: <1368725646-4593-1-git-send-email-frederic.dalleau@linux.intel.com> <1368725646-4593-6-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> When an incoming SCO connection is requested, check the selected voice setting,
> and reply appropriately. Voice setting should have been negotiated previously.
> For example, in case of HFP, the codec is negotiated using AT commands on the
> RFCOMM channel. This patch only changes replies for socket with defered setup
> enabled.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> net/bluetooth/sco.c |   23 ++++++++++++++++++-----
> 1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 7b4c3df..7881208 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -653,7 +653,7 @@ static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> 	return err;
> }
> 
> -static void sco_conn_defer_accept(struct hci_conn *conn)
> +static void sco_conn_defer_accept(struct hci_conn *conn, int setting)
> {
> 	struct hci_dev *hdev = conn->hdev;
> 
> @@ -676,9 +676,22 @@ static void sco_conn_defer_accept(struct hci_conn *conn)
> 
> 		cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
> 		cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
> -		cp.max_latency    = __constant_cpu_to_le16(0xffff);
> -		cp.content_format = cpu_to_le16(hdev->voice_setting);
> -		cp.retrans_effort = 0xff;

so we are now ignoring the hdev->voice_setting. This is fine for eSCO, but what are we doing in case we have a 1.1 controller that only supports the Add_SCO command?

Regards

Marcel

