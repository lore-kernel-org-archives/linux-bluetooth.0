Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Jan 2012 14:14:32 +0100
From: Per-Henrik Lundblom <ph@whatever.nu>
To: linux-bluetooth@vger.kernel.org
Subject: bluetooth-alsa: Connection fix for kernel >= 2.6.30
Message-ID: <20120102131432.GB12738@whatever.nu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

After trying to get bluetooth-alsa working on Ubuntu 11.10 (kernel
3.0.0) I realized that the struct sockaddr_l2 struct was changed in
kernel 2.6.30 to include a l2_cid variable. This variable is of course
not set in the a2dpd code which results in a socket connect() call
returning -EINVAL.

Simple fix is to memset struct before use. Patch is attached.
Unfortunately I don't have any idea where to send the patch, hope this
list isn't totally wrong.

/PH

--
Per-Henrik Lundblom           epost: ph@whatever.nu
telefon: 0733-20 71 26        hemsida: www.whatever.nu


--CE+1k2dSO48ffgeK
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="sockaddr_l2-fix.patch"

Index: a2dpd_tools.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/plugz/alsa-plugins/a2dpd/a2dpd_tools.c,v
retrieving revision 1.8
diff -u -r1.8 a2dpd_tools.c
--- a2dpd_tools.c	26 Jul 2007 13:33:54 -0000	1.8
+++ a2dpd_tools.c	1 Jan 2012 22:31:12 -0000
@@ -212,6 +212,7 @@
 	{
 		struct sockaddr_l2 sa;
 
+                memset(&sa, 0, sizeof(sa));
 		// create L2CAP connection
 		session->sock = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
 		session->local = 0;

--CE+1k2dSO48ffgeK--
