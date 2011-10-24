Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 BlueZ] Add new command and event for LTK storage support
Date: Mon, 24 Oct 2011 15:33:32 +0200
Message-Id: <1319463212-13307-1-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1319459187-11092-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1319459187-11092-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This documents the new command and event that are to be added to
the Management API to add support for persistent pairing of LE
devices.
---

Changes:
 - New command code, because new commands were added;
 - Removed the Debug Keys parameter;


 doc/mgmt-api.txt |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 57771b4..9e158a1 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -382,6 +382,23 @@ Name Information Command
 	expected for each Device Found event with the Confirm Name
 	flag set.

+Load Long Term Keys Command
+===========================
+
+	Command Code:		0x0023
+	Controller Index:	<controller id>
+	Command Parameters:	Key Count (2 Octets)
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

@@ -638,3 +655,18 @@ Device Unblocked Event
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

