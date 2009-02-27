Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1235753648-10045-1-git-send-email-philipp.zabel@gmail.com>
References: <1235753648-10045-1-git-send-email-philipp.zabel@gmail.com>
Date: Fri, 27 Feb 2009 23:35:30 +0100
Message-ID: <74d0deb30902271435u1d2ac128ob09896a86abbff64@mail.gmail.com>
Subject: Re: [PATCH] pcmcia: dtl1_cs: fix pcmcia_loop_config logic
From: pHilipp Zabel <philipp.zabel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org,
	Dominik Brodowski <linux@dominikbrodowski.net>, Marcel Holtmann <marcel@holtmann.org>,
	Philipp Zabel <philipp.zabel@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Feb 27, 2009 at 5:54 PM, Philipp Zabel <philipp.zabel@gmail.com> wr=
ote:
> pcmcia_loop_config returns 0 on success.
>
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
> ---
> =A0drivers/bluetooth/dtl1_cs.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
> index 901bdd9..e0ee642 100644
> --- a/drivers/bluetooth/dtl1_cs.c
> +++ b/drivers/bluetooth/dtl1_cs.c
> @@ -616,7 +616,7 @@ static int dtl1_config(struct pcmcia_device *link)
>
> =A0 =A0 =A0 =A0/* Look for a generic full-sized window */
> =A0 =A0 =A0 =A0link->io.NumPorts1 =3D 8;
> - =A0 =A0 =A0 if (!pcmcia_loop_config(link, dtl1_confcheck, NULL))
> + =A0 =A0 =A0 if (pcmcia_loop_config(link, dtl1_confcheck, NULL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto failed;
>
> =A0 =A0 =A0 =A0i =3D pcmcia_request_irq(link, &link->irq);
> --
> 1.5.6.5

with this change my Nokia DTL-1 CF card gets detected, but the
interface stays down.

# hciconfig hci0 up
Can't init device hci0: Connection timed out (110)

I added some printk's to dtl_write and dtl_receive to dump the TX/RX
bytes and rx_count (in parentheses):

pcmcia 1.0: pcmcia: registering new device pcmcia1.0
dtl1_receive: 80(4) 10(3) 02(2) 00(1) 0f(2) 00(1) <6>
Bluetooth: Nokia control data =3D 0f 00
dtl1_write: 81 00 03 00 03 0c 00 00
dtl1_interrupt: RLSI
dtl1_receive: 00(4)
dtl1_receive: 80(3) 10(2) 02(1) 00(528) 0f(527) 00(526)
dtl1_receive: 84(525) 00(524) 06(523) 00(522) 0e(521) 04(520) 04(519) 03(51=
8)
dtl1_receive: 0c(517) 00(516)
dtl1_write: 81 00 03 00 03 0c 00 00
dtl1_interrupt: RLSI
dtl1_receive: 00(515)
dtl1_receive: 80(514) 10(513) 02(512) 00(511) 0f(510) 00(509)
dtl1_receive: 84(508) 00(507) 06(506) 00(505) 0e(504) 04(503) 04(502)
dtl1_receive: 03(501)
dtl1_receive: 0c(500)
dtl1_receive: 00(499)

It seems the culprit is the stray zero byte read after the RLSI
interrupt causing the 0x80 packet type to be interpreted as length. I
can work around this error with the following patch:

diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index e0ee642..91c4c92 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -210,6 +210,7 @@ static void dtl1_receive(dtl1_info_t *info)
        unsigned int iobase;
        nsh_t *nsh;
        int boguscount =3D 0;
+       __u8 byte;

        if (!info) {
                BT_ERR("Unknown device");
@@ -230,10 +231,16 @@ static void dtl1_receive(dtl1_info_t *info)
                                return;
                        }

-               *skb_put(info->rx_skb, 1) =3D inb(iobase + UART_RX);
-               nsh =3D (nsh_t *)info->rx_skb->data;
+               byte =3D inb(iobase + UART_RX);

-               info->rx_count--;
+               if ((info->rx_state =3D=3D RECV_WAIT_NSH) &&
(info->rx_count =3D=3D NSHL) && (byte =3D=3D 0)) {
+                       continue;
+               } else {
+                       *skb_put(info->rx_skb, 1) =3D byte;
+                       nsh =3D (nsh_t *)info->rx_skb->data;
+
+                       info->rx_count--;
+               }

                if (info->rx_count =3D=3D 0) {

But I fear this just covers up an error somewhere else. Can this RSLI
error and zero byte read be avoided somehow?

regards
Philipp
