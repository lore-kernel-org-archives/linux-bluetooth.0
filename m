Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <451D96BD.6010201@flcd.net>
References: <4504301E.4060402@flcd.net> <1158313871.5233.11.camel@localhost>
	<450AD1DF.2010401@flcd.net> <1158337144.5233.34.camel@localhost>
	<451D96BD.6010201@flcd.net>
Date: Sat, 30 Sep 2006 00:03:33 +0200
Message-Id: <1159567413.29673.6.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] enable auth and BNEP question?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Denis,

> >>>> 2. I mostly use my Linux box to share create bluetooth network with 
> >>>> other PC and my PDA so previously I had "pan " directory inside 
> >>>> /etc/bluetooth/ with dev-up and dev-down files which automatically bring 
> >>>> up bnep0 device, but seems that BlueZ 3.5 is working differently and I 
> >>>> need to execute "ifconfig benp0 up" to enable my connection.
> >>>> Is there a way to automate this?
> >>>>     
> >>>>         
> >>> you might wanna try the -A, -E or -S switch for pand.
> >>>   
> >>>       
> >> Thanks for response, Marcel!
> >>
> >> I've tried switches you've recommend and seems that "-S" is what I'm 
> >> looking for although it asked me authorization 3 times(even once devices 
> >> was paired) but now it seems to work like it should.
> >>
> >> Maybe you can help me with brining up bnep0 interface automatically as well?
> >>     
> >
> > this depends on your distro. All distros have a way of bringing up
> > devices automatically. Or you might wanna check the pand.1 manual page.
> >   
> Thanks, Marcel! I'm on Debian and have tried few ways of brining up 
> interface by distro means but failed.
> I were managed to automate process by using --devup switch with pand 
> which was just what I was looking for.
> 
> BTW just wish to say that this option isn't appearing in man page, 
> thought you may like to know about this.

check the latest source code and if it is still missing, send in a patch
for it.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
