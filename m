Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v9 01/16] doc/mgmt-api: multi-adv implementation details
Date: Thu, 18 Jun 2015 03:17:31 +0200
Message-Id: <1434590266-26744-2-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
References: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A few additional decisions have been made while implementing the
multi-advertising feature where the mgmt api spec was leaving room for
interpretation. These changes are being documented in this patch.
---
 doc/mgmt-api.txt | 73 ++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 12 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 4b97aad..ffa774d 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -305,6 +305,15 @@ Set Powered Command
 	switching the controller off will expire this timeout and
 	disable discoverable.
 
+	Settings programmed via Set Advertising and Add/Remove
+	Advertising while the controller was powered off will be activated
+	when powering the controller on.
+
+	Switching the controller off will permanently cancel and remove
+	all advertising instances with a timeout set, i.e. time limited
+	advertising instances are not being remembered across power cycles.
+	Advertising Removed events will be issued accordingly.
+
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
 
@@ -585,6 +594,10 @@ Set Low Energy Command
 	In case the kernel subsystem does not support Low Energy or the
 	controller does not either, the command will fail regardless.
 
+	Disabling LE support will permanently disable and remove all
+	advertising instances configured with the Add Advertising
+	command. Advertising Removed events will be issued accordingly.
+
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
 
@@ -1594,6 +1607,10 @@ Set Advertising Command
 
 	Using this command will temporarily deactive any configuration
 	made by the Add Advertising command. This command takes precedence.
+	Once a Set Advertising command with value 0x00 is issued any
+	previously made configurations via Add/Remove Advertising, including
+	such changes made while Set Advertising was active, will be re-
+	enabled.
 
 	A pre-requisite is that LE is already enabled, otherwise this
 	command will return a "rejected" response.
@@ -2548,9 +2565,11 @@ Add Advertising Command
 	can be used to switch a Bluetooth Low Energy controller into
 	advertising mode.
 
-	Added advertising information with this command will be ignored
-	when using the Set Advertising command to enable advertising. The
-	usage of Set Advertising command take precedence over this command.
+	Added advertising information with this command will not be visible
+	immediately if advertising is enabled via the Set Advertising
+	command. The usage of the Set Advertising command takes precedence
+	over this command. Instance information is stored and will be
+	advertised once advertising via Set Advertising has been disabled.
 
 	The Instance identifier is a value between 1 and the number of
 	supported instances. The value 0 is reserved.
@@ -2593,13 +2612,16 @@ Add Advertising Command
 	broadcaster role.
 
 	The Duration parameter configures the length of an Instance. The
-	value is in seconds and a value of 0 indicates an automatic choice
-	for the Duration. If only one advertising Instance has been added,
-	then the Duration value will be ignored. It only applies for the
-	case where multiple Instances are configured. In that case every
-	Instance will be available for the Duration time and after that
-	it switches to the next one. This is a simple round-robin based
-	approach.
+	value is in seconds.
+
+	A value of 0 indicates a default value is chosen for the
+	Duration. The default is 2 seconds.
+
+	If only one advertising Instance has been added, then the Duration
+	value will be ignored. It only applies for the case where multiple
+	Instances are configured. In that case every Instance will be
+	available for the Duration time and after that it switches to
+	the next one. This is a simple round-robin based approach.
 
 	The Timeout parameter configures the life-time of an Instance. In
 	case the value 0 is used it indicates no expiration time. If a
@@ -2611,8 +2633,24 @@ Add Advertising Command
 
 	When a Timeout is provided, then the Duration substracts from
 	the actual Timeout value of that Instance. For example an Instance
-	with Timeout of 6 and Duration of 2 will be scheduled exactly 3
-	times. Other Instances have no influence on the Timeout.
+	with Timeout of 5 and Duration of 2 will be scheduled exactly 3
+	times, twice with 2 seconds and once with one second. Other
+	Instances have no influence on the Timeout.
+
+	Re-adding an already existing instance (i.e. issuing the Add
+	Advertising command with an Instance identifier of an existing
+	instance) will update that instance's configuration.
+
+	An instance being added or changed while another instance is
+	being advertised will not be visible immediately but only when
+	the new/changed instance is being scheduled by the round robin
+	advertising algorithm.
+
+	Changes to an instance that is currently being advertised will
+	cancel that instance and switch to the next instance. The changes
+	will be visible the next time the instance is scheduled for
+	advertising. In case a single instance is active, this means
+	that changes will be visible right away.
 
 	A pre-requisite is that LE is already enabled, otherwise this
 	command will return a "rejected" response.
@@ -2645,6 +2683,17 @@ Remove Advertising Command
 	When the Instance parameter is zero, then all previously added
 	advertising Instances will be removed.
 
+	Removing advertising information with this command will not be
+	visible as long as advertising is enabled via the Set Advertising
+	command. The usage of the Set Advertising command takes precedence
+	over this command. Changes to Instance information are stored and
+	will be advertised once advertising via Set Advertising has been
+	disabled.
+
+	Removing an instance while it is being advertised will immediately
+	cancel the instance, even when it has been advertised less then its
+	configured Timeout or Duration.
+
 	This command can be used when the controller is not powered and
 	all settings will be programmed once powered.
 
-- 
1.9.1

