Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com [209.85.217.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0B2FE575
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728952; cv=none; b=cAs84ByKDcHTL8qxGumKQOi3qkaUrDrPZ29sxA0wWEaFHbnFWl6ZSo8MjnMPpP7tCx4kQHOByJuGohwhJDUWU1tYzKQZ4rAp6TE7vD5IRZq5zTg5Ws99sGjCCs0E4CS4TUDuI5OvIripMuhuVs/lspB7igsaM5BE+oQcvLdQVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728952; c=relaxed/simple;
	bh=lEDooOqHTJOCA6yGQ/NlIgDKloA4Nc8WfMfTtjUcl2Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1qLAiVvDOYAwMIYS4QUO9/mcpxaR2na/PGLYkfO2akiKp2E/ti+iniuWUPDO/sZ5FJNBaoyzFltZKLhlah5VKwqyd1Izcyw9PYc3sn1JTHT01+cHHKHx2yo0xyKjLHehswq/lBdxHlUIwbZnXGxZ/6AyjKuiH4+D9ib5eKulL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHHj4alB; arc=none smtp.client-ip=209.85.217.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHHj4alB"
Received: by mail-vs1-f65.google.com with SMTP id ada2fe7eead31-5ed065f1007so1001247137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769728949; x=1770333749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZ1jgYDk9c/OTg16yuRr92kG3tr0tFWRqorLhULVMEg=;
        b=MHHj4alB9bz+mKO92SpOKTJo60EFOBICs7+OPw4QBeUlWMYOOYrw+uodhrJSmiCEbK
         GABnyAEf6ZpWiiC3u2C0a2WOe40SM2GfwnNkC31LCFxoyGaj6mppugxdJavAyuMBvoB5
         O/nOwZ+RHzJL42Yf8NVyCyIYNIlzz4qUO7H0ofwdrlt9Bypa0Ag8dBu2g+g1C6eCWfWW
         tVv7vsWBvf/QHD0POg4UYxdpIWI6vUM3oKmwzEHJcIPCS3rK4KZdiYBJ+MOecUkcOF62
         +p0lGFdSCEhRxzzcQYrD6nXONyigf8C8Pa1luj9bgy2N6xMActJMS7lKMZye7GihsbmF
         EYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728949; x=1770333749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oZ1jgYDk9c/OTg16yuRr92kG3tr0tFWRqorLhULVMEg=;
        b=Z4gAZEo9GufDlT3Tr/BgEV2p1Qhx1O8Yt9xCKx7PeDEExZN2zDoeGH+LojMyT3+iC3
         w8sSKv8Ji8aDjMJ6NOuLMJP0rAPFA38dULwQxnbBt/6c49qWTUge8Px5jUkolMFEHbbD
         uDAs5pber3bw42cmGlAXtXbFb6mTjNJyyRzqQqF20A0yL4SGBuxIwjySLtviLZBOmOHM
         Qt8Koi6XuEctdrZJDRcxfDYCe4+p+Flka+EFB6tGo+twyPL7+ApPQi2KyEqX2ZWCFhxf
         7DpmDCMOXuX5Ny/YcdlkmZjb6Kes/iZ7o05bZadLTt5bDavH2z2iVappGLyRY+ZZgE92
         00sg==
X-Gm-Message-State: AOJu0Yxn/8i9KhRqzPBQ8jVUfN6GGbuJoHNQRDnQu1Rphkkh9JIUgP/0
	D3NaEQHfH6C78bb6zxo72XrFBNtDwMgXpoQXWSvM6R75TLUpi3Z1k/d47e8udxsgtYE=
X-Gm-Gg: AZuq6aKJ51koVq69FIHld14nW3Q8ZiErMeLm7VtcRBi/pTRIXaJkuoPoKeXCY+esDJU
	78BYxmJSWYZ3706VH0T/37X531pEMcG1zk9BG/lf8FDY7ZWMeG5zaGoxFGJ/whH+M6eIiJCnt8m
	qdXpVGqIo4KuItbJsawsnJEl71LquH9VA9eYy+2+HY/UMNZRijFebart2NmuHQvwbrObsQ/O6u4
	Q1vUeaJ/49ku6XCyPIA8ORrKpMvMLYkG2oGKGjMEBcEmpsISnJQ3fdySgPs0OV0zrfO/9ITeXHw
	yLWxFPkQN5lzVSK+ESyxBUhQBU5doDvzvh1GSXQcUDjKEq0I4W/MdZviYo60RpGeM5GMHuWVSyX
	LrykfxohqBoHrgjAHofjTRLgwJzhfvpzEswSE3O/UxREVNZaQSqN98TtUSRk7UDJjxpWPmJa58W
	5sJhd5Pkzsemz7m4bDVno2Zbm4vNNvvvAvwAcZkWFOewzvQy3Lgc0Mh1gl8K3oL48LbugX+yRNy
	T0g8A==
X-Received: by 2002:a05:6102:cc7:b0:5df:b2cd:12c9 with SMTP id ada2fe7eead31-5f8e2620183mr388401137.40.1769728949056;
        Thu, 29 Jan 2026 15:22:29 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948724cb7casm1535890241.9.2026.01.29.15.22.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:22:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 12/15] doc/bluetoothctl-player: Document arguments and add examples
