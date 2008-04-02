Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100804021257r43decf07o9f70c93b11bf3a87@mail.gmail.com>
Date: Wed, 2 Apr 2008 16:57:58 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] RequestMode implementation
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello all,

For people not present in irc today, Ive been implementing the support
of "sessions" for
adapter.RequestMode, the code is already in cvs if someone want to take a l=
ook.

The idea is that the application should no longer use, even though it
still could,
adapter.SetMode or in case of the new adapter.SetProperty("Mode", but use
RequestMode that will monitor the lifetime of the application and restore t=
he
"global" mode when the "session" is released.

The logic behind the RequestMode is:
  - It can only set "connectable" or "discoverable" modes, so should
not interfere much.
  - Session can temporary request a higher mode than the global mode.
  - By the time a session is active discoverable timeout is not enabled.
  - It supports multiples applications, the higher requested mode prevail.
  - Requested modes should be accepted by agent every time a higher mode is
requested.
  - All requests are appended to a list, the session will live until
the last application releases
it.
  - After the last application using the session exit the mode changes
back to global mode.
  - SetMode/SetProperty("Mode" takes effects on either session mode
and global mode if
it is higher and just in global mode if it is lower. (alternatively it
can ask the agent if the
 application can lower the session mode).

Lets check if this logic is ok and so check with some use cases if
there are some we can't
handle.

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
