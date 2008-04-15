Return-Path: <cyrus@holtmann.org>
Message-ID: <4805151F.1010309@jlab.org>
Date: Tue, 15 Apr 2008 16:50:39 -0400
From: Chris Carlin <carlin@jlab.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Mysterious regression: Link authentication time out
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

I've been using three Dell branded bluetooth keyboards (P/N DH953) just fine for
months. Now they've simultaneously stopped working, and system logs have the
following repeated every time the keyboard tries to connect:

Apr 15 16:16:14 [hcid] Link authentication failed: Connection timed out (110)
Apr 15 16:16:14 [hcid] link_key_request (sba=***, dba=***)

with *** replaced by the respective addresses.

These are three completely independent keyboards miles apart. The
computers use various brands and chipsets in their bluetooth dongles, which themselves are variety of combinations of bluetooth version and class, and which continue to work flawlessly with mice, A2DP, etc. They run Bluez versions between 3.28 and 3.30, Linux kernels 2.6.23/4

As I said, all three keyboards had been working fine for six months to a year--so good was my experience that I kept buying new ones and recommending them. Yet despite this record all three stopped working within a single week. I didn't
make any changes to the systems during that time--no upgrades, no bluez
configuration changes, nothing.

I've replaced batteries, deleted and re-paired, restarted, re-pined, and
everything else but with no luck. 

Anyone have any idea what might be going on here? Has there been a worldwide
death of these keyboards?

~Chris


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
