Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH] Optimise call history queries
Date: Tue, 14 Jun 2011 09:09:00 +0200
Message-Id: <1308035340-4027-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This changes order of graph pattern elements, moving OPTIONAL block to
the end of the query. This gives a dramatic performance improvement.
---
 plugins/phonebook-tracker.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 1022d3a..80dfc02 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -161,6 +161,7 @@
 	"?_call a nmo:Call . "						\
 	"?_unb_contact a nco:Contact . "				\
 	"?_unb_contact nco:hasPhoneNumber ?_cpn . "			\
+CONSTRAINT								\
 	"OPTIONAL { "							\
 		"{ SELECT ?_contact ?_cpn ?_role ?_number "		\
 			"count(?_contact) as ?cnt "			\
@@ -177,7 +178,6 @@
 		"} GROUP BY ?_cpn } "					\
 		"FILTER(?cnt = 1) "					\
 	"} "								\
-CONSTRAINT								\
 "} "
 
 #define CALLS_LIST(CONSTRAINT)						\
-- 
1.7.4.1

