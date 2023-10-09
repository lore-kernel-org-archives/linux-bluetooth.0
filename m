Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F6AE95A8D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 23:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378202AbjJIX3p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjJIX3o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 19:29:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D619D
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 16:29:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c888b3a25aso30029025ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 16:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696894180; x=1697498980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3unjQojlbVvLNK7E7W62JL7SG6twcnQHkRwrrK4+Zo=;
        b=CpcR1BkxVzElEmXQ35ZfNpGxNZF1PTApVFdgWM3GdiuKguz+59y/hVb11MnUqn+s0H
         5qFCUhL06toJ7MWr16XZvPWxPm1JDl5+leIwfyQU74tGBx4KEB4K5DP7rDkpJMvql1BS
         GaVwL7PPMhvXJeXBNtSMSAVb8O01+B8azUdsQL59BtdMOt37f9X6jbx5lB825TeGYEfG
         oAz3n2goCUDfuNUT1V0rns3yTaiJy4BLqjovUmqovNX81AdtbjSPsC8KLkPzKLEK/zhn
         q1ZeIlAunnI66lL30osiE4gTV13sGwfJsLkbkaZDUnGpNJYjxsfedn1P+aXK1PLi7CvU
         Fe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696894180; x=1697498980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3unjQojlbVvLNK7E7W62JL7SG6twcnQHkRwrrK4+Zo=;
        b=S4apKyEozxv3xi9QZqzNxu1HJ5AO3Qv7Vsxmx9+IVKX4q0ER+a2bZ9eAeDt8rHkAaP
         qQLLnLjOWw2ctqdpQc3WLt2JcdIwhxBzWyEFyubZh2u2M6BjEP3BMGb3RO2GULGjQv0j
         a2be+BK9CC16WRAED+Yl0qdr07YbNL5BrmpXsXeO028e96i5YAfuAyWLzLwMGoq8k9bO
         KWN3lvLYFgl/uHa+MDgcOikJUiEemZNpBKOOkKhNz/ajJJHTjyXnhybd2UGm2yadx42W
         hu97MrYPYaLpEYk+r+p9E/742vmU0jQuOQ7It9u8i0+/aUWFLlhAJaPa5YN0r3RkDoYm
         57rA==
X-Gm-Message-State: AOJu0Yzr05cnAl0kQPSjiFGKJ3y8iFcoIzk+qfirlSF9lS9fr53C//nK
        RZiwG6SBjZjL93hPYOpdf5zIsMSYO0YjTlUt
X-Google-Smtp-Source: AGHT+IEwBoMCigec7Te6fGge/ZnPvb5Wl435ILOeXtyYNTavDi8GDZZHXW//6wb03/+AY7iNZGAmNQ==
X-Received: by 2002:a17:903:1c6:b0:1bf:7d3b:4405 with SMTP id e6-20020a17090301c600b001bf7d3b4405mr18438515plh.14.1696894180338;
        Mon, 09 Oct 2023 16:29:40 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902989400b001c5b8087fe5sm10182711plp.94.2023.10.09.16.29.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:29:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/11] doc/agent-api: Rename to org.bluez.Agent{Manager}.rst
Date:   Mon,  9 Oct 2023 16:29:25 -0700
Message-ID: <20231009232933.500652-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009232933.500652-1-luiz.dentz@gmail.com>
References: <20231009232933.500652-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames agent-api.txt to org.bluez.Agent{Manager}.rst and generate
manpages org.bluez.Agent{Manager}.5.
---
 Makefile.am                    |  11 +-
 doc/agent-api.txt              | 185 ---------------------------------
 doc/org.bluez.Agent.rst        | 149 ++++++++++++++++++++++++++
 doc/org.bluez.AgentManager.rst |  83 +++++++++++++++
 4 files changed, 239 insertions(+), 189 deletions(-)
 delete mode 100644 doc/agent-api.txt
 create mode 100644 doc/org.bluez.Agent.rst
 create mode 100644 doc/org.bluez.AgentManager.rst

diff --git a/Makefile.am b/Makefile.am
index 9e74f4f0fc76..b25bc521cab3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -358,7 +358,8 @@ CLEANFILES += $(builtin_files) src/bluetooth.service
 if MANPAGES
 man_MANS += src/bluetoothd.8
 man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
