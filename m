Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Aben Siatris <aben@webcom.sk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Hotplug
References: <200404101126.25631.conardcox@earthlink.net>
In-Reply-To: <200404101126.25631.conardcox@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200404101747.11107.aben@webcom.sk>
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
Date: Sat, 10 Apr 2004 17:47:11 +0200

D=C5=88a Saturday 10 April 2004 17:26 Richard Cox nap=C3=ADsal:
> Gentlemen,
> 	I'm trying to get bluez running on my gentoo linux server so I can conne=
ct to=20
> my IPaq 2215.  I've got a connection successfully established, but I'm tr=
ying=20
> to automate it with hotplug in hopes of setting up a NAP bridge.  The doc=
s=20
> I've found so far are rather unclear on this subject, but I've created an=
=20
> '/etc/hotplug/bluetooth.agent' script.  Right now, I'm just trying to get=
=20
> hotplug to call that script when a connection is established to automatic=
ally=20
> configure bnep0, but it only seems to get called on startup when I reboot=
 my=20
> kernel.  I had the impression that 'pand' would emit a hotplug event for=
=20
> bnep0 when a connection is established, but I'm not so sure now.  Any=20
> guidance about how I might proceed.  Thank you in advance for any informa=
tion=20
> you may provide.

not bluetooth.agent, but net.agent.
you need action after creating NET (bnep0)

i have iPAQ4155 connected.
read thread  "No more bluez.o in 2.6?"


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
