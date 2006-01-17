Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43CD6921.9060603@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] libsbc refactoring
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
Date: Tue, 17 Jan 2006 15:01:05 -0700

Victor,

I've been meaning to try to simplify the 64-bit fixed point by
eliminating the struct that combines two 32-bit values. So now we depend
on the compiler to do all 64-bit math. The arm assembly goes out.

Can you try this and make sure it's still performing well on arm?

This makes all the different flavors of math look the same in the basic ops:

#define SBC_FIXED_0(val) {val = 0;}
#define ADD(dst, src)  {dst += src;}
#define SUB(dst, src)  {dst -= src;}
#define MUL(dst, a, b) {dst = (sbc_fixed_t)a * b;}
#define MULA(dst, a, b)  {dst += (sbc_fixed_t)a * b;}

so we could even eliminate these macros. I know Marcel would be happy to
see them go ;)

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
