Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ] doc: Update possible values of Agent capabilities
Date: Wed, 16 May 2012 09:26:24 -0300
Message-Id: <1337171184-909-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/adapter-api.txt |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 0cded8c..dccb6bf 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -165,10 +165,11 @@ Methods		dict GetProperties()
 			of its registered agents will be removed.
 
 			The capability parameter can have the values
-			"DisplayOnly", "DisplayYesNo", "KeyboardOnly" and
-			"NoInputNoOutput" which reflects the input and output
-			capabilities of the agent. If an empty string is
-			used it will fallback to "DisplayYesNo".
+			"DisplayOnly", "DisplayYesNo", "KeyboardOnly",
+			"NoInputNoOutput" and "KeyboardDisplay" which reflects
+			the input and output capabilities of the agent. If an
+			empty string is used it will fallback to
+			"DisplayYesNo".
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.AlreadyExists
-- 
1.7.10.2

