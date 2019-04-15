Return-Path: <SRS0=fr0v=SR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF9FC10F0E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Apr 2019 19:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3E220854
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Apr 2019 19:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfDOTuK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:50:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:35078 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728610AbfDOTuJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Apr 2019 15:50:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 12:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="140919388"
Received: from bgix-dell-lap.sea.intel.com ([10.254.112.76])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2019 12:50:05 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, marcel@holtmann.org, brian.gix@intel.com,
        johan.hedberg@gmail.com, michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ v5 1/1] mesh: Add APIs for Provisioner and Config Client
Date:   Mon, 15 Apr 2019 12:49:46 -0700
Message-Id: <20190415194946.13121-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190415194946.13121-1-brian.gix@intel.com>
References: <20190415194946.13121-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The added D-Bus APIs enable Applications to function in a Provisioner
Initiator role, and as a Configuration Client.
---
 doc/mesh-api.txt | 451 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 437 insertions(+), 14 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 0b341a0f9..f034bc900 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -30,6 +30,7 @@ Methods:
 			org.bluez.mesh.Error.InvalidArguments
 
 	void Cancel(void)
+
 		Cancels an outstanding provisioning request initiated by Join()
 		method.
 
@@ -109,6 +110,58 @@ Methods:
 		PossibleErrors:
 			org.bluez.mesh.Error.NotFound
 
+	uint64 token CreateNetwork(object app_root, array{byte}[16] uuid)
+
+		This is the first method that an application calls to become
+		a Provisioner node, and a Configuration Client on a newly
+		created Mesh Network.
+
+		The app_root parameter is a D-Bus object root path of the
+		application that implements org.bluez.mesh.Application1
+		interface, and a org.bluez.mesh.Provisioner1 interface. The
+		application represents a node where child mesh elements have
+		their own objects that implement org.bluez.mesh.Element1
+		interface. The application hierarchy also contains a provision
+		agent object that implements org.bluez.mesh.ProvisionAgent1
+		interface. The standard DBus.ObjectManager interface must be
+		available on the app_root path.
+
+		The uuid parameter is a 16-byte array that contains Device UUID.
+
+		The returned token must be preserved by the application in
+		order to authenticate itself to the mesh daemon and attach to
+		the network as a mesh node by calling Attach() method or
+		permanently remove the identity of the mesh node by calling
+		Leave() method.
+
+		The other information the bluetooth-meshd daemon will preserve
+		about the initial node, is to give it the initial primary
+		unicast address (0x0001), and create and assign a net_key as the
+		primary network net_index (0x000).
+
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
+
+	 uint64 token ImportLocalNode(string config_file)
+
+		This method creates a local mesh node based on node
+		configuration that has been generated outside bluetooth-meshd.
+
+		The config_file parameter is a full path to the node
+		configuration file. The node configuration file is in JSON
+		format and complies to the schema defined in "Mesh Node
+		Configuration Schema" section.
+
+		The returned token must be preserved by the application in
+		order to authenticate itself to the mesh daemon and attach to
+		the network as a mesh node by calling Attach() method or
+		permanently remove the identity of the mesh node by calling
+		Leave() method.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments,
+			org.bluez.mesh.Error.NotFound,
+			org.bluez.mesh.Error.Failed
 
 Mesh Node Hierarchy
 ===================
@@ -146,6 +199,88 @@ Methods:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.NotFound
 
+	void SendWithDeviceKey(object element_path, uint16 destination,
+					uint16 net_index, array{byte} data)
+
+		This method is used to send a message originated by a local
+		model encoded with the device key of the remote node.
+
+		The element_path parameter is the object path of an element from
+		a collection of the application elements (see Mesh Application
+		Hierarchy section).
+
+		The destination parameter contains the destination address. This
+		destination must be a uint16 to a unicast address, or a well
+		known group address.
+
+		The net_index parameter is the subnet index of the network on
+		which the message is to be sent.
+
+		The data parameter is an outgoing message to be encypted by the
+		meshd daemon and sent on.
+
+		Possible errors:
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.NotFound
+
+	void AddNetKey(object element_path, uint16 destination,
+			uint16 subnet_index, uint16 net_index, boolean update)
+
+		This method is used to send add or update network key originated
+		by the local configuration client to a remote configuration
+		server.
+
+		The element_path parameter is the object path of an element from
+		a collection of the application elements (see Mesh Application
+		Hierarchy section).
+
+		The destination parameter contains the destination address. This
+		destination must be a uint16 to a nodes primary unicast address.
+
+		The subnet_index parameter refers to the subnet index of the
+		network that is being added or updated. This key must exist in
+		the local key database.
+
+		The net_index parameter is the subnet index of the network on
+		which the message is to be sent.
+
+		The update parameter indicates if this is an addition or an
+		update. If true, the subnet key must be in the phase 1 state of
+		the key update procedure.
+
+		Possible errors:
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.NotFound
+
+	void AddAppKey(object element_path, uint16 destination,
+			uint16 app_index, uint16 net_index, boolean update)
+
+		This method is used to send add or update network key originated
+		by the local configuration client to a remote configuration
+		server.
+
+		The element_path parameter is the object path of an element from
+		a collection of the application elements (see Mesh Application
+		Hierarchy section).
+
+		The destination parameter contains the destination address. This
+		destination must be a uint16 to a nodes primary unicast address.
+
+		The app_index parameter refers to the application key which is
+		being added or updated. This key must exist in the local key
+		database.
+
+		The net_index parameter is the subnet index of the network on
+		which the message is to be sent.
+
+		The update parameter indicates if this is an addition or an
+		update. If true, the subnet key must be in the phase 1 state of
+		the key update procedure.
+
+		Possible errors:
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.NotFound
+
 	void Publish(object element_path, uint16 model, array{byte} data)
 
 		This method is used to send a publication originated by a local
