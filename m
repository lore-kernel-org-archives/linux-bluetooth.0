Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 20 Nov 2006 10:26:22 +0100
From: Stefan Seyfried <seife@suse.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20061120092622.GF4941@suse.de>
References: <c303508f0611181827s178b8776g57d3dbec37264691@mail.gmail.com>
	<1164011287.28397.9.camel@localhost>
MIME-Version: 1.0
In-Reply-To: <1164011287.28397.9.camel@localhost>
Subject: Re: [Bluez-devel] Rfcomm kernel crashes (2.6.18.2)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Mon, Nov 20, 2006 at 09:28:07AM +0100, Marcel Holtmann wrote:

> so you have something to reproduce this. That is good. Please try out
> the attached patch and report back if it fixes this for you.

just in case this is supposed to go in...

> diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> index b8e3a5f..46c03f8 100644
> --- a/net/bluetooth/rfcomm/tty.c
> +++ b/net/bluetooth/rfcomm/tty.c
> @@ -915,12 +915,14 @@ static void rfcomm_tty_unthrottle(struct
>  static int rfcomm_tty_chars_in_buffer(struct tty_struct *tty)
>  {
>  	struct rfcomm_dev *dev =3D (struct rfcomm_dev *) tty->driver_data;
> -	struct rfcomm_dlc *dlc =3D dev->dlc;
>  =

>  	BT_DBG("tty %p dev %p", tty, dev);

dev used
  =

> -	if (!skb_queue_empty(&dlc->tx_queue))
> -		return dlc->mtu;
> +	if (!dev || !dev->dlc)

dev checked.

> +		return 0;
> +
> +	if (!skb_queue_empty(&dev->dlc->tx_queue))
> +		return dev->dlc->mtu;
>  =

>  	return 0;
>  }
> @@ -928,11 +930,12 @@ static int rfcomm_tty_chars_in_buffer(st
>  static void rfcomm_tty_flush_buffer(struct tty_struct *tty)
>  {
>  	struct rfcomm_dev *dev =3D (struct rfcomm_dev *) tty->driver_data;
> -	if (!dev)
> -		return;
>  =

>  	BT_DBG("tty %p dev %p", tty, dev);

dev used
  =

> +	if (!dev || !dev->dlc)

dev checked....
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
