Return-Path: <cyrus@holtmann.org>
From: Timo Mueller <mail@timomueller.eu>
To: linux-bluetooth@vger.kernel.org
Cc: Timo Mueller <timo.mueller@bmw-carit.de>
Subject: [PATCHv1 1/2] doc: Introduce default adapter property
Date: Tue,  3 Dec 2013 16:21:45 +0100
Message-Id: <1dc8c4e895c1511d82feaf65e33fdf2c93161e5d.1386078490.git.timo.mueller@bmw-carit.de>
In-Reply-To: <cover.1386078490.git.timo.mueller@bmw-carit.de>
References: <cover.1386078490.git.timo.mueller@bmw-carit.de>
In-Reply-To: <cover.1386078490.git.timo.mueller@bmw-carit.de>
References: <cover.1386078490.git.timo.mueller@bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Timo Mueller <timo.mueller@bmw-carit.de>

Some plugins choose a default adapter when no specific adapter has
been selected. This information was not exposed in the adapters D-Bus
properties.

With the new property users can find out which adapter is used if no
adapter has been specified. This allows them to change the properties
of the adapter beforehand, e.g. powering the adapter before oob data
is sent.
---
 doc/adapter-api.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 74d235a..9990432 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -153,3 +153,12 @@ Properties	string Address [readonly]
 
 			Local Device ID information in modalias format
 			used by the kernel and udev.
+
+		boolean Default [readonly]
+
+			Indicates that the adapter is the default adapter. The
+			default adapter is used when multiple adapters exist and
+			no specific adapter has been selected.
+
+			In case the default adapter is removed, one of the
+			remaining adapters will become the new default adapter.
-- 
1.8.3.1

