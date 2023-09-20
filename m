Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0792CE79A8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 00:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjITAKS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 20:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITAKR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 20:10:17 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0F995
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 17:10:08 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-578d0d94986so517440a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 17:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695168607; x=1695773407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZdG7O+xTNU7/hC3zMUKwtpEMrSjaWVoX9D+9fyqATc=;
        b=aDrfD00YUElw9VGEWZ6nVi/q1cmuSCWWRNYKyCRm8xq36xGVBnFU0IYuS/W+9hE+Is
         sGYxGaYNplLHZTOR0QaD1Y4Cok/hrj9LTdFGQTh2Z3FNO0enKuQYO/RbXkwf096lGIg/
         hWb27vIpZko3aqMf3fFnppVtU7vxWhCkV4LZevYaiIY5oI1YNuuti7dHP0NFbfMwKP+I
         S6oYZ9EpT71H/cy0dWPj8Z9iKaJ+II8nknscX53weaYiEC/N2uuJij4TSRWF9aIuQOYu
         xfsedSU/geuqtSzHCrF0JDiTnrCNQ7EOctzu2vMEJa7G+JcRPiMb/GtqlzGLX4Zofz9j
         zp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695168607; x=1695773407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZdG7O+xTNU7/hC3zMUKwtpEMrSjaWVoX9D+9fyqATc=;
        b=rf5i7OL43cH3padOwoU4Zl6ypHqvrL8T13znT0Lve+n54Ds09br/TLbjDysDOPjqwJ
         YPlAxnuWkAoGptAlBId6UeITushavbOhwz6GAHhof57J10BSgK3S651L5X+e1PFErqXv
         YCzI6CJuHVGJZnZ4pAWGWLGpdTwMwbnRZmtfdN8RoSqVkK9x35bVN2KUvsdCMbawrvD/
         wn3MYFG/u5SvIk0xB+Y8k+5ZCNm8yk487aJ3W89P0TgoJ9pq99484lysa4fspu8Tw1m9
         Qw4y922pm4wJVYxg0yCA5vJOSFVMO8MAM5MLIvCQliMsyVe35ew4tQX4oDbk5N8Cj/zR
         O7Hg==
X-Gm-Message-State: AOJu0YzslDnKxkFc9o3E3+7AFWjMjD4Q0vbEHzcFhgnrMJlC7wTjxRFA
        AUqFJs6CZPF9/V/6mNftffVvCp/Av88=
X-Google-Smtp-Source: AGHT+IFKMaEQRs/VEhSu+6jZoJbMj5sT+jMjEsyn7EZgGABTrENS4Xy2q4gEHQuLB4TYiEQOK9j8TA==
X-Received: by 2002:a17:90b:3650:b0:26b:3751:652a with SMTP id nh16-20020a17090b365000b0026b3751652amr1270352pjb.38.1695168606229;
        Tue, 19 Sep 2023 17:10:06 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090a670900b002630c9d78aasm142664pjj.5.2023.09.19.17.10.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 17:10:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] media-api: Convert to ReStructuredText format
Date:   Tue, 19 Sep 2023 17:10:04 -0700
Message-ID: <20230920001004.355664-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This converts media-api.txt to media-api.rst.
---
 Makefile.am         |    2 +-
 doc/media-api.rst   | 1047 +++++++++++++++++++++++++++++++++++++++++++
 doc/media-api.txt   |  889 ------------------------------------
 test/example-player |    2 +-
 test/simple-player  |    2 +-
 5 files changed, 1050 insertions(+), 892 deletions(-)
 create mode 100644 doc/media-api.rst
 delete mode 100644 doc/media-api.txt

diff --git a/Makefile.am b/Makefile.am
index c28c59a05492..30db74a0c441 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -397,7 +397,7 @@ EXTRA_DIST += doc/assigned-numbers.txt doc/supported-features.txt \
 EXTRA_DIST += doc/mgmt-api.txt \
 		doc/adapter-api.txt doc/device-api.txt \
 		doc/agent-api.txt doc/profile-api.txt \
-		doc/network-api.txt doc/media-api.txt \
+		doc/network-api.txt doc/media-api.rst \
 		doc/health-api.txt doc/sap-api.txt \
 		doc/input-api.txt
 
