Return-Path: <maxime.chevallier@openwide.fr>
Date: Wed, 17 Feb 2016 10:18:26 +0100
From: Chevallier Maxime <maxime.chevallier@openwide.fr>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: [RFC][PATCH 1/1 v2] mgmt : Add Set Advertising Parameters command
Message-ID: <20160217091826.GA12061@vps217108.ovh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 731a088..d46b28c 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2801,6 +2801,57 @@ Start Limited Discovery Command
 				Invalid Index
 
 
+Set Advertising Parameters Command
+==================================
+
+	Command Code:		0x0042
+	Controller Index:	<controller id>
+	Command Parameters:	Adv_Interval_Min (2 Octets)
+					Adv_Interval_Max (2 Octets)
+	Return Parameters:
+
+	This command is used to set Advertising Parameters.
+
+	This command sets global advertising parameters that will be
+	applied on advertisings started both with the Set Advertising
+	and the Add Advertising commands.
+
+	The Adv_Interval_Min parameter and Adv_Interval_Max are
+	lower and upper bounds for the controller to issue advertising
+	packets. The exact momet the packet is actually issued is up to
+	the controller.
+
+	The Adv_Interval_Min and Adv_Interval_Max are expressed in units
+	so that : Time ( milliseconds ) = N x 0.625.
+
+	Their default value is 0x0080 (1.28s).
+
+	Both Adv_Interval_Min and Adv_Interval_Max must be within the
+	range [ 0x0020 0x4000 ] (20 ms to 10.24 s).
+
+	Adv_Interval_Min must be less or equal than Adv_Interval_Max.
+
+	If advertisement is not connectable, that is if Set Advertising
+	is set with Advertising 0x01 and we are set as not connectable,
+	then Adv_Interval_Min and Adv_Interval_Max parameters must not
+	be less than 0x00A0 (100 ms). If this is the case, these
+	parameters are restored to their default value until we are
+	connectable again.
+
+	A pre-requisite is that LE is already enabled, otherwise this
+	command will return a "rejected" response.
+
+	This command can be used when the controller is not powered and
+	all settings will be programmed once powered.
+
+	This command generates a Command Complete event on success or a
+	Command Status event on failure.
+
+	Possible errors:	Rejected
+				Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
2.1.4
