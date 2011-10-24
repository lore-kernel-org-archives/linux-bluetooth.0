Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Add new command and event for LTK storage support
Date: Mon, 24 Oct 2011 14:26:27 +0200
Message-Id: <1319459187-11092-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This documents the new command and event that are to be added to
the Management API to add support for persistent pairing of LE
devices.
---
 doc/mgmt-api.txt |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 8d5d8d5..44fef0b 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -356,6 +356,24 @@ Name Information Command
 	expected for each Device Found event with the Confirm Name
 	flag set.
 
+Load Long Term Keys Command
+===========================
+
+	Command Code:		0x0021
+	Controller Index:	<controller id>
+	Command Parameters:	Debug Keys (1 Octet)
+				Key Count (2 Octets)
+				Key1 {
+					Address (6 Octets)
+					PIN_Length (1 Octet)
+					Encryption Size (1 Octet)
+					Enc. Diversifier (2 Octets)
+					Random Number (8 Octets)
+					Value (16 Octets)
+				}
+				Key2 {  }
+				...
+
 Read Tracing Buffer Size Command
 ================================
 
@@ -588,3 +606,18 @@ Device Unblocked Event
 Event Code		0x00016
 Controller Index	<controller id>
 Event Parameters	Address (6 Octets)
+
+New Long Term Key Event
+=======================
+
+Event Code		0x0017
+Controller Index	<controller id>
+Event Parameters	Store Hint (1 Octet)
+			Key {
+				Address (6 Octets)
+				PIN_Length (1 Octet)
+				Encryption Size (1 Octet)
+				Enc. Diversifier (2 Octets)
+				Random Number (8 Octets)
+				Value (16 Octets)
+			}
-- 
1.7.7

