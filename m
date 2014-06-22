Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add management support for controller configuration
Date: Sun, 22 Jun 2014 22:08:12 +0200
Message-Id: <1403467692-41754-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index dadee88c1807..c53854e41c27 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -216,7 +216,7 @@ Read Controller Information Command
 	If not short name is set the Short_Name parameter will be empty
 	(begin with a nul byte).
 
-	Current_Settings & Supported_Settings is a bitmask with
+	Current_Settings and Supported_Settings is a bitmask with
 	currently the following available bits:
 
 		0	Powered
@@ -233,6 +233,7 @@ Read Controller Information Command
 		11	Secure Connections
 		12	Debug Keys
 		13	Privacy
+		14	Controller Configuration
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -1813,6 +1814,121 @@ Load Connection Parameters Command
 				Not Supported
 
 
+Read Unconfigured Controller Index List Command
+===============================================
+
+	Command Code:		0x0033
+	Controller Index:	<non-controller>
+	Command Parameters:
+	Return Parameters:	Num_Controllers (2 Octets)
+				Controller_Index[i] (2 Octets)
+
+	This command returns the list of currently unconfigured controllers.
+	Unconfigured controllers added after calling this command can be
+	monitored using the Unconfigured Index Added event.
+
+	An unconfigured controller can either move to a configured state
+	indicated by the Index Added event or it can be removed which
+	would be indicated by the Index Removed event.
+
+	Only controllers that require configuration will be listed with
+	this command. A controller that is fully configured will not
+	be listed even if it supports configuration changes.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+
+Read Controller Configuration Information Command
+=================================================
+
+	Command Code:		0x0034
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Manufacturer (2 Octets)
+				Supported_Configurations (4 Octets)
+				Missing_Configurations (4 Octets)
+
+	This command is used to retreive the supported configuration
+	options of a controller and the missing configuration options.
+
+	The missing options are required to be configured before the
+	controller is considered fully configured and ready for standard
+	operation. The command is typically used right after getting the
+	response to Read Unconfigured Controller Index List command or
+	Unconfigured Index Added event.
+
+	Supported_Configurations and Missing_Configurations is a
+	bitmask with currently the following available bits:
+
+		0	Bluetooth public address configuration
+
+	It is valid to call this command on controllers that do not
+	require any configuration. It is possible that a fully configured
+	controller offers additional support for configuration.
+
+	For example a controller may contain a valid Bluetooth public
+	device address, but also allows to configure it from the host
+	stack. In this case the general support for configurations will
+	be indicated by the Controller Configuration settings. For
+	controllers where no configuration options are available that
+	setting option will not be present.
+
+	When all configurations have been completed and as a result the
+	Missing_Configurations mask would become empty, then the now
+	ready controller will be announced via Index Added event.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+
+
+Set Public Address Command
+==========================
+
+	Command Code:		0x0035
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+	Return Parameters:	Missing_Configurations (4 Octets)
+
+	This command allows configuration of public address. Since a vendor
+	specific procedure is required, this command might not be supported
+	by all controllers. Actually most likely only a handful embedded
+	controllers will offer support for this command.
+
+	When the suport for Bluetooth public address configuration is
+	indicated in the Supported Configurations mask, then this command
+	can be used to configure the public address.
+
+	It is only possible to configure the public address when the
+	controller is powered off.
+
+	For an unconfigured controller and when Missing_Configurations
+	returns an empty mask, this means that a Index Added event for
+	the now fully configured controller can be expected.
+
+	For a fully configured controller, the current controller index
+	will become invalid and an Index Removed event will be send. Once
+	the address has been successfully changed an Index Added event
+	will be send. There is no guarantee that the controller index
+	stays the same.
+
+	All previous configured parameters and settings are lost when
+	this command succeeds. The controller has to be treated as new
+	one. Use this command for a fully configured controller only when
+	you really know what you are doing.
+
+	This command generates a Command Complete event on success or a
+	Command Status event on failure.
+
+	Possible errors:	Rejected
+				Not Supported
+				Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
@@ -2444,3 +2560,19 @@ New Connection Parameter Event
 	The Min_Connection_Interval, Max_Connection_Interval,
 	Connection_Latency and Supervision_Timeout parameters are
 	encoded as described in Core 4.1 spec, Vol 2, 7.7.65.3.
+
+
+Unconfigured Index Added Event
+==============================
+
+	Event Code:		0x001b
+	Controller Index:	<controller id>
+	Event Parameters:
+
+	This event indicates that a new unconfigured controller has been
+	added to the system. It is usually followed by a Read Controller
+	Configuration Information command.
+
+	Only when a controller requires further configuration, it will
+	be announced with this event. If it supports configuration, but
+	does not require it, then an Index Added event will be used.
-- 
1.9.3

