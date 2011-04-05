Return-Path: <cyrus@holtmann.org>
From: Zhang Jiejing-B33651 <B33651@freescale.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
CC: "suraj@atheros.com" <suraj@atheros.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: change gfp type in hci_recv_stream_fragment()
Date: Tue, 5 Apr 2011 08:47:13 +0000
Message-ID: <00EDC7B5DB2F5145BEDBC1CE66AD2727166177@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1301554616-27595-1-git-send-email-jiejing.zhang@freescale.com>,<20110404211617.GD2230@joana>
In-Reply-To: <20110404211617.GD2230@joana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,=0A=
=0A=
Yes, you are right, this is a irq context can't use GFP_KERNEL.=0A=
=0A=
But what if it return error like -NOMEM? =0A=
I meet this while debugging hci_ath.c driver.=0A=
this the function call chain in hci_ath.c driver when some data receive.=0A=
=0A=
low_level_uart_driver -> hci_ldisc.c:hci_uart_tty_receive()  --> ath_recv()=
 --> hci_recv_stream_fragment()=0A=
=0A=
1. If hci_recv_stream_fragment return an error like -NOMEM, the ath_recv() =
will report a error : Frame Reassembly Failed. but still return the count t=
o hci_uart_tty_receive(). hci_uart_tty_receive() will add this count to his=
 receive statistics. =0A=
=0A=
2. I think it should do some thing like report an error, let upper level kn=
ow the receive data is got error.  =0A=
I guess maybe upper level like rfcomm will check the package's checksum ? =
=0A=
=0A=
This patch is for the #1.=0A=
=0A=
diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c=0A=
index bd34406..caf807e 100644=0A=
--- a/drivers/bluetooth/hci_ath.c=0A=
+++ b/drivers/bluetooth/hci_ath.c=0A=
@@ -201,8 +201,12 @@ static struct sk_buff *ath_dequeue(struct hci_uart *hu=
)=0A=
 /* Recv data */=0A=
 static int ath_recv(struct hci_uart *hu, void *data, int count)=0A=
 {=0A=
-	if (hci_recv_stream_fragment(hu->hdev, data, count) < 0)=0A=
+	int ret;=0A=
+	ret =3D hci_recv_stream_fragment(hu->hdev, data, count);=0A=
+	if (ret < 0) {=0A=
 		BT_ERR("Frame Reassembly Failed");=0A=
+		return ret;=0A=
+	}=0A=
 =0A=
 	return count;=0A=
 }=0A=
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c=
=0A=
index 48ad2a7..320f718 100644=0A=
--- a/drivers/bluetooth/hci_ldisc.c=0A=
+++ b/drivers/bluetooth/hci_ldisc.c=0A=
@@ -359,6 +359,7 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)=
=0A=
  */=0A=
 static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data, c=
har *flags, int count)=0A=
 {=0A=
+	int ret;=0A=
 	struct hci_uart *hu =3D (void *)tty->disc_data;=0A=
 =0A=
 	if (!hu || tty !=3D hu->tty)=0A=
@@ -368,8 +369,9 @@ static void hci_uart_tty_receive(struct tty_struct *tty=
, const u8 *data, char *f=0A=
 		return;=0A=
 =0A=
 	spin_lock(&hu->rx_lock);=0A=
-	hu->proto->recv(hu, (void *) data, count);=0A=
-	hu->hdev->stat.byte_rx +=3D count;=0A=
+	ret =3D hu->proto->recv(hu, (void *) data, count);=0A=
+	if (ret > 0)=0A=
+		hu->hdev->stat.byte_rx +=3D count;=0A=
 	spin_unlock(&hu->rx_lock);=0A=
 =0A=
 	tty_unthrottle(tty);=0A=
=0A=
=0A=
________________________________________=0A=
From: Gustavo F. Padovan [pao@profusion.mobi] on behalf of Gustavo F. Padov=
an [padovan@profusion.mobi]=0A=
Sent: Tuesday, April 05, 2011 5:16 AM=0A=
To: Zhang Jiejing-B33651=0A=
Cc: suraj@atheros.com; marcel@holtmann.org; linux-bluetooth@vger.kernel.org=
=0A=
Subject: Re: [PATCH] Bluetooth: change gfp type in hci_recv_stream_fragment=
()=0A=
=0A=
Hi Zhang,=0A=
=0A=
* Zhang Jiejing <jiejing.zhang@freescale.com> [2011-03-31 14:56:56 +0800]:=
=0A=
=0A=
> change gfp type passed to hci_reassembly(), replace GFP_ATOMIC=0A=
> to GFP_KERNEL. Since some HCI_ACLDATA may request 1024+4 bytes=0A=
> some time GFP_ATOMIC will failed to allocation memory during=0A=
> large file FTP transfer in high baud rate.=0A=
>=0A=
> Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>=0A=
> ---=0A=
>  net/bluetooth/hci_core.c |    2 +-=0A=
>  1 files changed, 1 insertions(+), 1 deletions(-)=0A=
>=0A=
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c=0A=
> index 9c4541b..22b3ded 100644=0A=
> --- a/net/bluetooth/hci_core.c=0A=
> +++ b/net/bluetooth/hci_core.c=0A=
> @@ -1214,7 +1214,7 @@ int hci_recv_stream_fragment(struct hci_dev *hdev, =
void *data, int count)=0A=
>                       type =3D bt_cb(skb)->pkt_type;=0A=
>=0A=
>               rem =3D hci_reassembly(hdev, type, data,=0A=
> -                                     count, STREAM_REASSEMBLY, GFP_ATOMI=
C);=0A=
> +                                     count, STREAM_REASSEMBLY, GFP_KERNE=
L);=0A=
=0A=
We can't use GFP_KERNEL in a interrupt context, we can't sleep here and=0A=
GFP_ATOMIC guarantees that.=0A=
=0A=
--=0A=
Gustavo F. Padovan=0A=
http://profusion.mobi=0A=
=0A=
