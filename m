Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Richard Cox <conardcox@earthlink.net>
Reply-To: rcox27@triad.rr.com
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Hotplug
References: <200404101126.25631.conardcox@earthlink.net> <200404101206.09125.rcox27@triad.rr.com> <200404101836.25240.aben@webcom.sk>
In-Reply-To: <200404101836.25240.aben@webcom.sk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200404101255.19942.conardcox@earthlink.net>
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
Date: Sat, 10 Apr 2004 12:55:19 -0400

On Saturday 10 April 2004 12:36 pm, Aben Siatris wrote:
> D=C5=88a Saturday 10 April 2004 18:06 Richard Cox nap=C3=ADsal:
> > On Saturday 10 April 2004 11:47 am, Aben Siatris wrote:
> > > not bluetooth.agent, but net.agent.
> > > you need action after creating NET (bnep0)
> > >
> > > i have iPAQ4155 connected.
> > > read thread  "No more bluez.o in 2.6?"
> >
> > Aben,
> > 	Thank you so much!  I had been reading some old documentation it would
> > appear.  net.agent  is the script beeing called by hotplug for when pand
> > establishes a connection.  Hopfully, I'll have my iPAQ connected soon,
> > like you.
>
> but i have 2 problems. i am on LAN, and on internet, but
> have not connect to synCE to synchronizing contats, etc, and
> i now in interface 192.168.20.* (bnep0) and LAN (eth0) is on 192.168.0.*
> i need be visiting from LAN for example as 192.168.0.29.
> i am not guru in iptables and nat networking :)))
>
Aben,

	Well, I'm still working on it, but the approach I plan to take is to use a=
=20
bridge to link bnep0->pan0->eth1(internal) on my internal network.  I have =
a=20
very comprehensive firewall up on my external firewall, so I don't yet know=
=20
if that will cause problems.  I'll let you know you this turns out shortly=
=20
tho.

Cheers,

Richard


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
