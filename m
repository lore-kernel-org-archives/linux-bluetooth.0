Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] pcmcia: dtl1_cs: fix pcmcia_loop_config logic
From: Marcel Holtmann <marcel@holtmann.org>
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-pcmcia@lists.infradead.org,
	Dominik Brodowski <linux@dominikbrodowski.net>
In-Reply-To: <74d0deb30902271435u1d2ac128ob09896a86abbff64@mail.gmail.com>
References: <1235753648-10045-1-git-send-email-philipp.zabel@gmail.com>
	 <74d0deb30902271435u1d2ac128ob09896a86abbff64@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 28 Feb 2009 22:38:28 +0100
Message-Id: <1235857108.6074.38.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Philipp.

> > pcmcia_loop_config returns 0 on success.
> >
> > Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
> > ---
> >  drivers/bluetooth/dtl1_cs.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
> > index 901bdd9..e0ee642 100644
> > --- a/drivers/bluetooth/dtl1_cs.c
> > +++ b/drivers/bluetooth/dtl1_cs.c
> > @@ -616,7 +616,7 @@ static int dtl1_config(struct pcmcia_device *link)
> >
> >        /* Look for a generic full-sized window */
> >        link->io.NumPorts1 = 8;
> > -       if (!pcmcia_loop_config(link, dtl1_confcheck, NULL))
> > +       if (pcmcia_loop_config(link, dtl1_confcheck, NULL))
> >                goto failed;
> >
> >        i = pcmcia_request_irq(link, &link->irq);
> > --
> > 1.5.6.5
> 
> with this change my Nokia DTL-1 CF card gets detected, but the
> interface stays down.
> 
> # hciconfig hci0 up
> Can't init device hci0: Connection timed out (110)
> 
> I added some printk's to dtl_write and dtl_receive to dump the TX/RX
> bytes and rx_count (in parentheses):
> 
> pcmcia 1.0: pcmcia: registering new device pcmcia1.0
> dtl1_receive: 80(4) 10(3) 02(2) 00(1) 0f(2) 00(1) <6>
> Bluetooth: Nokia control data = 0f 00
> dtl1_write: 81 00 03 00 03 0c 00 00
> dtl1_interrupt: RLSI
> dtl1_receive: 00(4)
> dtl1_receive: 80(3) 10(2) 02(1) 00(528) 0f(527) 00(526)
> dtl1_receive: 84(525) 00(524) 06(523) 00(522) 0e(521) 04(520) 04(519) 03(518)
> dtl1_receive: 0c(517) 00(516)
> dtl1_write: 81 00 03 00 03 0c 00 00
> dtl1_interrupt: RLSI
> dtl1_receive: 00(515)
> dtl1_receive: 80(514) 10(513) 02(512) 00(511) 0f(510) 00(509)
> dtl1_receive: 84(508) 00(507) 06(506) 00(505) 0e(504) 04(503) 04(502)
> dtl1_receive: 03(501)
> dtl1_receive: 0c(500)
> dtl1_receive: 00(499)
> 
> It seems the culprit is the stray zero byte read after the RLSI
> interrupt causing the 0x80 packet type to be interpreted as length. I
> can work around this error with the following patch:
> 
> diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
> index e0ee642..91c4c92 100644
> --- a/drivers/bluetooth/dtl1_cs.c
> +++ b/drivers/bluetooth/dtl1_cs.c
> @@ -210,6 +210,7 @@ static void dtl1_receive(dtl1_info_t *info)
>         unsigned int iobase;
>         nsh_t *nsh;
>         int boguscount = 0;
> +       __u8 byte;
> 
>         if (!info) {
>                 BT_ERR("Unknown device");
> @@ -230,10 +231,16 @@ static void dtl1_receive(dtl1_info_t *info)
>                                 return;
>                         }
> 
> -               *skb_put(info->rx_skb, 1) = inb(iobase + UART_RX);
> -               nsh = (nsh_t *)info->rx_skb->data;
> +               byte = inb(iobase + UART_RX);
> 
> -               info->rx_count--;
> +               if ((info->rx_state == RECV_WAIT_NSH) &&
> (info->rx_count == NSHL) && (byte == 0)) {
> +                       continue;
> +               } else {
> +                       *skb_put(info->rx_skb, 1) = byte;
> +                       nsh = (nsh_t *)info->rx_skb->data;
> +
> +                       info->rx_count--;
> +               }
> 
>                 if (info->rx_count == 0) {
> 
> But I fear this just covers up an error somewhere else. Can this RSLI
> error and zero byte read be avoided somehow?

The dtl1 driver is more reverse engineered than that we really know how
this Nokia protocol works. I would have to check with my DTL-1 and DTL-4
cards to see if this a general problem. However that has to wait until
April when I can pick them up again.

Regards

Marcel