-	    doc/org.bluez.DeviceSet.5
+		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
+		doc/org.bluez.Agent.5
 man_MANS += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
@@ -366,7 +367,8 @@ man_MANS += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 endif
 manual_pages += src/bluetoothd.8
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
-		doc/org.bluez.DeviceSet.5
+		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
+		doc/org.bluez.Agent.5
 manual_pages += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
@@ -407,12 +409,13 @@ EXTRA_DIST += doc/assigned-numbers.txt doc/supported-features.txt \
 				doc/settings-storage.txt
 
 EXTRA_DIST += doc/mgmt-api.txt \
-		doc/agent-api.txt doc/profile-api.txt \
+		doc/profile-api.txt \
 		doc/network-api.txt doc/health-api.txt \
 		doc/sap-api.txt doc/input-api.txt
 
 EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
-	      doc/org.bluez.DeviceSet.rst
+	      doc/org.bluez.DeviceSet.rst doc/org.bluez.AgentManager.rst \
+	      doc/org.bluez.Agent.rst
 
 EXTRA_DIST += doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
 		doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.rst \
diff --git a/doc/agent-api.txt b/doc/agent-api.txt
deleted file mode 100644
index 0d9347cab390..000000000000
--- a/doc/agent-api.txt
+++ /dev/null
@@ -1,185 +0,0 @@
-BlueZ D-Bus Agent API description
-**********************************
-
-
-Agent Manager hierarchy
-=======================
-
-Service		org.bluez
-Interface	org.bluez.AgentManager1
-Object path	/org/bluez
-
-		void RegisterAgent(object agent, string capability)
-
-			This registers an agent handler.
-
-			The object path defines the path of the agent
-			that will be called when user input is needed.
-
-			Every application can register its own agent and
-			for all actions triggered by that application its
-			agent is used.
-
-			It is not required by an application to register
-			an agent. If an application does chooses to not
-			register an agent, the default agent is used. This
-			is on most cases a good idea. Only application
-			like a pairing wizard should register their own
-			agent.
-
-			An application can only register one agent. Multiple
-			agents per application is not supported.
-
-			The capability parameter can have the values
-			"DisplayOnly", "DisplayYesNo", "KeyboardOnly",
-			"NoInputNoOutput" and "KeyboardDisplay" which
-			reflects the input and output capabilities of the
-			agent.
-
-			If an empty string is used it will fallback to
-			"KeyboardDisplay".
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.AlreadyExists
-
-		void UnregisterAgent(object agent)
-
-			This unregisters the agent that has been previously
-			registered. The object path parameter must match the
-			same value that has been used on registration.
-
-			Possible errors: org.bluez.Error.DoesNotExist
-
-		void RequestDefaultAgent(object agent)
-
-			This requests is to make the application agent
-			the default agent. The application is required
-			to register an agent.
-
-			Special permission might be required to become
-			the default agent.
-
-			Possible errors: org.bluez.Error.DoesNotExist
-
-
-Agent hierarchy
-===============
-
-Service		unique name
-Interface	org.bluez.Agent1
-Object path	freely definable
-
-Methods		void Release()
-
-			This method gets called when the service daemon
-			unregisters the agent. An agent can use it to do
-			cleanup tasks. There is no need to unregister the
-			agent, because when this method gets called it has
-			already been unregistered.
-
-		string RequestPinCode(object device)
-
-			This method gets called when the service daemon
-			needs to get the passkey for an authentication.
-
-			The return value should be a string of 1-16 characters
-			length. The string can be alphanumeric.
-
-			Possible errors: org.bluez.Error.Rejected
-			                 org.bluez.Error.Canceled
-
-		void DisplayPinCode(object device, string pincode)
-
-			This method gets called when the service daemon
-			needs to display a pincode for an authentication.
-
-			An empty reply should be returned. When the pincode
-			needs no longer to be displayed, the Cancel method
-			of the agent will be called.
-
-			This is used during the pairing process of keyboards
-			that don't support Bluetooth 2.1 Secure Simple Pairing,
-			in contrast to DisplayPasskey which is used for those
-			that do.
-
-			This method will only ever be called once since
-			older keyboards do not support typing notification.
-
-			Note that the PIN will always be a 6-digit number,
-			zero-padded to 6 digits. This is for harmony with
-			the later specification.
-
-			Possible errors: org.bluez.Error.Rejected
-			                 org.bluez.Error.Canceled
-
-		uint32 RequestPasskey(object device)
-
-			This method gets called when the service daemon
-			needs to get the passkey for an authentication.
-
-			The return value should be a numeric value
-			between 0-999999.
-
-			Possible errors: org.bluez.Error.Rejected
-			                 org.bluez.Error.Canceled
-
-		void DisplayPasskey(object device, uint32 passkey,
-								uint16 entered)
-
-			This method gets called when the service daemon
-			needs to display a passkey for an authentication.
-
-			The entered parameter indicates the number of already
-			typed keys on the remote side.
-
-			An empty reply should be returned. When the passkey
-			needs no longer to be displayed, the Cancel method
-			of the agent will be called.
-
-			During the pairing process this method might be
-			called multiple times to update the entered value.
-
-			Note that the passkey will always be a 6-digit number,
-			so the display should be zero-padded at the start if
-			the value contains less than 6 digits.
-
-		void RequestConfirmation(object device, uint32 passkey)
-
-			This method gets called when the service daemon
-			needs to confirm a passkey for an authentication.
-
-			To confirm the value it should return an empty reply
-			or an error in case the passkey is invalid.
-
-			Note that the passkey will always be a 6-digit number,
-			so the display should be zero-padded at the start if
-			the value contains less than 6 digits.
-
-			Possible errors: org.bluez.Error.Rejected
-			                 org.bluez.Error.Canceled
-
-		void RequestAuthorization(object device)
-
-			This method gets called to request the user to
-			authorize an incoming pairing attempt which
-			would in other circumstances trigger the just-works
-			model, or when the user plugged in a device that
-			implements cable pairing. In the latter case, the
-			device would not be connected to the adapter via
-			Bluetooth yet.
-
-			Possible errors: org.bluez.Error.Rejected
-			                 org.bluez.Error.Canceled
-
-		void AuthorizeService(object device, string uuid)
-
-			This method gets called when the service daemon
-			needs to authorize a connection/service request.
-
-			Possible errors: org.bluez.Error.Rejected
-			                 org.bluez.Error.Canceled
-
-		void Cancel()
-
-			This method gets called to indicate that the agent
-			request failed before a reply was returned.
diff --git a/doc/org.bluez.Agent.rst b/doc/org.bluez.Agent.rst
new file mode 100644
index 000000000000..11d09b94d228
--- /dev/null
+++ b/doc/org.bluez.Agent.rst
@@ -0,0 +1,149 @@
+===============
+org.bluez.Agent
+===============
+
+-----------------------------------
+BlueZ D-Bus Agent API documentation
+-----------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	unique name
+:Interface:	org.bluez.Agent1
+:Object path:	freely definable
+
+Methods
+-------
+
+void Release()
+``````````````
+
+	This method gets called when the service daemon unregisters the agent.
+	An agent can use it to do cleanup tasks. There is no need to unregister
+	the agent, because when this method gets called it has already been
+	unregistered.
+
+string RequestPinCode(object device)
+````````````````````````````````````
+
+	This method gets called when the service daemon needs to get the passkey
+	for an authentication.
+
+	The return value should be a string of 1-16 characters length. The
+	string can be alphanumeric.
+
+	Possible errors:
+
+	:org.bluez.Error.Rejected:
+	:org.bluez.Error.Canceled:
+
+void DisplayPinCode(object device, string pincode)
+``````````````````````````````````````````````````
+
+	This method gets called when the service daemon needs to display a
+	pincode for an authentication.
+
+	An empty reply should be returned. When the pincode needs no longer to
+	be displayed, the Cancel method of the agent will be called.
+
+	This is used during the pairing process of keyboards that don't support
+	Bluetooth 2.1 Secure Simple Pairing, in contrast to DisplayPasskey which
+	is used for those that do.
+
+	This method will only ever be called once since older keyboards do not
+	support typing notification.
+
+	Note that the PIN will always be a 6-digit number, zero-padded to 6
+	digits. This is for harmony with the later specification.
+
+	Possible errors:
+
+	:org.bluez.Error.Rejected:
+	:org.bluez.Error.Canceled:
+
+uint32 RequestPasskey(object device)
+````````````````````````````````````
+
+	This method gets called when the service daemon needs to get the passkey
+	for an authentication.
+
+	The return value should be a numeric value between 0-999999.
+
+	Possible errors:
+
+	:org.bluez.Error.Rejected:
+	:org.bluez.Error.Canceled:
+
+void DisplayPasskey(object device, uint32 passkey, uint16 entered)
+``````````````````````````````````````````````````````````````````
+
+	This method gets called when the service daemon needs to display a
+	passkey for an authentication.
+
+	The entered parameter indicates the number of already typed keys on the
+	remote side.
+
+	An empty reply should be returned. When the passkey needs no longer to
+	be displayed, the Cancel method of the agent will be called.
+
+	During the pairing process this method might be called multiple times to
+	update the entered value.
+
+	Note that the passkey will always be a 6-digit number, so the display
+	should be zero-padded at the start if the value contains less than 6
+	digits.
+
+void RequestConfirmation(object device, uint32 passkey)
+```````````````````````````````````````````````````````
+
+	This method gets called when the service daemon needs to confirm a
+	passkey for an authentication.
+
+	To confirm the value it should return an empty reply or an error in case
+	the passkey is invalid.
+
+	Note that the passkey will always be a 6-digit number, so the display
+	should be zero-padded at the start if the value contains less than 6
+	digits.
+
+	Possible errors:
+
+	:org.bluez.Error.Rejected:
+	:org.bluez.Error.Canceled:
+
+void RequestAuthorization(object device)
+````````````````````````````````````````
+
+	This method gets called to request the user to authorize an incoming
+	pairing attempt which would in other circumstances trigger the
+	just-works model, or when the user plugged in a device that implements
+	cable pairing. In the latter case, the device would not be connected to
+	the adapter via Bluetooth yet.
+
+	Possible errors:
+
+	:org.bluez.Error.Rejected:
+	:org.bluez.Error.Canceled:
+
+void AuthorizeService(object device, string uuid)
+`````````````````````````````````````````````````
+
+	This method gets called when the service daemon needs to authorize a
+	connection/service request.
+
+	Possible errors:
+
+	:org.bluez.Error.Rejected:
+	:org.bluez.Error.Canceled:
+
+void Cancel()
+`````````````
+
+	This method gets called to indicate that the agent request failed before
+	a reply was returned.
diff --git a/doc/org.bluez.AgentManager.rst b/doc/org.bluez.AgentManager.rst
new file mode 100644
index 000000000000..dfc0297da8d2
--- /dev/null
+++ b/doc/org.bluez.AgentManager.rst
@@ -0,0 +1,83 @@
+======================
+org.bluez.AgentManager
+======================
+
+------------------------------------------
+BlueZ D-Bus AgentManager API documentation
+------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.AgentManager1
+:Object path:	/org/bluez
+
+Methods
+-------
+
+void RegisterAgent(object agent, string capability)
+```````````````````````````````````````````````````
+
+	Registers pairing agent.
+
+	The object path defines the path of the agent that will be called when
+	user input is needed and must implement **org.bluez.Agent(5)**
+	interface.
+
+	Every application can register its own agent and for all actions
+	triggered by that application its agent is used.
+
+	It is not required by an application to register an agent. If an
+	application does chooses to not register an agent, the default agent is
+	used. This is on most cases a good idea. Only application like a pairing
+	wizard should register their own agent.
+
+	An application can only register one agent. Multiple agents per
+	application is not supported.
+
+	Possible capability values:
+
+	:"":
+
+		Fallback to "KeyboardDisplay".
+
+	:"DisplayOnly":
+	:"DisplayYesNo":
+	:"KeyboardOnly":
+	:"NoInputNoOutput":
+	:"KeyboardDisplay":
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.AlreadyExists:
+
+void UnregisterAgent(object agent)
+``````````````````````````````````
+
+	Unregisters an agent that has been previously registered using
+	**RegisterAgent**. The object path parameter must match the same value
+	that has been used on registration.
+
+	Possible errors:
+
+	:org.bluez.Error.DoesNotExist:
+
+void RequestDefaultAgent(object agent)
+``````````````````````````````````````
+
+	Requests to make the application agent the default agent. The
+	application is required to register an agent.
+
+	Special permission might be required to become the default agent.
+
+	Possible errors:
+
+	:org.bluez.Error.DoesNotExist:
+
-- 
2.41.0

