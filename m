Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <db972f43040909223675a4a082@mail.gmail.com>
From: Ricky Soh <rickysoh@gmail.com>
Reply-To: Ricky Soh <rickysoh@gmail.com>
To: Bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Help needed (Fedora Core 2)
In-Reply-To: <20040910034429.37672.qmail@web11605.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <db972f43040909203314e6825d@mail.gmail.com>
	 <20040910034429.37672.qmail@web11605.mail.yahoo.com>
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
Date: Fri, 10 Sep 2004 13:36:44 +0800

Dear all,

when i couldn't get bluez on lsmod and l2test and scotest command,
does it mean my bluez is not installed properly? If so, how do i get
it done?

I understand that fedora core 2 is preinstalled with bluez, how do i
get it loaded then instead of the bluetooth?

Sincerely
Ricky




On Thu, 9 Sep 2004 20:44:29 -0700 (PDT), David Zhu <saki96@yahoo.com> wrote:
> hmm, not sure, i'm afraid this is slightly beyond my
> help then.  maybe one of the many how-tos on the bluez
> site can help you out.  or one of the other people on
> the mailing list.  i don't think bluez creates any
> devices for you by default under /dev
> 
> if your software requires the existence of something
> specific under /dev with bluetooth, does it provide
> any documentation?
> 
> 
> --- Ricky Soh <rickysoh@gmail.com> wrote:
> 
> > cos i was running a software that requires the
> > existence of that
> > folder. Do i add that folder in myself? i doubt so.
> >
> > My l2test and scotest are not available as well.
> > Why?
> >
> > Is there a way to set bluetooth to passive mode
> > only.
> >
> > ric
> >
> >
> > On Thu, 9 Sep 2004 20:27:04 -0700 (PDT), David Zhu
> > <saki96@yahoo.com> wrote:
> > > what are you trying to do?  you won't see anything
> > > under /dev when you plug in a usb bluetooth
> > adapter.
> > > i added a /dev/rfcomm0 to use the bluetooth serial
> > > capabilities.
> > >
> > >
> > >
> > > --- Ricky Soh <rickysoh@gmail.com> wrote:
> > >
> > > > i only see
> > > >
> > > > l2cap
> > > > hci_usb
> > > > bluetooth
> > > > uhci_hcd instead ofohci_hcd
> > > >
> > > > how do i start hcid and sdpd? Under hciconfig
> > -a, i
> > > > got all the
> > > > necessary information for my hci0 device. I tot
> > when
> > > > i plug in a
> > > > bluetooth device, under /dev, a bluetooth folder
> > > > will be created?
> > > > Please help. Thanks.
> > > >
> > > > Ric
> > > >
> > > > On Thu, 9 Sep 2004 20:10:19 -0700 (PDT), David
> > Zhu
> > > > <saki96@yahoo.com> wrote:
> > > > > You should see the follwing under lsmod:
> > > > >
> > > > > rfcomm
> > > > > l2cap
> > > > > hci_usb
> > > > > bluetooth
> > > > > ohci_hcd
> > > > >
> > > > > What happens when you try "hciconfig -a"?  Did
> > you
> > > > > remember to start the bluetooth services (is
> > hcid
> > > > and
> > > > > sdpd running)?
> > > > >
> > > > >
> > > > > --- Ricky Soh <rickysoh@gmail.com> wrote:
> > > > >
> > > > > > Hi dave, thanks for replying.
> > > > > >
> > > > > > I did exactly as told and i have whats
> > stated
> > > > there
> > > > > > except
> > > > > > bluez-libs-devel-2.5-2.1
> > > > > > bluez-sdp-devel-1.5-2.1
> > > > > >
> > > > > > I suppose bluez should be installed but
> > under
> > > > lsmod,
> > > > > > why its not shown
> > > > > > but there is a bluetooth instead. I can run
> > most
> > > > of
> > > > > > the tools of bluez
> > > > > > but l2test, scotest and some others are not
> > > > found.
> > > > > > Is my installation
> > > > > > not complete? how do i go about reinstalling
> > > > bluez?
> > > > > > thanks
> > > > > >
> > > > > > Sincerely
> > > > > > Ricky
> > > > > >
> > > > > >
> > > > > > On Thu, 9 Sep 2004 19:26:51 -0700 (PDT),
> > David
> > > > Zhu
> > > > > > <saki96@yahoo.com> wrote:
> > > > > > > Hi Ricky,
> > > > > > >
> > > > > > > I may be able to help you out since I
> > recently
> > > > > > tried
> > > > > > > to get bluez working with my fedora core 2
> > > > > > > installation.  The quickest way to tell if
> > you
> > > > > > have a
> > > > > > > complete bluez install for fedora is to
> > just
> > > > do a
> > > > > > "rpm
> > > > > > > -qa | grep blue"
> > > > > > >
> > > > > > > You should have at least the following
> > > > packages
> > > > > > > installed for bluez to work correctly:
> > > > > > >
> > > > > > > bluez-libs-2.5-2.1
> > > > > > > bluez-utils-2.4-3
> > > > > > > bluez-sdp-1.5-2.1
> > > > > > >
> > > > > > > If any are missing, you can just download
> > the
> > > > > > > necessary rpms from one of the fedora
> > mirrors.
> > > > > > good
> > > > > > > luck.
> > > > > > >
> > > > > > > Dave
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --- Ricky Soh <rickysoh@gmail.com> wrote:
> > > > > > >
> > > > > > > > Dear all,
> > > > > > > > Sorry, i have a noob's question. I am
> > using
> > > > > > fedora
> > > > > > > > core2.
> > > > > > > >
> > > > > > > > 1. When i plug in my usb BT dongle,
> > > > > > /dev/bluetooth/
> > > > > > > > directory is not
> > > > > > > > created. Under lsmod, there is no bluez
> > but
> > > > only
> > > > > > > > bluetooth. The
> > > > > > > > command l2ping but not l2test is working
> > > > only.
> > > > > > For
> > > > > > > > l2test, command not
> > > > > > > > found. Scotest is not found too.
> > > > > > > >
> > > > > > > > Based on the above symptons, i suspect
> > > > fedora
> > > > > > core 2
> > > > > > > > does not have the
> > > > > > > > full version of bluez installed. Am i
> > right
> > > > to
> > > > > > say
> > > > > > > > that or bluez is
> > > > > > > > not even installed? I tot bluez is the
> > > > official
> > > > > > > > linux bt protocol,
> > > > > > > > thus bluetooth in fedora core 2 should
> > be
> > > > bluez
> > > > > > > > right? Please
> > > > > > > > enlighten me and advise me how do i get
> > > > bluez
> > > > > > > > working... thanks.
> > > > > > > >
> > > > > > > > Sincerely
> > > > > > > > Ricky
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
> -------------------------------------------------------
> > > > > > > > This SF.Net email is sponsored by: YOU
> > BE
> > > > THE
> > > > > > JUDGE.
> > > > > > > > Be one of 170
> > > > > > > > Project Admins to receive an Apple iPod
> > Mini
> > > > > > FREE
> > > > > > > > for your judgement on
> > > > > > > > who ports your project to Linux PPC the
> > > > best.
> > > > > > > > Sponsored by IBM.
> > > > > > > > Deadline: Sept. 13. Go here:
> > > > > > > > http://sf.net/ppc_contest.php
> > > > > > > >
> > > > _______________________________________________
> > > > > > > > Bluez-users mailing list
> > > > > > > > Bluez-users@lists.sourceforge.net
> > 
> === message truncated ===
> 
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! Mail - 50x more storage than other providers!
> 
> 
> http://promotions.yahoo.com/new_mail
>


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
