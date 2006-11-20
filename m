Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061120092622.GF4941@suse.de>
References: <c303508f0611181827s178b8776g57d3dbec37264691@mail.gmail.com>
	<1164011287.28397.9.camel@localhost>  <20061120092622.GF4941@suse.de>
Date: Mon, 20 Nov 2006 10:35:04 +0100
Message-Id: <1164015304.28397.28.camel@localhost>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Stefan,

> > so you have something to reproduce this. That is good. Please try out
> > the attached patch and report back if it fixes this for you.
> 
> just in case this is supposed to go in...
> 
> > diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> > index b8e3a5f..46c03f8 100644
> > --- a/net/bluetooth/rfcomm/tty.c
> > +++ b/net/bluetooth/rfcomm/tty.c
> > @@ -915,12 +915,14 @@ static void rfcomm_tty_unthrottle(struct
> >  static int rfcomm_tty_chars_in_buffer(struct tty_struct *tty)
> >  {
> >  	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
> > -	struct rfcomm_dlc *dlc = dev->dlc;
> >  
> >  	BT_DBG("tty %p dev %p", tty, dev);
> 
> dev used

and? It will print "(nil)" which is fine. And it is debug output anyway.
This is not a dereference.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
