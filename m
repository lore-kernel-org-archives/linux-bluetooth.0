Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <37666aa80711182224q731d19f4mb0610949fb3d240d@mail.gmail.com>
Date: Sun, 18 Nov 2007 22:24:33 -0800
From: Han <keepsimple@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] is SDP required for RFCOMM communications?
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

Hi,

I just started to use BlueZ to write bluetooth programs in C.  And I
am using VMware based Ubuntu Linux.

I can do hci_inquiry successfully. But  when I tried to run a RFCOMM
server program ( listen on channel 1).  The client always reports
error : "Operation now in progress".

The same client can connect with no problem if i closed VMware +
ubuntu and enable bluetooth in windows XP.

since the windows XP enables bluetooth & SDP services (Serial Port on
RFCOMM channel 1),  i was wondering if SDP is required to do RFCOMM
communication (on server side)  ?

or, is there anything else the server side need to do to accept the
RFCOMM connections ?

Thanks in advance,
Han

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
