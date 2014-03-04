Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 01/10] avrcp: Fix possible buffer overflow
Date: Tue,  4 Mar 2014 16:02:06 +0200
Message-Id: <1393941735-12187-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393941735-12187-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393941735-12187-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This fixes static analysers warnings.
---
 profiles/audio/avrcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index bca2fc8..aa932e0 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1909,6 +1909,9 @@ static void avrcp_get_current_player_value(struct avrcp *session,
 	struct avrcp_header *pdu = (void *) buf;
 	uint16_t length = AVRCP_HEADER_LENGTH + count + 1;
 
+	if (count > AVRCP_ATTRIBUTE_LAST)
+		return;
+
 	memset(buf, 0, sizeof(buf));
 
 	set_company_id(pdu->company_id, IEEEID_BTSIG);
-- 
1.8.3.2

