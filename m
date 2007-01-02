Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 2 Jan 2007 09:44:14 -0200
From: Cris <ml133@netpole.com.br>
To: bluez-users@lists.sourceforge.net
Message-Id: <20070102094414.f7b9cef1.ml133@netpole.com.br>
In-Reply-To: <57c68ddc0701020229w6ddfaab3yf989a8e3999cbd1@mail.gmail.com>
References: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>
	<1167725398.30886.32.camel@violet>
	<57c68ddc0701020016y29fafa8duf77494bb50ac6d75@mail.gmail.com>
	<20070102081813.6a264b0e.ml133@netpole.com.br>
	<57c68ddc0701020229w6ddfaab3yf989a8e3999cbd1@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problem in making multiple connections using
 single bluetooth adapter using bluez
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

On Tue, 2 Jan 2007 15:59:19 +0530
"siddhant tewari" <siddhant.tewari@gmail.com> wrote:

> hi cris,
>            I tried similar thing using OBEX push client and the thing that
> happened is exactly what u apprehended ...
>     ->  One thread waited for the other to get completed .... sad blues
> behavior.....this is exactly what is creating trouble in my application ...

Obviously, BlueZ didn't learn to deal with more than one connection at
the same time yet. They are still thinking that everybody has a
desktop computer with KDE (or Windows, as dbus being a derivate from
gtk, is specially designed to be platform independent) and just a
single cellphone or PDA at home. Of course, large companies like Nokia
are not really affected by these problems, as a cellphone is so small
that it can't deal with much more than one thing at the same time
anyway. But this may change in some future.

So your only choice is to not use libbluetooth. Marcel is right when
he says that this implies a lot of work, as you will have to implement
each protocol layer yourself. But as these are quite badly designed in
BlueZ, there is really no fix for it. If the BlueZ developers had a
different way of dealing with users (just look at their answers) the
many thousands of hours of work we are doing each one on his own could
go into this project. So, we are alone here. Your choices like mine or
anybody else's who is trying to serious work with bluetooth, is either
to give up or to do the work.

But be aware, that re-writing the protocol stack may not be
enough. I've done so and am having bad troubles because BlueZ
developers think that an exclusive usage over a socket can be
implemented by the concept of a raw socket. This is not true. Even
using raw sockets the kernel will interfere in your programming,
meaning that it is quite possible that we will have to replace also
the kernel modules, which would make 100% of BlueZ code unusable. Not
regulating mutually interfering accesses to one and the same ressource
is pure Windows philosophy, where each program, starting with
kernel.dll thinks it owns the complete device. Raw sockets allow to do
low leve things, but they don't guarantee that someone else wont undo
what ever my program has done a second earlier. Even if this someone
else is the kernel herself.

I've suggested the use of an exclusive flag with the HCI sockets, when
Marcel answered, that the kernel does NOT interfere when I open that
socket in raw. This is just not true. Marcel (who should know as he
wrote this monster) asked what exactly happens. Here it is:

If your program is already active and you plug in an USB bluetooth
dongle, the kernel issues several informational queries to the
device. It needs to do so, as a raw socket doesn't imply that there
couldn't be more than one processes accessing the same device (there
is no exclusivity), while a second process might want to use a cooked
socket. In my case, I know that there will be no other process,
specially not hcid or dbus, but the kernel doesn't, and still issues
these commands. Thus, I need to expect anything to happen, just for
the USB dongle having been plugged in. This raises the level of
complexity of my program by a power of magnitud. Also, Marcel himself
said, that whenever a major version number is increased, we can not
trust that the behaviour wont change incompatibly with the previous
version (besides the use of dbus and apparently the inability to
multitask). Did anybody see any reasoning why dbus is defended so
stiff neckedly? Or why nobody cares to work on a design which actually
matches what bluetooth specifications persue?

Much worse is what happens if you create a connection. Until you get
the connection complete event, everything is fine. But then, the
kernel will issue several commands, ignoring any commands of yours
until it's done. Among those is HCI_Write_Link_Policy_Settings. At
this point it seems to be impossible to achieve for instance a role
switch. Also, the kernel has no way to know what my program is trying
to do, and thus can not know which is the link policy I need.

You see, everybody doing things like you and me (and I've seen more
than just a few more out there) is just out of luck. The best would be
somebody starting to fork the full development of Bluetooth support in
Linux, but this time with a well thought design based on a thorough
understanding of bluetooth and it's protocols.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
