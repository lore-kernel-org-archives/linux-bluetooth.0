Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] obexd: Fix comparing array to 0
Date: Wed,  3 Dec 2014 16:08:53 +0200
Message-Id: <1417615733-7350-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1417615733-7350-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1417615733-7350-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Comparing an arrays to 0 is not useful.
---
 obexd/client/pbap.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 57632b4..28203a8 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -1111,9 +1111,6 @@ static gboolean get_databaseid(const GDBusPropertyTable *property,
 	char value[33];
 	const char *pvalue = value;
 
-	if (!pbap->databaseid)
-		return FALSE;
-
 	if (u128_to_string(pbap->databaseid, value, sizeof(value)) < 0)
 		return FALSE;
 
@@ -1137,9 +1134,6 @@ static gboolean get_primary(const GDBusPropertyTable *property,
 	char value[33];
 	const char *pvalue = value;
 
-	if (!pbap->primary)
-		return FALSE;
-
 	if (u128_to_string(pbap->primary, value, sizeof(value)) < 0)
 		return FALSE;
 
@@ -1155,9 +1149,6 @@ static gboolean get_secondary(const GDBusPropertyTable *property,
 	char value[33];
 	const char *pvalue = value;
 
-	if (!pbap->secondary)
-		return FALSE;
-
 	if (u128_to_string(pbap->secondary, value, sizeof(value)) < 0)
 		return FALSE;
 
-- 
1.9.1

