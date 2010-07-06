Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add "hciX" to hciconfig man page
Date: Tue,  6 Jul 2010 10:00:42 -0300
Message-Id: <1278421242-21854-1-git-send-email-gustavo@padovan.org>
In-Reply-To: <19504.50180.287560.834476@gargle.gargle.HOWL>
References: <19504.50180.287560.834476@gargle.gargle.HOWL>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hciconfig.8 |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tools/hciconfig.8 b/tools/hciconfig.8
index 13f52c6..35956c4 100644
--- a/tools/hciconfig.8
+++ b/tools/hciconfig.8
@@ -10,6 +10,7 @@ hciconfig \- configure Bluetooth devices
 .br
 .B hciconfig
 .RB [\| \-a \|]
+.B hciX
 .RI [\| command
 .RI [\| "command parameters" \|]\|]
 
-- 
1.7.1

