Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] media-api: Update documentation to include Volume property
Date: Tue, 22 May 2012 17:00:55 +0300
Message-Id: <1337695255-9197-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1337695255-9197-1-git-send-email-luiz.dentz@gmail.com>
References: <1337695255-9197-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/media-api.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 7a593c3..20772f0 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -341,3 +341,11 @@ Properties	object Device [readonly]
 			Optional. Indicates where is the transport being routed
 
 			Possible Values: "HCI" or "PCM"
+
+		byte Volume [readwrite]
+
+			Optional. Indicates volume level of the transport,
+			this property is only writeable when the transport was
+			acquired by the sender.
+
+			Possible Values: 0-127
-- 
1.7.7.6

