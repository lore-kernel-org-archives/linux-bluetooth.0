Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <f8e53fb0709200804h5dffbc3cy115a9669ab4d05c6@mail.gmail.com>
Date: Thu, 20 Sep 2007 17:04:16 +0200
From: "Andrea Galbusera" <gizero@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Basic serial communication over RFCOMM
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi all,
I'm new to bluetooth programming and to serial communication too, but
I have a basic understanding of unix I/O.

I'm writing an application to communicate with some BT connected
devices. RFCOMM stuff is up and running ok.

I actually can do basic communication using minicom, but when I try to
do it in a simple open(), write() and read() program nothing happens!
I suspect this to be related to some basic setup of the tty attached
to the RFCOMM device I'm not managing correctly. If I keep minicom
open on a terminal and run my application on another this works fine
(I see correct answers from the device).

Could you please suggest any code examples or resources useful for
newbies on such a topic. I know there is a lot of stuff behind ttys
but hopefully only some parameters will be required.

TIA

Andrea

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
