Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ms explorer for bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: neoclust <n1c0l4s.l3@wanadoo.fr>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <200410140042.12450.n1c0l4s.l3@wanadoo.fr>
References: <200410122022.30501.n1c0l4s.l3@wanadoo.fr>
	 <200410131224.13689.n1c0l4s.l3@wanadoo.fr>
	 <1097668334.4643.24.camel@notepaq>
	 <200410140042.12450.n1c0l4s.l3@wanadoo.fr>
Content-Type: text/plain
Message-Id: <1097753159.4640.43.camel@notepaq>
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
Date: Thu, 14 Oct 2004 13:25:59 +0200

Hi Nicholas,

> > > > I misread your email. What I think is that maybe the keyboard will only
> > > > work if you enforce the encryption. Is this the second generation of
> > > > the Microsoft keyboard?
> > >
> > > how can i know this info ?
> >
> > look at your box. What does it say and how does the keyboard look like?
> 
> my mouse: http://images.ldlc.com/photosldlc/00/00/41/13/LD0000411349_1.jpg
> my KB       : http://images.ldlc.com/photos/00/00/24/16/ME0000241663_1.jpg

please do actually pictures with a digitial camera from them and publish
that ones.

> > > > Can you do a "hcitool info ..." as root to your
> > > > keyboard?
> > >
> > > how can i know my <bdaddr> for my keabord  ?
> >
> > Press the "connect" button on the keyboard and run "hcitool scan".
> 
> if i let only the keyboard pluged it doesn't work better and when i plug the 
> mouse it ( the mouse) work directly
> 
> I use a mdk kernel can it be a mdk bug ?
> 
> but i mh patches wasn't include in the kernel the mouse would not work isn't 
> it ?

As long as it is 2.6.8 or later you will have some basic HID support.

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
