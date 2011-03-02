Return-Path: <cyrus@holtmann.org>
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Pawlik <lucas.pawlik@gmail.com>
Subject: [PATCH] Fix handling owner data in phonebook pull
Date: Wed,  2 Mar 2011 14:25:55 +0100
Message-Id: <1299072355-24766-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix handling "empty" phone owner data in phonebook pull via
PBAP. Previously owner vCard was always present as a first on list in
phonebook pull results even if it was empty. This patch fix this and
owner vCard will not be present in pulled phonebook.
---
 plugins/phonebook-tracker.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 2cd10de..e71ec7b 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -137,6 +137,7 @@
 "WHERE {"								\
 "	?_contact a nco:PersonContact ."				\
 "	OPTIONAL {?_contact nco:hasAffiliation ?_role .}"		\
+"	FILTER (regex(str(?_contact), \"urn:uuid:\"))"			\
 "}"									\
 "ORDER BY tracker:id(?_contact)"
 
-- 
1.7.0.4

