Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Fix typo error in the attribute API documentation
Date: Wed,  8 Jun 2011 11:07:33 +0200
Message-Id: <1307524053-10477-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/attribute-api.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index f2778f3..98d7f30 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -12,7 +12,7 @@ or service from attribute database.
 
 Local services are children of the adapter object path. Remote services
 are children of the remote device object path. This doesn't solve the
-problem where local atttributes can have different instances based on
+problem where local attributes can have different instances based on
 the remote device.
 
 In general the idea is to also represent SDP records as services so that
-- 
1.7.5.2

