Return-Path: <SRS0=McSj=ON=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E8EC04EB8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Dec 2018 22:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594AE2081C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Dec 2018 22:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594AE2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbeLDWEF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:04:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:61216 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeLDWEF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Dec 2018 17:04:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 14:04:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="116053940"
Received: from bgix-dell-lap.sea.intel.com ([10.251.155.14])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2018 14:04:04 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org
Subject: [PATCH BlueZ] doc: Update mesh Agent API
Date:   Tue,  4 Dec 2018 14:04:01 -0800
Message-Id: <20181204220401.10440-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

Change enumerated values to strings in method parameters, and
corrected formatting for 80 character terminals.
---
 doc/mesh-api.txt | 634 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 338 insertions(+), 296 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 38c0fd384..e1bc3ee02 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -1,3 +1,4 @@
+xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
 BlueZ D-Bus Mesh API description
 ********************************
 
@@ -8,104 +9,106 @@ Interface	org.bluez.mesh.Network1
 Object path	/org/bluez/mesh
 
 Methods:
-		void Join(object app_defined_root, array{byte}[16] uuid)
+	void Join(object app_defined_root, array{byte}[16] uuid)
 
-			This is the first method that an application has to call to become
-			a provisioned node on a mesh network. The call will initiate
-			broadcasting of Unprovisioned Device Beacon.
+		This is the first method that an application has to call to
+		become a provisioned node on a mesh network.  The call will
+		initiate broadcasting of Unprovisioned Device Beacon.
 
-			The app_defined_root parameter is a D-Bus object root path of the
-			application that implements org.bluez.mesh.Application1 interface.
-			The application represents a node where child mesh elements have
-			their own objects that implement org.bluez.mesh.Element1 interface.
-			The application hierarchy also contains a provision agent object
-			that implements org.bluez.mesh.ProvisionAgent1 interface.
-			The standard DBus.ObjectManager interface must be available on the
-			app_defined_root path.
+		The app_defined_root parameter is a D-Bus object root path of
+		the application that implements org.bluez.mesh.Application1
+		interface. The application represents a node where child mesh
+		elements have their own objects that implement
+		org.bluez.mesh.Element1 interface.  The application hierarchy
+		also contains a provision agent object that implements
+		org.bluez.mesh.ProvisionAgent1 interface.  The standard
+		DBus.ObjectManager interface must be available on the
+		app_defined_root path.
 
-			The uuid parameter is a 16-byte array that contains Device UUID.
+		The uuid parameter is a 16-byte array that contains Device UUID.
 
-			PossibleErrors:
-				org.bluez.mesh.Error.InvalidArguments
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
 
-		void Cancel(void)
-			Cancels an outstanding provisioning request initiated by Join()
-			method.
+	void Cancel(void)
+		Cancels an outstanding provisioning request initiated by Join()
+		method.
 
