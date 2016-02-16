Return-Path: <maxime.chevallier@openwide.fr>
Date: Tue, 16 Feb 2016 14:09:27 +0100
From: Chevallier Maxime <maxime.chevallier@openwide.fr>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	johan.hedberg@gmail.com
Subject: [RFC][PATCH] Add Set Advertising Parameters command
Message-ID: <20160216130927.GA10374@vps217108.ovh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 731a088..4b842fd 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2596,6 +2596,7 @@ Add Advertising Command
 		4	Add TX Power field to Adv_Data
 		5	Add Appearance field to Scan_Rsp
 		6	Add Local Name in Scan_Rsp
+		7	Pending Parameters
 
 	When the connectable flag is set, then the controller will use
 	undirected connectable advertising. The value of the connectable
@@ -2623,6 +2624,12 @@ Add Advertising Command
 	supported to provide less air traffic for devices implementing
 	broadcaster role.
 
+	If the Pending Parameters flag is set, the Advertising Instance
+	will only be queued when the Set Advertising Parameters command
+	is issued, with the correct Instance identifier. If the next
+	command is not a Set Advertising Parameters commmand, the current
+	Advertising Instance is cancelled.
+
 	The Duration parameter configures the length of an Instance. The
 	value is in seconds.
 
@@ -2680,6 +2687,66 @@ Add Advertising Command
 				Invalid Index
 
 
+Set Advertising Parameters Command
+==================================
+
+	Command Code:		0x003f
+	Controller Index:	<controller id>
+	Command Parameters:	Instance (1 Octet)
+				Adv_Interval_min (2 Octets)
+				Adv_Interval_max (2 Octets)
+	Return Parameters:
+
+	This command is used to set advertising parameters for a Bluetooth
+	Low Energy controller.
+
+	This command can be used to configure global advertising parameters
+	that will be applied for advertising issued by the Set Advertising
+	command.
+
+	This command can also be used to configure single Advertising
+	Instances. In that case, the parameters applied for the Advertising
+	Instance will override global Advertising Parameters when the
+	Adversiting Instance is running.
+
+	When configuring an Advertising Instance, the Instance must have
+	been added with the flag "Pending parameters". The Advertising
+	Instance will be added to queue only when the Set Advertising
+	Parameters will be issued.
+
+	The Instance parameter designates what we want to configure.
+	If the Instance parameter is 0, the Advertising Parameters apply
+	globally, for both the advertising issued with the Set Adverting
+	and the Advertising Instances issued with Add Avertsing.
+
+	If the Instance Parameter is not 0, it will apply on the given
+	Advertising Instance, if it exists.
+
+	In the case we are setting Advertising Parameters for an
+	Advertising Instance that is currently being advertised (if we
+	set global parameters, or if the Advertising Instance was not
+	added with the "Pending Parameters" flag), the parameters will be
+	applied at the next Instance or the next Set Advertising command.
+
+	In the case the controller is not advertising, the parameters will
+	be applied the next time we enable advertising.
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
+	Possible errors:	Failed
+				Rejected
+				Not Supported
+				Invalid Parameters
+				Invalid Index
+
+
 Remove Advertising Command
 ==========================
 
-- 
2.1.4
