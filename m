Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43EDA1BB.4040909@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] more AVRCP tinkering
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 11 Feb 2006 01:35:07 -0700

Hey

I found a better alternative to listening for AVRCP "callbacks" from the
headset. The "callback" connection to the computer is only made after
the a2dp stream starts and is always torn down when the stream closes.

I can open the l2cap connection at any time going from the computer to
headset (even before playing something) and this connection isn't ever
torn down by the headset. It's conceivable that this mode of operation
could be used to start the stream up in addition to controlling a
running a2dp stream.

Still no luck sending volup/down to the headset (not even a nak).

Committed to cvs in a new app "avsnd" that takes the mac addr as its
only argument. Currently coded to try sending volup after every
interaction with the headset.

Brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
