Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19078C61D97
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 20:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjAXU0o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjAXU0c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 15:26:32 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B404FADE
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:22 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o13so16299673pjg.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tI5BOYIiJ/ZNujPsyZPCPXDEbjxHMzubZ8HJ7es34c=;
        b=b8P7JgjzKYXhlB0/PdjyNuLlMdobHWrlckDGayDVP4gyb6TnMx5xAx2TXLGeOOZtpZ
         9c7tJncKg5V1c89/1uFp1oQORz1aK0cE+OjQoG88oOhDlKv7UYbMAyGL/vBnRtkbdE/L
         NAHgOhkEFmojgKzd5tjyQnfgzry+/B4TbXV9V9vPvd+n3FrOybTkp4YKIc63HAkUO0dB
         1ZID5c84QQyDLpuLlC8HAWTIkMfMbsw8j5BUpMFv0Ir8v8yOfB0XfllLUT4E9rWfozbD
         hfEh0r2qXGwxvLO1W0HqRXho/0tgGg86YaJl5vemrlpFetY7l6jcYUU5lQj+uAElL9pw
         PRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tI5BOYIiJ/ZNujPsyZPCPXDEbjxHMzubZ8HJ7es34c=;
        b=n4Z/WtaBYImmByczXShrXi/iU7lWzvaKm8JOFYl9+bQ7WP3OFXRFDwYNRil/7Tn8XY
         74lVQ6XfMWqpg+wyCaybGc2wJHKi8u1Pnh56gJyjK/kZKuy7T5PdKB4mSTb0xeJg7wXj
         UUlZwGEjNMUBqeOuogoX804efz1dc4wxKcb+m8gFm9+x9o944gSoG5v+sP25XkIuMSBA
         e79iis+IiEmX5QtR2ETFCjBI9rw9EwNoteH6VDCa+3lMf2vNCBmZTcXjqMtNCO7EE0sz
         W0+JN7JIxOh9TeR9HPWnB2lJN3hB8sp4NABA6o1LWdNkfKDQY84SHFb/hXxDuiXWkxB5
         NVTA==
X-Gm-Message-State: AFqh2kq9wJGrzkhdj6Nri3/GVYS5e+Ez7SCblQcTeNOKbd25KHK39OAA
        m3XkS1HdGxe6U+EmwQPZl4tfIFzInfRr1w==
X-Google-Smtp-Source: AMrXdXunVXRIrL+sSgeZShIOjeMPeVER1M9p40C9RZSJi8xXGnftrrZSD2a3LzeHtGcniVpslRgwpA==
X-Received: by 2002:a17:902:d506:b0:194:8a27:f5c6 with SMTP id b6-20020a170902d50600b001948a27f5c6mr41767823plg.22.1674591981148;
        Tue, 24 Jan 2023 12:26:21 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id ju21-20020a170903429500b0019600b78487sm2108099plb.33.2023.01.24.12.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:26:20 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v4 01/13] doc/mesh: Add Remote Provisioning DBus APIs
Date:   Tue, 24 Jan 2023 12:26:04 -0800
Message-Id: <20230124202616.310544-2-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124202616.310544-1-brian.gix@gmail.com>
References: <20230124202616.310544-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

Remote Provisioning (introduced in Mesh Profile Specification v1.1)

* Allows Provisioners to use a remote server to scan for and
  provision devices.

* Allows Config managers to reprovision existing nodes to:
	* Refresh Device Keys
	* Reassign Node Addresses
	* Refresh Node Composition
---
 doc/mesh-api.txt | 140 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 6 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 85de6705e..393ae566f 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -484,7 +484,28 @@ Methods:
 			Specifies number of seconds for scanning to be active.
 			If set to 0 or if this key is not present, then the
 			scanning will continue until UnprovisionedScanCancel()
-			or AddNode() methods are called.
+			or AddNode() methods are called. If not present, and a
+			remote server is specified, the default timeout will be
+			60 seconds.
+
+		uint16 Server
+			Specifies a remote server on which to perform scanning.
+			If not present, scanning will be local. If present,
+			the timeout must be between 1 and 60 seconds.
+
+		uint16 Subnet
+			Specifies a subnet for the remote server. If not
+			present, primary subnet will be used. If Server not
+			present, the Subnet will be ignored.
+
+		array{byte}[16] Filter
+			Specifies a specific UUID to search for. If not
+			present, all found UUIDs will be returned.
+
+		uint8 array Extended
+			Specifies variable number of Bluetooth AD types to
+			return with scan result. Only valid if a Filter has been
+			specified.
 
 		Each time a unique unprovisioned beacon is heard, the
 		ScanResult() method on the app will be called with the result.
@@ -514,8 +535,48 @@ Methods:
 		of the unprovisioned device to be added to the network.
 
 		The options parameter is a dictionary that may contain
