Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B419CC46467
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 23:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjASX6P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjASX6L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Jan 2023 18:58:11 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C144BA1992
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:05 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b17so3864845pld.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dg+OLczEsFoyAkjMV+YWxfgBqPA3+Kql+jsBQri6mKE=;
        b=Kp8Okw7y5RqfjfN7KaeC9amSPxMtG63QzgdFSlNyI1E++zJRah4ZHRYu9Ym5Rb+Yvi
         JRuvYiHm/lM0xFUFtGvXl1Gc9SvC4TzKT188pd/eepz8K308Dc8ns1j/9tkOfWexlJX+
         QucTAn25lmbkMTy+oROr2deMrJ2Wvl8++ZsD2Ec1D8+PiYqOwU5d0ovtPzvtsVUlLzKg
         xpliUr2b+vFZEb5Su1ajqu/iYPej1cTj9wu+olTVqooYCrTLmktyLM2PJHSyKsgq/d/M
         s/FPUxfpTr7n6rA0aDOGOpc5a6zxWtAhZdlG0+HA/s8V8nyotF30nqgxDTOoPr1VUnpH
         vPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dg+OLczEsFoyAkjMV+YWxfgBqPA3+Kql+jsBQri6mKE=;
        b=UHLwMM9i1IoKERMJYZgwvJ71aSbdGrLub/ygQ/YCDFDPgOXjRMA+iYf8hA78MI33A1
         M3NSVi/KUL9oOb4mQ+9hS2w7zL5tOU+myfzY75dqcIR29nNeoIVjZQxskQ2IcZnKEFYO
         ipgDxgHHkQ8ycUm+V3SYXoXcLUNOlSR+s+KpXeeV0RQvnaB/NZ4NZny202fcwAzaadiw
         AKGiHQjSY3ti/qeWo0OTO22o1zc2zwwXLvXRaEQf8VzXXfJIpHb7KBF4wNxctq7AK9p4
         RWJCEprt/KArMabRlel5j0aQAOimrWCOogYXDSLPBPaInYOQFxNllQ19TUOGTqsXb9hX
         wRQw==
X-Gm-Message-State: AFqh2kodBAf0bjbYS2fYGFk/FYDy8wcZX3iqPSReBt3WgWfNoyPxo3gT
        pqD8dWuOvXyBdEDv+bvKfUwmNa6A3IknLQ==
X-Google-Smtp-Source: AMrXdXvHWNH8ssdYz+mWPexkVOxP1k2O01INRJT/bMRORR8Mh5BijgJyIP5x5leb7KgRq2rUmkznAA==
X-Received: by 2002:a17:902:e846:b0:194:df3e:51b3 with SMTP id t6-20020a170902e84600b00194df3e51b3mr1360918plg.26.1674172684374;
        Thu, 19 Jan 2023 15:58:04 -0800 (PST)
Received: from fedora.. (97-113-173-242.tukw.qwest.net. [97.113.173.242])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b0019460c34839sm14826373plc.185.2023.01.19.15.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:03 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 01/12] doc/mesh: Add Remote Provisioning DBus APIs
Date:   Thu, 19 Jan 2023 15:57:44 -0800
Message-Id: <20230119235755.46002-2-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235755.46002-1-brian.gix@gmail.com>
References: <20230119235755.46002-1-brian.gix@gmail.com>
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
2.39.0

