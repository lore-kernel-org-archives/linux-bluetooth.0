Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Message-ID: <pan.2005.02.03.21.45.08.935510@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] snd-bt-sco and ACPI suspend to ram and disk
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
Date: Thu, 03 Feb 2005 22:45:10 +0100

Hello,

I am using snd-bt-sco with my headset, and I noticed that every time that
snd-bt-sco kernel module is loaded, I cannot suspend to ram or to disk
using ACPI due to the error bellow.
I seems that snd-bt-sco refuses to sleep.
Has anyone experienced this, or is my setup broken ?

Thx.


Feb  3 01:21:38 t41 kernel: Tasks that refused to be refrigerated and
haven't since exited: Feb  3 01:21:38 t41 kernel:  - snd-bt-scod (#12315)
signalled but didn't enter refrigerator. Feb  3 01:21:38 t41 kernel:
snd-bt-scod   S C0445A20     0 12315      1         15280  7299 (L-TLB)
Feb  3 01:21:38 t41 kernel: d4635e50 00000046 cdd82560 c0445a20 00000092
000ad0dc c044680c f7983ec4 Feb  3 01:21:38 t41 kernel:        f7ad2808
d4635edc f7b16aa0 00000000 7c808b80 000f87fb cdd826b8 de5250e0 Feb  3
01:21:38 t41 kernel:        de525080 d4634000 d4635ea0 f8affda6 cdd82560
0000006b 00000100 00000000 Feb  3 01:21:38 t41 kernel: Call Trace:




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