Date: Thu, 29 Jan 2026 18:21:51 -0500
Message-ID: <20260129232201.1049568-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129232201.1049568-1-luiz.dentz@gmail.com>
References: <20260129232201.1049568-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add comprehensive parameter documentation for all media player commands
including show, select, play, equalizer, repeat, shuffle, scan, search,
queue and folder navigation. Documents player paths, item selection
and media control parameters.
---
 doc/bluetoothctl-player.rst | 103 ++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/doc/bluetoothctl-player.rst b/doc/bluetoothctl-player.rst
index 1c5d436b31db..cd454bc5a8e2 100644
--- a/doc/bluetoothctl-player.rst
+++ b/doc/bluetoothctl-player.rst
@@ -27,6 +27,8 @@ list
 List available players.
 
 :Usage: **> list**
+:Example Display all available media players (local and remote):
+	| **> list**
 
 show
 ----
@@ -34,6 +36,11 @@ show
 Show player information.
 
 :Usage: **> show [player]**
+:[player]: Media player path or identifier (optional, shows currently selected player if omitted)
+:Example Show information for currently selected player:
+	| **> show**
+:Example Show remote player information:
+	| **> show /org/bluez/hci0/dev_00_11_22_33_44_55/player0**
 
 select
 ------
@@ -41,6 +48,9 @@ select
 Select default player.
 
 :Usage: **> select <player>**
+:<player>: Media player path or identifier to select as default
+:Example Select remote Bluetooth media player:
+	| **> select /org/bluez/hci0/dev_00_11_22_33_44_55/player0**
 
 play
 ----
@@ -48,6 +58,15 @@ play
 Start playback.
 
 :Usage: **> play [item]**
+:[item]: Media item path to play (optional, starts playback of current item if omitted)
+:Example Start playback on current player:
+	| **> play**
+:Example Play specific item from media browser:
+	| **> play /org/bluez/item/1**
+:Example Play named track item:
+	| **> play /org/bluez/item/track_001**
+:Example Play track from specific album folder:
+	| **> play /org/bluez/item/album_rock/track_05**
 
 pause
 -----
@@ -55,6 +74,8 @@ pause
 Pause playback.
 
 :Usage: **> pause**
+:Example Pause current playback:
+	| **> pause**
 
 stop
 ----
@@ -62,6 +83,8 @@ stop
 Stop playback.
 
 :Usage: **> stop**
+:Example Stop current playback:
+	| **> stop**
 
 next
 ----
@@ -69,6 +92,8 @@ next
 Jump to next item.
 
 :Usage: **> next**
+:Example Skip to next track:
+	| **> next**
 
 previous
 --------
@@ -76,6 +101,8 @@ previous
 Jump to previous item.
 
 :Usage: **> previous**
+:Example Go back to previous track:
+	| **> previous**
 
 fast-forward
 ------------
@@ -83,6 +110,8 @@ fast-forward
 Fast forward playback.
 
 :Usage: **> fast-forward**
+:Example Enable fast forward mode:
+	| **> fast-forward**
 
 rewind
 ------
@@ -90,6 +119,8 @@ rewind
 Rewind playback.
 
 :Usage: **> rewind**
+:Example Enable rewind mode:
+	| **> rewind**
 
 equalizer
 ---------
@@ -97,6 +128,11 @@ equalizer
 Enable/Disable equalizer.
 
 :Usage: **> equalizer <on/off>**
