Return-Path: <cyrus@holtmann.org>
Message-ID: <11f816ab0805221611p7927d3dcqfdc87bd9110dad42@mail.gmail.com>
Date: Fri, 23 May 2008 01:11:36 +0200
From: Luca <lucamarturana@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Simulate a bluetooth keyboard from a pc
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

Hi to all,

I would create a software that simulates a bluetooth keyboard using
the keyboard of the pc and a bluetooth dongle. Can this be done with
bluez libs? I read the documentation of bluez-libs and bluez-utils but
I didn't understand same things:

1. The bluez-utils input dbus interface is used to connect a bluetooth
keyboard to the pc, isn't it? So it's the opposite of that I need?
2. I have to create an HIDP server? Can this be done with bluez-libs?
How can this be done? Are there same examples on how to create a HIDP
server with bluez libs and C?
3. bluez-python seems that don't support HIDP servers, right? So I must use C.

I hope that I have explained fine my question, if it's not tell me to
explain again.
Thanks for the attention and excuse me for my bad english!

Regards

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
