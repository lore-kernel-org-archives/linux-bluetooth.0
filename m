Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Sending files from phone to ppc machine fails
From: Marcel Holtmann <marcel@holtmann.org>
To: Sjoerd Simons <sjoerd@spring.luon.net>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <20041001095814.GA5611@spring.luon.net>
References: <20040930161652.GA10170@spring.luon.net>
	 <1096563173.4371.5.camel@notepaq> <20040930170602.GA13427@spring.luon.net>
	 <20041001095814.GA5611@spring.luon.net>
Content-Type: text/plain
Message-Id: <1096641815.4265.13.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 01 Oct 2004 16:43:35 +0200

Hi Sjoerd,

> > > >   Since some time i've got an Ericsson T630. Sending files via obex from
> > > >   both my ppc and x86 machine to the phone works fine. But from the phone
> > > >   i can only send stuff to the x86. When sending to my powerbook the
> > > >   phone almost immediatly indicates ``connection failed''.  [...]
> > > > 
> > > >   Any ideas what could be going wrong here ?
> > > 
> > > stop hidd and see if it works then.
> > 
> > That does indeed solve it (should have though about trying that).
> 
> Seems i was a little too fast. Now it works ``sometimes'', but most of the
> times it takes three or four tries to send a file over. Incidentally i'm
> working on another x86 machine today and that also works fine ?

maybe there is another big endian bug somewhere, but I don't think so.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
