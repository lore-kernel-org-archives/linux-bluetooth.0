Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 2/2] Add missing const to utility functions.
Date: Mon, 31 Jan 2011 16:09:32 -0300
Message-Id: <1296500972-14105-2-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1296500972-14105-1-git-send-email-andre.dieb@signove.com>
References: <1296500972-14105-1-git-send-email-andre.dieb@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: André Dieb Martins <andre.dieb@signove.com>

---
 parser/hci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index 8b45376..183fa66 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -704,7 +704,7 @@ static char *authentication2str(uint8_t authentication)
 	}
 }
 
-static char *eventmask2str(uint8_t mask[8])
+static char *eventmask2str(const uint8_t mask[8])
 {
 	int i;
 
@@ -733,7 +733,7 @@ static char *eventmask2str(uint8_t mask[8])
 	}
 }
 
-static char *lefeatures2str(uint8_t features[8])
+static char *lefeatures2str(const uint8_t features[8])
 {
 	if (features[0] & 0x01)
 		return "Link Layer supports LE Encryption";
-- 
1.7.1

