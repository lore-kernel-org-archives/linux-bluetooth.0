Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5B2E95A8D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 23:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379075AbjJIXaE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379129AbjJIX37 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 19:29:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB29DE
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 16:29:56 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso3880822b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 16:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696894195; x=1697498995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBUIXIG+BJH55FBylamGiHVWsy/rkPIgFVY7SqMzynU=;
        b=XdSmYqP4RFgFcbHx0pDs1FAKR5egOZL2QjY4YxbnKQdXuR1MfbhYkh/YU6wKE0IECs
         XKMg/zpHjtHRgaPKEIwgFnTllD1vUxizi6eBik6Cvfe3o1e2zAbGj5f+dJNQWdLVVbl2
         w7YnlFrAApNEICz3yN5YN+s0qMrioxKvZoF8cEiqzTNoZ8ijKzYvMYnysLKROJ6xMJV8
         SLsjes/j0LWYp+mcMYEm/x1sxLQuEUOXVGL3TRWo7ej8GN8v3yIP/giUk/EMgCjJCZer
         ughujcpey4ymimLRzrIuvPGvA4eK7lYmaPiP8hMwxcXkqMc4FkcLRXgv6u1Mr/5Cy1LQ
         EFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696894195; x=1697498995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBUIXIG+BJH55FBylamGiHVWsy/rkPIgFVY7SqMzynU=;
        b=a5pgvIbRGK8DmGPa3SgjNPXySA/fj1zQj/jSPpzLwrupBO2KybgWF+Uw2CjfcMThtp
         o9a2LvS6N6iYNNL04Y5gzue7P07fU1cuPjQUDY6pcU23cJaNV4knPh0MGSpK6WsDn5ko
         tPHbzFk2i1VX+8Pj16MermweFhF6gioOcO9DciHqk5kiTQMA2SfZdngimw/ev4uzoJZc
         kZTG9UtrZpCI22/w+wJSkgT48CUXQi5/qGc3c3PQsifiZIrmw9ipXYGRfMI2ANKwQqvO
         w2v08+XWAkHiufsctnjWpfNXA9sMGCtX4mgnYu50mTkBCzKG6VSlDxNwpiIGYiaIDZVT
         IuFw==
X-Gm-Message-State: AOJu0Yz2JNZ4a44NWphGeHywGCN/3/RrT5CteymOk4yLK/1Mj0J63b76
        S/gHVtQ8X7uOw/sQ8Mk+y8HGhubCgKT2HaB5
X-Google-Smtp-Source: AGHT+IEf2u6xpkbNeVPlrVh9jRBokOH8OeYhcTopvz0F6b4GoXk6GlFWzVoJEdhtH/LzDZAaDRBAHA==
X-Received: by 2002:a05:6a20:ce90:b0:15e:a8:6bb4 with SMTP id if16-20020a056a20ce9000b0015e00a86bb4mr13596164pzb.8.1696894195258;
        Mon, 09 Oct 2023 16:29:55 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902989400b001c5b8087fe5sm10182711plp.94.2023.10.09.16.29.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:29:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 11/11] doc/admin-policy-api: Rename to org.bluez.AdminPolicy*.rst
Date:   Mon,  9 Oct 2023 16:29:33 -0700
Message-ID: <20231009232933.500652-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009232933.500652-1-luiz.dentz@gmail.com>
References: <20231009232933.500652-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames admin-policy-api.txt to org.bluez.AdminPolicy*.rst and
generate manpages org.bluez.AdminPolicy*.5.
---
 Makefile.am                         | 12 ++++--
 doc/admin-policy-api.txt            | 65 -----------------------------
 doc/org.bluez.AdminPolicySet.rst    | 52 +++++++++++++++++++++++
 doc/org.bluez.AdminPolicyStatus.rst | 49 ++++++++++++++++++++++
 4 files changed, 110 insertions(+), 68 deletions(-)
 delete mode 100644 doc/admin-policy-api.txt
 create mode 100644 doc/org.bluez.AdminPolicySet.rst
 create mode 100644 doc/org.bluez.AdminPolicyStatus.rst

diff --git a/Makefile.am b/Makefile.am
index ae44937a50e1..53dd12615560 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -363,7 +363,9 @@ man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.Profile.5 doc/org.bluez.NetworkServer.5 \
 		doc/org.bluez.Network.5 doc/org.bluez.Input.5 \
 		doc/org.bluez.BatteryProviderManager.5 \
-		doc/org.bluez.BatteryProvider.5 doc/org.bluez.Battery.5
+		doc/org.bluez.BatteryProvider.5 doc/org.bluez.Battery.5 \
+		doc/org.bluez.AdminPolicySet.5 \
+		doc/org.bluez.AdminPolicyStatus.5
 man_MANS += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
@@ -384,7 +386,9 @@ manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.Profile.5 doc/org.bluez.NetworkServer.5 \
 		doc/org.bluez.Network.5 doc/org.bluez.Input.5\
 		doc/org.bluez.BatteryProviderManager.5 \
-		doc/org.bluez.BatteryProvider.5 doc/org.bluez.Battery.5
+		doc/org.bluez.BatteryProvider.5 doc/org.bluez.Battery.5 \
+		doc/org.bluez.AdminPolicySet.5 \
+		doc/org.bluez.AdminPolicyStatus.5
 manual_pages += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
