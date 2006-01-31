Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43DF951D.6080500@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] 32-bit libsbc
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
Date: Tue, 31 Jan 2006 09:49:33 -0700

Marcel,

I cleaned up and simplified the sbc stuff. It uses a single math
implementation, 32-bit ints, and has no assembly. All library
misbehavior such as printf, exit, etc is gone.

It still has macros for multiply and multiply-add ops but these are very
useful for hunting down overflows. I suspect there may be situations
where a input stream can cause an overflow so I'd like to leave those in.

The files are in btsco cvs under the subdir "sbc32"

I dropped sbc.c, sbc_math.h, sbc_tables.h in the sbc project lib dir and
sbc.h in its include dir and everything builds and installs just great.

Do the test/util apps like sbcenc, sbcdec, sbcinfo belong somewhere in
the libsbc project?

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