+:<on/off>: Enable (on) or disable (off) the equalizer
+:Example Enable equalizer:
+	| **> equalizer on**
+:Example Disable equalizer:
+	| **> equalizer off**
 
 repeat
 ------
@@ -104,6 +140,15 @@ repeat
 Set repeat mode.
 
 :Usage: **> repeat <singletrack/alltrack/group/off>**
+:<singletrack/alltrack/group/off>: Set repeat mode - singletrack (current track), alltrack (all tracks), group (current group/album), or off (no repeat)
+:Example Disable repeat mode:
+	| **> repeat off**
+:Example Repeat current track:
+	| **> repeat singletrack**
+:Example Repeat entire playlist/queue:
+	| **> repeat alltrack**
+:Example Repeat current group/album:
+	| **> repeat group**
 
 shuffle
 -------
@@ -111,6 +156,13 @@ shuffle
 Set shuffle mode.
 
 :Usage: **> shuffle <alltracks/group/off>**
+:<alltracks/group/off>: Set shuffle mode - alltracks (shuffle all tracks), group (shuffle within current group), or off (no shuffle)
+:Example Disable shuffle mode:
+	| **> shuffle off**
+:Example Shuffle all tracks in playlist:
+	| **> shuffle alltracks**
+:Example Shuffle tracks within current group:
+	| **> shuffle group**
 
 scan
 ----
@@ -118,6 +170,13 @@ scan
 Set scan mode.
 
 :Usage: **> scan <alltracks/group/off>**
+:<alltracks/group/off>: Set scan mode - alltracks (scan through all tracks), group (scan within current group), or off (no scan)
+:Example Disable scan mode:
+	| **> scan off**
+:Example Scan through all tracks:
+	| **> scan alltracks**
+:Example Scan through current group only:
+	| **> scan group**
 
 change-folder
 -------------
@@ -125,6 +184,15 @@ change-folder
 Change current folder.
 
 :Usage: **> change-folder <item>**
+:<item>: Folder path to navigate to, or ".." to go up one directory level
+:Example Navigate to Albums folder:
+	| **> change-folder /org/bluez/item/Albums**
+:Example Navigate to Artists folder:
+	| **> change-folder /org/bluez/item/Artists**
+:Example Navigate to Playlists folder:
+	| **> change-folder /org/bluez/item/Playlists**
+:Example Go up one directory level:
+	| **> change-folder ..**
 
 list-items
 ----------
@@ -132,6 +200,18 @@ list-items
 List items of current folder.
 
 :Usage: **> list-items [start] [end]**
+:[start]: Starting index for item list (optional, defaults to 0)
+:[end]: Ending index for item list (optional, lists all items from start if omitted)
+:Example List all items in current folder:
+	| **> list-items**
+:Example List first 10 items (0-10):
+	| **> list-items 0 10**
+:Example List items 5 through 15:
+	| **> list-items 5 15**
+:Example List items 10 through 20:
+	| **> list-items 10 20**
+:Example List first 50 items:
+	| **> list-items 0 50**
 
 search
 ------
@@ -139,6 +219,15 @@ search
 Search items containing string.
 
 :Usage: **> search <string>**
+:<string>: Search term to find matching items (songs, albums, artists, etc.)
+:Example Search for Beatles songs/albums:
+	| **> search "The Beatles"**
+:Example Search for items containing "rock":
+	| **> search "rock"**
+:Example Search for items from 2023:
+	| **> search "2023"**
+:Example Search for playlists:
+	| **> search "playlist"**
 
 queue
 -----
@@ -146,6 +235,13 @@ queue
 Add item to playlist queue.
 
 :Usage: **> queue <item>**
+:<item>: Media item path to add to the playback queue
+:Example Add specific track to queue:
+	| **> queue /org/bluez/item/track_001**
+:Example Add entire album to queue:
+	| **> queue /org/bluez/item/album_rock**
+:Example Add playlist to queue:
+	| **> queue /org/bluez/item/playlist_favorites**
 
 show-item
 ---------
@@ -153,6 +249,13 @@ show-item
 Show item information.
 
 :Usage: **> show-item <item>**
+:<item>: Media item path to display detailed information for
+:Example Show details of specific track:
+	| **> show-item /org/bluez/item/track_001**
+:Example Show details of album:
+	| **> show-item /org/bluez/item/album_rock**
+:Example Show details of artist:
+	| **> show-item /org/bluez/item/artist_beatles**
 
 RESOURCES
 =========
-- 
2.52.0

