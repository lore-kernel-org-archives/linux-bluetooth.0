Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH v3 2/2] Change append to prepend in pull_newmissedcalls
Date: Thu, 19 May 2011 15:57:44 +0300
Message-Id: <1305809864-9963-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1305809864-9963-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1305809864-9963-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/phonebook-tracker.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 95908ba..0e77ce8 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1464,7 +1464,7 @@ static int pull_newmissedcalls(const char **reply, int num_fields,
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

