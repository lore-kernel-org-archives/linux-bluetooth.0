Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 2/7] Minor fix when skipping duplicate UUID16 from EIR.
Date: Wed,  4 Aug 2010 16:00:26 -0700
Message-Id: <1280962831-18147-3-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1280962831-18147-1-git-send-email-ingas@codeaurora.org>
References: <1280962831-18147-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sdpd-service.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index cdbb4f4..35e333d 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -242,7 +242,7 @@ void create_ext_inquiry_response(const char *name,
 			if (uuid[i] == rec->svclass.value.uuid16)
 				break;
 
-		if (i == index - 1)
+		if (i < index)
 			continue;
 
 		uuid[index++] = rec->svclass.value.uuid16;
-- 
1.7.2

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
