Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <7f52ac20609040638i2c34568fu7d7820350d714d36@mail.gmail.com>
Date: Mon, 4 Sep 2006 14:38:49 +0100
From: "Hentai Pantsu" <sugoi.sama@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Nasty bug with sdp on /etc/default/bluetooth ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

A couple of lines on my /etc/default/bluetooth file

SDPD_ENABLE=true
SDPTOOL_OPTIONS="add --channel=10 OPUSH"


The problem is that i can't send files from the mobile to the
computer, when obexserver is listening, unless i explicitly do this:
sdptool add --channel=10 OPUSH

However, i could send files from the mobile if i had kbluetooth
running, and it seemed to used channel 3. I suspect kbluetooth created
that channel automatically.

Can someone confirm if this is a bug or not?
Is there any way to list registered channels? I played with sdptool
but couldn't get anything from it (most of the times it says no route
to host).



My BT adventure sure as been interesting... :-| What other challenges
will i encounter in the future?
If this is a PITA from a user's point of view, i can only imagine the
nightmares the devs must have faced :-p


Thanks

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
