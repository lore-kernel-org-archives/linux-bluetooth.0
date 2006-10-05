Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 5 Oct 2006 08:10:12 -0300
From: Cris <ml133@netpole.com.br>
To: bluez-users@lists.sourceforge.net
Message-Id: <20061005081012.1382fa2b.ml133@netpole.com.br>
In-Reply-To: <1118650597.20061004182027@magitech.org>
References: <4910207664.20061004141916@magitech.org>
	<20061004212955.cc67bc36.ml133@netpole.com.br>
	<1118650597.20061004182027@magitech.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Wed, 4 Oct 2006 18:20:27 -0700
"Benn" <bb.bluez@magitech.org> wrote:

> First of all, as you suggested, BlueZ may not be the right stack. Are the=
re
> logical alternative stacks available, or is it more a matter of using the
> underlying framework rather then the publicly exposed API?

I=B4m not a kernel hacker, so I can't really qualify bluez's stack, but
it seems that hardware support with bluez is quite good. I was talking
about libbluetooth.so; IIRC there was another bluetooth project for
linux, but it seems far less popular and supported less (or
different?) devices, so I didn't follow it. I do use the bluez kernel
stack but neither the library nor the daemons.

> You brought up authentication.  If I am OBEX pushing then, as the
> server, if I don't specify any authentication none will be required.
> Correct?  Are there other authentication related issues I should be
> aware of?

I've given up any attempt to understand how bluez security model
works, first because if the mentioned library deficiencies and second
because of the heavy shift to dbus in the last versions makes it
virtually impossible even to try to use it. The fact is that,
according to bluetooth specifications, authentication is not required
as long as neither of the peers request authentication.

> Can you point out where this loop actually resides in source, off hand?

Those functions in libbluetooth which require a timeout as an argument
internally call a function `hci_send_req()' in blues-libs/src/hci.c
which will send the command and wait for the answer. Rather than a
select-loop as I said yesterday, it's a poll loop, blocking the return
of the function until an answer arrives or a timeout happens.

> I'm not adverse to using the lower level API's if it truly becomes necess=
ary,
> but since the file transfers are small and fork()'ing seems a reasonable,
> though not ideal, solution, I might stick with that.  A central process t=
hat
> is responsible for discovery, forking off separate children to handle the
> actual file dispatches should work, yes?

Open two shells, prepare a commandline obextftp to send a file from
your linux box (only one bluetooth adapter) to two different
cellphones or PDAs in each, and start them more or less at the same
time. All attempts I made ended with one working immediately, the
other either waiting until the first finished or giving some
busy-error. As I believe that obexftp doesn't switch role, the linux
box should become the master of a 3-membered piconet and simultaneous
transmission should work. But bluez defeats that. Actually, up to five
more devices could join the party. But not with libbluetooth.so.

-- =

Cris

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
