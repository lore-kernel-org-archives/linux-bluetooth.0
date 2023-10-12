Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8BECDB46E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Oct 2023 20:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442277AbjJLUWT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Oct 2023 16:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343834AbjJLUWS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Oct 2023 16:22:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5FEBB
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 13:22:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9d407bb15so12379805ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 13:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697142131; x=1697746931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iIF4Go2ki6cFwcEsjc0BxEq/1L4VsTQClpKxxtsztBk=;
        b=jJu1SJer9S308G6Z5bFEc9p+2NzpNmOfvynwWCSTB6BW6hX4wMmz9vdnJbm+DY6AD8
         Moln33dVUDpmZ3IofAEg6WwuAPQyjtUHO8yuiGnCQtrk+SiPXzVLbNMZIwKSdQCEbIGR
         r3ypCtPtx5UnfFbvNB8fOkCjVtLjrH2sssCJjNS1WT3wy6VOYYHklVqrgzthuEIzQggf
         3wKGYixGbRbnivpKm1dtsB/IhlWMELyZZqa2Ti+HhYb2p7DSgn13NAwBPOlTycd1aThM
         Aqz/6WND1Latc+3UfoDAlQxSggT2ysAUpLiZUZeAKZGIazF6pezxq/nwxGBt5JUXmecs
         FBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697142131; x=1697746931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIF4Go2ki6cFwcEsjc0BxEq/1L4VsTQClpKxxtsztBk=;
        b=wQcHBCkJsI5bKybeZQ9Q59R0og5fJTCofphnIqBPCK5dAX2TjnlkV8xqtRYrhGciph
         ExI8aOAsWLjE2a0DPqNQPzqlZKvJHsX8iCFAeQX3m/b4b04xcxFFE4MCsERlMKSqRPUP
         Mxi1G5Jd3m31874IY/Rsy+K9Yg5R5D4zNfamJp/ysI/NLPbb9fFAdH112rvkJ+/DsUR4
         ZhYnucaTB63F/A9nt88fxmdBnS5tccG01VYVcJFDeZuq5iieSMx/93pMJ/2qdnhi7o5h
         Sd7OeLYJicl2VCwgd0z+kFRK9Gi0s4u8cCu7OR0ZvJAC5ADL/WxFoSd+I5ETd2ddCP5x
         A5BA==
X-Gm-Message-State: AOJu0YxR4t/NlaHXnZtcEgpdS3HYSZ2KZLMRMxtOJnmVwfdkmyGDvZSa
        L0NORS5DWXtl5UQv7l0TOntrH62ImOFiv8bcoRI=
X-Google-Smtp-Source: AGHT+IGP/5ZfjENky3+FscDbB+HQfvDdiLQNzjHDYfOkvS0FtWrRcgQLOTxuzUQSJxPU32Iqtwo4Eg==
X-Received: by 2002:a17:902:e80e:b0:1c6:2d13:5b77 with SMTP id u14-20020a170902e80e00b001c62d135b77mr29330411plg.39.1697142130227;
        Thu, 12 Oct 2023 13:22:10 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id i16-20020a17090332d000b001c582de968dsm2387349plr.72.2023.10.12.13.22.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:22:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/obex-*-api: Rename to org.bluez.obex.*.rst
Date:   Thu, 12 Oct 2023 13:22:07 -0700
Message-ID: <20231012202207.1365107-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames obex-*-api.txt to org.bluez.obex.*.rst and generate
manpages org.bluez.obex.*.5.
---
 Makefile.am                            |  28 +-
 doc/obex-agent-api.txt                 |  62 --
 doc/obex-api.txt                       | 894 -------------------------
 doc/org.bluez.obex.Agent.rst           |  54 ++
 doc/org.bluez.obex.AgentManager.rst    |  45 ++
 doc/org.bluez.obex.Client.rst          |  69 ++
 doc/org.bluez.obex.FileTransfer.rst    | 155 +++++
 doc/org.bluez.obex.Message.rst         | 139 ++++
 doc/org.bluez.obex.MessageAccess.rst   | 201 ++++++
 doc/org.bluez.obex.ObjectPush.rst      |  84 +++
 doc/org.bluez.obex.PhonebookAccess.rst | 386 +++++++++++
 doc/org.bluez.obex.Session.rst         |  61 ++
 doc/org.bluez.obex.Synchronization.rst |  82 +++
 doc/org.bluez.obex.Transfer.rst        | 123 ++++
 14 files changed, 1426 insertions(+), 957 deletions(-)
 delete mode 100644 doc/obex-agent-api.txt
 delete mode 100644 doc/obex-api.txt
 create mode 100644 doc/org.bluez.obex.Agent.rst
 create mode 100644 doc/org.bluez.obex.AgentManager.rst
 create mode 100644 doc/org.bluez.obex.Client.rst
 create mode 100644 doc/org.bluez.obex.FileTransfer.rst
 create mode 100644 doc/org.bluez.obex.Message.rst
 create mode 100644 doc/org.bluez.obex.MessageAccess.rst
 create mode 100644 doc/org.bluez.obex.ObjectPush.rst
 create mode 100644 doc/org.bluez.obex.PhonebookAccess.rst
 create mode 100644 doc/org.bluez.obex.Session.rst
 create mode 100644 doc/org.bluez.obex.Synchronization.rst
 create mode 100644 doc/org.bluez.obex.Transfer.rst

diff --git a/Makefile.am b/Makefile.am
index 4232463a42c9..2f50131e53de 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -378,6 +378,15 @@ man_MANS += doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.5 \
 		doc/org.bluez.LEAdvertisement.5 \
 		doc/org.bluez.AdvertisementMonitorManager.5 \
 		doc/org.bluez.AdvertisementMonitor.5
+man_MANS += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
+		doc/org.bluez.obex.Transfer.5 \
+		doc/org.bluez.obex.ObjectPush.5 \
+		doc/org.bluez.obex.FileTransfer.5 \
+		doc/org.bluez.obex.Synchronization.5 \
+		doc/org.bluez.obex.PhonebookAccess.5 \
+		doc/org.bluez.obex.MessageAccess.5 \
+		doc/org.bluez.obex.Message.5 \
+		doc/org.bluez.AgentManager.5 doc/org.bluez.Agent.5
 endif
 manual_pages += src/bluetoothd.8
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
@@ -401,6 +410,15 @@ manual_pages += doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.5 \
 		doc/org.bluez.LEAdvertisement.5 \
 		doc/org.bluez.AdvertisementMonitorManager.5 \
 		doc/org.bluez.AdvertisementMonitor.5
+manual_pages += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
+		doc/org.bluez.obex.Transfer.5 \
+		doc/org.bluez.obex.ObjectPush.5 \
+		doc/org.bluez.obex.FileTransfer.5 \
+		doc/org.bluez.obex.Synchronization.5 \
+		doc/org.bluez.obex.PhonebookAccess.5 \
+		doc/org.bluez.obex.MessageAccess.5 \
+		doc/org.bluez.obex.Message.5 \
+		doc/org.bluez.AgentManager.5 doc/org.bluez.Agent.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -464,7 +482,15 @@ EXTRA_DIST += doc/org.bluez.GattManager.rst doc/org.bluez.GattProfile.rst\
 		doc/org.bluez.AdvertisementMonitorManager.rst \
 		doc/org.bluez.AdvertisementMonitor.rst
 
