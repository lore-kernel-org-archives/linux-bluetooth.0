Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43DC6114.70103@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] 32-bit sbc now in CVS
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
Date: Sat, 28 Jan 2006 23:30:44 -0700

guys

FYI, I worked through the scaling to get 32-bit decoding to work. I
committed this and made the 32-bit encoder/decoder the default when you
enable fixed-point.

It turns out that we are counting on undefined compiler behavior in
several places.

 signed_var >> x

Is not necessarily defined to perform an arithmetic shift. It *could* be
replaced by:

 signed_var / (1 << x)

And while this will always produce the correct value, we can't count on
it being performed optimally (ie, it could really generate a heavyweight
division op)

I'm inclined to leave it as-is. Maybe there's an autoconf test to
confirm this compiler behavior, boiling down to:

 ASSERT(-2 >> 1 == -1)

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