@@ -193,6 +328,201 @@ Methods:
 			org.bluez.mesh.Error.DoesNotExist
 			org.bluez.mesh.Error.InvalidArguments
 
+Mesh Provisioning Hierarchy
+============================
+Service		org.bluez.mesh
+Interface	org.bluez.mesh.Management1
+Object path	/org/bluez/mesh/node<xxxx>
+		where xxxx is a 4-digit hexadecimal number generated by daemon
+
+Methods:
+	void UnprovisionedScan(uint16 seconds)
+
+		This method is used by the application that supports
+		org.bluez.mesh.Provisioner1 interface to start listening
+		(scanning) for unprovisioned devices in the area. Scanning
+		will continue for the specified number of seconds, or, if 0 is
+		specified, then continuously until UnprovisionedScanCancel() is
+		called or if AddNode() method is called.
+
+		Each time a unique unprovisioned beacon is heard, the
+		ScanResult() method on the app will be called with the result.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.NotAuthorized
+
+	void UnprovisionedScanCancel(void)
+
+		This method is used by the application that supports
+		org.bluez.mesh.Provisioner1 interface to stop listening
+		(scanning) for unprovisioned devices in the area.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.NotAuthorized
+
+	void AddNode(array{byte}[16] uuid)
+
+		This method is used by the application that supports
+		org.bluez.mesh.Provisioner1 interface to add the
+		unprovisioned device specified by uuid, to the Network.
+
+		The uuid parameter is a 16-byte array that contains Device UUID
+		of the unprovisioned device to be added to the network.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.NotAuthorized
+
+	void CreateSubnet(uint16 net_index)
+
+		This method is used by the application to generate and add a new
+		network subnet key.
+
+		The net_index parameter is a 12-bit value (0x001-0xFFF)
+		specifying which net key to add.
+
+		This call affects the local bluetooth-meshd key database only.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.AlreadyExists
+
+	void UpdateSubnet(uint16 net_index)
+
+		This method is used by the application to generate a new network
+		subnet key, and set it's key refresh state to Phase 1.
+
+		The net_index parameter is a 12-bit value (0x000-0xFFF)
+		specifying which net key to update. Note that the subnet must
+		exist prior to updating.
+
+		This call affects the local bluetooth-meshd key database only.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.DoesNotExist
+
+	void DeleteSubnet(uint16 net_index)
+
+		This method is used by the application that to delete a subnet.
+
+		The net_index parameter is a 12-bit value (0x001-0xFFF)
+		specifying which net key to delete. The primary net key (0x000)
+		may not be deleted.
+
+		This call affects the local bluetooth-meshd key database only.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.DoesNotExist
+
+	void SetKeyPhase(uint16 net_index, uint8 phase)
+		This method is used to set the master key update phase of the
+		given subnet.
+
+		The net_index parameter is a 12-bit value (0x000-0xFFF)
+		specifying which subnet phase to set.
+
+		The phase parameter is used to cycle the local key database
+		through the phases as defined by the Mesh Profile Specification.
+		Allowed values:
+			0 - Cancel Key Refresh (May only be called from Phase 1,
+				and should never be called once the new key has
+				started propagating)
+			1 - Invalid Argument (see NetKeyUpdate method)
+			2 - Go to Phase 2 (May only be called from Phase 1)
+			3 - Complete Key Refresh procedure (May only be called
+				from Phase 2)
+
+		This call affects the local bluetooth-meshd key database only.
+		It is the responsibility of the application to maintain the key
+		refresh phases per the Mesh Profile Specification.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.DoesNotExist
+
+	void CreateAppKey(uint16 net_index, uint16 app_index)
+
+		This method is used by the application to generate and add a new
+		application key.
+
+		The net_index parameter is a 12-bit value (0x000-0xFFF)
+		specifying which net key to bind the application key to.
+
+		The app_index parameter is a 12-bit value (0x000-0xFFF)
+		specifying which app key to add.
+
+		This call affects the local bluetooth-meshd key database only.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.AlreadyExists
+
+	void UpdateAppKey(uint16 app_index)
+
+		This method is used by the application to generate a new
+		application key.
+
+		The app_index parameter is a 12-bit value (0x000-0xFFF)
+		specifying which app key to update. Note that the subnet that
+		the key is bound to must exist and be in Phase 1.
+
+		This call affects the local bluetooth-meshd key database only.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.DoesNotExist
+
+	void DeleteAppKey(uint16 app_index)
+
+		This method is used by the application to delete an application
+		key.
+
+		The app_index parameter is a 12-bit value (0x000-0xFFF)
+		specifying which app key to delete.
+
+		This call affects the local bluetooth-meshd key database only.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.DoesNotExist
+
+	void ImportRemoteNode(uint16 primary, uint8 count,
+					array{byte}[16] device_key)
+
+		This method is used by the application to import a remote node
+		that has been provisioned by an external process.
+
+		The primary parameter specifies the unicast address of the
+		the node being imported.
+
+		The count parameter specifies the number of elements that are
+		assigned to this remote node.
+
+		The device_key parameter is the access layer key that will be
+		will used to decrypt privledged messages from this remote node.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
+
+	void DeleteRemoteNode(uint16 primary, uint8 count)
+
+		This method is used by the application to delete a remote node
+		from the local device key database.
+
+		The primary parameter specifies the unicast address of the
+		the node being deleted.
+
+		The count parameter specifies the number of elements that were
+		assigned to the remote node.
+
+		This call affects the local bluetooth-meshd key database only.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.DoesNotExist
+
 Properties:
 	dict Features [read-only]
 
