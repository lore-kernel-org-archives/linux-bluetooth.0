Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040910031019.42707.qmail@web11608.mail.yahoo.com>
From: David Zhu <saki96@yahoo.com>
Subject: Re: [Bluez-users] Help needed (Fedora Core 2)
To: Ricky Soh <rickysoh@gmail.com>, Bluez-users@lists.sourceforge.net
In-Reply-To: <db972f43040909195258e1b060@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 9 Sep 2004 20:10:19 -0700 (PDT)

You should see the follwing under lsmod:

rfcomm
l2cap
hci_usb
bluetooth
ohci_hcd

What happens when you try "hciconfig -a"?  Did you
remember to start the bluetooth services (is hcid and
sdpd running)?


--- Ricky Soh <rickysoh@gmail.com> wrote:

> Hi dave, thanks for replying.
> 
> I did exactly as told and i have whats stated there
> except 
> bluez-libs-devel-2.5-2.1
> bluez-sdp-devel-1.5-2.1
> 
> I suppose bluez should be installed but under lsmod,
> why its not shown
> but there is a bluetooth instead. I can run most of
> the tools of bluez
> but l2test, scotest and some others are not found.
> Is my installation
> not complete? how do i go about reinstalling bluez?
> thanks
> 
> Sincerely
> Ricky
> 
> 
> On Thu, 9 Sep 2004 19:26:51 -0700 (PDT), David Zhu
> <saki96@yahoo.com> wrote:
> > Hi Ricky,
> > 
> > I may be able to help you out since I recently
> tried
> > to get bluez working with my fedora core 2
> > installation.  The quickest way to tell if you
> have a
> > complete bluez install for fedora is to just do a
> "rpm
> > -qa | grep blue"
> > 
> > You should have at least the following packages
> > installed for bluez to work correctly:
> > 
> > bluez-libs-2.5-2.1
> > bluez-utils-2.4-3
> > bluez-sdp-1.5-2.1
> > 
> > If any are missing, you can just download the
> > necessary rpms from one of the fedora mirrors. 
> good
> > luck.
> > 
> > Dave
> > 
> > 
> > 
> > --- Ricky Soh <rickysoh@gmail.com> wrote:
> > 
> > > Dear all,
> > > Sorry, i have a noob's question. I am using
> fedora
> > > core2.
> > >
> > > 1. When i plug in my usb BT dongle,
> /dev/bluetooth/
> > > directory is not
> > > created. Under lsmod, there is no bluez but only
> > > bluetooth. The
> > > command l2ping but not l2test is working only.
> For
> > > l2test, command not
> > > found. Scotest is not found too.
> > >
> > > Based on the above symptons, i suspect fedora
> core 2
> > > does not have the
> > > full version of bluez installed. Am i right to
> say
> > > that or bluez is
> > > not even installed? I tot bluez is the official
> > > linux bt protocol,
> > > thus bluetooth in fedora core 2 should be bluez
> > > right? Please
> > > enlighten me and advise me how do i get bluez
> > > working... thanks.
> > >
> > > Sincerely
> > > Ricky
> > >
> > >
> > >
> >
>
-------------------------------------------------------
> > > This SF.Net email is sponsored by: YOU BE THE
> JUDGE.
> > > Be one of 170
> > > Project Admins to receive an Apple iPod Mini
> FREE
> > > for your judgement on
> > > who ports your project to Linux PPC the best.
> > > Sponsored by IBM.
> > > Deadline: Sept. 13. Go here:
> > > http://sf.net/ppc_contest.php
> > > _______________________________________________
> > > Bluez-users mailing list
> > > Bluez-users@lists.sourceforge.net
> > >
> >
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> > >
> > 
> > 
> > __________________________________
> > Do you Yahoo!?
> > New and Improved Yahoo! Mail - Send 10MB messages!
> > http://promotions.yahoo.com/new_mail
> >
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE.
> Be one of 170
> Project Admins to receive an Apple iPod Mini FREE
> for your judgement on
> who ports your project to Linux PPC the best.
> Sponsored by IBM. 
> Deadline: Sept. 13. Go here:
> http://sf.net/ppc_contest.php
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



		
_______________________________
Do you Yahoo!?
Shop for Back-to-School deals on Yahoo! Shopping.
http://shopping.yahoo.com/backtoschool


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
