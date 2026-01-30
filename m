Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C8C301026
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801986; cv=none; b=qCDnaU+iP9PYW7cCSBkWVA32tKqlnItEtEu+GDkFa1df904D5lZJiUGxMAQLDLshgQinn7MV/CmDjUQVjHWeV2Maw4GKkI48Y/me8mu3XHpxkunNwMGUk7igETDQwOV1d07X6IP/pufq8V53L/NS2nmFzUjjcxNRg180YB+FWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801986; c=relaxed/simple;
	bh=0r2wsKNM5PBapatPF2vhBYVmuiX/XqJ8mELQ02dGqBY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VC23TATiUQzkTXVDr/geL3U9tRkmavAGnqfkx0VCUa+8MNxiXgWIcxN3L3bU5BAnywztjzmeAN9sYUZ/scduaLSo28aft0eYXu2BWWPTjqDGfglzt3rtwVmQtZ6KrwuFd46UbRqZPkFNdn4FtNxMV2VxMMzoNV1qhEd6nIPImX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMWp0v/4; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMWp0v/4"
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-566360cab07so799366e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801983; x=1770406783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rx/ocwfBYqh1py3VurJ3UfTU+HkUKbb6wfZRKvKqIBg=;
        b=KMWp0v/4eCP/4c/nKZny4ABhm/ujGgoKICXFWGSHv+SSy/01GuL4gOMTTGMBBAfzRf
         4dZzCs874FaG+xqD62WRglNohcniVzHbQPQoymBplaaFIoQZl0PaBf5T8j44QmaUrDlY
         SpNrbLOLxo+CZoakr3LXziNgF8oFlsYe2jAQDQawcURmDCBRAkIRr/ag0K37emO+KtNW
         cOnnByEKr0EmY7PAKoL+QpnwvOPwbv8MchpI8y7zFI8mDr35Cwa7rZ99TTCkoll52Ctx
         QUyuHb5U1zXgDIkT5g93zPOKMEZMMo4MEimQUTCMz+BF9IjB7SidsK8bSgWkglsdL/Js
         QwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801983; x=1770406783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rx/ocwfBYqh1py3VurJ3UfTU+HkUKbb6wfZRKvKqIBg=;
        b=QYFhF3HgKAnnHaYG+sE63gAEc9C4+JFYgyH0ZGJ/spwtrFPuAn41Qr5po9qzfxIL/+
         c+qUmMbwxHk+zsVOv02yZUba9LG2bmeQc6NYsktRsRC1rs++1dLAtB5/NvJDyva8+zMN
         mqCi61ga8WLohN5+zwq/f3HEUaRlxuzJRqDeSmZb0+Yi5wBVizX8NGw+jTT+rAFCqAZQ
         hxbpozXaATooxmKDVA+xQxBxdlR3RDQR9lIpXNdTvd2crTDly0KqMVQHC0KcZy1ei84A
         IHYb3lRa/+mOok5sHxbUaE0G+jH+r9DBgzzZo3tdDl7GfE9EhekdQDb1XMqRGxbHD7Mq
         ygOg==
X-Gm-Message-State: AOJu0Ywkw1KrqzNadzpH69UVa2BXUCXue12d2bO/uAXUpv65bEd/YRYj
	0cG3X577NrT3LEZmbNtO5ZcazNptMV/NWWzjJrByOVU5OVgzVG0dDCsFuezYf4jh
X-Gm-Gg: AZuq6aJkJWXoMff7s2s//nbnpP7W61jkfRJ5hIvtPZnK/PDplHbzzlme7wRGurK88kM
	zfyiZD01BLdlOc3MkdEZ4yY3bDkgM0+ZcTvpWsecW6/Imf0u1tx7TNkcLQBImbO9wk9ksSskSup
	MhEIXDVL7vbUc7NI0AeC77d518pQGpev3SdfksA/trIUJNUNQuRvGLvEuPKzTmBSxD37Cef8eQh
	j98o5Nph6ek1Jjq6v/EXKSUrtCrh6doEXjFMhkagmM2TH+VIx0YNB/QhElp9eVRVFceS03OHgMg
	hYI2RsR3exWFimDmNhWY71eUUu7nrlMAhXJhq6SkVzi1rY/fPz52L2PnSsOdIsHy+44gp4bp6Bm
	CiNMvLLr6XkTRunQzcF3XVSCOLjkelQYDaD0QvaP5BeaAVY6xRa7ZE5zxf6ZklDQMmUeYnvtZcS
	lr7vFI5+w6Na0Dosc+/CSaRVWrGijrYfGr9DaRGWd78/qqsz7dWwWvZn5EUtK9Yj+1+tiOz3yOB
	L56mot2ohDygso7
X-Received: by 2002:a05:6122:250f:b0:53c:6d68:1cce with SMTP id 71dfb90a1353d-566a0102407mr1287077e0c.16.1769801982732;
        Fri, 30 Jan 2026 11:39:42 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 12/35] doc/bluetoothctl-player: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 14:38:54 -0500
Message-ID: <20260130193921.1273263-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.
---
 doc/bluetoothctl-player.rst | 118 ++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/doc/bluetoothctl-player.rst b/doc/bluetoothctl-player.rst
