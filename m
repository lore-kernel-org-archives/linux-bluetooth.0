Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] avrcp: Fix using incorrect buffer for SetVolume
Date: Thu, 30 Jan 2014 18:12:55 +0200
Message-Id: <1391098376-26834-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1391098376-26834-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391098376-26834-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The command requires one parameter.
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2e1a940..128f7d3 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3706,7 +3706,7 @@ int avrcp_set_volume(struct btd_device *dev, uint8_t volume)
 {
 	struct avrcp_server *server;
 	struct avrcp *session;
-	uint8_t buf[AVRCP_HEADER_LENGTH + 2];
+	uint8_t buf[AVRCP_HEADER_LENGTH + 1];
 	struct avrcp_header *pdu = (void *) buf;
 
 	server = find_server(servers, device_get_adapter(dev));
-- 
1.8.3.2