@@ -442,7 +446,9 @@ EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
 		doc/org.bluez.Profile.rst doc/org.bluez.NetworkServer.rst \
 		doc/org.bluez.Network.rst doc/org.bluez.Input.rst \
 		doc/org.bluez.BatteryProviderManager.rst \
-		doc/org.bluez.BatteryProvider.rst doc/org.bluez.Battery.rst
+		doc/org.bluez.BatteryProvider.rst doc/org.bluez.Battery.rst \
+		doc/org.bluez.AdminPolicySet.rst \
+		doc/org.bluez.AdminPolicyStatus.rst
 
 EXTRA_DIST += doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
 		doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.rst \
diff --git a/doc/admin-policy-api.txt b/doc/admin-policy-api.txt
deleted file mode 100644
index 3f116901dbd7..000000000000
--- a/doc/admin-policy-api.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-BlueZ D-Bus Admin Policy API description
-***********************************
-
-This API provides methods to control the behavior of bluez as an administrator.
-
-Interface AdminPolicySet1 provides methods to set policies. Once the policy is
-set successfully, it will affect all clients and stay persistently even after
-restarting Bluetooth Daemon. The only way to clear it is to overwrite the
-policy with the same method.
-
-Interface AdminPolicyStatus1 provides readonly properties to indicate the
-current values of admin policy.
-
-
-Admin Policy Set hierarchy
-=================
-
-Service		org.bluez
-Interface	org.bluez.AdminPolicySet1
-Object path	[variable prefix]/{hci0,hci1,...}
-
-Methods		void SetServiceAllowList(array{string} UUIDs)
-
-			This method sets the service allowlist by specifying
-			service UUIDs.
-
-			When SetServiceAllowList is called, bluez will block
-			incoming and outgoing connections to the service not in
-			UUIDs for all of the clients.
-
-			Any subsequent calls to this method will supersede any
-			previously set allowlist values.  Calling this method
-			with an empty array will allow any service UUIDs to be
-			used.
-
-			The default value is an empty array.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.Failed
-
-
-Admin Policy Status hierarchy
-=================
-
-Service		org.bluez
-Interface	org.bluez.AdminPolicyStatus1
-Object path	[variable prefix]/{hci0,hci1,...}
-
-Properties	array{string} ServiceAllowList [readonly]
-
-			Current value of service allow list.
-
-
-
-Admin Policy Status hierarchy
-=================
-
-Service		org.bluez
-Interface	org.bluez.AdminPolicyStatus1
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-Properties	bool IsAffectedByPolicy [readonly]
-
-			Indicate if there is any auto-connect profile in this
-			device is not allowed by admin policy.
diff --git a/doc/org.bluez.AdminPolicySet.rst b/doc/org.bluez.AdminPolicySet.rst
new file mode 100644
index 000000000000..7ce4efcfed99
--- /dev/null
+++ b/doc/org.bluez.AdminPolicySet.rst
@@ -0,0 +1,52 @@
+========================
+org.bluez.AdminPolicySet
+========================
+
+--------------------------------------------
+BlueZ D-Bus AdminPolicySet API documentation
+--------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Description
+============
+
+This API provides methods to control the behavior of **bluetoothd(8)** as an
+administrator.
+
+Interface AdminPolicySet1 provides methods to set policies. Once the policy is
+set successfully, it will affect all clients and stay persistently even after
+restarting **bluetoothd(8)**. The only way to clear it is to overwrite the
+policy with the same method.
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.AdminPolicySet1 [experimental]
+:Object path:	[variable prefix]/{hci0,hci1,...}
+
+Methods
+-------
+
+void SetServiceAllowList(array{string} UUIDs)
+`````````````````````````````````````````````
+
+	Sets the service allowlist by specifying service UUIDs.
+
+	When called, **bluetoothd(8)** will block incoming and outgoing
+	connections to the service not in UUIDs for all of the clients.
+
+	Any subsequent calls to this method will supersede any previously set
+	allowlist values.  Calling this method with an empty array will allow
+	any service UUIDs to be used.
+
+	The default value is an empty array.
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.Failed:
diff --git a/doc/org.bluez.AdminPolicyStatus.rst b/doc/org.bluez.AdminPolicyStatus.rst
new file mode 100644
index 000000000000..ad2dc58dec0a
--- /dev/null
+++ b/doc/org.bluez.AdminPolicyStatus.rst
@@ -0,0 +1,49 @@
+===========================
+org.bluez.AdminPolicyStatus
+===========================
+
+-----------------------------------------------
+BlueZ D-Bus AdminPolicyStatus API documentation
+-----------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Description
+===========
+
+Interface AdminPolicyStatus1 provides readonly properties to indicate the
+current values of admin policy affecting the Adapter and Device objects.
+
+Interface
+=========
+
+Adapter
+-------
+
+:Service:	org.bluez
+:Interface:	org.bluez.AdminPolicyStatus1 [experimental]
+:Object path:	[variable prefix]/{hci0,hci1,...}
+
+Device
+------
+
+:Service:	org.bluez
+:Interface:	org.bluez.AdminPolicyStatus1 [experimental]
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Properties
+----------
+
+array{string} ServiceAllowList [readonly, adapter-only]
+```````````````````````````````````````````````````````
+
+	Current value of service allow list.
+
+bool IsAffectedByPolicy [readonly, device-only]
+```````````````````````````````````````````````
+
+	Indicate if there is any auto-connect profile in this device is not
+	allowed by admin policy.
-- 
2.41.0