-		additional configuration info (currently an empty placeholder
-		for forward compatibility).
+		additional optional configuration info:
+
+		uint16 Server
+			Specifies a remote server to perform provisioning on. If
+			not present, provisioning will be done locally.
+
+		uint16 Subnet
+			Specifies a subnet for the remote server. If not
+			present, primary subnet will be used. If Server not
+			present Subnet will be ignored.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.NotAuthorized
+
+	void Reprovision(uint16 unicast, dict options)
+
+		This method is used by the application that supports
+		org.bluez.mesh.Provisioner1 interface to perform one of the
+		Node Provisioning Protocol Interface procedures with a remote
+		node to refresh its device key, unicast address, and
+		composition. Remote node being reprovisioned must have the
+		Remote Provisioning Server model.
+
+		The unicast parameter is the 16-bit primary node address of
+		the remote node being reprovisioned.
+
+		The options parameter is a dictionary that may contain
+		additional optional configuration info:
+
+		uint8 NPPI
+			Specifies the Node Provisioning Protocol Interface
+			behavior, as defined in the Mesh Profile Specification:
+				0 - Device Key Refresh Only
+				1 - Node Address Refresh
+				2 - Node Composition Refresh
+
+			If not present, behavior 0 will be used.
+
+		uint16 Subnet
+			Specifies the subnet remote node is on. If not
+			present, primary subnet will be tried.
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
@@ -1055,11 +1116,19 @@ Object path	freely definable
 		byte remote device UUID (always), a 16 bit mask of OOB
 		authentication flags (optional), and a 32 bit URI hash (if URI
 		bit set in OOB mask). Whether these fields exist or not is a
-		decision of the remote device.
+		decision of the unprovisioned device.
 
 		The options parameter is a dictionary that may contain
-		additional scan result info (currently an empty placeholder for
-		forward compatibility).
+		additional optional configuration info:
+
+		uint16 Server
+			Specifies the remote server that received the
+			Unprovisioned beacon. If not present, beacon was
+			received locally.
+
+		uint8 array ExtendedData
+			If Extended data was requested during scanning, any
+			received data will be returned here.
 
 		If a beacon with a UUID that has already been reported is
 		recieved by the daemon, it will be silently discarded unless it
@@ -1082,6 +1151,26 @@ Object path	freely definable
 		PossibleErrors:
 			org.bluez.mesh.Error.Abort
 
+	uint16 unicast RequestReprovData(uint16 original, uint8 count)
+
+		This method is implemented by a Provisioner capable application
+		and is called when the remote node being reprovisioned has been
+		fully authenticated and confirmed. This method will only be
+		called if the NPPI-1 procedure (Node Address Refresh) is being
+		performed.
+
+		The original parameter is the current unicast address of the
+		node being reprovisioned.
+
+		The count parameter is the number of consecutive unicast
+		addresses the remote node is requesting.
+
+		Return Parameter:
+		unicast - Primary Unicast address of the new node
+
+		PossibleErrors:
+			org.bluez.mesh.Error.Abort
+
 	void AddNodeComplete(array{byte}[16] uuid, uint16 unicast, uint8 count)
 
 		This method is called when the node provisioning initiated
@@ -1096,6 +1185,33 @@ Object path	freely definable
 		The new node may now be sent messages using the credentials
 		supplied by the RequestProvData method.
 
+	void ReprovComplete(uint16 original, uint8 nppi, uint16 unicast,
+								uint8 count)
+
+		This method is called when the node Reprovisioning initiated
+		by a Reprovision() method call successfully completed.
+
+		The original parameter is the former primary address of the
+		node that has been reprovisioned.
+
+		The nppi parameter indicates which NPPI behavior was performed.
+		If behavior 1 or 2 was performed, the node is materially
+		different than it was before reprovisioning, and Composition,
+		Bindings, Publication and Subscription settings should be
+		refreshed.
+
+		The unicast parameter is the new primary address that has been
+		assigned to the node, If NPPI behavior 1 was performed this
+		value may be different from the original. If behavior 0 or 2
+		was performed, the original and new primary address should be
+		the same.
+
+		The count parameter is the number of unicast addresses assigned
+		to the node.
+
+		The node may now be sent messages using the credentials
+		supplied by the RequestReprovData method.
+
 	void AddNodeFailed(array{byte}[16] uuid, string reason)
 
 		This method is called when the node provisioning initiated by
@@ -1109,6 +1225,18 @@ Object path	freely definable
 		"decryption-error", "unexpected-error",
 		"cannot-assign-addresses".
 
+	void ReprovFailed(uint16 unicast, string reason)
+
+		This method is called when node reprovisioning initiated by
+		Reprovision() has failed. If reprovisioning has failed, the
+		prior credentials of the remote node may still be valid.
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
-- 
2.39.1

