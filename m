Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 5 Oct 2006 08:27:59 -0300
From: Cris <ml133@netpole.com.br>
To: bluez-users@lists.sourceforge.net
Message-Id: <20061005082759.76270976.ml133@netpole.com.br>
In-Reply-To: <1160032959.15505.5.camel@localhost>
References: <4910207664.20061004141916@magitech.org>
	<20061004212955.cc67bc36.ml133@netpole.com.br>
	<1160032959.15505.5.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Automatic Object Pushing when Devices Enter Range
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

On Thu, 05 Oct 2006 09:22:39 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

[...]

> The only sane way of doing this is over the D-Bus API

[...]

> The D-Bus is not as bad everybody tries to tell you. For the hcid for
> example we only need the additional D-Bus library:

Nobody told me, even when I asked (but I was told to be patient
instead of getting an answer). This is my own conclusion after many
weeks of work. Try to install and use dbus in 8 or 16 MB RAM system
with about 300MB permanent storage. This is a small device, not a
desktop.

What is sane about having a function block, doing nothing but waiting,
sending requests back and forth with 3 daemons, and all those message
queues and forked children, when everything can stay in a simple main
loop? Even the use of glib doesn't make any sense here; glib's
interface exists to be portable even with Windows. This is something
you just can't afford on small systems. While all this makes sense in
other contexts, bluetooth is clearly designed for small devices, where
that is neither clean nor sane. Bluez userland is for desktop computers
or higher, and up to v3.4 (I didn't see 3.5 yet) not appropriate when
there is a need to use next to all what bluetooth has to offer,
specially in terms of multitasking.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
