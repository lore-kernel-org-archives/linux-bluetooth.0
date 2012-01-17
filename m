Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 01/11] mgmt-api: Update the commands for exchanging LTK's
Date: Tue, 17 Jan 2012 20:28:40 -0300
Message-Id: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For restoring the device from storage we need to have the Address type
of the device, the LTK is a good place for this.

In some cases, we may be notified of keys that were generated in the
Host, that key key would be used when the Host is the slave role in
a later connection, we should be able to differentiate this type of
key because it doesn't mean that we have a bonding with the Remote
Device.
---
 doc/mgmt-api.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 3e188c2..8fe7c94 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -477,7 +477,9 @@ Load Long Term Keys Command
 	Command Parameters:	Key Count (2 Octets)
 				Key1 {
 					Address (6 Octets)
+					Type (1 Octet)
 					Authenticated (1 Octet)
+					Master (1 Octet)
 					Encryption Size (1 Octet)
 					Enc. Diversifier (2 Octets)
 					Random Number (8 Octets)
@@ -758,7 +760,9 @@ Controller Index	<controller id>
 Event Parameters	Store Hint (1 Octet)
 			Key {
 				Address (6 Octets)
+				Type (1 Octet)
 				Authenticated (1 Octet)
+				Master (1 Octet)
 				Encryption Size (1 Octet)
 				Enc. Diversifier (2 Octets)
 				Random Number (8 Octets)
-- 
1.7.8.1

