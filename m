Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH] Fix fetching call history in parts
Date: Tue, 24 May 2011 10:02:52 +0200
Message-Id: <1306224172-4212-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes doing a phone book pull on call history phone book, from
specified offset and/or with specified limit.
---
 plugins/phonebook-tracker.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index a20870e..1022d3a 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -250,8 +250,7 @@ CALLS_CONSTRAINTS(CONSTRAINT)						\
 	"nmo:receivedDate(?_call) "					\
 	"nmo:isSent(?_call) "						\
 	"nmo:isAnswered(?_call) "					\
-	"fn:concat(tracker:coalesce(?_ncontact, \"\"),"			\
-	"tracker:coalesce(?_unb_contact, \"\"))"			\
+	"?_call "							\
 CALLS_CONSTRAINTS(CONSTRAINT)						\
 "ORDER BY DESC(nmo:sentDate(?_call)) "
 
-- 
1.7.4.1

