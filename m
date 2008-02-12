Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Feb 2008 22:06:55 -0500
From: Aristeu Sergio Rozanski Filho <aris@ruivo.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20080212030655.GB17385@jake.ruivo.org>
MIME-Version: 1.0
Subject: [Bluez-devel] [PATCH 1/4] common/uinput.h: update uinput.h with
	needed key	definitions
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This patch adds missing key definitions used by ps3 remote support, but
only the definitions already upstream.

---
 common/uinput.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/common/uinput.h	2008-02-11 22:01:00.000000000 -0500
+++ b/common/uinput.h	2008-02-11 22:01:33.000000000 -0500
@@ -262,6 +262,7 @@ extern "C" {
 #define KEY_PROG4		203
 #define KEY_SUSPEND		205
 #define KEY_CLOSE		206
+#define KEY_PLAY		207
 
 #define KEY_UNKNOWN		220
 
@@ -406,6 +407,10 @@ extern "C" {
 #define KEY_TEEN		0x19e
 #define KEY_TWEN		0x19f
 
+#define KEY_FRAMEBACK		0x1b2
+#define KEY_FRAMEFORWARD	0x1b3
+#define KEY_CONTEXT_MENU	0x1fb
+
 #define KEY_MAX			0x1ff
 
 /* Relative axes */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