@@ -224,13 +554,24 @@ Properties:
 		This property indicates whether the periodic beaconing is
 		enabled (true) or disabled (false).
 
+	uint8 BeaconFlags [read-only]
+
+		This property may be read at any time to determine the flag
+		field setting on sent and received beacons of the primary
+		network key.
+
+	uint32 IvIndex [read-only]
+
+		This property may be read at any time to determine the IV_Index
+		that the current network is on. This information is only useful
+		for provisioning.
+
 	uint32 SecondsSinceLastHeard [read-only]
 
 		This property may be read at any time to determine the number of
 		seconds since mesh network layer traffic was last detected on
 		this node's network.
 
-
 Mesh Application Hierarchy
 ==========================
 Service		unique name
@@ -247,6 +588,7 @@ An example mesh application hierarchy may look like this:
 			|   - org.freedesktop.DBus.ObjectManager
 			|   - org.bluez.mesh.Application1
 			|   - org.bluez.mesh.Attention1 (optional)
+			|   - org.bluez.mesh.Provisioner1 (optional,Provisioner)
 			|
 			-> /com/example/agent
 			| |   - org.bluez.mesh.ProvisionAgent1
@@ -325,6 +667,22 @@ Methods:
 
 		The data parameter is the incoming message.
 
+	void DevKeyMessageReceived(uint16 source, uint16 net_index,
+							array{byte} data)
+
+		This method is called by meshd daemon when a message arrives
+		addressed to the application, which was sent with the remote
+		node's device key.
+
+		The source parameter is unicast address of the remote
+		node-element that sent the message.
+
+		The net_index parameter indicates what subnet the message was
+		received on, and if a response is required, the same subnet
+		must be used to send the response.
+
+		The data parameter is the incoming message.
+
 	void UpdateModelConfiguration(uint16 model_id, dict config)
 
 		This method is called by bluetooth-meshd daemon when a model's
@@ -383,7 +741,7 @@ Object path	freely definable
 This is an optional interface that implements health attention timer.
 
 Methods:
-	void SetTimer(uint8 element_index,  uint16 time)
+	void SetTimer(uint8 element_index, uint16 time)
 
 		The element_index parameter is the element's index within the
 		node where the health server model is hosted.
@@ -406,6 +764,76 @@ Methods:
 			org.bluez.mesh.Error.NotSupported
 
 
