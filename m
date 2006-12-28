Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20061228084251.GB3955@ucw.cz>
References: <20061223234305.GA1809@elf.ucw.cz>
	<20061223235501.GA1740@elf.ucw.cz> <1166971163.15485.21.camel@violet>
	<20061224234357.GA1817@elf.ucw.cz>  <20061228084251.GB3955@ucw.cz>
Date: Thu, 28 Dec 2006 11:40:25 +0100
Message-Id: <1167302425.2417.18.camel@violet>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, bluez-devel@lists.sf.net,
        kernel list <linux-kernel@vger.kernel.org>, maxk@qualcomm.com
Subject: Re: [Bluez-devel] bluetooth memory corruption (was Re: ext3-related
	crash in	2.6.20-rc1)
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

Hi Pavel,

> > > > > I got this nasty oops while playing with debugger. Not sure if that is
> > > > > related; it also might be something with bluetooth; I already know it
> > > > > corrupts memory during suspend, perhaps it corrupts memory in some
> > > > > error path?
> > > > 
> > > > Okay, I spoke too soon. bluetooth & suspend memory corruption was
> > > > _way_ harder to reproduce than expected. Took me 5-or-so-suspend
> > > > cycles... so it is probably unrelated to the previous crash.
> > > 
> > > can you try to reproduce this with 2.6.20-rc2 as well.
> > 
> > (reproduced in another mail).
> > 
> >         _urb_queue_tail(__pending_q(husb, _urb->type), _urb);
> >         err = usb_submit_urb(urb, GFP_ATOMIC);
> >         if (err) {
> >                 BT_ERR("%s tx submit failed urb %p type %d err %d",
> >                                 husb->hdev->name, urb, _urb->type, err);
> >                 _urb_unlink(_urb);
> > 
> >                 ~~~~~~~~~~~~~~~~~~
> > 	 	 Do we need to remove urb from pending_q here?
> > 
> >                 _urb_queue_tail(__completed_q(husb, _urb->type), _urb);
> >         } else
> >                 atomic_inc(__pending_tx(husb, _urb->type));
> > 
> 
> Any news? Should I convert above idea to a patch? Or should I make
> bluetooth suspend() routine return error so corruption is impossible
> to hit?

to be honest, I have no idea. This code is way to ugly anyway.

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
