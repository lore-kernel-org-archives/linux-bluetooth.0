Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 1/4] lib: Declare mode field in sco_options
Date: Wed, 30 Jan 2013 18:03:01 +0100
Message-Id: <1359565384-4656-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1359565384-4656-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1359565384-4656-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sco.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/sco.h b/lib/sco.h
index 75336a5..c3a03ce 100644
--- a/lib/sco.h
+++ b/lib/sco.h
@@ -47,6 +47,7 @@ struct sockaddr_sco {
 #define SCO_OPTIONS	0x01
 struct sco_options {
 	uint16_t	mtu;
+	uint8_t		mode;
 };
 
 #define SCO_CONNINFO	0x02
-- 
1.7.9.5

