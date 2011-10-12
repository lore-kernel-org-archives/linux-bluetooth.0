Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 09/12] AVRCP: Check if len matches number of IDs
Date: Wed, 12 Oct 2011 12:11:19 -0300
Message-Id: <1318432282-25002-9-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If number of attributes remote side provided is larger than the length
we read, we would read garbage from stack memory.
---
 audio/avrcp.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 0ca91a5..8b46650 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -597,12 +597,16 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 	int size;
 	unsigned int i;
 
-	if (len < 8 || *identifier != 0)
+	if (len < 9 || *identifier != 0)
+		goto err;
+
+	nattr = pdu->params[8];
+
+	if (len < nattr * sizeof(uint32_t) + 1)
 		goto err;
 
 	len = 0;
 	pos = 1; /* Keep track of current position in reponse */
-	nattr = pdu->params[8];
 
 	if (!nattr) {
 		/*
-- 
1.7.7

