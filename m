Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 3/3] Change append to prepend in pull_newmissedcalls
Date: Wed, 18 May 2011 18:58:08 +0300
Message-Id: <1305734288-4317-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1305734288-4317-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1305734288-4317-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/phonebook-tracker.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 52ed31b..d5cdc15 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1947,7 +1947,7 @@ static int pull_newmissedcalls(const char **reply, int num_fields,
 			data->newmissedcalls++;
 		else {
 			GString *number = g_string_new(reply[1]);
-			data->numbers = g_slist_append(data->numbers,
+			data->numbers = g_slist_prepend(data->numbers,
 								number);
 		}
 	}
-- 
1.7.4.1

