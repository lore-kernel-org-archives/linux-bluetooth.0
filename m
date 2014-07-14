Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC] doc: Extend management OOB commands with LE support
Date: Mon, 14 Jul 2014 11:44:35 +0200
Message-Id: <1405331075-12735-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This tries to address providing SMP TK value over OOB channel.
As well as supporting LE only controllers.

NOTE:
Read local OOB data was simplified by always providing all parameters.
This could be still left with optional hash_256/rand_256 and optional
TK. Then userspace would have to use settings and reply size for
identification of optional fields.
---
 doc/mgmt-api.txt | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 2b32dd5..cdfd173 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1208,17 +1208,25 @@ Read Local Out Of Band Data Command
 	Command Parameters:
 	Return Parameters:	Hash_192 (16 Octets)
 				Randomizer_192 (16 Octets)
-				Hash_256 (16 Octets, Optional)
-				Randomizer_256 (16 Octets, Optional)
+				Hash_256 (16 Octets)
+				Randomizer_256 (16 Octets)
+				TK (16 Octets)
 
 	This command is used to read the local Out of Band data.
 
 	This command can only be used when the controller is powered.
 
-	If Secure Connections support is enabled, then this command
+	If BR/EDR support is enabled, then this command will return Hash_192
+	and Randomizer_192.
+
+	If also Secure Connections support is enabled, then this command
 	will return P-192 versions of hash and randomizer as well as
 	P-256 versions of both.
 
+	If Low Energy support is enabled then this command will return TK.
+
+	If any feature is disabled then respective fields will be set to zeros.
+
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
 
@@ -1240,6 +1248,7 @@ Add Remote Out Of Band Data Command
 				Randomizer_192 (16 Octets)
 				Hash_256 (16 Octets, Optional)
 				Randomizer_256 (16 Octets, Optional)
+				TK (16 Octets, Optional)
 	Return Parameters:	Address (6 Octets)
 				Address_Type (1 Octet)
 
@@ -1254,18 +1263,28 @@ Add Remote Out Of Band Data Command
 	Provided Out Of Band data is persistent over power down/up toggles.
 
 	This command also accept optional P-256 versions of hash and
-	randomizer. If they are not provided, then they are set to
+	randomizer and SMP TK. If they are not provided, then they are set to
 	zero value.
 
 	The P-256 versions of both can also be provided when the
 	support for Secure Connections is not enabled. However in
 	that case they will never be used.
 
+	TK can be provided when support for LE is not enabled. However in that
+	case TK will never be used.
+
 	To only provide the P-256 versions of hash and randomizer,
 	it is valid to leave both P-192 fields as zero values. If
 	Secure Connections is disabled, then of course this is the
 	same as not providing any data at all.
 
+	To only provide the TK it is valid to leave both P-192 fields as zero
+	values and not provide P-256 version of those.
+
+	If TK is provided it is required to pass proper LE address type.
+	For hash and randomizer BR/EDR is assumed regadless of passed address
+	type.
+
 	This command generates a Command Complete event on success
 	or failure.
 
@@ -1286,12 +1305,14 @@ Remove Remote Out Of Band Data Command
 				Address_Type (1 Octet)
 
 	This command is used to remove data added using the Add Remote
-	Out Of Band Data command.
+	Out Of Band Data command. If address type is set to 0xff all data is
+	removed.
 
 	Possible values for the Address_Type parameter:
 		0	BR/EDR
 		1	LE Public
 		2	LE Random
+		0xff	Any
 
 	This command generates a Command Complete event on success
 	or failure.
-- 
1.9.1

