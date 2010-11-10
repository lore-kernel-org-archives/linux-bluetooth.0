Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH 7/7] Changed number of fields selected via pbap queries
Date: Wed, 10 Nov 2010 14:15:30 +0100
Message-Id: <1289394930-6694-7-git-send-email-bulislaw@linux.com>
In-Reply-To: <1289394930-6694-1-git-send-email-bulislaw@linux.com>
References: <1289394930-6694-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After fixing type handling in PBAP, there are more fields selected in each
query, contacts_other_query_from_uri needed to be adjusted.
---
 plugins/phonebook-tracker.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index f195f3f..672d59f 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -822,6 +822,7 @@
 	"SELECT \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "\
 	"\"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "	\
 	"\"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "	\
+	"\"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "			\
 	"nco:phoneNumber(?t) \"NOTACALL\" \"false\" \"false\" <%s> "	\
 	"WHERE { "							\
 		"<%s> a nco:Contact . "					\
-- 
1.7.0.4

