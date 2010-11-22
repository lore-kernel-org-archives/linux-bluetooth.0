Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH] Fix typo in adapter documentation
Date: Mon, 22 Nov 2010 20:05:56 +0100
Message-Id: <1290452756-7967-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/adapter-api.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 65e2887..f287f29 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -148,7 +148,7 @@ Methods		dict GetProperties()
 
 			This registers the adapter wide agent.
 
-			The object path defines the path the of the agent
+			The object path defines the path of the agent
 			that will be called when user input is needed.
 
 			If an application disconnects from the bus all
-- 
1.7.1