diff --git a/doc/media-api.rst b/doc/media-api.rst
new file mode 100644
index 000000000000..34bf44e8ffbb
--- /dev/null
+++ b/doc/media-api.rst
@@ -0,0 +1,1047 @@
+===================================
+BlueZ D-Bus Media API documentation
+===================================
+
+
+Media interface
+===============
+
+:Service:	org.bluez
+:Interface:	org.bluez.Media1
+:Object path:	[variable prefix]/{hci0,hci1,...}
+
+Methods
+-------
+
+void RegisterEndpoint(object endpoint, dict properties)
+```````````````````````````````````````````````````````
+
+	Register a local end point to sender, the sender can register as many
+	end points as it likes.
+
+	Note: If the sender disconnects the end points are automatically
+	unregistered.
+
+	possible properties:
+
+	:string UUID:
+
+		UUID of the profile which the endpoint is for.
+
+		UUID must be in the list of SupportedUUIDS.
+
+	:byte Codec:
+
+		Assigned number of codec that the endpoint implements. The
+		values should match the profile specification which is
+		indicated by the UUID.
+
+	:uint32_t Vendor [Optional]:
+
+		Vendor-specific Company ID, Codec ID tuple that the endpoint
+		implements.
+
+		It shall be set to appropriate value when Vendor Specific Codec
+		(0xff) is used.
+
+	:array{byte} Capabilities:
+
+		Capabilities blob, it is used as it is so the size and byte
+		order must match.
+
+	:array{byte} Metadata [Optional]:
+
+		Metadata blob, it is used as it is so the size and byte order
+		must match.
+
+	Possible Errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.NotSupported:
+
+		emitted when interface for the end-point is disabled
+
+void UnregisterEndpoint(object endpoint)
+````````````````````````````````````````
+	Unregister sender end point.
+
+void RegisterPlayer(object player, dict properties)
+```````````````````````````````````````````````````
+
+	Register a media player object to sender, the sender can register as
+	many objects as it likes.
+
+	Object must implement at least org.mpris.MediaPlayer2.Player as defined
+	in MPRIS 2.2 spec:
+
+		http://specifications.freedesktop.org/mpris-spec/latest/
+
+	Note: If the sender disconnects its objects are automatically
+	unregistered.
+
+	Possible Errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.NotSupported:
+
+void UnregisterPlayer(object player)
+````````````````````````````````````
+
+	Unregister sender media player.
+
+void RegisterApplication(object root, dict options)
+```````````````````````````````````````````````````
+
+	Register endpoints an player objects within root object which must
+	implement ObjectManager.
+
+	The application object path together with the D-Bus system bus
+	connection ID define the identification of the application.
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.AlreadyExists:
+
+void UnregisterApplication(object application)
+``````````````````````````````````````````````
+
+	This unregisters the services that has been previously registered. The
+	object path parameter must match the same value that has been used on
+	registration.
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.DoesNotExist:
+
+Properties
+----------
+
+array{string} SupportedUUIDs [readonly]
+```````````````````````````````````````
+
+	List of 128-bit UUIDs that represents the supported Endpoint
+	registration.
+
+MediaControl interface
+======================
+
+:Service:	org.bluez
+:Interface:	org.bluez.MediaControl1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Methods
+-------
+
+void Play() [Deprecated]
+````````````````````````
+
+	Resume playback.
+
+void Pause() [Deprecated]
+`````````````````````````
+
+	Pause playback.
+
+void Stop() [Deprecated]
+````````````````````````
+
+	Stop playback.
+
+void Next() [Deprecated]
+````````````````````````
+
+	Next item.
+
+void Previous() [Deprecated]
+````````````````````````````
+
+	Previous item.
+
+void VolumeUp() [Deprecated]
+````````````````````````````
+
+	Adjust remote volume one step up
+
+void VolumeDown() [Deprecated]
+``````````````````````````````
+
+	Adjust remote volume one step down
+
+void FastForward() [Deprecated]
+```````````````````````````````
+
+	Fast forward playback, this action is only stopped when another method
+	in this interface is called.
+
+void Rewind() [Deprecated]
+``````````````````````````
+
+	Rewind playback, this action is only stopped when another method in
+	this interface is called.
+
+Properties
+----------
+
+boolean Connected [readonly]
+````````````````````````````
+
+object Player [readonly, optional]
+``````````````````````````````````
+
+	Addressed Player object path.
+
+MediaPlayer interface
+=====================
+
+:Service:	org.bluez (Controller role)
+:Interface:	org.bluez.MediaPlayer1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
+
+Methods
+-------
+
+void Play()
+```````````
+
+	Resume playback.
+
+	Possible Errors:
+
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+void Pause()
+````````````
+
+	Pause playback.
+
+	Possible Errors:
+
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+void Stop()
+```````````
+
+	Stop playback.
+
+	Possible Errors:
+
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+void Next()
+```````````
+
+	Next item.
+
+	Possible Errors:
+
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+void Previous()
+```````````````
+
+	Previous item.
+
+	Possible Errors:
+
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+void FastForward()
+``````````````````
+
+	Fast forward playback, this action is only stopped when another method
+	in this interface is called.
+
+	Possible Errors:
+
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+void Rewind()
+`````````````
+
+	Rewind playback, this action is only stopped when another method in
+	this interface is called.
+
+	Possible Errors:
+
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+void Press(byte avc_key)
+````````````````````````
+
+	Press a specific key to send as passthrough command. The key will be
+	released automatically. Use Hold() instead if the intention is to hold
+	down the key.
+
+	Possible Errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+void Hold(byte avc_key)
+```````````````````````
+
+	Press and hold a specific key to send as passthrough command. It is
+	your responsibility to make sure that Release() is called after calling
+	this method. The held key will also be released when any other method
+	in this interface is called.
+
+	Possible Errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+void Release()
+``````````````
+
+	Release the previously held key invoked using Hold().
+
+	Possible Errors:
+
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+Properties
+----------
+
+string Equalizer [readwrite]
+````````````````````````````
+
+	Possible values: "off" or "on"
+
+string Repeat [readwrite]
+`````````````````````````
+
+	Possible values: "off", "singletrack", "alltracks" or "group"
+
+string Shuffle [readwrite]
+``````````````````````````
+
+	Possible values: "off", "alltracks" or "group"
+
+string Scan [readwrite]
+```````````````````````
+
+	Possible values: "off", "alltracks" or "group"
+
+string Status [readonly]
+````````````````````````
+
+	Possible status: "playing", "stopped", "paused", "forward-seek",
+			 "reverse-seek" or "error"
+
+uint32 Position [readonly]
+``````````````````````````
+
+	Playback position in milliseconds. Changing the position may generate
+	additional events that will be sent to the remote device. When position
+	is 0 it means the track is starting and when it's greater than or equal
+	to track's duration the track has ended.
+
+	Note that even if duration is not available in metadata it's possible
+	to signal its end by setting position to the maximum uint32 value.
+
+dict Track [readonly]
+`````````````````````
+
+	Track metadata.
+
+	Possible values:
+
+	:string Title:
+
+		Track title name
+
+	:string Artist:
+
+		Track artist name
+
+	:string Album:
+
+		Track album name
+
+	:string Genre:
+
+		Track genre name
+
+	:uint32 NumberOfTracks:
+
+		Number of tracks in total
+
+	:uint32 TrackNumber:
+
+		Track number
+
+	:uint32 Duration:
+
+		Track duration in milliseconds
+
+object Device [readonly]
+````````````````````````
+
+	Device object path.
+
+string Name [readonly]
+``````````````````````
+
+	Player name
+
+string Type [readonly]
+``````````````````````
+
+	Player type
+
+	Possible values:
+
+		"Audio"
+		"Video"
+		"Audio Broadcasting"
+		"Video Broadcasting"
+
+string Subtype [readonly]
+`````````````````````````
+
+	Player subtype
+
+	Possible values:
+
+		"Audio Book"
+		"Podcast"
+
+boolean Browsable [readonly]
+````````````````````````````
+
+	If present indicates the player can be browsed using MediaFolder
+	interface.
+
+	Possible values:
+
+	:True:
+
+		Supported and active
+
+	:False:
+
+		Supported but inactive
+
+	Note: If supported but inactive clients can enable it by using
+	MediaFolder interface but it might interfere in the playback of other
+	players.
+
+boolean Searchable [readonly]
+`````````````````````````````
+
+	If present indicates the player can be searched using MediaFolder
+	interface.
+
+	Possible values:
+
+	:True:
+
+		Supported and active
+
+	:False:
+
+		Supported but inactive
+
+	Note: If supported but inactive clients can enable it by using
+	MediaFolder interface but it might interfere in the playback of other
+	players.
+
+object Playlist
+```````````````
+
+	Playlist object path.
+
+MediaFolder interface
+=====================
+
+:Service:	unique name (Target role)
+		org.bluez (Controller role)
+:Interface:	org.bluez.MediaFolder1
+:Object path:	freely definable (Target role)
+		[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
+		(Controller role)
+
+Methods
+-------
+
+object Search(string value, dict filter)
+````````````````````````````````````````
+
+	Return a folder object containing the search result.
+
+	To list the items found use the folder object returned and pass to
+	ChangeFolder.
+
+	Possible Errors:
+
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+array{objects, properties} ListItems(dict filter)
+`````````````````````````````````````````````````
+
+	Return a list of items found
+
+	Possible Errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+void ChangeFolder(object folder)
+````````````````````````````````
+
+	Change current folder.
+
+	Note: By changing folder the items of previous folder might be destroyed
+	and have to be listed again, the exception is NowPlaying folder which
+	should be always present while the player is active.
+
+	Possible Errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+Properties
+----------
+
+uint32 NumberOfItems [readonly]
+```````````````````````````````
+
+	Number of items in the folder
+
+string Name [readonly]
+``````````````````````
+
+	Folder name:
+
+	Possible values:
+
+	:"/Filesystem/...":
+
+		Filesystem scope
+
+	:"/NowPlaying/...":
+
+		NowPlaying scope
+
+	Note: /NowPlaying folder might not be listed if player is stopped,
+	folders created by Search are virtual so once another Search is perform
+	or the folder is changed using ChangeFolder it will no longer be listed.
+
+Filters
+-------
+
+:uint32 Start:
+
+	Offset of the first item.
+
+	Default value: 0
+
+:uint32 End:
+
+	Offset of the last item.
+
+	Default value: NumbeOfItems
+
+:array{string} Attributes:
+
+	Item properties that should be included in the list.
+
+	Possible Values:
+
+		"title", "artist", "album", "genre", "number-of-tracks",
+		"number", "duration"
+
+		Default Value: All
+
+MediaItem interface
+===================
+
+:Service:	unique name (Target role)
+		org.bluez (Controller role)
+:Interface:	org.bluez.MediaItem1
+:Object path:	freely definable (Target role)
+		[variable
+		prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX/itemX
+		(Controller role)
+
+Methods
+-------
+
+void Play()
+```````````
+
+	Play item
+
+	Possible Errors:
+
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+void AddtoNowPlaying()
+``````````````````````
+
+	Add item to now playing list
+
+	Possible Errors:
+
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
+
+Properties
+----------
+
+object Player [readonly]
+````````````````````````
+
+	Player object path the item belongs to
+
+string Name [readonly]
+``````````````````````
+
+	Item displayable name
+
+string Type [readonly]
+``````````````````````
+
+	Item type
+
+	Possible values: "video", "audio", "folder"
+
+string FolderType [readonly, optional]
+``````````````````````````````````````
+
+	Folder type.
+
+	Possible values: "mixed", "titles", "albums", "artists"
+
+	Available if property Type is "Folder"
+
+boolean Playable [readonly, optional]
+`````````````````````````````````````
+
+	Indicates if the item can be played
+
+	Available if property Type is "folder"
+
+dict Metadata [readonly]
+````````````````````````
+
+	Item metadata.
+
+	Possible values:
+
+	:string Title:
+
+		Item title name
+
+		Available if property Type is "audio" or "video"
+
+	:string Artist:
+
+		Item artist name
+
+		Available if property Type is "audio" or "video"
+
+	:string Album:
+
+		Item album name
+
+		Available if property Type is "audio" or "video"
+
+	:string Genre:
+
+		Item genre name
+
+		Available if property Type is "audio" or "video"
+
+	:uint32 NumberOfTracks:
+
+		Item album number of tracks in total
+
+		Available if property Type is "audio" or "video"
+
+	:uint32 Number:
+
+		Item album number
+
+		Available if property Type is "audio" or "video"
+
+	:uint32 Duration:
+
+		Item duration in milliseconds
+
+		Available if property Type is "audio" or "video"
+
+MediaEndpoint interface
+=======================
+
+:Service:	unique name (Server role)
+		org.bluez (Client role)
+:Interface:	org.bluez.MediaEndpoint1
+:Object path:	freely definable (Server role)
+		[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/sepX
+		(Client role)
+
+Methods
+-------
+
+void SetConfiguration(object transport, dict properties)
+````````````````````````````````````````````````````````
+
+	Set configuration for the transport.
+
+	For client role transport must be set with a server endpoint oject which
+	will be configured and the properties must contain the following
+	properties:
+
+	:array{byte} Capabilities [Mandatory]:
+	:array{byte} Metadata [ISO only]:
+	:byte CIG [ISO only]:
+	:byte CIS [ISO only]:
+	:uint32 Interval [ISO only]:
+	:bool Framing [ISO only]:
+	:string PHY [ISO only]:
+	:uint16 SDU [ISO only]:
+	:byte Retransmissions [ISO only]:
+	:uint16 Latency [ISO only]:
+	:uint32 Delay [ISO only]:
+	:uint8 TargetLatency [ISO Latency]:
+	:byte BIG [ISO broadcast only]:
+	:byte BIS [ISO broadcast only]:
+	:byte SyncInterval [ISO broadcast only]:
+	:byte Encryption [ISO broadcast only]:
+	:byte Options [ISO broadcast only]:
+	:uint16 Skip [ISO broadcast only]:
+	:uint16 SyncTimeout [ISO broadcast only]:
+	:byte SyncCteType [ISO broadcast only]:
+	:byte MSE [ISO broadcast only]:
+	:uint16 Timeout [ISO broadcast only]:
+	:array{byte} BroadcastCode [ISO broadcast only]:
+
+array{byte} SelectConfiguration(array{byte} capabilities)
+`````````````````````````````````````````````````````````
+
+	Select preferable configuration from the supported capabilities.
+
+	Returns a configuration which can be used to setup a transport.
+
+	Note: There is no need to cache the selected configuration since on
+	success the configuration is send back as parameter of SetConfiguration.
+
+dict SelectProperties(dict properties)
+``````````````````````````````````````
+
+	Select preferable properties from the supported properties:
+
+	:object Endpoint [ISO only]:
+	:Refer to SetConfiguration for the list of other possible properties.:
+
+	Returns propeties which can be used to setup a transport.
+
+	Note: There is no need to cache the selected properties since on
+	success the configuration is send back as parameter of SetConfiguration.
+
+void ClearConfiguration(object transport)
+`````````````````````````````````````````
+
+	Clear transport configuration.
+
+void Release()
+``````````````
+
+	This method gets called when the service daemon unregisters the
+	endpoint. An endpoint can use it to do cleanup tasks. There is no need
+	to unregister the endpoint, because when this method gets called it has
+	already been unregistered.
+
+Properties
+----------
+
+string UUID [readonly, optional]
+````````````````````````````````
+
+	UUID of the profile which the endpoint is for.
+
+byte Codec [readonly, optional]
+```````````````````````````````
+
+	Assigned number of codec that the endpoint implements.
+	The values should match the profile specification which is indicated by
+	the UUID.
+
+uint32_t Vendor [readonly, Optional]
+````````````````````````````````````
+
+	Vendor-specific Company ID, Codec ID tuple that the endpoint implements.
+
+	It shall be set to appropriate value when Vendor Specific Codec (0xff)
+	is used.
+
+array{byte} Capabilities [readonly, optional]
+`````````````````````````````````````````````
+
+	Capabilities blob, it is used as it is so the size and byte order must
+	match.
+
+array{byte} Metadata [readonly, Optional]
+`````````````````````````````````````````
+
+	Metadata blob, it is used as it is so the size and byte order must
+	match.
+
+object Device [readonly, optional]
+``````````````````````````````````
+
+	Device object which the endpoint is belongs to.
+
+bool DelayReporting [readonly, optional]
+````````````````````````````````````````
+
+	Indicates if endpoint supports Delay Reporting.
+
+byte Framing [ISO only]
+```````````````````````
+
+	Indicates endpoint support framing.
+
+byte PHY [ISO only]
+```````````````````
+
+	Indicates endpoint supported PHY.
+
+uint16_t MaximumLatency [ISO only]
+``````````````````````````````````
+
+	Indicates endpoint maximum latency.
+
+uint32_t MinimumDelay [ISO only]
+````````````````````````````````
+
+	Indicates endpoint minimum presentation delay.
+
+uint32_t MaximumDelay [ISO only]
+````````````````````````````````
+
+	Indicates endpoint maximum presentation delay.
+
+uint32_t PreferredMinimumDelay [ISO only]
+`````````````````````````````````````````
+
+	Indicates endpoint preferred minimum presentation delay.
+
+uint32_t PreferredMinimumDelay [ISO only]
+`````````````````````````````````````````
+
+	Indicates endpoint preferred minimum presentation delay.
+
+uint32 Location [ISO only]
+``````````````````````````
+
+	Indicates endpoint supported locations.
+
+uint16 SupportedContext [ISO only]
+``````````````````````````````````
+
+	Indicates endpoint supported audio context.
+
+uint16 Context [ISO only]
+`````````````````````````
+
+	Indicates endpoint available audio context.
+
+MediaTransport interface
+========================
+
+:Service:	org.bluez
+:Interface:	org.bluez.MediaTransport1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/fdX
+
+Methods
+-------
+
+fd, uint16, uint16 Acquire()
+````````````````````````````
+
+	Acquire transport file descriptor and the MTU for read and write
+	respectively.
+
+	Possible Errors:
+
+	:org.bluez.Error.NotAuthorized:
+	:org.bluez.Error.Failed:
+
+fd, uint16, uint16 TryAcquire()
+```````````````````````````````
+
+	Acquire transport file descriptor only if the transport is in "pending"
+	state at the time the message is received by BlueZ. Otherwise no request
+	will be sent to the remote device and the function will just fail with
+	org.bluez.Error.NotAvailable.
+
+	Possible Errors:
+
+	:org.bluez.Error.NotAuthorized:
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.NotAvailable:
+
+void Release()
+``````````````
+
+	Releases file descriptor.
+
+Properties
+----------
+
+object Device [readonly]
+````````````````````````
+
+	Device object which the transport is connected to.
+
+string UUID [readonly]
+``````````````````````
+
+	UUID of the profile which the transport is for.
+
+byte Codec [readonly]
+`````````````````````
+
+	Assigned number of codec that the transport support.
+	The values should match the profile specification which is indicated by
+	the UUID.
+
+array{byte} Configuration [readonly]
+````````````````````````````````````
+
+	Configuration blob, it is used as it is so the size and byte order must
+	match.
+
+string State [readonly]
+```````````````````````
+
+	Indicates the state of the transport. Possible values are:
+
+	:"idle": not streaming
+	:"pending": streaming but not acquired
+	:"active": streaming and acquired
+
+uint16 Delay [readwrite, optional]
+``````````````````````````````````
+
+	Transport delay in 1/10 of millisecond, this property is only writeable
+	when the transport was acquired by the sender.
+
+uint16 Volume [readwrite, optional]
+```````````````````````````````````
+
+	Indicates volume level of the transport, this property is only writeable
+	when the transport was acquired by the sender.
+
+	Possible Values: 0-127
+
+object Endpoint [readonly, optional, experimental]
+``````````````````````````````````````````````````
+
+	Endpoint object which the transport is associated with.
+
+uint32 Location [readonly, ISO only, experimental]
+``````````````````````````````````````````````````
+
+	Indicates transport Audio Location.
+
+array{byte} Metadata [readwrite, ISO Only, experimental]
+````````````````````````````````````````````````````````
+
+	Indicates transport Metadata.
+
+array{object} Links [readonly, optional, ISO only, experimental]
+````````````````````````````````````````````````````````````````
+
+	Linked transport objects which the transport is associated with.
+
+dict QoS [readonly, optional, ISO only, experimental]
+`````````````````````````````````````````````````````
+
+	Only present when QoS is configured.
+
+	Possible values for Unicast:
+
+	:byte CIG:
+
+		Indicates configured CIG.
+
+	:byte CIS:
+
+		Indicates configured CIS.
+
+	:uint32 Interval:
+
+		Indicates configured ISO interval.
+
+	:boolean Framing:
+
+		Indicates configured framing.
+
+	:byte PHY:
+
+		Indicates configured PHY.
+
+	:uint16 SDU:
+
+		Indicates configured SDU.
+
+	:byte Retransmissions:
+
+		Indicates configured retransmissions.
+
+	:uint16 Latency:
+
+		Indicates configured transport latency.
+
+	Possible values for Broadcast:
+
+	:byte BIG:
+
+		Indicates configured QoS BIG.
+
+	:byte BIS:
+
+		Indicates configured BIS.
+
+	:uint32 SyncFactor:
+
+		Indicates configured sync factor.
+
+	:uint32 Interval:
+
+		Indicates configured ISO interval.
+
+	:byte PHY:
+
+		Indicates configured PHY.
+
+	:uint16 SDU:
+
+		Indicates configured maximum SDU.
+
+	:byte SyncTimeout:
+
+		Indicates configured broadcast sync timeout.
+
+	:uint16 Latency:
+
+		Indicates configured transport latency.
diff --git a/doc/media-api.txt b/doc/media-api.txt
deleted file mode 100644
index cbcfac85c27b..000000000000
--- a/doc/media-api.txt
+++ /dev/null
@@ -1,889 +0,0 @@
-BlueZ D-Bus Media API description
-*********************************
-
-
-Media hierarchy
-===============
-
-Service		org.bluez
-Interface	org.bluez.Media1
-Object path	[variable prefix]/{hci0,hci1,...}
-
-Methods		void RegisterEndpoint(object endpoint, dict properties)
-
-			Register a local end point to sender, the sender can
-			register as many end points as it likes.
-
-			Note: If the sender disconnects the end points are
-			automatically unregistered.
-
-			possible properties:
-
-				string UUID:
-
-					UUID of the profile which the endpoint
-					is for.
-
-					UUID must be in the list of
-					SupportedUUIDS.
-
-				byte Codec:
-
-					Assigned number of codec that the
-					endpoint implements. The values should
-					match the profile specification which
-					is indicated by the UUID.
-
-				uint32_t Vendor [Optional]:
-
-					Vendor-specific Company ID, Codec ID
-					tuple that the endpoint implements.
-
-					It shall be set to appropriate value
-					when Vendor Specific Codec (0xff)
-					is used.
-
-				array{byte} Capabilities:
-
-					Capabilities blob, it is used as it is
-					so the size and byte order must match.
-
-				array{byte} Metadata [Optional]:
-
-					Metadata blob, it is used as it is
-					so the size and byte order must match.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NotSupported - emitted
-					 when interface for the end-point is
-					 disabled.
-
-		void UnregisterEndpoint(object endpoint)
-
-			Unregister sender end point.
-
-		void RegisterPlayer(object player, dict properties)
-
-			Register a media player object to sender, the sender
-			can register as many objects as it likes.
-
-			Object must implement at least
-			org.mpris.MediaPlayer2.Player as defined in MPRIS 2.2
-			spec:
-
-			http://specifications.freedesktop.org/mpris-spec/latest/
-
-			Note: If the sender disconnects its objects are
-			automatically unregistered.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NotSupported
-
-		void UnregisterPlayer(object player)
-
-			Unregister sender media player.
-
-		void RegisterApplication(object root, dict options)
-
-			Register endpoints an player objects within root
-			object which must implement ObjectManager.
-
-			The application object path together with the D-Bus
-			system bus connection ID define the identification of
-			the application.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.AlreadyExists
-
-		void UnregisterApplication(object application)
-
-			This unregisters the services that has been
-			previously registered. The object path parameter
-			must match the same value that has been used
-			on registration.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.DoesNotExist
-
-Properties	array{string} SupportedUUIDs [readonly]:
-
-			List of 128-bit UUIDs that represents the supported
-			Endpoint registration.
-
-Media Control hierarchy
-=======================
-
-Service		org.bluez
-Interface	org.bluez.MediaControl1
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-Methods		void Play() [Deprecated]
-
-			Resume playback.
-
-		void Pause() [Deprecated]
-
-			Pause playback.
-
-		void Stop() [Deprecated]
-
-			Stop playback.
-
-		void Next() [Deprecated]
-
-			Next item.
-
-		void Previous() [Deprecated]
-
-			Previous item.
-
-		void VolumeUp() [Deprecated]
-
-			Adjust remote volume one step up
-
-		void VolumeDown() [Deprecated]
-
-			Adjust remote volume one step down
-
-		void FastForward() [Deprecated]
-
-			Fast forward playback, this action is only stopped
-			when another method in this interface is called.
-
-		void Rewind() [Deprecated]
-
-			Rewind playback, this action is only stopped
-			when another method in this interface is called.
-
-Properties
-
-		boolean Connected [readonly]
-
-		object Player [readonly, optional]
-
-			Addressed Player object path.
-
-
-MediaPlayer1 hierarchy
-======================
-
-Service		org.bluez (Controller role)
-Interface	org.bluez.MediaPlayer1
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
-
-Methods		void Play()
-
-			Resume playback.
-
-			Possible Errors: org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-		void Pause()
-
-			Pause playback.
-
-			Possible Errors: org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-		void Stop()
-
-			Stop playback.
-
-			Possible Errors: org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-		void Next()
-
-			Next item.
-
-			Possible Errors: org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-		void Previous()
-
-			Previous item.
-
-			Possible Errors: org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-		void FastForward()
-
-			Fast forward playback, this action is only stopped
-			when another method in this interface is called.
-
-			Possible Errors: org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-		void Rewind()
-
-			Rewind playback, this action is only stopped
-			when another method in this interface is called.
-
-			Possible Errors: org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-		void Press(byte avc_key)
-
-			Press a specific key to send as passthrough command.
-			The key will be released automatically. Use Hold()
-			instead if the intention is to hold down the key.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-		void Hold(byte avc_key)
-
-			Press and hold a specific key to send as passthrough
-			command. It is your responsibility to make sure that
-			Release() is called after calling this method. The held
-			key will also be released when any other method in this
-			interface is called.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-		void Release()
-
-			Release the previously held key invoked using Hold().
-
-			Possible Errors: org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-Properties	string Equalizer [readwrite]
-
-			Possible values: "off" or "on"
-
-		string Repeat [readwrite]
-
-			Possible values: "off", "singletrack", "alltracks" or
-					"group"
-
-		string Shuffle [readwrite]
-
-			Possible values: "off", "alltracks" or "group"
-
-		string Scan [readwrite]
-
-			Possible values: "off", "alltracks" or "group"
-
-		string Status [readonly]
-
-			Possible status: "playing", "stopped", "paused",
-					"forward-seek", "reverse-seek"
-					or "error"
-
-		uint32 Position [readonly]
-
-			Playback position in milliseconds. Changing the
-			position may generate additional events that will be
-			sent to the remote device. When position is 0 it means
-			the track is starting and when it's greater than or
-			equal to track's duration the track has ended. Note
-			that even if duration is not available in metadata it's
-			possible to signal its end by setting position to the
-			maximum uint32 value.
-
-		dict Track [readonly]
-
-			Track metadata.
-
-			Possible values:
-
-				string Title:
-
-					Track title name
-
-				string Artist:
-
-					Track artist name
-
-				string Album:
-
-					Track album name
-
-				string Genre:
-
-					Track genre name
-
-				uint32 NumberOfTracks:
-
-					Number of tracks in total
-
-				uint32 TrackNumber:
-
-					Track number
-
-				uint32 Duration:
-
-					Track duration in milliseconds
-
-		object Device [readonly]
-
-			Device object path.
-
-		string Name [readonly]
-
-			Player name
-
-		string Type [readonly]
-
-			Player type
-
-			Possible values:
-
-				"Audio"
-				"Video"
-				"Audio Broadcasting"
-				"Video Broadcasting"
-
-		string Subtype [readonly]
-
-			Player subtype
-
-			Possible values:
-
-				"Audio Book"
-				"Podcast"
-
-		boolean Browsable [readonly]
-
-			If present indicates the player can be browsed using
-			MediaFolder interface.
-
-			Possible values:
-
-				True: Supported and active
-				False: Supported but inactive
-
-			Note: If supported but inactive clients can enable it
-			by using MediaFolder interface but it might interfere
-			in the playback of other players.
-
-
-		boolean Searchable [readonly]
-
-			If present indicates the player can be searched using
-			MediaFolder interface.
-
-			Possible values:
-
-				True: Supported and active
-				False: Supported but inactive
-
-			Note: If supported but inactive clients can enable it
-			by using MediaFolder interface but it might interfere
-			in the playback of other players.
-
-		object Playlist
-
-			Playlist object path.
-
-MediaFolder1 hierarchy
-======================
-
-Service		unique name (Target role)
-		org.bluez (Controller role)
-Interface	org.bluez.MediaFolder1
-Object path	freely definable (Target role)
-		[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
-		(Controller role)
-
-Methods		object Search(string value, dict filter)
-
-			Return a folder object containing the search result.
-
-			To list the items found use the folder object returned
-			and pass to ChangeFolder.
-
-			Possible Errors: org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-		array{objects, properties} ListItems(dict filter)
-
-			Return a list of items found
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-		void ChangeFolder(object folder)
-
-			Change current folder.
-
-			Note: By changing folder the items of previous folder
-			might be destroyed and have to be listed again, the
-			exception is NowPlaying folder which should be always
-			present while the player is active.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-Properties	uint32 NumberOfItems [readonly]
-
-			Number of items in the folder
-
-		string Name [readonly]
-
-			Folder name:
-
-			Possible values:
-				"/Filesystem/...": Filesystem scope
-				"/NowPlaying/...": NowPlaying scope
-
-			Note: /NowPlaying folder might not be listed if player
-			is stopped, folders created by Search are virtual so
-			once another Search is perform or the folder is
-			changed using ChangeFolder it will no longer be listed.
-
-Filters		uint32 Start:
-
-			Offset of the first item.
-
-			Default value: 0
-
-		uint32 End:
-
-			Offset of the last item.
-
-			Default value: NumbeOfItems
-
-		array{string} Attributes
-
-			Item properties that should be included in the list.
-
-			Possible Values:
-
-				"title", "artist", "album", "genre",
-				"number-of-tracks", "number", "duration"
-
-			Default Value: All
-
-MediaItem1 hierarchy
-====================
-
-Service		unique name (Target role)
-		org.bluez (Controller role)
-Interface	org.bluez.MediaItem1
-Object path	freely definable (Target role)
-		[variable
-		prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX/itemX
-		(Controller role)
-
-Methods		void Play()
-
-			Play item
-
-			Possible Errors: org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-		void AddtoNowPlaying()
-
-			Add item to now playing list
-
-			Possible Errors: org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-Properties	object Player [readonly]
-
-			Player object path the item belongs to
-
-		string Name [readonly]
-
-			Item displayable name
-
-		string Type [readonly]
-
-			Item type
-
-			Possible values: "video", "audio", "folder"
-
-		string FolderType [readonly, optional]
-
-			Folder type.
-
-			Possible values: "mixed", "titles", "albums", "artists"
-
-			Available if property Type is "Folder"
-
-		boolean Playable [readonly, optional]
-
-			Indicates if the item can be played
-
-			Available if property Type is "folder"
-
-		dict Metadata [readonly]
-
-			Item metadata.
-
-			Possible values:
-
-				string Title
-
-					Item title name
-
-					Available if property Type is "audio"
-					or "video"
-
-				string Artist
-
-					Item artist name
-
-					Available if property Type is "audio"
-					or "video"
-
-				string Album
-
-					Item album name
-
-					Available if property Type is "audio"
-					or "video"
-
-				string Genre
-
-					Item genre name
-
-					Available if property Type is "audio"
-					or "video"
-
-				uint32 NumberOfTracks
-
-					Item album number of tracks in total
-
-					Available if property Type is "audio"
-					or "video"
-
-				uint32 Number
-
-					Item album number
-
-					Available if property Type is "audio"
-					or "video"
-
-				uint32 Duration
-
-					Item duration in milliseconds
-
-					Available if property Type is "audio"
-					or "video"
-
-MediaEndpoint1 hierarchy
-========================
-
-Service		unique name (Server role)
-		org.bluez (Client role)
-Interface	org.bluez.MediaEndpoint1
-Object path	freely definable (Server role)
-		[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/sepX
-		(Client role)
-
-Methods		void SetConfiguration(object transport, dict properties)
-
-			Set configuration for the transport.
-
-			For client role transport must be set with a server
-			endpoint oject which will be configured and the
-			properties must contain the following properties:
-
-				array{byte} Capabilities [Mandatory]
-				array{byte} Metadata [ISO only]
-				byte CIG [ISO only]
-				byte CIS [ISO only]
-				uint32 Interval [ISO only]
-				bool Framing [ISO only]
-				string PHY [ISO only]
-				uint16 SDU [ISO only]
-				byte Retransmissions [ISO only]
-				uint16 Latency [ISO only]
-				uint32 Delay [ISO only]
-				uint8 TargetLatency [ISO Latency]
-				byte BIG [ISO broadcast only]
-				byte BIS [ISO broadcast only]
-				byte SyncInterval [ISO broadcast only]
-				byte Encryption [ISO broadcast only]
-				byte Options [ISO broadcast only]
-				uint16 Skip [ISO broadcast only]
-				uint16 SyncTimeout [ISO broadcast only]
-				byte SyncCteType [ISO broadcast only]
-				byte MSE [ISO broadcast only]
-				uint16 Timeout [ISO broadcast only]
-				array{byte} BroadcastCode [ISO broadcast only]
-
-		array{byte} SelectConfiguration(array{byte} capabilities)
-
-			Select preferable configuration from the supported
-			capabilities.
-
-			Returns a configuration which can be used to setup
-			a transport.
-
-			Note: There is no need to cache the selected
-			configuration since on success the configuration is
-			send back as parameter of SetConfiguration.
-
-		dict SelectProperties(dict properties)
-
-			Select preferable properties from the supported
-			properties:
-				object Endpoint [ISO only]
-				Refer to SetConfiguration for the list of
-					other possible properties.
-
-			Returns propeties which can be used to setup
-			a transport.
-
-			Note: There is no need to cache the selected
-			properties since on success the configuration is
-			send back as parameter of SetConfiguration.
-
-		void ClearConfiguration(object transport)
-
-			Clear transport configuration.
-
-		void Release()
-
-			This method gets called when the service daemon
-			unregisters the endpoint. An endpoint can use it to do
-			cleanup tasks. There is no need to unregister the
-			endpoint, because when this method gets called it has
-			already been unregistered.
-
-Properties	string UUID [readonly, optional]:
-
-			UUID of the profile which the endpoint is for.
-
-		byte Codec [readonly, optional]:
-
-			Assigned number of codec that the endpoint implements.
-			The values should match the profile specification which
-			is indicated by the UUID.
-
-		uint32_t Vendor [readonly, Optional]:
-
-			Vendor-specific Company ID, Codec ID tuple that the
-			endpoint implements.
-
-			It shall be set to appropriate value when Vendor
-			Specific Codec (0xff) is used.
-
-		array{byte} Capabilities [readonly, optional]:
-
-			Capabilities blob, it is used as it is so the size and
-			byte order must match.
-
-		array{byte} Metadata [readonly, Optional]:
-
-			Metadata blob, it is used as it is so the size and
-			byte order must match.
-
-		object Device [readonly, optional]:
-
-			Device object which the endpoint is belongs to.
-
-		bool DelayReporting [readonly, optional]:
-
-			Indicates if endpoint supports Delay Reporting.
-
-		byte Framing [ISO only]
-
-			Indicates endpoint support framing.
-
-		byte PHY [ISO only]
-
-			Indicates endpoint supported PHY.
-
-		uint16_t MaximumLatency [ISO only]
-
-			Indicates endpoint maximum latency.
-
-		uint32_t MinimumDelay [ISO only]
-
-			Indicates endpoint minimum presentation delay.
-
-		uint32_t MaximumDelay [ISO only]
-
-			Indicates endpoint maximum presentation delay.
-
-		uint32_t PreferredMinimumDelay [ISO only]
-
-			Indicates endpoint preferred minimum presentation delay.
-
-		uint32_t PreferredMinimumDelay [ISO only]
-
-			Indicates endpoint preferred minimum presentation delay.
-
-		uint32 Location [ISO only]
-
-			Indicates endpoint supported locations.
-
-		uint16 SupportedContext [ISO only]
-
-			Indicates endpoint supported audio context.
-
-		uint16 Context [ISO only]
-
-			Indicates endpoint available audio context.
-
-MediaTransport1 hierarchy
-=========================
-
-Service		org.bluez
-Interface	org.bluez.MediaTransport1
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/fdX
-
-Methods		fd, uint16, uint16 Acquire()
-
-			Acquire transport file descriptor and the MTU for read
-			and write respectively.
-
-			Possible Errors: org.bluez.Error.NotAuthorized
-					 org.bluez.Error.Failed
-
-		fd, uint16, uint16 TryAcquire()
-
-			Acquire transport file descriptor only if the transport
-			is in "pending" state at the time the message is
-			received by BlueZ. Otherwise no request will be sent
-			to the remote device and the function will just fail
-			with org.bluez.Error.NotAvailable.
-
-			Possible Errors: org.bluez.Error.NotAuthorized
-					 org.bluez.Error.Failed
-					 org.bluez.Error.NotAvailable
-
-		void Release()
-
-			Releases file descriptor.
-
-Properties	object Device [readonly]
-
-			Device object which the transport is connected to.
-
-		string UUID [readonly]
-
-			UUID of the profile which the transport is for.
-
-		byte Codec [readonly]
-
-			Assigned number of codec that the transport support.
-			The values should match the profile specification which
-			is indicated by the UUID.
-
-		array{byte} Configuration [readonly]
-
-			Configuration blob, it is used as it is so the size and
-			byte order must match.
-
-		string State [readonly]
-
-			Indicates the state of the transport. Possible
-			values are:
-				"idle": not streaming
-				"pending": streaming but not acquired
-				"active": streaming and acquired
-
-		uint16 Delay [readwrite]
-
-			Optional. Transport delay in 1/10 of millisecond, this
-			property is only writeable when the transport was
-			acquired by the sender.
-
-		uint16 Volume [readwrite]
-
-			Optional. Indicates volume level of the transport,
-			this property is only writeable when the transport was
-			acquired by the sender.
-
-			Possible Values: 0-127
-
-		object Endpoint [readonly, optional, experimental]
-
-			Endpoint object which the transport is associated
-			with.
-
-		uint32 Location [readonly, ISO only, experimental]
-
-			Indicates transport Audio Location.
-
-		array{byte} Metadata [ISO Only, experimental]
-
-			Indicates transport Metadata.
-
-		array{object} Links [readonly, optional, ISO only, experimental]
-
-			Linked transport objects which the transport is
-			associated with.
-
-		dict QoS [readonly, optional, ISO only, experimental]
-
-			Only present when QoS is configured.
-
-			Possible values for Unicast:
-
-			byte CIG
-
-				Indicates configured CIG.
-
-			byte CIS
-
-				Indicates configured CIS.
-
-			uint32 Interval
-
-				Indicates configured ISO interval.
-
-			boolean Framing
-
-				Indicates configured framing.
-
-			byte PHY
-
-				Indicates configured PHY.
-
-			uint16 SDU
-
-				Indicates configured SDU.
-
-			byte Retransmissions
-
-				Indicates configured retransmissions.
-
-			uint16 Latency
-
-				Indicates configured transport latency.
-
-			Possible values for Broadcast:
-
-			byte BIG
-
-				Indicates configured QoS BIG.
-
-			byte BIS
-
-				Indicates configured BIS.
-
-			uint32 SyncInterval
-
-				Indicates configured broadcast sync interval.
-
-			uint32 Interval
-
-				Indicates configured ISO interval.
-
-			byte PHY
-
-				Indicates configured PHY.
-
-			uint16 SDU
-
-				Indicates configured maximum SDU.
-
-			byte SyncTimeout
-
-				Indicates configured broadcast sync timeout.
-
-			uint16 Latency
-
-				Indicates configured transport latency.
diff --git a/test/example-player b/test/example-player
index 1497d1107a16..167460badcff 100644
--- a/test/example-player
+++ b/test/example-player
@@ -96,7 +96,7 @@ class Player(dbus.service.Object):
         """PropertiesChanged(interface, properties, invalidated)
 
         Send a PropertiesChanged signal. 'properties' is a dictionary
-        containing string parameters as specified in doc/media-api.txt.
+        containing string parameters as specified in doc/media-api.rst.
         """
         pass
 
diff --git a/test/simple-player b/test/simple-player
index 92682844d0f4..7bad3d14f848 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -78,7 +78,7 @@ class Player(dbus.service.Object):
 		"""PropertiesChanged(interface, properties, invalidated)
 
 		Send a PropertiesChanged signal. 'properties' is a dictionary
-		containing string parameters as specified in doc/media-api.txt.
+		containing string parameters as specified in doc/media-api.rst.
 		"""
 		pass
 
-- 
2.41.0

