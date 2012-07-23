Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 7/7] doc: Add Register/Unregister GATT based services
Date: Mon, 23 Jul 2012 11:55:20 -0400
Message-Id: <1343058920-18608-8-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch extends the Service interface to allow applications to
register and unregister GATT based services.
---
 doc/service-api.txt |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/doc/service-api.txt b/doc/service-api.txt
index 0139f5f..1380932 100644
--- a/doc/service-api.txt
+++ b/doc/service-api.txt
@@ -43,6 +43,39 @@ Methods		uint32 AddRecord(string record)
 					 org.bluez.Error.DoesNotExist
 					 org.bluez.Error.Failed
 
+		void Register(string uuid, dict settings,
+					array{object} characteristics)
+
+			Add a GATT based service. The uuid represents the
+			primary/secondary service UUID. The settings
+			dictionary has the following format:
+			{
+				"id": string (optional)
+			}
+
+			settings field is being added to allow API
+			flexibility. The "id" field allows the core to
+			manage handle allocation and internal GATT storage.
+
+			GATT included services is supported by providing the
+			same characteristic object path (restricted to same
+			provider/owner).
+
+			The characteristic objects implemented by the
+			caller shall follow the interface defined in the
+			attribute API.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.AlreadyExists
+
+		void Unregister(string uuid)
+
+			Removes a given GATT based service previously
+			registered by the caller.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NotAuthorized
+
 		void RegisterWatcher(object agent, dict settings,
 						array{object} characteristics)
 
-- 
1.7.9.5

