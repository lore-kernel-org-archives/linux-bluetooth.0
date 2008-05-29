Return-Path: <cyrus@holtmann.org>
Message-ID: <1945.124.170.117.82.1212030264.squirrel@www.magtech.com.au>
Date: Thu, 29 May 2008 13:04:24 +1000 (EST)
From: arasv@magtech.com.au
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] DUND pre-pppd script
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

I need to determine my ppp IP address pair before I run pppd.

The reason is that I have several network interfaces running at once on my
system so I need to choose an IP address in a subnet that is not already
taken.

Would you recommend that I add a pre-ppp-up mechanism to dund to do this?

If someone knows how to get pppd to run a script *before* it reads its
configuration file then I would rather do that instead.

Aras


______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
