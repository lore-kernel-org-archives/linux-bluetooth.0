Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>,
	Ranulf Doswell <ralf@ranulf.net>,
	"Pascal A . Brisset" <pascal44973@pabr.org>,
	Marcin Tolysz <tolysz@gmail.com>,
	Christian Birchinger <joker@netswarm.net>,
	Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>,
	Mikko Virkkila <virkkila@kapsi.fi>,
	Simon Wood <simon@mungewell.org>,
	Arc Riley <arcriley@gmail.com>
Subject: [PATCH BlueZ 3/4] Link to udev only when needed
Date: Fri,  5 Aug 2011 16:09:17 +0200
Message-Id: <1312553358-26280-4-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't link bluetoothd to udev unconditionally, but only when it is
needed. For now bluetoothd needs to be linked to udev only when the
sixaxis plugin is enabled.
---
 Makefile.am |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index dbe0170..219ca0f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -288,7 +288,11 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/event.h src/event.c \
 			src/oob.h src/oob.c src/eir.h src/eir.c
 src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
-							@CAPNG_LIBS@ @UDEV_LIBS@ -ldl -lrt
+							@CAPNG_LIBS@ -ldl -lrt
+if SIXAXISPLUGIN
+src_bluetoothd_LDADD += @UDEV_LIBS@
+endif
+
 src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
-- 
1.7.5.4

