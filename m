Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Nov 2008 10:20:09 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: compat/Makefile.am manpages fix / pand/dund question
Message-ID: <20081110092009.GD11057@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

pand.1 and dund.1 are always installed. Fix below.

Then some kind of packaging question:
I got users that request pand and dund. I am under the impression
that this should be handled by the networking service, however was
unable to find anything understandable on the WIKI where I can point
them to.

Am I still "allowed" to package pand and dund, e.g. in a "bluez-compat"
package? I guess that I should not package hidd, no matter how much
users would like it, though ;-)

Thanks,

	Stefan

diff --git a/compat/Makefile.am b/compat/Makefile.am
index f3422fc..58254ad 100644
--- a/compat/Makefile.am
+++ b/compat/Makefile.am
@@ -20,11 +20,11 @@ bin_PROGRAMS += pand
 pand_SOURCES = pand.c pand.h bnep.c sdp.h sdp.c
 
 pand_LDADD = $(top_builddir)/common/libhelper.a @BLUEZ_LIBS@
-endif
 
 if MANPAGES
 man_MANS += pand.1
 endif
+endif
 
 if DUND
 bin_PROGRAMS += dund
@@ -32,11 +32,11 @@ bin_PROGRAMS += dund
 dund_SOURCES = dund.c dund.h lib.h sdp.h sdp.c dun.c msdun.c
 
 dund_LDADD = $(top_builddir)/common/libhelper.a @BLUEZ_LIBS@
-endif
 
 if MANPAGES
 man_MANS += dund.1
 endif
+endif
 
 AM_CFLAGS = @BLUEZ_CFLAGS@
 

-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out." 

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