-		(object node, array{byte, array{(uint16, dict}} configuration)
+	(object node, array{byte, array{(uint16, dict}} configuration)
 				Attach(object app_defined_root, uint64 token)
 
-			This is the first method that an application must call to get access
-			to mesh node functionalities.
+		This is the first method that an application must call to get
+		access to mesh node functionalities.
 
-			The app_defined_root parameter is a D-Bus object root path of the
-			application that implements org.bluez.mesh.Application1 interface.
-			The application represents a node where child mesh elements have
-			their own objects that implement org.bluez.mesh.Element1 interface.
-			The standard DBus.ObjectManager interface must be available on the
-			app_defined_root path.
+		The app_defined_root parameter is a D-Bus object root path of
+		the application that implements org.bluez.mesh.Application1
+		interface. The application represents a node where child mesh
+		elements have their own objects that implement
+		org.bluez.mesh.Element1 interface. The standard
+		DBus.ObjectManager interface must be available on the
+		app_defined_root path.
 
-			The token parameter is a 64-bit number that has been assigned to the
-			application when it first got provisioned/joined mesh network, i.e.
-			upon receiving JoinComplete() method. The daemon uses the token to
-			verify whether the application is authorized to assume the mesh
-			node identity.
+		The token parameter is a 64-bit number that has been assigned to
+		the application when it first got provisioned/joined mesh
+		network, i.e. upon receiving JoinComplete() method. The daemon
+		uses the token to verify whether the application is authorized
+		to assume the mesh node identity.
 
-			In case of success, the method call returns mesh node object (see
-			Mesh Node Hierarchy section) and current configuration settings.
-			The return value of configuration parameter is an array, where each
-			entry is a structure that contains element configuration.
-			The element configuration structure is organized as follows:
+		In case of success, the method call returns mesh node object
+		(see Mesh Node Hierarchy section) and current configuration
+		settings. The return value of configuration parameter is an
+		array, where each entry is a structure that contains element
+		configuration.  The element configuration structure is organized
+		as follows:
 
-				byte
+		byte
 
-					Element index, identifies the element to which this
-					configuration entry pertians.
+			Element index, identifies the element to which this
+			configuration entry pertians.
 
-				array{struct}
+		array{struct}
 
-					Models array where each entry is a structure with the
-					following members:
+			Models array where each entry is a structure with the
+			following members:
 
-						uint16
+			uint16
 
-							Either a SIG Model Identifier or, if Vendor key is
-							present in model configuration dictionary, a 16-bit
-							vendor-assigned Model Identifier
+				Either a SIG Model Identifier or, if Vendor key
+				is present in model configuration dictionary, a
+				16-bit vendor-assigned Model Identifier
 
-						dict
+			dict
 
-							A dictionary that contains model configuration with
-							the following keys defined:
+				A dictionary that contains model configuration
+				with the following keys defined:
 
-								array{uint16} Bindings
+				array{uint16} Bindings
 
-									Indices of application keys bound to
-									the model
+					Indices of application keys bound to the
+					model
 
-								uint32 PublicationPeriod
+				uint32 PublicationPeriod
 
-									Model publication period in milliseconds
+					Model publication period in milliseconds
 
-								uint16 Vendor
+				uint16 Vendor
 
-									A 16-bit Bluetooth-assigned Company
-									Identifier of the vendor as defined by
-									Bluetooth SIG
+					A 16-bit Company ID as defined by the
+					Bluetooth SIG
 
-			PossibleErrors:
-				org.bluez.mesh.Error.InvalidArguments
-				org.bluez.mesh.Error.NotFound,
-				org.bluez.mesh.Error.Failed
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.NotFound,
+			org.bluez.mesh.Error.Failed
 
-		void Leave(uint64 token)
+	void Leave(uint64 token)
 
-			This removes the configuration information about the mesh node
-			identified by the 64-bit token parameter. The token parameter
-			has been obtained as a result of successful Join() method call.
+		This removes the configuration information about the mesh node
+		identified by the 64-bit token parameter. The token parameter
+		has been obtained as a result of successful Join() method call.
 
-			PossibleErrors:
-				org.bluez.mesh.Error.NotFound
+		PossibleErrors:
+			org.bluez.mesh.Error.NotFound
 
 
 Mesh Node Hierarchy
@@ -113,122 +116,126 @@ Mesh Node Hierarchy
 Service		org.bluez.mesh
 Interface	org.bluez.mesh.Node1
 Object path	/org/bluez/mesh/node<xxxx>
-		where xxxx is a 4-digit hexadecimal number generated by meshd daemon
+		where xxxx is a 4-digit hexadecimal number generated by daemon
 
 Methods:
-		void Send(object element_path, uint16 destination, uint16 key_index,
-								array{byte} data)
+	void Send(object element_path, uint16 destination, uint16 key_index,
+							array{byte} data)
 
-			This method is used to send a message originated by a local model.
+		This method is used to send a message originated by a local
+		model.
 
-			The element_path parameter is the object path of an element from
-			a collection of the application elements (see Mesh Application
-			Hierarchy section).
+		The element_path parameter is the object path of an element from
+		a collection of the application elements (see Mesh Application
+		Hierarchy section).
 
-			The destination parameter contains the destination address. This
-			destination must be a uint16 to a unicast address, or a well known
-			group address.
+		The destination parameter contains the destination address. This
+		destination must be a uint16 to a unicast address, or a well
+		known group address.
 
-			The key_index parameter determines which application key to use for
-			encrypting the message. The key_index must be valid for that
-			element, i.e., the application key must be bound to a model on this
-			element. Otherwise, org.bluez.mesh.Error.NotAuthorized will be
-			returned.
+		The key_index parameter determines which application key to use
+		for encrypting the message. The key_index must be valid for that
+		element, i.e., the application key must be bound to a model on
+		this element. Otherwise, org.bluez.mesh.Error.NotAuthorized will
+		be returned.
 
-			The data parameter is an outgoing message to be encypted by the
-			meshd daemon and sent on.
+		The data parameter is an outgoing message to be encypted by the
+		meshd daemon and sent on.
 
-			Possible errors:
-				org.bluez.mesh.Error.NotAuthorized
-				org.bluez.mesh.Error.InvalidArguments
-				org.bluez.mesh.Error.NotFound
+		Possible errors:
+			org.bluez.mesh.Error.NotAuthorized
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.NotFound
 
-		void Publish(object element_path, uint16 model, array{byte} data)
+	void Publish(object element_path, uint16 model, array{byte} data)
 
-			This method is used to send a publication originated by a local
-			model. If the model does not exist, or it has no publication record,
-			the method returns org.bluez.mesh.Error.DoesNotExist error.
+		This method is used to send a publication originated by a local
+		model. If the model does not exist, or it has no publication
+		record, the method returns org.bluez.mesh.Error.DoesNotExist
+		error.
 
-			The element_path parameter is the object path of an element from
-			a collection of the application elements (see Mesh Application
-			Hierarchy section).
+		The element_path parameter is the object path of an element from
+		a collection of the application elements (see Mesh Application
+		Hierarchy section).
 
-			The model parameter contains a model ID, as defined by the
-			Bluetooth SIG.
+		The model parameter contains a model ID, as defined by the
+		Bluetooth SIG.
 
-			Since only one Publish record may exist per element-model, the
-			destination and key_index are obtained from the Publication
-			record cached by the daemon.
+		Since only one Publish record may exist per element-model, the
+		destination and key_index are obtained from the Publication
+		record cached by the daemon.
 
-			Possible errors:
-				org.bluez.mesh.Error.DoesNotExist
-				org.bluez.mesh.Error.InvalidArguments
+		Possible errors:
+			org.bluez.mesh.Error.DoesNotExist
+			org.bluez.mesh.Error.InvalidArguments
 
-		void VendorPublish(object element_path, uint16 vendor, uint16 model_id,
-								array{byte} data)
+	void VendorPublish(object element_path, uint16 vendor, uint16 model_id,
+							array{byte} data)
 
-			This method is used to send a publication originated by a local
-			vendor model. If the model does not exist, or it has no publication
-			record, the method returns org.bluez.mesh.Error.DoesNotExist error.
+		This method is used to send a publication originated by a local
+		vendor model. If the model does not exist, or it has no
+		publication record, the method returns
+		org.bluez.mesh.Error.DoesNotExist error.
 
-			The element_path parameter is the object path of an element from
-			a collection of the application elements (see Mesh Application
-			Hierarchy section).
+		The element_path parameter is the object path of an element from
+		a collection of the application elements (see Mesh Application
+		Hierarchy section).
 
-			The vendor parameter is a 16-bit Bluetooth-assigned Company
-			Identifier.
+		The vendor parameter is a 16-bit Bluetooth-assigned Company ID.
 
-			The model_id parameter is a 16-bit vendor-assigned Model Identifier.
+		The model_id parameter is a 16-bit vendor-assigned Model
+		Identifier.
 
-			Since only one Publish record may exist per element-model, the
-			destination and key_index are obtained from the Publication
-			record cached by the daemon.
+		Since only one Publish record may exist per element-model, the
+		destination and key_index are obtained from the Publication
+		record cached by the daemon.
 
-			Possible errors:
-				org.bluez.mesh.Error.DoesNotExist
-				org.bluez.mesh.Error.InvalidArguments
+		Possible errors:
+			org.bluez.mesh.Error.DoesNotExist
+			org.bluez.mesh.Error.InvalidArguments
 
 Properties:
-		dict Features [read-only]
+	dict Features [read-only]
 
-			The dictionary that contains information about feature support.
-			The following keys are defined:
+		The dictionary that contains information about feature support.
+		The following keys are defined:
 
-				boolean Friend
+		boolean Friend
 
-					Indicates the ability to establish a friendship with a
-					Low Power node
+			Indicates the ability to establish a friendship with a
+			Low Power node
 
-				boolean LowPower
+		boolean LowPower
 
-					Indicates support for operating in Low Power node mode
+			Indicates support for operating in Low Power node mode
 
-				boolean Proxy
+		boolean Proxy
 
-					Indicates support for GATT proxy
+			Indicates support for GATT proxy
 
-				boolean Relay - indicates support for relaying messages
+		boolean Relay
+			Indicates support for relaying messages
 
-			If the key is absent from the dictionary, the feature is not
-			supported. Otherwise, true means that the feature is enabled and
-			false means that the feature is disabled.
+	If a key is absent from the dictionary, the feature is not supported.
+	Otherwise, true means that the feature is enabled and false means that
+	the feature is disabled.
 
-		boolean Beacon [read-only]
+	boolean Beacon [read-only]
 
-			This property indicates whether the periodic beaconing is enabled
-			(true) or disabled (false).
+		This property indicates whether the periodic beaconing is
+		enabled (true) or disabled (false).
 
-		uint32 SecondsSinceLastHeard [read-only]
+	uint32 SecondsSinceLastHeard [read-only]
 
-			This property may be read at any time to determine the number of
-			seconds since mesh network layer traffic was last detected on this
-			node's network.
+		This property may be read at any time to determine the number of
+		seconds since mesh network layer traffic was last detected on
+		this node's network.
 
 
 Mesh Application Hierarchy
 ==========================
 Service		unique name
-Interface		org.bluez.mesh.Application1
+Interface	org.bluez.mesh.Application1
 Object path	<app_defined_root>
 
 An application is a collection of elements that host SIG defined and vendor
@@ -254,40 +261,41 @@ An example mesh application hierarchy may look like this:
 			| |   - org.bluez.mesh.Element1
 
 Methods:
-		void JoinComplete(uint64 token)
+	void JoinComplete(uint64 token)
 
-			This method is called when the node provisioning initiated
-			by a Join() method call successfully completed.
+		This method is called when the node provisioning initiated
+		by a Join() method call successfully completed.
 
-			The token parameter serves as a unique identifier of the particular
-			node. The token must be preserved by the application in order to
-			authenticate itself to the mesh daemon and attach to the network
-			as a mesh node by calling Attach() method or permanently remove the
-			identity of the mesh node by calling Leave() method.
+		The token parameter serves as a unique identifier of the
+		particular node. The token must be preserved by the application
+		in order to authenticate itself to the mesh daemon and attach to
+		the network as a mesh node by calling Attach() method or
+		permanently remove the identity of the mesh node by calling
+		Leave() method.
 
-		void JoinFailed(string reason)
+	void JoinFailed(string reason)
 
-			This method is called when the node provisioning initiated
-			by Join() has failed.
+		This method is called when the node provisioning initiated by
+		Join() has failed.
 
-			The reason parameter identifies the reason for provisioning failure.
-			The defined values are: "timeout", "bad-pdu", "confirmation-failed",
-			"out-of-resources", "decryption-error", "unexpected-error",
-			"cannot-assign-addresses".
+		The reason parameter identifies the reason for provisioning
+		failure. The defined values are: "timeout", "bad-pdu",
+		"confirmation-failed", "out-of-resources", "decryption-error",
+		"unexpected-error", "cannot-assign-addresses".
 
 Properties:
-		uint16 CompanyID [read-only]
+	uint16 CompanyID [read-only]
 
-			A 16-bit Bluetooth-assigned Company Identifier of the vendor as
-			defined by Bluetooth SIG
+		A 16-bit Bluetooth-assigned Company Identifier of the vendor as
+		defined by Bluetooth SIG
 
-		uint16 ProductID [read-only]
+	uint16 ProductID [read-only]
 
-			A 16-bit vendor-assigned product identifier
+		A 16-bit vendor-assigned product identifier
 
-		uint16 VersionID [read-only]
+	uint16 VersionID [read-only]
 
-			A 16-bit vendor-assigned product version identifier
+		A 16-bit vendor-assigned product version identifier
 
 
 Mesh Element Hierarchy
@@ -297,77 +305,74 @@ Interface	org.bluez.mesh.Element1
 Object path	<app_defined_element_path>
 
 Methods:
-		void MessageReceived(uint16 source, uint16 key_index,
-								boolean subscription, array{byte} data)
+	void MessageReceived(uint16 source, uint16 key_index,
+					boolean subscription, array{byte} data)
 
-			This method is called by meshd daemon when a message arrives
-			addressed to the application.
+		This method is called by meshd daemon when a message arrives
+		addressed to the application.
 
-			The source parameter is unicast address of the remote node-element
-			that sent the message.
+		The source parameter is unicast address of the remote
+		node-element that sent the message.
 
-			The key_index parameter indicates which application key has been
-			used to decode the incoming message. The same key_index should be
-			used by the application when sending a response to this message
-			(in case a response is expected).
+		The key_index parameter indicates which application key has been
+		used to decode the incoming message. The same key_index should
+		be used by the application when sending a response to this
+		message (in case a response is expected).
 
-			The subscription parameter is a boolean that is set to true if
-			the message is received as a part of the subscription (i.e., the
-			destination is either a well known group address or a virtual
-			label.
+		The subscription parameter is a boolean that is set to true if
+		the message is received as a part of the subscription (i.e., the
+		destination is either a well known group address or a virtual
+		label.
 
-			The data parameter is the incoming message.
+		The data parameter is the incoming message.
 
-		void UpdateModelConfiguration(uint16 model_id, dict config)
+	void UpdateModelConfiguration(uint16 model_id, dict config)
 
-			This method is called by meshd daemon when a model's configuration
-			is updated.
+		This method is called by meshd daemon when a model's
+		configuration is updated.
 
-			The model_id parameter contains BT SIG Model Identifier or, if
-			Vendor key is present in config dictionary, a 16-bit
-			vendor-assigned Model Identifier.
+		The model_id parameter contains BT SIG Model Identifier or, if
+		Vendor key is present in config dictionary, a 16-bit
+		vendor-assigned Model Identifier.
 
-			The config parameter is a dictionary with the following keys
-			defined:
+		The config parameter is a dictionary with the following keys
+		defined:
 
-				array{uint16} Bindings
+		array{uint16} Bindings
 
-					Indices of application keys bound to the model
+			Indices of application keys bound to the model
 
-				uint32 PublicationPeriod
+		uint32 PublicationPeriod
 
-					Model publication period in milliseconds
+			Model publication period in milliseconds
 
-				uint16 Vendor
+		uint16 Vendor
 
-					A 16-bit Bluetooth-assigned Company Identifier of the
-					vendor as defined by Bluetooth SIG
+			A 16-bit Bluetooth-assigned Company Identifier of the
+			vendor as defined by Bluetooth SIG
 
 Properties:
-			uint8 Index [read-only]
-
-				Element index. It is required that the application follows
-				sequential numbering scheme for the elements, starting with 0.
+	uint8 Index [read-only]
 
-			array{uint16} Models [read-only]
+		Element index. It is required that the application follows
+		sequential numbering scheme for the elements, starting with 0.
 
-				An array of SIG Model Identifiers. The array may be empty.
+	array{uint16} Models [read-only]
 
-			array{(uint16, uint16)} VendorModels [read-only]
+		An array of SIG Model Identifiers. The array may be empty.
 
-				An array of pairs (vendor, model ID):
+	array{(uint16, uint16)} VendorModels [read-only]
 
-					vendor is a 16-bit Bluetooth-assigned Company Identifier
-					of the vendor as defined by Bluetooth SIG
+		An array of pairs (vendor, model ID): vendor is a 16-bit
+		Bluetooth-assigned Company ID as defined by Bluetooth SIG.
+		model ID is a 16-bit vendor-assigned Model Identifier
 
-					model ID is a 16-bit vendor-assigned Model Identifier
+		The array may be empty.
 
-				The array may be empty.
+	uint16 Location [read-only, optional]
 
-			uint16 Location [read-only, optional]
-
-				Location descriptor as defined in the GATT Bluetooth Namespace
-				Descriptors section of the Bluetooth SIG Assigned Numbers
+		Location descriptor as defined in the GATT Bluetooth Namespace
+		Descriptors section of the Bluetooth SIG Assigned Numbers
 
 
 Mesh Attention Hierarchy
@@ -379,27 +384,27 @@ Object path	freely definable
 This is an optional interface that implements health attention timer.
 
 Methods:
-		void SetTimer(uint8 element_index,  uint16 time)
+	void SetTimer(uint8 element_index,  uint16 time)
 
-			The element_index parameter is the element's index within the node
-			where the health server model is hosted.
+		The element_index parameter is the element's index within the
+		node where the health server model is hosted.
 
-			The time parameter indicates how many seconds the attention state
-			shall be on.
+		The time parameter indicates how many seconds the attention
+		state shall be on.
 
-			PossibleErrors:
-				org.bluez.mesh.Error.NotSupported
+		PossibleErrors:
+			org.bluez.mesh.Error.NotSupported
 
-		uint16 GetTimer(uint16 element)
+	uint16 GetTimer(uint16 element)
 
-			The element parameter is the unicast address within the node
-			where the health server model is hosted.
+		The element parameter is the unicast address within the node
+		where the health server model is hosted.
 
-			Returns the number of seconds for how long the attention action
-			remains staying on.
+		Returns the number of seconds for how long the attention action
+		remains staying on.
 
-			PossibleErrors:
-				org.bluez.mesh.Error.NotSupported
+		PossibleErrors:
+			org.bluez.mesh.Error.NotSupported
 
 
 Provisioning Agent Hierarchy
@@ -409,102 +414,139 @@ Interface	org.bluez.mesh.ProvisionAgent1
 Object path	freely definable
 
 Methods:
-		array{byte} PrivateKey()
+	array{byte} PrivateKey()
 
-			This method is called during provisioning if the Provisioner
-			has requested Out-Of-Band ECC key exchange. The Private key
-			is returned to the Daemon, and the Public Key is delivered to
-			the remote Provisioner using a method that does not involve
-			the Bluetooth Mesh system. The Private Key returned must be
-			32 octets in size, or the Provisioning procedure will fail
-			and be canceled.
+		This method is called during provisioning if the Provisioner
+		has requested Out-Of-Band ECC key exchange. The Private key is
+		returned to the Daemon, and the Public Key is delivered to the
+		remote Provisioner using a method that does not involve the
+		Bluetooth Mesh system. The Private Key returned must be 32
+		octets in size, or the Provisioning procedure will fail and be
+		canceled.
 
-			This function will only be called if the Provisioner has
-			requested pre-determined keys to be exchanged Out-of-Band,
-			and the local role is Unprovisioned device.
+		This function will only be called if the Provisioner has
+		requested pre-determined keys to be exchanged Out-of-Band, and
+		the local role is Unprovisioned device.
 
-		array{byte} PublicKey()
+	array{byte} PublicKey()
 
-			This method is called during provisioning if the local device
-			is the Provisioner, and is requestng Out-Of-Band ECC key
-			exchange. The Public key is returned to the Daemon
-			that is the matched pair of the Private key of the remote
-			device. The Public Key returned must be 64 octets in
-			size, or the Provisioning procedure will fail and be canceled.
+		This method is called during provisioning if the local device is
+		the Provisioner, and is requestng Out-Of-Band ECC key exchange.
+		The Public key is returned to the Daemon that is the matched
+		pair of the Private key of the remote device. The Public Key
+		returned must be 64 octets in size, or the Provisioning
+		procedure will fail and be canceled.
 
-			This function will only be called if the Provisioner has
-			requested pre-determined keys to be exchanged Out-of-Band,
-			and the local role is Provisioner.
+		This function will only be called if the Provisioner has
+		requested pre-determined keys to be exchanged Out-of-Band, and
+		the local role is Provisioner.
 
-		void DisplayString(string display)
-			This method is called when the Daemon has something important
-			for the Agent to Display, but does not require any additional
-			input locally. For instance: "Enter "ABCDE" on remote device".
+	void DisplayString(string value)
+		This method is called when the Daemon has something important
+		for the Agent to Display, but does not require any additional
+		input locally. For instance: "Enter "ABCDE" on remote device".
 
-		void DisplayNumeric(uint8 type, uint32 number)
+	void DisplayNumeric(string type, uint32 number)
 
-			This method is called when the Daemon has something important
-			for the Agent to Display, but does not require any additional
-			input locally. For instance: "Enter 149264 on remote device".
+		This method is called when the Daemon has something important
+		for the Agent to Display, but does not require any additional
+		input locally. For instance: "Enter 14939264 on remote device".
 
-			The type parameter indicates the display method. An enumeration
-			of "Blink", "Beep", "Vibrate", or "OutNumeric".
+		The type parameter indicates the display method.  Allowed values
+		are:
 
-			The number parameter is the specific value represented by
-			the Prompt.
+			"blink" - Locally blink LED
+			"beep" - Locally make a noise
+			"vibrate" - Locally vibrate
+			"out-numeric" - Display value to enter remotely
+			"push" - Request pushes on remote button
+			"twist" - Request twists on remote knob
 
-		uint32 PromptNumeric(uint8 type)
+		The number parameter is the specific value represented by the
+		Prompt.
 
-			This method is called when the Daemon has requires the user to
-			enter a 1-9 digit decimal value.
+	uint32 PromptNumeric(string type)
 
-			The type parameter indicates the input method. An enumeration
-			of "Push", "Twist", or "InNumeric".
+		This method is called when the Daemon has requires the user to
+		enter a 1-99999999 digit decimal value.
 
-			This agent should prompt the user for specific input. For instance:
-			"Enter value being displayed by remote device".
+		The type parameter indicates the input method. Allowed values
+		are:
 
-		array{byte} PromptStatic(uint8 type)
+			"blink" - Enter times remote LED blinked
+			"beep" - Enter times remote device beeped
+			"vibrate" - Enter times remote device vibrated
+			"in-numeric" - Enter remotely displayed value
+			"push" - Push local button remotely requested times
+			"twist" - Twist local knob remotely requested times
 
-			This method is called when the Daemon requires a 16 octet
-			byte array, as an Out-of-Band authentication.
 
-			The type parameter indicates the input method. An enumeration
-			of "Static", or "InAlpha".
+		This agent should prompt the user for specific input. For
+		instance: "Enter value being displayed by remote device".
 
-			The Static data returned must be 16 octets in size, or the
-			Provisioning procedure will fail and be canceled. If input is
-			an InAlpha String, the printable charactors should be left
-			justified, with trailing 0x00 octets filling the remaining bytes.
+	array{byte} PromptStatic(string type)
 
-		void Cancel()
+		This method is called when the Daemon requires a 16 octet byte
+		array, as an Out-of-Band authentication.
 
-			This method gets called by the daemon to cancel any existing
-			Agent Requests. When called, any pending user input should be
-			canceled.
+		The type parameter indicates the input method. Allowed values
+		are:
 
+			"static-oob" - return 16 octet array
+			"in-alpha" - return 16 octet alpha array
 
-Properties:
-			array{string} Capabilities [read-only]
+		The Static data returned must be 16 octets in size, or the
+		Provisioning procedure will fail and be canceled. If input type
+		is "in-alpha", the printable characters should be
+		left-justified, with trailing 0x00 octets filling the remaining
+		bytes.
 
-				An array of strings with the following allowed values:
-					"blink", "beep", "vibrate", "out-numeric", "out-alpha",
-					"push", "twist", "in-numeric", "in-alpha", "public-oob",
-					"static-oob".
+	void Cancel()
 
+		This method gets called by the daemon to cancel any existing
+		Agent Requests. When called, any pending user input should be
+		canceled, and any display requests removed.
 
-			array{string} OutOfBandInfo [read-only, optional]
 
-				Indicates availability of OOB data.
-				An array of strings with the following allowed values:
-					"other", "uri", "machine-code-2d", "bar-code", "nfc",
-					"number", "string", "on-box", "in-box", "on-paper",
-					"in-manual", "on-device"
-
-			string URI [read-only, optional]
-
-				Uniform Resource Identifier points to out-of-band (OOB)
-				information (e.g., a public key)
+Properties:
+	array{string} Capabilities [read-only]
+
+		An array of strings with the following allowed values:
+
+			"blink"
+			"beep"
+			"vibrate"
+			"out-numeric"
+			"out-alpha"
+			"push"
+			"twist"
+			"in-numeric"
+			"in-alpha"
+			"static-oob"
+			"public-oob"
+
+	array{string} OutOfBandInfo [read-only, optional]
+
+		Indicates availability of OOB data. An array of strings with the
+		following allowed values:
+
+			"other"
+			"uri"
+			"machine-code-2d"
+			"bar-code"
+			"nfc"
+			"number"
+			"string"
+			"on-box"
+			"in-box"
+			"on-paper",
+			"in-manual"
+			"on-device"
+
+	string URI [read-only, optional]
+
+		Uniform Resource Identifier points to out-of-band (OOB)
+		information (e.g., a public key)
 
 
 Mesh Provisioner Hierarchy
-- 
2.14.5