index 1c5d436b31db..ccdd66663c67 100644
--- a/doc/bluetoothctl-player.rst
+++ b/doc/bluetoothctl-player.rst
@@ -18,6 +18,9 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [player.commands]
 
+This submenu controls media playback using the **org.bluez.MediaPlayer(5)**
+interface.
+
 Media Player Commands
 =====================
 
@@ -27,6 +30,8 @@ list
 List available players.
 
 :Usage: **> list**
+:Example Display all available media players (local and remote):
+	| **> list**
 
 show
 ----
@@ -34,6 +39,12 @@ show
 Show player information.
 
 :Usage: **> show [player]**
+:Uses: **org.bluez.MediaPlayer(5)** properties
+:[player]: Media player path or identifier (optional, shows currently selected player if omitted)
+:Example Show information for currently selected player:
+	| **> show**
+:Example Show remote player information:
+	| **> show /org/bluez/hci0/dev_00_11_22_33_44_55/player0**
 
 select
 ------
@@ -41,6 +52,9 @@ select
 Select default player.
 
 :Usage: **> select <player>**
+:<player>: Media player path or identifier to select as default
+:Example Select remote Bluetooth media player:
+	| **> select /org/bluez/hci0/dev_00_11_22_33_44_55/player0**
 
 play
 ----
@@ -48,6 +62,16 @@ play
 Start playback.
 
 :Usage: **> play [item]**
+:Uses: **org.bluez.MediaPlayer(5)** method **Play**
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
@@ -55,6 +79,9 @@ pause
 Pause playback.
 
 :Usage: **> pause**
+:Uses: **org.bluez.MediaPlayer(5)** method **Pause**
+:Example Pause current playback:
+	| **> pause**
 
 stop
 ----
@@ -62,6 +89,9 @@ stop
 Stop playback.
 
 :Usage: **> stop**
+:Uses: **org.bluez.MediaPlayer(5)** method **Stop**
+:Example Stop current playback:
+	| **> stop**
 
 next
 ----
@@ -69,6 +99,9 @@ next
 Jump to next item.
 
 :Usage: **> next**
+:Uses: **org.bluez.MediaPlayer(5)** method **Next**
+:Example Skip to next track:
+	| **> next**
 
 previous
 --------
@@ -76,6 +109,9 @@ previous
 Jump to previous item.
 
 :Usage: **> previous**
+:Uses: **org.bluez.MediaPlayer(5)** method **Previous**
+:Example Go back to previous track:
+	| **> previous**
 
 fast-forward
 ------------
@@ -83,6 +119,9 @@ fast-forward
 Fast forward playback.
 
 :Usage: **> fast-forward**
+:Uses: **org.bluez.MediaPlayer(5)** method **FastForward**
+:Example Enable fast forward mode:
+	| **> fast-forward**
 
 rewind
 ------
@@ -90,6 +129,9 @@ rewind
 Rewind playback.
 
 :Usage: **> rewind**
+:Uses: **org.bluez.MediaPlayer(5)** method **Rewind**
+:Example Enable rewind mode:
+	| **> rewind**
 
 equalizer
 ---------
@@ -97,6 +139,12 @@ equalizer
 Enable/Disable equalizer.
 
 :Usage: **> equalizer <on/off>**
+:Uses: **org.bluez.MediaPlayer(5)** property **Equalizer**
+:<on/off>: Enable (on) or disable (off) the equalizer
+:Example Enable equalizer:
+	| **> equalizer on**
+:Example Disable equalizer:
+	| **> equalizer off**
 
 repeat
 ------
@@ -104,6 +152,16 @@ repeat
 Set repeat mode.
 
 :Usage: **> repeat <singletrack/alltrack/group/off>**
+:Uses: **org.bluez.MediaPlayer(5)** property **Repeat**
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
@@ -111,6 +169,14 @@ shuffle
 Set shuffle mode.
 
 :Usage: **> shuffle <alltracks/group/off>**
+:Uses: **org.bluez.MediaPlayer(5)** property **Shuffle**
+:<alltracks/group/off>: Set shuffle mode - alltracks (shuffle all tracks), group (shuffle within current group), or off (no shuffle)
+:Example Disable shuffle mode:
+	| **> shuffle off**
+:Example Shuffle all tracks in playlist:
+	| **> shuffle alltracks**
+:Example Shuffle tracks within current group:
+	| **> shuffle group**
 
 scan
 ----
@@ -118,6 +184,14 @@ scan
 Set scan mode.
 
 :Usage: **> scan <alltracks/group/off>**
+:Uses: **org.bluez.MediaPlayer(5)** property **Scan**
+:<alltracks/group/off>: Set scan mode - alltracks (scan through all tracks), group (scan within current group), or off (no scan)
+:Example Disable scan mode:
+	| **> scan off**
+:Example Scan through all tracks:
+	| **> scan alltracks**
+:Example Scan through current group only:
+	| **> scan group**
 
 change-folder
 -------------
@@ -125,6 +199,15 @@ change-folder
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
@@ -132,6 +215,18 @@ list-items
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
@@ -139,6 +234,15 @@ search
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
@@ -146,6 +250,13 @@ queue
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
@@ -153,6 +264,13 @@ show-item
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

