Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	johan.hedberg@nokia.com, padovan@profusion.mobi,
	rshaffer@codeaurora.org, Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 2/3] Fix Handle range if Pri/Sec Service is Empty
Date: Wed, 19 Jan 2011 14:00:52 -0800
Message-Id: <1295474453-8495-3-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1295474453-8495-1-git-send-email-bgix@codeaurora.org>
References: <1295474453-8495-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 04bc1ec..f38d61a 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -242,6 +242,7 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 
 		last_size = a->len;
 		old = cur;
+		last_handle = cur->handle;
 	}
 
 	if (groups == NULL)
-- 
1.7.1

--
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
