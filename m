Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 4/4] Add missing options to bootstrap-configure
Date: Fri, 30 Dec 2011 15:26:11 -0400
Message-Id: <1325273171-24698-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1325273171-24698-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1325273171-24698-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With these options, all BlueZ C files are compiled with
"./bootstrap-configure". The only exception is --enable-hal, which
conflicts with the "formfactor" plugin.
---
 bootstrap-configure |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/bootstrap-configure b/bootstrap-configure
index 89ea156..bdb9234 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -32,6 +32,9 @@ fi
 		--enable-dund \
 		--enable-test \
 		--enable-cups \
+		--enable-dbusoob \
+		--enable-maemo6 \
+		--enable-pnat \
 		--enable-sap \
 		--enable-thermometer \
 		--enable-wiimote \
-- 
1.7.0.4