-EXTRA_DIST += doc/obex-api.txt doc/obex-agent-api.txt
+EXTRA_DIST += doc/org.bluez.obex.Client.rst doc/org.bluez.obex.Session.rst \
+		doc/org.bluez.obex.Transfer.rst \
+		doc/org.bluez.obex.ObjectPush.rst \
+		doc/org.bluez.obex.FileTransfer.rst \
+		doc/org.bluez.obex.Synchronization.rst \
+		doc/org.bluez.obex.PhonebookAccess.rst \
+		doc/org.bluez.obex.MessageAccess.rst \
+		doc/org.bluez.obex.Message.rst \
+		doc/org.bluez.AgentManager.rst doc/org.bluez.Agent.rst
 
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
diff --git a/doc/obex-agent-api.txt b/doc/obex-agent-api.txt
deleted file mode 100644
index 7c720927dcc5..000000000000
--- a/doc/obex-agent-api.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-OBEX D-Bus Agent API description
-********************************
-
-
-Agent Manager hierarchy
-=======================
-
-Service		org.bluez.obex
-Interface	org.bluez.obex.AgentManager1
-Object path	/org/bluez/obex
-
-Methods		void RegisterAgent(object agent)
-
-			Register an agent to request authorization of
-			the user to accept/reject objects. Object push
-			service needs to authorize each received object.
-
-			Possible errors: org.bluez.obex.Error.AlreadyExists
-
-		void UnregisterAgent(object agent)
-
-			This unregisters the agent that has been previously
-			registered. The object path parameter must match the
-			same value that has been used on registration.
-
-			Possible errors: org.bluez.obex.Error.DoesNotExist
-
-
-Agent hierarchy
-===============
-
-Service		unique name
-Interface	org.bluez.obex.Agent1
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
-		string AuthorizePush(object transfer)
-
-			This method gets called when the service daemon
-			needs to accept/reject a Bluetooth object push request.
-
-			Returns the full path (including the filename) or the
-			folder name suffixed with '/' where the object shall
-			be stored. The transfer object will contain a Filename
-			property that contains the default location and name
-			that can be returned.
-
-			Possible errors: org.bluez.obex.Error.Rejected
-			                 org.bluez.obex.Error.Canceled
-
-		void Cancel()
-
-			This method gets called to indicate that the agent
-			request failed before a reply was returned. It cancels
-			the previous request.
diff --git a/doc/obex-api.txt b/doc/obex-api.txt
deleted file mode 100644
index f39355af0ee7..000000000000
--- a/doc/obex-api.txt
+++ /dev/null
@@ -1,894 +0,0 @@
-OBEX D-Bus API description
-**************************
-
-
-Client hierarchy
-================
-
-Service		org.bluez.obex
-Interface	org.bluez.obex.Client1
-Object path	/org/bluez/obex
-
-Methods		object CreateSession(string destination, dict args)
-
-			Create a new OBEX session for the given remote address.
-
-			The last parameter is a dictionary to hold optional or
-			type-specific parameters. Typical parameters that can
-			be set in this dictionary include the following:
-
-				string "Target" : type of session to be created
-				string "Source" : local address to be used
-				byte "Channel"
-
-			The currently supported targets are the following:
-
-				"ftp"
-				"map"
-				"opp"
-				"pbap"
-				"sync"
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-		void RemoveSession(object session)
-
-			Unregister session and abort pending transfers.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.NotAuthorized
-
-Session hierarchy
-=================
-
-Service		org.bluez.obex
-Interface	org.bluez.obex.Session1
-Object path	/org/bluez/obex/server/session{0, 1, 2, ...} or
-		/org/bluez/obex/client/session{0, 1, 2, ...}
-
-Methods		string GetCapabilities()
-
-			Get remote device capabilities.
-
-			Possible errors: org.bluez.obex.Error.NotSupported
-					 org.bluez.obex.Error.Failed
-
-Properties	string Source [readonly]
-
-			Bluetooth adapter address
-
-		string Destination [readonly]
-
-			Bluetooth device address
-
-		byte Channel [readonly]
-
-			Bluetooth channel
-
-		string Target [readonly]
-
-			Target UUID
-
-		string Root [readonly]
-
-			Root path
-
-
-Transfer hierarchy
-==================
-
-Service		org.bluez.obex
-Interface	org.bluez.obex.Transfer1
-Object path	[Session object path]/transfer{0, 1, 2, ...}
-
-Methods		void Cancel()
-
-			Stops the current transference.
-
-			Possible errors: org.bluez.obex.Error.NotAuthorized
-					 org.bluez.obex.Error.InProgress
-					 org.bluez.obex.Error.Failed
-
-		void Suspend()
-
-			Suspend transference.
-
-			Possible errors: org.bluez.obex.Error.NotAuthorized
-					 org.bluez.obex.Error.NotInProgress
-
-			Note that it is not possible to suspend transfers
-			which are queued which is why NotInProgress is listed
-			as possible error.
-
-		void Resume()
-
-			Resume transference.
-
-			Possible errors: org.bluez.obex.Error.NotAuthorized
-					 org.bluez.obex.Error.NotInProgress
-
-			Note that it is not possible to resume transfers
-			which are queued which is why NotInProgress is listed
-			as possible error.
-
-Properties	string Status [readonly]
-
-			Inform the current status of the transfer.
-
-			Possible values: "queued", "active", "suspended",
-					"complete" or "error"
-
-		object Session [readonly]
-
-			The object path of the session the transfer belongs
-			to.
-
-		string Name [readonly]
-
-			Name of the transferred object. Either Name or Type
-			or both will be present.
-
-		string Type [readonly]
-
-			Type of the transferred object. Either Name or Type
-			or both will be present.
-
-		uint64 Time [readonly, optional]
-
-			Time of the transferred object if this is
-			provided by the remote party.
-
-		uint64 Size [readonly, optional]
-
-			Size of the transferred object. If the size is
-			unknown, then this property will not be present.
-
-		uint64 Transferred [readonly, optional]
-
-			Number of bytes transferred. For queued transfers, this
-			value will not be present.
-
-		string Filename [readonly, optional]
-
-			Complete name of the file being received or sent.
-
-			For incoming object push transaction, this will be
-			the proposed default location and name. It can be
-			overwritten by the AuthorizePush agent callback
-			and will be then updated accordingly.
-
-
-Object Push hierarchy
-=====================
-
-Service		org.bluez.obex
-Interface	org.bluez.obex.ObjectPush1
-Object path	[Session object path]
-
-Methods		object, dict SendFile(string sourcefile)
-
-			Send one local file to the remote device.
-
-			The returned path represents the newly created transfer,
-			which should be used to find out if the content has been
-			successfully transferred or if the operation fails.
-
-			The properties of this transfer are also returned along
-			with the object path, to avoid a call to GetProperties.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-		object, dict PullBusinessCard(string targetfile)
-
-			Request the business card from a remote device and
-			store it in the local file.
-
-			If an empty target file is given, a name will be
-			automatically calculated for the temporary file.
-
-			The returned path represents the newly created transfer,
-			which should be used to find out if the content has been
-			successfully transferred or if the operation fails.
-
-			The properties of this transfer are also returned along
-			with the object path, to avoid a call to GetProperties.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-		object, dict ExchangeBusinessCards(string clientfile,
-							string targetfile)
-
-			Push the client's business card to the remote device
-			and then retrieve the remote business card and store
-			it in a local file.
-
-			If an empty target file is given, a name will be
-			automatically calculated for the temporary file.
-
-			The returned path represents the newly created transfer,
-			which should be used to find out if the content has been
-			successfully transferred or if the operation fails.
-
-			The properties of this transfer are also returned along
-			with the object path, to avoid a call to GetProperties.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-
-File Transfer hierarchy
-=======================
-
-Service		org.bluez.obex
-Interface	org.bluez.obex.FileTransfer
-Object path	[Session object path]
-
-Methods		void ChangeFolder(string folder)
-
-			Change the current folder of the remote device.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-		void CreateFolder(string folder)
-
-			Create a new folder in the remote device.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-		array{dict} ListFolder()
-
-			Returns a dictionary containing information about
-			the current folder content.
-
-			The following keys are defined:
-
-				string Name : Object name in UTF-8 format
-				string Type : Either "folder" or "file"
-				uint64 Size : Object size or number of items in
-						folder
-				string Permission : Group, owner and other
-							permission
-				uint64 Modified : Last change
-				uint64 Accessed : Last access
-				uint64 Created : Creation date
-
-			Possible errors: org.bluez.obex.Error.Failed
-
-		object, dict GetFile(string targetfile, string sourcefile)
-
-			Copy the source file (from remote device) to the
-			target file (on local filesystem).
-
-			If an empty target file is given, a name will be
-			automatically calculated for the temporary file.
-
-			The returned path represents the newly created transfer,
-			which should be used to find out if the content has been
-			successfully transferred or if the operation fails.
-
-			The properties of this transfer are also returned along
-			with the object path, to avoid a call to GetProperties.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-		object, dict PutFile(string sourcefile, string targetfile)
-
-			Copy the source file (from local filesystem) to the
-			target file (on remote device).
-
-			The returned path represents the newly created transfer,
-			which should be used to find out if the content has been
-			successfully transferred or if the operation fails.
-
-			The properties of this transfer are also returned along
-			with the object path, to avoid a call to GetProperties.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-		void CopyFile(string sourcefile, string targetfile)
-
-			Copy a file within the remote device from source file
-			to target file.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-		void MoveFile(string sourcefile, string targetfile)
-
-			Move a file within the remote device from source file
-			to the target file.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-		void Delete(string file)
-
-			Deletes the specified file/folder.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-
-Phonebook Access hierarchy
-==========================
-
-Service		org.bluez.obex
-Interface	org.bluez.obex.PhonebookAccess1
-Object path	[Session object path]
-
-Methods		void Select(string location, string phonebook)
-
-			Select the phonebook object for other operations. Should
-			be call before all the other operations.
-
-			location : Where the phonebook is stored, possible
-			inputs :
-				"int" ( "internal" which is default )
-				"sim" ( "sim1" )
-				"sim2"
-				...
-
-			phonebook : Possible inputs :
-				"pb" :	phonebook for the saved contacts
-				"ich":	incoming call history
-				"och":	outgoing call history
-				"mch":	missing call history
-				"cch":	combination of ich och mch
-				"spd":	speed dials entry ( only for "internal" )
-				"fav":	favorites entry ( only for "internal" )
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-		object, dict PullAll(string targetfile, dict filters)
-
-			Return the entire phonebook object from the PSE server
-			in plain string with vcard format, and store it in
-			a local file.
-
-			If an empty target file is given, a name will be
-			automatically calculated for the temporary file.
-
-			The returned path represents the newly created transfer,
-			which should be used to find out if the content has been
-			successfully transferred or if the operation fails.
-
-			The properties of this transfer are also returned along
-			with the object path, to avoid a call to GetProperties.
-
-			Possible filters: Format, Order, Offset, MaxCount and
-			Fields
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					org.bluez.obex.Forbidden
-
-		array{string vcard, string name} List(dict filters)
-
-			Return an array of vcard-listing data where every entry
-			consists of a pair of strings containing the vcard
-			handle and the contact name. For example:
-				"1.vcf" : "John"
-
-			Possible filters: Order, Offset and MaxCount
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Forbidden
-
-		object, dict
-		Pull(string vcard, string targetfile, dict filters)
-
-			Given a vcard handle, retrieve the vcard in the current
-			phonebook object and store it in a local file.
-
-			If an empty target file is given, a name will be
-			automatically calculated for the temporary file.
-
-			The returned path represents the newly created transfer,
-			which should be used to find out if the content has been
-			successfully transferred or if the operation fails.
-
-			The properties of this transfer are also returned along
-			with the object path, to avoid a call to GetProperties.
-
-			Possbile filters: Format and Fields
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Forbidden
-					 org.bluez.obex.Error.Failed
-
-		array{string vcard, string name}
-		Search(string field, string value, dict filters)
-
-			Search for entries matching the given condition and
-			return an array of vcard-listing data where every entry
-			consists of a pair of strings containing the vcard
-			handle and the contact name.
-
-			vcard : name paired string match the search condition.
-
-			field : the field in the vcard to search with
-				{ "name" (default) | "number" | "sound" }
-			value : the string value to search for
-
-
-			Possible filters: Order, Offset and MaxCount
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Forbidden
-					 org.bluez.obex.Error.Failed
-
-		uint16 GetSize()
-
-			Return the number of entries in the selected phonebook
-			object that are actually used (i.e. indexes that
-			correspond to non-NULL entries).
-
-			Possible errors: org.bluez.obex.Error.Forbidden
-					 org.bluez.obex.Error.Failed
-
-		void UpdateVersion()
-
-			Attempt to update PrimaryCounter and SecondaryCounter.
-
-			Possible errors: org.bluez.obex.Error.NotSupported
-					 org.bluez.obex.Error.Forbidden
-					 org.bluez.obex.Error.Failed
-
-		array{string} ListFilterFields()
-
-			Return All Available fields that can be used in Fields
-			filter.
-
-			Possible errors: None
-
-Filter:		string Format:
-
-			Items vcard format
-
-			Possible values: "vcard21" (default) or "vcard30"
-
-		string Order:
-
-			Items order
-
-			Possible values: "indexed" (default), "alphanumeric" or
-			"phonetic"
-
-		uint16 Offset:
-
-			Offset of the first item, default is 0
-
-		uint16 MaxCount:
-
-			Maximum number of items, default is unlimited (65535)
-
-		array{string} Fields:
-
-			Item vcard fields, default is all values.
-
-			Possible values can be query with ListFilterFields.
-
-		array{string} FilterAll:
-
-			Filter items by fields using AND logic, cannot be used
-			together with FilterAny.
-
-			Possible values can be query with ListFilterFields.
-
-		array{string} FilterAny:
-
-			Filter items by fields using OR logic, cannot be used
-			together with FilterAll.
-
-			Possible values can be query with ListFilterFields.
-
-		bool ResetNewMissedCalls
-
-			Reset new the missed calls items, shall only be used
-			for folders mch and cch.
-
-Properties	string Folder [readonly]
-
-			Current folder.
-
-		string DatabaseIdentifier [readonly, optional]
-
-			128 bits persistent database identifier.
-
-			Possible values: 32-character hexadecimal such
-			as A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
-
-		string PrimaryCounter [readonly, optional]
-
-			128 bits primary version counter.
-
-			Possible values: 32-character hexadecimal such
-			as A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
-
-		string SecondaryCounter [readonly, optional]
-
-			128 bits secondary version counter.
-
-			Possible values: 32-character hexadecimal such
-			as A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
-
-		bool FixedImageSize [readonly, optional]
-
-			Indicate support for fixed image size.
-
-			Possible values: True if image is JPEG 300x300 pixels
-			otherwise False.
-
-Synchronization hierarchy
-=========================
-
-Service		org.bluez.obex
-Interface	org.bluez.obex.Synchronization1
-Object path	[Session object path]
-
-Methods		void SetLocation(string location)
-
-			Set the phonebook object store location for other
-			operations. Should be called before all the other
-			operations.
-
-			location: Where the phonebook is stored, possible
-			values:
-				"int" ( "internal" which is default )
-				"sim1"
-				"sim2"
-				......
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-
-		object, dict GetPhonebook(string targetfile)
-
-			Retrieve an entire Phonebook Object store from remote
-			device, and stores it in a local file.
-
-			If an empty target file is given, a name will be
-			automatically calculated for the temporary file.
-
-			The returned path represents the newly created transfer,
-			which should be used to find out if the content has been
-			successfully transferred or if the operation fails.
-
-			The properties of this transfer are also returned along
-			with the object path, to avoid a call to GetProperties.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-		object, dict PutPhonebook(string sourcefile)
-
-			Send an entire Phonebook Object store to remote device.
-
-			The returned path represents the newly created transfer,
-			which should be used to find out if the content has been
-			successfully transferred or if the operation fails.
-
-			The properties of this transfer are also returned along
-			with the object path, to avoid a call to GetProperties.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-
-Message Access hierarchy
-=========================
-
-Service		org.bluez.obex
-Interface	org.bluez.obex.MessageAccess1
-Object path	[Session object path]
-
-Methods		void SetFolder(string name)
-
-			Set working directory for current session, *name* may
-			be the directory name or '..[/dir]'.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-		array{dict} ListFolders(dict filter)
-
-			Returns a dictionary containing information about
-			the current folder content.
-
-			The following keys are defined:
-
-				string Name : Folder name
-
-			Possible filters: Offset and MaxCount
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-		array{string} ListFilterFields()
-
-			Return all available fields that can be used in Fields
-			filter.
-
-			Possible errors: None
-
-		array{object, dict} ListMessages(string folder, dict filter)
-
-			Returns an array containing the messages found in the
-			given subfolder of the current folder, or in the
-			current folder if folder is empty.
-
-			Possible Filters: Offset, MaxCount, SubjectLength, Fields,
-			Type, PeriodStart, PeriodEnd, Status, Recipient, Sender,
-			Priority
-
-			Each message is represented by an object path followed
-			by a dictionary of the properties.
-
-			Properties:
-
-				string Subject:
-
-					Message subject
-
-				string Timestamp:
-
-					Message timestamp
-
-				string Sender:
-
-					Message sender name
-
-				string SenderAddress:
-
-					Message sender address
-
-				string ReplyTo:
-
-					Message Reply-To address
-
-				string Recipient:
-
-					Message recipient name
-
-				string RecipientAddress:
-
-					Message recipient address
-
-				string Type:
-
-					Message type
-
-					Possible values: "email", "sms-gsm",
-					"sms-cdma" and "mms"
-
-				uint64 Size:
-
-					Message size in bytes
-
-				boolean Text:
-
-					Message text flag
-
-					Specifies whether message has textual
-					content or is binary only
-
-				string Status:
-
-					Message status
-
-					Possible values for received messages:
-					"complete", "fractioned", "notification"
-
-					Possible values for sent messages:
-					"delivery-success", "sending-success",
-					"delivery-failure", "sending-failure"
-
-				uint64 AttachmentSize:
-
-					Message overall attachment size in bytes
-
-				boolean Priority:
-
-					Message priority flag
-
-				boolean Read:
-
-					Message read flag
-
-				boolean Sent:
-
-					Message sent flag
-
-				boolean Protected:
-
-					Message protected flag
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-		void UpdateInbox(void)
-
-			Request remote to update its inbox.
-
-			Possible errors: org.bluez.obex.Error.Failed
-
-		object, dict
-		PushMessage(string sourcefile, string folder, dict args)
-
-			Transfer a message (in bMessage format) to the
-			remote device.
-
-			The message is transferred either to the given
-			subfolder of the current folder, or to the current
-			folder if folder is empty.
-
-			Possible args: Transparent, Retry, Charset
-
-			The returned path represents the newly created transfer,
-			which should be used to find out if the content has been
-			successfully transferred or if the operation fails.
-
-			The properties of this transfer are also returned along
-			with the object path, to avoid a call to GetAll.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-
-Filter:		uint16 Offset:
-
-			Offset of the first item, default is 0
-
-		uint16 MaxCount:
-
-			Maximum number of items, default is 1024
-
-		byte SubjectLength:
-
-			Maximum length of the Subject property in the
-			message, default is 256
-
-		array{string} Fields:
-
-			Message fields, default is all values.
-
-			Possible values can be query with ListFilterFields.
-
-		array{string} Types:
-
-			Filter messages by type.
-
-			Possible values: "sms", "email", "mms".
-
-		string PeriodBegin:
-
-			Filter messages by starting period.
-
-			Possible values: Date in "YYYYMMDDTHHMMSS" format.
-
-		string PeriodEnd:
-
-			Filter messages by ending period.
-
-			Possible values: Date in "YYYYMMDDTHHMMSS" format.
-
-		boolean Read:
-
-			Filter messages by read flag.
-
-			Possible values: True for read or False for unread
-
-		string Recipient:
-
-			Filter messages by recipient address.
-
-		string Sender:
-
-			Filter messages by sender address.
-
-		boolean Priority:
-
-			Filter messages by priority flag.
-
-			Possible values: True for high priority or False for
-			non-high priority
-
-Message hierarchy
-=================
-
-Service		org.bluez.obex
-Interface	org.bluez.obex.Message1
-Object path	[Session object path]/{message0,...}
-
-Methods		object, dict Get(string targetfile, boolean attachment)
-
-			Download message and store it in the target file.
-
-			If an empty target file is given, a temporary file
-			will be automatically generated.
-
-			The returned path represents the newly created transfer,
-			which should be used to find out if the content has been
-			successfully transferred or if the operation fails.
-
-			The properties of this transfer are also returned along
-			with the object path, to avoid a call to GetProperties.
-
-			Possible errors: org.bluez.obex.Error.InvalidArguments
-					 org.bluez.obex.Error.Failed
-
-Properties	string Folder [readonly]
-
-			Folder which the message belongs to
-
-		string Subject [readonly]
-
-			Message subject
-
-		string Timestamp [readonly]
-
-			Message timestamp
-
-		string Sender [readonly]
-
-			Message sender name
-
-		string SenderAddress [readonly]
-
-			Message sender address
-
-		string ReplyTo [readonly]
-
-			Message Reply-To address
-
-		string Recipient [readonly]
-
-			Message recipient name
-
-		string RecipientAddress [readonly]
-
-			Message recipient address
-
-		string Type [readonly]
-
-			Message type
-
-			Possible values: "email", "sms-gsm",
-			"sms-cdma" and "mms"
-
-		uint64 Size [readonly]
-
-			Message size in bytes
-
-		string Status [readonly]
-
-			Message reception status
-
-			Possible values: "complete",
-			"fractioned" and "notification"
-
-		boolean Priority [readonly]
-
-			Message priority flag
-
-		boolean Read [read/write]
-
-			Message read flag
-
-		boolean Deleted [writeonly]
-
-			Message deleted flag
-
-		boolean Sent [readonly]
-
-			Message sent flag
-
-		boolean Protected [readonly]
-
-			Message protected flag
diff --git a/doc/org.bluez.obex.Agent.rst b/doc/org.bluez.obex.Agent.rst
new file mode 100644
index 000000000000..b832e278c86a
--- /dev/null
+++ b/doc/org.bluez.obex.Agent.rst
@@ -0,0 +1,54 @@
+====================
+org.bluez.obex.Agent
+====================
+
+----------------------------------------
+BlueZ D-Bus OBEX Agent API documentation
+----------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+;Service:	unique name
+:Interface:	org.bluez.obex.Agent1
+:Object path:	freely definable
+
+Methods
+-------
+
+void Release()
+``````````````
+
+	This method gets called when **obexd(8)** daemon unregisters the agent.
+	An agent can use it to do cleanup tasks. There is no need to unregister
+	the agent, because when this method gets called it has already been
+	unregistered.
+
+string AuthorizePush(object transfer)
+`````````````````````````````````````
+
+	This method gets called when the **obexd(8)** needs to accept/reject a
+	Bluetooth object push request.
+
+	Returns the full path (including the filename) or the folder name
+	suffixed with '/' where the object shall be stored.
+
+	The transfer object, see **org.bluez.obex.Transfer(5)** will contain a
+	Filename property that contains the default location and name that can
+	be returned.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.Rejected:
+	:org.bluez.obex.Error.Canceled:
+
+void Cancel()
+`````````````
+
+	This method gets called to indicate that the agent request failed before
+	a reply was returned. It cancels the previous request.
diff --git a/doc/org.bluez.obex.AgentManager.rst b/doc/org.bluez.obex.AgentManager.rst
new file mode 100644
index 000000000000..f18f227bcb4b
--- /dev/null
+++ b/doc/org.bluez.obex.AgentManager.rst
@@ -0,0 +1,45 @@
+===========================
+org.bluez.obex.AgentManager
+===========================
+
+-----------------------------------------------
+BlueZ D-Bus OBEX AgentManager API documentation
+-----------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez.obex
+:Interface:	org.bluez.obex.AgentManager1
+:Object path:	/org/bluez/obex
+
+Methods
+```````
+
+void RegisterAgent(object agent)
+````````````````````````````````
+
+	Registers an agent, which must implement **org.bluez.obex.Agent(5)**, to
+	request authorization of the user to accept/reject objects.
+
+	Object push service needs to authorize each received object.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.AlreadyExists:
+
+void UnregisterAgent(object agent)
+``````````````````````````````````
+
+	Unregisters the agent that has been previously registered using
+	**RegisterAgent()**. The object path parameter must match the same value
+	that has been used on registration.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.DoesNotExist:
diff --git a/doc/org.bluez.obex.Client.rst b/doc/org.bluez.obex.Client.rst
new file mode 100644
index 000000000000..9f77a9abc0a8
--- /dev/null
+++ b/doc/org.bluez.obex.Client.rst
@@ -0,0 +1,69 @@
+=====================
+org.bluez.obex.Client
+=====================
+
+-----------------------------------------
+BlueZ D-Bus OBEX Client API documentation
+-----------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez.obex
+:Interface:	org.bluez.obex.Client1
+:Object path:	/org/bluez/obex
+
+Methods
+-------
+
+object CreateSession(string destination, dict args)
+```````````````````````````````````````````````````
+
+	Connects to the destination address and then proceed to create an OBEX
+	session object which implements **org.bluez.obex.Session(5)** interface.
+
+	The last parameter is a dictionary to hold optional or type-specific
+	parameters.
+
+	Possible args values:
+
+	:string Target:
+
+		Type of session to be created.
+
+		Possible values:
+
+		:"ftp":
+		:"map":
+		:"opp":
+		:"pbap":
+		:"sync":
+
+	:string Source:
+
+		Local address to be used.
+
+	:byte Channel:
+
+		Channel to be used.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+void RemoveSession(object session)
+``````````````````````````````````
+
+	Disconnects and removes session previously created by
+	**CreateSession()** aborting any pending transfers.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.NotAuthorized:
diff --git a/doc/org.bluez.obex.FileTransfer.rst b/doc/org.bluez.obex.FileTransfer.rst
new file mode 100644
index 000000000000..6dce7e59d78e
--- /dev/null
+++ b/doc/org.bluez.obex.FileTransfer.rst
@@ -0,0 +1,155 @@
+===========================
+org.bluez.obex.FileTransfer
+===========================
+
+-----------------------------------------------
+BlueZ D-Bus OBEX FileTransfer API documentation
+-----------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez.obex
+:Interface:	org.bluez.obex.FileTransfer1
+:Object path:	[Session object path]
+
+Methods
+-------
+
+void ChangeFolder(string folder)
+````````````````````````````````
+
+	Changes the current folder of the remote device.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+void CreateFolder(string folder)
+````````````````````````````````
+
+	Creates a new folder in the remote device.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+array{dict} ListFolder()
+````````````````````````
+
+	Returns a dictionary containing information about the current folder
+	content.
+
+	Possible return values:
+
+	:string Name:
+
+		Object name in UTF-8 format.
+
+	:string Type:
+
+		Either "folder" or "file".
+
+	:uint64 Size:
+
+		Object size or number of items in folder.
+
+	:string Permission:
+
+		Group, owner and other permission.
+
+	:uint64 Modified:
+
+		Last change.
+
+	:uint64 Accessed:
+
+		Last access.
+
+	:uint64 Created:
+
+		Creation date.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.Failed:
+
+object, dict GetFile(string targetfile, string sourcefile)
+``````````````````````````````````````````````````````````
+
+	Copies the contents of the source file (from remote device) to the
+	target file (on local filesystem).
+
+	If an empty target file is given, a name will be automatically generated
+	for the temporary file.
+
+	The returned path represents the newly created transfer, which should be
+	used to find out if the content has been successfully transferred or
+	if the operation fails.
+
+	The properties of this transfer are also returned along with the object
+	path, to avoid a call to GetProperties, see
+	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+object, dict PutFile(string sourcefile, string targetfile)
+``````````````````````````````````````````````````````````
+
+	Copies the contents of the source file (from local filesystem) to the
+	target file (on remote device).
+
+	The returned path represents the newly created transfer, which should be
+	used to find out if the content has been successfully transferred or if
+	the operation fails.
+
+	The properties of this transfer are also returned along with the object
+	path, to avoid a call to GetProperties, see
+	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+void CopyFile(string sourcefile, string targetfile)
+```````````````````````````````````````````````````
+
+	Copies the contents from source file to target file on the remote
+	device.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+void MoveFile(string sourcefile, string targetfile)
+```````````````````````````````````````````````````
+
+	Moves a file within the remote device from source file to the target
+	file.
+
+	Possible errors:
+
+	;org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+void Delete(string file)
+````````````````````````
+
+	Deletes the specified file/folder.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
diff --git a/doc/org.bluez.obex.Message.rst b/doc/org.bluez.obex.Message.rst
new file mode 100644
index 000000000000..082f87271887
--- /dev/null
+++ b/doc/org.bluez.obex.Message.rst
@@ -0,0 +1,139 @@
+======================
+org.bluez.obex.Message
+======================
+
+------------------------------------------
+BlueZ D-Bus OBEX Message API documentation
+------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez.obex
+:Interface:	org.bluez.obex.Message1
+:Object path:	[Session object path]/message{#}
+
+Methods
+-------
+
+object, dict Get(string targetfile, boolean attachment)
+```````````````````````````````````````````````````````
+
+	Download message and store it in the target file.
+
+	If an empty target file is given, a temporary file will be automatically
+	generated.
+
+	The returned path represents the newly created transfer, which should be
+	used to find out if the content has been successfully transferred or if
+	the operation fails.
+
+	The properties of this transfer are also returned along with the object
+	path, to avoid a call to GetProperties, see
+	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+Properties
+----------
+
+string Folder [readonly]
+````````````````````````
+
+	Folder which the message belongs to
+
+string Subject [readonly]
+`````````````````````````
+
+	Message subject
+
+string Timestamp [readonly]
+```````````````````````````
+
+	Message timestamp
+
+string Sender [readonly]
+````````````````````````
+
+	Message sender name
+
+string SenderAddress [readonly]
+```````````````````````````````
+
+	Message sender address
+
+string ReplyTo [readonly]
+`````````````````````````
+
+	Message Reply-To address
+
+string Recipient [readonly]
+```````````````````````````
+
+	Message recipient name
+
+string RecipientAddress [readonly]
+``````````````````````````````````
+
+	Message recipient address
+
+string Type [readonly]
+``````````````````````
+
+	Message type
+
+	Possible values:
+
+	:"email":
+	:"sms-gsm":
+	:"sms-cdma":
+	:"mms":
+
+uint64 Size [readonly]
+``````````````````````
+
+	Message size in bytes
+
+string Status [readonly]
+````````````````````````
+
+	Message reception status
+
+	Possible values:
+
+	:"complete":
+	:"fractioned":
+	:"notification":
+
+boolean Priority [readonly]
+```````````````````````````
+
+	Message priority flag
+
+boolean Read [read/write]
+`````````````````````````
+
+	Message read flag
+
+boolean Deleted [writeonly]
+```````````````````````````
+
+	Message deleted flag
+
+boolean Sent [readonly]
+```````````````````````
+
+	Message sent flag
+
+boolean Protected [readonly]
+````````````````````````````
+
+	Message protected flag
diff --git a/doc/org.bluez.obex.MessageAccess.rst b/doc/org.bluez.obex.MessageAccess.rst
new file mode 100644
index 000000000000..4f7f07d1babd
--- /dev/null
+++ b/doc/org.bluez.obex.MessageAccess.rst
@@ -0,0 +1,201 @@
+============================
+org.bluez.obex.MessageAccess
+============================
+
+------------------------------------------------
+BlueZ D-Bus OBEX MessageAccess API documentation
+------------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez.obex
+:Interface:	org.bluez.obex.MessageAccess1
+:Object path:	[Session object path]
+
+Methods
+-------
+
+void SetFolder(string name)
+```````````````````````````
+
+	Set working directory for current session.
+
+	Possible name:
+
+		Directory name or '..[/dir]'.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+array{dict} ListFolders(dict filter)
+````````````````````````````````````
+
+	Returns a dictionary containing information about the current folder
+	content.
+
+	Possible filter:
+
+	:uint16 Offset (default 0):
+
+		Offset of the first item.
+
+	:uint16 MaxCount (default 1024):
+
+		Maximum number of items.
+
+	Possible return:
+
+	:string Name:
+
+		Folder name
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+array{string} ListFilterFields()
+````````````````````````````````
+
+	Return all available fields that can be used in **Fields** filter.
+
+	Possible values:
+
+	:"subject":
+	:"timestamp":
+	:"sender":
+	:"sender-address":
+	:"recipient":
+	:"recipient-address":
+	:"type":
+	:"size":
+	:"status":
+	:"text":
+	:"attachment":
+	:"priority":
+	:"read":
+	:"sent":
+	:"protected":
+	:"replyto":
+
+	Possible errors: None
+
+array{object, dict} ListMessages(string folder, dict filter)
+````````````````````````````````````````````````````````````
+
+	Returns an array containing the messages objects found in the given
+	subfolder of the current folder, or in the current folder if folder is
+	empty.
+
+	Possible Filters:
+
+	:uint16 Offset (default 0):
+
+		Offset of the first item.
+
+	uint16 MaxCount (default 1024):
+
+		Maximum number of items.
+
+	:byte SubjectLength (default 256):
+
+		Maximum length of the Subject property in the message.
+
+	:array{string} Fields:
+
+		Message fields, default is all values.
+
+		See **ListFilterFields()** for possible values.
+
+	:array{string} Types:
+
+		Filter messages by type.
+
+		Possible values:
+
+		:"sms":
+		:"email":
+		:"mms":
+
+	:string PeriodBegin:
+
+		Filter messages by starting period.
+
+		Possible values:
+
+			Date in "YYYYMMDDTHHMMSS" format.
+
+	:string PeriodEnd:
+
+		Filter messages by ending period.
+
+		Possible values:
+
+			Date in "YYYYMMDDTHHMMSS" format.
+
+	:boolean Read:
+
+		Filter messages by read flag.
+
+		Possible values:
+
+			True for read or False for unread
+
+	:string Recipient:
+
+		Filter messages by recipient address.
+
+	:string Sender:
+
+		Filter messages by sender address.
+
+	:boolean Priority:
+
+		Filter messages by priority flag.
+
+		Possible values:
+
+			True for high priority or False for non-high priority.
+
+	Each message is represented by an object path, which implements
+	**org.bluez.obex.Message(5)** interface, followed by a dictionary
+	of its properties.
+
+void UpdateInbox(void)
+
+	Requests remote to update its inbox.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.Failed:
+
+object, dict PushMessage(string sourcefile, string folder, dict args)
+`````````````````````````````````````````````````````````````````````
+
+	Transfers a message (in bMessage format) to the remote device.
+
+	The message is transferred either to the given subfolder of the current
+	folder, or to the current folder if folder is empty.
+
+	Possible args: Transparent, Retry, Charset
+
+	The returned path represents the newly created transfer, which should be
+	used to find out if the content has been successfully transferred or if
+	the operation fails.
+
+	The properties of this transfer are also returned along with the object
+	path, to avoid a call to GetProperties, see
+	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
diff --git a/doc/org.bluez.obex.ObjectPush.rst b/doc/org.bluez.obex.ObjectPush.rst
new file mode 100644
index 000000000000..aba2282a8480
--- /dev/null
+++ b/doc/org.bluez.obex.ObjectPush.rst
@@ -0,0 +1,84 @@
+=========================
+org.bluez.obex.ObjectPush
+=========================
+
+---------------------------------------------
+BlueZ D-Bus OBEX ObjectPush API documentation
+---------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez.obex
+:Interface:	org.bluez.obex.ObjectPush1
+:Object path:	[Session object path]
+
+Methods
+-------
+
+object, dict SendFile(string sourcefile)
+````````````````````````````````````````
+
+	Sends local file to the remote device.
+
+	The returned path represents the newly created transfer, which should be
+	used to find out if the content has been successfully transferred or if
+	the operation fails.
+
+	The properties of this transfer are also returned along with the object
+	path, to avoid a call to GetProperties, see
+	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+object, dict PullBusinessCard(string targetfile)
+````````````````````````````````````````````````
+
+	Request the business card from a remote device and store it in the local
+	file.
+
+	If an empty target file is given, a name will be automatically
+	generated for the temporary file.
+
+	The returned path represents the newly created transfer, which should be
+	used to find out if the content has been successfully transferred or if
+	the operation fails.
+
+	The properties of this transfer are also returned along with the object
+	path, to avoid a call to GetProperties, see
+	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+object, dict ExchangeBusinessCards(string clientfile, string targetfile)
+````````````````````````````````````````````````````````````````````````
+
+	Push the client's business card to the remote device and then retrieve
+	the remote business card and store it in a local file.
+
+	If an empty target file is given, a name will be automatically
+	generated for the temporary file.
+
+	The returned path represents the newly created transfer, which should
+	be used to find out if the content has been successfully transferred or
+	if the operation fails.
+
+	The properties of this transfer are also returned along with the object
+	path, to avoid a call to GetProperties, see
+	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
diff --git a/doc/org.bluez.obex.PhonebookAccess.rst b/doc/org.bluez.obex.PhonebookAccess.rst
new file mode 100644
index 000000000000..0e126b1b46c6
--- /dev/null
+++ b/doc/org.bluez.obex.PhonebookAccess.rst
@@ -0,0 +1,386 @@
+==============================
+org.bluez.obex.PhonebookAccess
+==============================
+
+--------------------------------------------------
+BlueZ D-Bus OBEX PhonebookAccess API documentation
+--------------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez.obex
+:Interface:	org.bluez.obex.PhonebookAccess1
+:Object path:	[Session object path]
+
+Methods
+-------
+
+void Select(string location, string phonebook)
+``````````````````````````````````````````````
+
+	Selects the phonebook object for other operations. Should be call before
+	all the other operations.
+
+	Possible location values:
+
+	:"int", "internal" (default):
+
+		Store in the Internal memory.
+
+	:"sim{#}":
+
+		Store in the sim number.
+
+	Possible phonebook values:
+
+	:"pb":
+
+		Store as contact.
+
+	:"ich":
+
+		Store as incoming call.
+
+	:"och":
+
+		Store as outgoing call.
+
+	:"mch":
+
+		Store as missing call.
+
+	:"cch":
+
+		Store as a combination of incoming, outgoing and missing call.
+
+	"spd":
+
+		Store as speed dials entry ( only for "internal" )
+
+	"fav":
+
+		Store as favorites entry ( only for "internal" )
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+object, dict PullAll(string targetfile, dict filters)
+`````````````````````````````````````````````````````
+
+	Returns the entire phonebook object from the PSE server in plain string
+	with vcard format, and store it in a local file.
+
+	If an empty target file is given, a name will be automatically generated
+	for the temporary file.
+
+	The returned path represents the newly created transfer, which should
+	be used to find out if the content has been successfully transferred or
+	if the operation fails.
+
+	The properties of this transfer are also returned along with the object
+	path, to avoid a call to GetProperties, see
+	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+
+	Possible filters:
+
+	:string Format:
+
+		Items vcard format.
+
+		Possible values:
+
+		:"vcard21" (default):
+		:"vcard30":
+
+	:string Order:
+
+		Items order.
+
+		Possible values:
+
+		:"":
+		:"indexed":
+		:"alphanumeric":
+		:"phonetic":
+
+	:uint16 Offset (default 0):
+
+		Offset of the first item.
+
+	:uint16 MaxCount (default 65535):
+
+		Maximum number of items.
+
+	:array{string} Fields (default all fields):
+
+		Item vcard fields.
+
+		See **ListFilterFields()** for possible values.
+
+	:array{string} FilterAll:
+
+		Filter items by fields using AND logic, cannot be used
+		together with **FilterAny**.
+
+		See **ListFilterFields()** for possible values.
+
+	:array{string} FilterAny:
+
+		Filter items by fields using OR logic, cannot be used together
+		with **FilterAll**.
+
+		See **ListFilterFields()** for possible values.
+
+	:bool ResetNewMissedCalls:
+
+		Reset new the missed calls items, shall only be used for folders
+		mch and cch.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Forbidden:
+
+array{string vcard, string name} List(dict filters)
+```````````````````````````````````````````````````
+
+	Returns array of vcard-listing data where every entry consists of a
+	pair of strings containing the vcard handle and the contact name.
+	For example:
+
+	:"1.vcf": "John"
+
+	Possible filters:
+
+	:string Order:
+
+		Contact order.
+
+		Possible values:
+
+		:"":
+		:"indexed":
+		:"alphanumeric":
+		:"phonetic":
+
+	:uint16 Offset:
+
+		Start offset.
+
+	:uint16 MaxCount:
+
+		Maximum number of contacts.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Forbidden:
+
+object, dict Pull(string vcard, string targetfile, dict filters)
+````````````````````````````````````````````````````````````````
+
+	Retrieves the vcard in the current phonebook object and store it in a
+	local file.
+
+	If an empty target file is given, a name will be automatically generated
+	for the temporary file.
+
+	The returned path represents the newly created transfer, which should be
+	used to find out if the content has been successfully transferred or if
+	the operation fails.
+
+	The properties of this transfer are also returned along with the object
+	path, to avoid a call to GetProperties, see
+	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+
+	Possible filters:
+
+	:string Format:
+
+		Contact data format.
+
+		Possible values:
+
+		:"":
+		:"vcard21":
+		:"vcard30":
+
+	:array{string} Fields:
+
+		See **ListFilterFields()** for possible values.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Forbidden:
+	:org.bluez.obex.Error.Failed:
+
+array{string vcard, string name} Search(string field, string value, dict filters)
+`````````````````````````````````````````````````````````````````````````````````
+
+	Searches for entries matching the given condition and return an array of
+	vcard-listing data where every entry consists of a pair of strings
+	containing the vcard handle and the contact name.
+
+	Possible field values:
+
+		:"name" (default):
+
+			Search by name.
+
+		:"number":
+
+			Search by number.
+
+		:"sound":
+
+			Search by sound.
+
+	value: the string value to search for
+
+	Possible filters:
+
+	:string Order:
+
+		Contact order.
+
+		Possible values:
+
+		:"":
+		:"indexed":
+		:"alphanumeric":
+		:"phonetic":
+
+	:uint16 Offset:
+
+		Start offset.
+
+	:uint16 MaxCount:
+
+		Maximum number of contacts.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Forbidden:
+	:org.bluez.obex.Error.Failed:
+
+uint16 GetSize()
+````````````````
+
+	Returns the number of entries in the selected phonebook object that are
+	actually used (i.e. indexes that correspond to non-NULL entries).
+
+	Possible errors:
+
+	:org.bluez.obex.Error.Forbidden:
+	:org.bluez.obex.Error.Failed:
+
+void UpdateVersion()
+````````````````````
+
+	Attempts to update PrimaryCounter and SecondaryCounter.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.NotSupported:
+	:org.bluez.obex.Error.Forbidden:
+	:org.bluez.obex.Error.Failed:
+
+array{string} ListFilterFields()
+````````````````````````````````
+
+	Returns all Available fields that can be used in Fields filter.
+
+	Possible return:
+
+	:"VERSION":
+	:"FN":
+	:"N":
+	:"PHOTO":
+	:"BDAY":
+	:"ADR":
+	:"LABEL":
+	:"TEL":
+	:"EMAIL":
+	:"MAILER":
+	:"TZ":
+	:"GEO":
+	:"TITLE":
+	:"ROLE":
+	:"LOGO":
+	:"AGENT":
+	:"ORG":
+	:"NOTE":
+	:"REV":
+	:"SOUND":
+	:"URL":
+	:"UID":
+	:"KEY":
+	:"NICKNAME":
+	:"CATEGORIES":
+	:"PROID":
+	:"CLASS":
+	:"SORT-STRING":
+	:"X-IRMC-CALL-DATETIME":
+	:"X-BT-SPEEDDIALKEY":
+	:"X-BT-UCI":
+	:"X-BT-UID":
+	:"BIT-{#}":
+
+	Possible errors: None
+
+Properties
+----------
+
+string Folder [readonly]
+````````````````````````
+
+	Current folder.
+
+string DatabaseIdentifier [readonly, optional]
+``````````````````````````````````````````````
+
+	128 bits persistent database identifier.
+
+	Possible values:
+
+		32-character hexadecimal such as
+		A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
+
+string PrimaryCounter [readonly, optional]
+``````````````````````````````````````````
+
+	128 bits primary version counter.
+
+	Possible values:
+
+		32-character hexadecimal such as
+		A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
+
+string SecondaryCounter [readonly, optional]
+````````````````````````````````````````````
+
+	128 bits secondary version counter.
+
+	Possible values:
+
+		32-character hexadecimal such as
+		A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
+
+bool FixedImageSize [readonly, optional]
+````````````````````````````````````````
+
+	Indicate support for fixed image size.
+
+	Possible values:
+
+		True if image is JPEG 300x300 pixels otherwise False.
diff --git a/doc/org.bluez.obex.Session.rst b/doc/org.bluez.obex.Session.rst
new file mode 100644
index 000000000000..1cef9a53d294
--- /dev/null
+++ b/doc/org.bluez.obex.Session.rst
@@ -0,0 +1,61 @@
+======================
+org.bluez.obex.Session
+======================
+
+-----------------------------------------
+BlueZ D-Bus OBEX Client API documentation
+-----------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez.obex
+:Interface:	org.bluez.obex.Session1
+:Object path:	/org/bluez/obex/server/session{#} or
+		/org/bluez/obex/client/session{#}
+
+Methods
+-------
+
+string GetCapabilities()
+````````````````````````
+
+	Get remote device capabilities.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.NotSupported:
+	:org.bluez.obex.Error.Failed:
+
+Properties
+----------
+
+string Source [readonly]
+````````````````````````
+
+	Bluetooth adapter address
+
+string Destination [readonly]
+`````````````````````````````
+
+	Bluetooth device address
+
+byte Channel [readonly]
+```````````````````````
+
+	Bluetooth channel
+
+string Target [readonly]
+````````````````````````
+
+	Target UUID
+
+string Root [readonly]
+``````````````````````
+
+	Root path
diff --git a/doc/org.bluez.obex.Synchronization.rst b/doc/org.bluez.obex.Synchronization.rst
new file mode 100644
index 000000000000..a41197dfb926
--- /dev/null
+++ b/doc/org.bluez.obex.Synchronization.rst
@@ -0,0 +1,82 @@
+==============================
+org.bluez.obex.Synchronization
+==============================
+
+--------------------------------------------------
+BlueZ D-Bus OBEX Synchronization API documentation
+--------------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez.obex
+:Interface:	org.bluez.obex.Synchronization1
+:Object path:	[Session object path]
+
+Methods
+-------
+
+void SetLocation(string location)
+`````````````````````````````````
+
+	Sets the phonebook object store location for other operations. Should be
+	called before all the other operations.
+
+	Possible location:
+
+	:"int" ( "internal" which is default ):
+
+		Store in the interval memory.
+
+	:"sim{#}":
+
+		Store in sim card number #.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+
+object, dict GetPhonebook(string targetfile)
+````````````````````````````````````````````
+
+	Retrieves an entire Phonebook Object store from remote device, and
+	stores it in a local file.
+
+	If an empty target file is given, a name will be automatically
+	calculated for the temporary file.
+
+	The returned path represents the newly created transfer, which should be
+	used to find out if the content has been successfully transferred or if
+	the operation fails.
+
+	The properties of this transfer are also returned along with the object
+	path, to avoid a call to GetProperties, see
+	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
+
+object, dict PutPhonebook(string sourcefile)
+````````````````````````````````````````````
+
+	Sends an entire Phonebook Object store to remote device.
+
+	The returned path represents the newly created transfer, which should be
+	used to find out if the content has been successfully transferred or if
+	the operation fails.
+
+	The properties of this transfer are also returned along with the object
+	path, to avoid a call to GetProperties, see
+	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.Failed:
diff --git a/doc/org.bluez.obex.Transfer.rst b/doc/org.bluez.obex.Transfer.rst
new file mode 100644
index 000000000000..733d82851f42
--- /dev/null
+++ b/doc/org.bluez.obex.Transfer.rst
@@ -0,0 +1,123 @@
+=======================
+org.bluez.obex.Transfer
+=======================
+
+-------------------------------------------
+BlueZ D-Bus OBEX Transfer API documentation
+-------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez.obex
+:Interface:	org.bluez.obex.Transfer1
+:Object path:	[Session object path]/transfer{#}
+
+Methods
+-------
+
+void Cancel()
+`````````````
+
+	Cancels the current transference.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.NotAuthorized:
+	:org.bluez.obex.Error.InProgress:
+	:org.bluez.obex.Error.Failed:
+
+void Suspend()
+``````````````
+
+	Suspends transference.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.NotAuthorized:
+	:org.bluez.obex.Error.NotInProgress:
+
+		If transfer is still in with **Status** **"queued"**.
+
+void Resume()
+`````````````
+
+	Resumes transference previously suspended with use of **Suspend()**
+	method.
+
+	Possible errors:
+
+	:org.bluez.obex.Error.NotAuthorized:
+	:org.bluez.obex.Error.NotInProgress:
+
+		If transfer is still in with **Status** **"queued"**.
+
+Properties
+----------
+
+string Status [readonly]
+````````````````````````
+
+	Indicates the current status of the transfer.
+
+	Possible values:
+
+	:"queued":
+	:"active":
+	:"suspended":
+	:"complete":
+	:"error":
+
+object Session [readonly]
+`````````````````````````
+
+	The object path of the session the transfer belongs to.
+
+string Name [readonly, optional]
+````````````````````````````````
+
+	Name of the object being transferred.
+
+	Either Name or Type or both will be present.
+
+string Type [readonly, optional]
+````````````````````````````````
+
+	Type of the object transferred being transferred.
+
+	Either Name or Type or both will be present.
+
+uint64 Time [readonly, optional]
+````````````````````````````````
+
+	Time of the object being transferred if this is provided by the remote
+	party.
+
+uint64 Size [readonly, optional]
+````````````````````````````````
+
+	Size of the object being transferred.
+
+	If the size is unknown, then this property will not be present.
+
+uint64 Transferred [readonly, optional]
+```````````````````````````````````````
+
+	Number of bytes transferred.
+
+	For transfers with **Status** set to **"queued"**, this value will not
+	be present.
+
+string Filename [readonly, optional]
+````````````````````````````````````
+
+	Complete name of the file being received or sent.
+
+	For incoming object push transaction, this will be the proposed default
+	location and name. It can be overwritten by the **AuthorizePush()** in
+	**org.bluez.obex.Agent(5)** and will be then updated accordingly.
-- 
2.41.0

