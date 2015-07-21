Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH BlueZ v1 15/15] peripheral: Add a Makefile for building a binary using soletta
Date: Tue, 21 Jul 2015 20:16:48 -0300
Message-Id: <1437520608-22444-16-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
References: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a sample Makefile using some of the soletta tools for building a
binary linking with the soletta binary implementing the Heartrate Sensor
profile.
---
 peripheral/soletta/Makefile | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 peripheral/soletta/Makefile

diff --git a/peripheral/soletta/Makefile b/peripheral/soletta/Makefile
new file mode 100644
index 0000000..86dbd7d
--- /dev/null
+++ b/peripheral/soletta/Makefile
@@ -0,0 +1,22 @@
+PKG_CONFIG ?= pkg-config
+
+PREFIX=$(shell $(PKG_CONFIG) --variable=prefix soletta)
+DATADIR=$(shell $(PKG_CONFIG) --variable=pkgdatadir  soletta)
+SOLETTA_CFLAGS=$(shell $(PKG_CONFIG) --cflags soletta)
+SOLETTA_LDFLAGS=$(shell $(PKG_CONFIG) --libs soletta)
+SOLETTA_INCLUDEDIR=$(shell $(PKG_CONFIG) --variable=includedir soletta)
+
+GENERATOR=$(PREFIX)/bin/sol-fbp-generator
+
+all: soletta-init main.c
+
+main.c: sol-flow.json heartrate.json heartrate.fbp
+	$(GENERATOR) -c sol-flow.json -j heartrate.json -j $(DATADIR)/flow/descriptions/timer.json heartrate.fbp $@
+
+soletta-init: main.c
+	$(CC) $(CFLAGS) -Os -o $@ $< .libs/heartrate.a $(SOLETTA_CFLAGS) -include $(SOLETTA_INCLUDEDIR)/soletta/timer-gen.h -include heartrate-gen.h $(SOLETTA_LDFLAGS)
+
+clean:
+	@rm main.c soletta-init
+
+.PHONY: clean
-- 
2.4.6

