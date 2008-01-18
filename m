Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-15?q?Fr=E9d=E9ric?= <fma@gbiloba.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Date: Fri, 18 Jan 2008 20:20:30 +0100
Message-Id: <200801182020.30477.fma@gbiloba.org>
Subject: [Bluez-users] Newbie needs help to start
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

I'm a new BlueTooth user. I'm working on a nice project [1] which consists =

to turn an astronomic mount into a panoramic head. I hacked the protocol =

between the head and the remote, and made a little serial interface to =

take control from a computer. The protocol is ascii, and the interface =

only consists to adapt levels.

Then, the idea is to plug a BT/serial converter to this interface to drive =

the head from a PDA. So, I bought a AIRcable Serial3 hardware, which is a =

nice product, because it is possible to program it to do higher level =

tasks. But for now, I'm just trying to use it as a simple converter, with =

the default firmeware.

And I need your help to access it from linux/debian. Manuel Naranjo helped =

me a lot, but I still have strange issues. And I would also like to =

understand how Bluetooth is implemented under linux; there seems to have a =

lot of layers, and it is not simple... So, if someone could summarize all =

this for me...

I also need to know how to use the serial protocol to access the Serial3 =

hardware as any other serial port. I tired to use rfcomm, but, again, I'm =

not sure to clearly undertand whait it is supposed to do.

Last thing: I'm a python developper, so I like very much all python =

examples on Bluez wiki ;o)

Thank you very much for you help.

[1]http://www.autopano.net/wiki/action/view/Orion_TeleTrack_altazimuth_trac=
king_mount

There is a link to the french wiki, which is more up-to-date. I didn't take =

the time to translate it...

-- =

   Fr=E9d=E9ric

   http://www.gbiloba.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