+Mesh Provisioner Hierarchy
+============================
+Service		unique name
+Interface	org.bluez.mesh.Provisioner1
+Object path	freely definable
+
+	ScanResult(int8 rssi, array{byte} data)
+
+		The method is called from the bluetooth-meshd daemon when a
+		unique UUID has been seen during UnprovisionedScan() for
+		unprovsioned devices.
+
+		The rssi parameter is a signed, normalized measurement of the
+		signal strength of the recieved unprovisioned beacon.
+
+		The data parameter is a variable length byte array, that may
+		have 1, 2 or 3 distinct fields contained in it including the 16
+		byte remote device UUID (always), a 32 bit mask of OOB
+		authentication flags (optional), and a 32 bit URI hash (if URI
+		bit set in OOB mask). Whether these fields exist or not is a
+		decision of the remote device.
+
+		If a beacon with a UUID that has already been reported is
+		recieved by the daemon, it will be silently discarded unless it
+		was recieved at a higher rssi power level.
+
+
+	uint16 net_index, uint8 flags, uint32 iv_index, uint16 unicast
+							RequestProvData()
+
+		This method is implemented by a Provisioner capable application
+		and is called when the remote device has been fully
+		authenticated and confirmed.
+
+		Return Parameters are from the Mesh Profile Spec:
+		net_index - Subnet index of the net_key
+		flags - Flags for IV_Update and Key Refresh
+		iv_index - Current IvIndex being used on the network
+		unicast - Primary Unicast address of the new node
+
+		PossibleErrors:
+			org.bluez.mesh.Error.Abort
+
+	void AddNodeComplete(array{byte}[16] uuid, uint16 unicast, uint8 count)
+
+		This method is called when the node provisioning initiated
+		by an AddNode() method call successfully completed.
+
+		The unicast parameter is the primary address that has been
+		assigned to the new node, and the address of it's config server.
+
+		The count parameter is the number of unicast addresses assigned
+		to the new node.
+
+		The new node may now be sent messages using the credentials
+		supplied by the RequestProvData method.
+
+	void AddNodeFailed(array{byte}[16] uuid, string reason)
+
+		This method is called when the node provisioning initiated by
+		AddNode() has failed. Depending on how far Provisioning
+		proceeded before failing, some cleanup of cached data may be
+		required.
+
+		The reason parameter identifies the reason for provisioning
+		failure. The defined values are: "aborted", "timeout",
+		"bad-pdu", "confirmation-failed", "out-of-resources",
+		"decryption-error", "unexpected-error",
+		"cannot-assign-addresses".
+
 Provisioning Agent Hierarchy
 ============================
 Service		unique name
@@ -441,6 +869,7 @@ Methods:
 		the local role is Provisioner.
 
 	void DisplayString(string value)
+
 		This method is called when the Daemon has something important
 		for the Agent to Display, but does not require any additional
 		input locally. For instance: "Enter "ABCDE" on remote device".
@@ -451,9 +880,8 @@ Methods:
 		for the Agent to Display, but does not require any additional
 		input locally. For instance: "Enter 14939264 on remote device".
 
-		The type parameter indicates the display method.  Allowed values
+		The type parameter indicates the display method. Allowed values
 		are:
-
 			"blink" - Locally blink LED
 			"beep" - Locally make a noise
 			"vibrate" - Locally vibrate
@@ -466,12 +894,11 @@ Methods:
 
 	uint32 PromptNumeric(string type)
 
-		This method is called when the Daemon has requires the user to
-		enter a 1-99999999 digit decimal value.
+		This method is called when the Daemon requests the user to
+		enter a decimal value between 1-99999999.
 
 		The type parameter indicates the input method. Allowed values
 		are:
-
 			"blink" - Enter times remote LED blinked
 			"beep" - Enter times remote device beeped
 			"vibrate" - Enter times remote device vibrated
@@ -483,14 +910,13 @@ Methods:
 		This agent should prompt the user for specific input. For
 		instance: "Enter value being displayed by remote device".
 
-	array{byte} PromptStatic(string type)
+	array{byte}[16] PromptStatic(string type)
 
 		This method is called when the Daemon requires a 16 octet byte
 		array, as an Out-of-Band authentication.
 
 		The type parameter indicates the input method. Allowed values
 		are:
-
 			"static-oob" - return 16 octet array
 			"in-alpha" - return 16 octet alpha array
 
@@ -511,7 +937,6 @@ Properties:
 	array{string} Capabilities [read-only]
 
 		An array of strings with the following allowed values:
-
 			"blink"
 			"beep"
 			"vibrate"
@@ -528,7 +953,6 @@ Properties:
 
 		Indicates availability of OOB data. An array of strings with the
 		following allowed values:
-
 			"other"
 			"uri"
 			"machine-code-2d"
@@ -547,7 +971,6 @@ Properties:
 		Uniform Resource Identifier points to out-of-band (OOB)
 		information (e.g., a public key)
 
-
-Mesh Provisioner Hierarchy
-==========================
+Mesh Node Configuration Schema
+==============================
 <TBD>
-- 
2.14.5

