Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: "pacho@condmat1.ciencias.uniovi.es"
	<pacho@condmat1.ciencias.uniovi.es>
CC: Glenn Phillips <glenn@coriolis-storm.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 9 Sep 2011 16:11:32 -0400
Subject: Re: Logitec MX5500 Bluetooth Version mismatch causing
 non-connectivity, workaround found
Message-ID: <1315599092.2004.85.camel@THOR>
References: <CAJD6O4KmmdrTLSj6Kj2PThFnkaFpcHp6y51b6a-LGygPw94e3g@mail.gmail.com>
	 <CAJD6O4+-e73hB1ody_cq-38HwF9p2ESQwQDAY-io_7bzHz3nFQ@mail.gmail.com>
	 <1315595445.29906.1.camel@belkin4>
In-Reply-To: <1315595445.29906.1.camel@belkin4>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2011-09-09 at 15:10 -0400, Pacho Ramos wrote:
> El vie, 09-09-2011 a las 11:22 -0700, Glenn Phillips escribió:
> > On Fri, Sep 9, 2011 at 11:07 AM, Glenn Phillips
> > <glenn@coriolis-storm.com> wrote:
> > 
> >     Hello, I have recently become aware of and have since experienced
> > some issues with my Logitec MX 5500 BT Kb/mouse combo.  After some
> > recent updates to my Sabayon linux(gentoo) system I have been unable
> > to use my Keyboard without modifying my udev rules.
> >     I have generated a bug report on our bugzilla already here:
> > http://bugs.sabayon.org/process_bug.cgi
> > 
> >     Link to /var/log/messages output http://pastebin.sabayon.org/pastie/7014
> >     and link to my workaround:
> > http://ubuntuforums.org/archive/index.php/t-1466806.html
> > 
> >     However I do not believe this is a good solution as this may break
> > other Logitec devices that rely on bluetooth functionality rather than
> > being able to fall back on usb only.
> > 
> >     current version of bluez - 4.96-r1
> >     previous working version - 4.93
> > 
> >     Thank you
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> Looks like:
> https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/658471
> 
> summarizes your problem

Hi Pacho,
I think Glenn means that he doesn't want to enable HCI mode. See my
earlier post here
http://marc.info/?l=linux-bluetooth&m=130713595419913&w=2

Hi Glenn,
The link you posted to sabayon.org is cookie-specific. Please repost
with a usable link.

The workaround you found on ubuntuforums.org is bogus. Until something
more suitable is found, if you don't want to run Bluetooth uninstall
bluez.

Regards,
Peter Hurley
