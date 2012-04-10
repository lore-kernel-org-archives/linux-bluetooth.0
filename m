Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v2 1/3] MAP: Mark filter strings const
Date: Tue, 10 Apr 2012 16:47:39 +0200
Message-Id: <1334069261-3668-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This structure is used for giving filters as input argument to
messages_get_messages_listing(). There is no need for the string members
to be modifiable in this context. And making them const plays well with
map_ap_get_string(), from which the values of these members are going to
be retrieved.
---
v2: Turn on verbose mode in commit messages

 plugins/messages.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/messages.h b/plugins/messages.h
index 00a040c..2cdd92f 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -111,11 +111,11 @@ struct messages_event {
 struct messages_filter {
 	uint32_t parameter_mask;
 	uint8_t type;
-	char *period_begin;
-	char *period_end;
+	const char *period_begin;
+	const char *period_end;
 	uint8_t read_status;
-	char *recipient;
-	char *originator;
+	const char *recipient;
+	const char *originator;
 	uint8_t priority;
 };
 
-- 
1.7.5.1

