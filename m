Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8FEE9413F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Oct 2023 01:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjJGBCC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Oct 2023 21:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjJGBB7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Oct 2023 21:01:59 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15172D8
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Oct 2023 18:01:57 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57b5f0d658dso1520702eaf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Oct 2023 18:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696640516; x=1697245316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkfOqC4rFp3I8rUQYFc12cHuq4/iMM2zLlkaD94aPZU=;
        b=KHr+Ajsb6Rlgf5Ts6+6WbjzqHE3X9kXBdJemepocqs+63FR+vN8xApcnsIcY3xy4ru
         1v89BsyBdPKbFwLTqBD9hyXKNsopZX77xOOe1XMWNJBTYPugBbpMcjD11RE5MJuVEzro
         V0wzmNOTL/bsYwKNjMH734l/HTeBnNiblkrwqwZ9e0aPAH7d4f/q8s9qabOpHHEV2sfI
         aHn0tKf4sCFn2BVhBzAKgZI557UU31I2jbNga1jBzvzgRsLfqg4lWnx7f4EEg8MuzCaG
         oTXUKFOg6waSWVDoQtqdmjM882A5VJh13NqPUWFfKS2AjLwXEQHGM0gCODr/3Cq7Az74
         15ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696640516; x=1697245316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkfOqC4rFp3I8rUQYFc12cHuq4/iMM2zLlkaD94aPZU=;
        b=efLQtaF4dZ+vQlEnjmV8+LFSXG/jMzQGWjCvt35mE5UdNSbXblgNlbiZOVdEoJPzss
         bEv8OQudXEZOzVerMgqX72XPg6NtllEFaURAPWOqmpoGh4MwsH2VlQOkr451Y9b2h6dK
         P9QFeNF6Uf0cSFYwwWei8sO3cLy9wO1D+6WHnSOBOwIvPqG/QN8WPayBGKQUkVKjohxx
         6KbvrBJ/kQl0kKIhix5xBNt2Kt3+ejMkB9zXD1B/ab6L0u1hGf/m90L/peyBHpyjQY0F
         8tktxZ7vS/Kg6/Rkb7Sy7EoOeRbnPZ99+4pKFl6V9HBG/gAG4XymlKJl4aAjd2lTz0Jm
         qG2A==
X-Gm-Message-State: AOJu0YxoXsrFVc6MUjNKrp8ZerPaKL8+a3Iy4yA0HTgmuhEJbdSnXah8
        fYZ6oQYmtL1KbYqgblUaPSHyn4vdXv+GxA3J
X-Google-Smtp-Source: AGHT+IHS6A1ZBTRvb8elYmVjmi0vA94HgLQPt48NCFf3rjg4zx+eyC1ZZT4ZlduHVEEcJKGE+FQjHw==
X-Received: by 2002:a05:6358:9485:b0:135:46d9:12f7 with SMTP id i5-20020a056358948500b0013546d912f7mr8606186rwb.26.1696640515223;
        Fri, 06 Oct 2023 18:01:55 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id co11-20020a17090afe8b00b00279060a0fccsm4098360pjb.9.2023.10.06.18.01.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 18:01:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] doc/agent-api: Rename to org.bluez.Agent{Manager}.rst
Date:   Fri,  6 Oct 2023 18:01:45 -0700
Message-ID: <20231007010150.4103452-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231007010150.4103452-1-luiz.dentz@gmail.com>
References: <20231007010150.4103452-1-luiz.dentz@gmail.com>
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
index 9e74f4f0fc76..f355ac0c379c 100644
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
+		doc/org.bluez.DeviceSet.5 doc/org.bluez.AagentManager.5 \
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

