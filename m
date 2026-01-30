Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com [209.85.221.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31BA2FE58C
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801988; cv=none; b=uG5X+jFCqsEmTDjb1h5KLTe24NTLR+JkzdiPtc64HnVr6KIhkIE8xF4JmwFQMK4ClS0jWwGUfJLVfgoCf878YDTIDW4O/gD+ex8LsXJgWVxUX67HJr2LjQgNS5VAd4972z+HiGIrgypXTTKlzdhwmh1jUwZ1jHgz5Dq5F2dwexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801988; c=relaxed/simple;
	bh=U12YggAc//1bv+uspaYqXIzKsHI1nWTvAPMCd2E7IwQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugLPmdSluTO8hnYgApDE+J8n9rwCeOqCwkAc9fiLhmCw06vIpSR/Lc5vdieiMKhGGBa0IV/q31qU4Rk16//TLAfasYfyM7evhS2ihHtBuPKuQSUlPZZowrU705Or6tXV/dXlyiQSD6xBvxbmEsLvOfJnLvvzgUTUuACRVb+WIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl55t+XU; arc=none smtp.client-ip=209.85.221.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl55t+XU"
Received: by mail-vk1-f193.google.com with SMTP id 71dfb90a1353d-56376c3e866so1776737e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801986; x=1770406786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhlgYY9r5KTZIeBhSzNDjcbZ4V0gtimcWaWiuie20Oo=;
        b=Pl55t+XU3T0f97Baqtlkby+dLmUvbYt8N/FpuQPnLYcRefy/ibUrP7Nv8/kEk0UQOF
         p56lc8y31Q7+CtEDV96DwELhfLYExeN3fQnyT2ZHBk8DO6IvLIgeWJYgiMq7maayF+nt
         kUveW8L3KBtd5BsyOgyvorxCdFPp0obnXMl1ZtNjfkFGNLlvwSOsV3cCNpMAy9/7a4M5
         Mu6zcg8Opeb+JEVdfihOtUDktz8EYHinsz+wM3VDnQFukCDa+Z61Qsr2OHFZmQCCgH0N
         8PvaIbSlhBuAWnaEoctzvds3REGBFuEq/hy6d4dg069/Xjkn7pqWVgLieE/aCElSbRhE
         8eJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801986; x=1770406786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jhlgYY9r5KTZIeBhSzNDjcbZ4V0gtimcWaWiuie20Oo=;
        b=uqm3zTraV101RqjBZMO5WWRrOaodQqszXjgJcdYn2fCqKjwgL9FaGXNZ7990JDUOxK
         dg5YdaH+sOdOEe3ISYiToXPifbp2XDfXIzaF+bf2dcvXFuku14yCfXp41aEc6NA7xp6+
         DXRzpUhFsct2gf3o+r+mteUfOnAcHSk9IaCkPng7xz7hXjJXfvwMj6us+lX/MSn9dhQJ
         eum6UUbkU35MCx0fDY7GZ0IX9T9Ksa/uYcZxb3270FSsqIZYMPDwvHgURIit1fSJIuOL
         Z3XIGeRiZfwjBGV1fRSfcp0K5fHCfRAH3EnMfiWCglOlbBQ+3DawlwukQGrlNMHUlf48
         IMzw==
X-Gm-Message-State: AOJu0YyHfdhnRCvhbZjoEb+uqgqJLIK1YOGUqRnrjdpKndK2cMQCqLP0
	Jnp71XEYChPyN3l5uqZz95z5fpA+wfTLgeiwx1lNaI45IzvQ0eWlPpBjXOTlu8P+
X-Gm-Gg: AZuq6aI8zacwYUbfdcX13kawhQ5oScD3usK19OEZxnXoAm+FhtNgIbQaYR09DLPzNvg
	ogX/aOconuvDNrpNTNMK+rqVyjTgiZ5GzYwL/tQIyX8g2H+YP1HH1v/i9gDlHfGnLG4MBjSZRhF
	/Xv/6qlsq3toIIOfUEVHPH2HNpRiMkrDo0Z+8jCjP+xXGtM6nJKaOEo/xipBCuZo6Dn6KVLS9pj
	HawvXc9hxrz5aJhDMPwMmT4sv+nWofvGz9eM8MKt+AUy4C5UtPZ4XM4AjV6iHcynPEwMJMC+jcy
	fZuQzQ8klgAR6KPkeSEz3kV/gw3c69tZ5xZSNmss/cz70oFUzAG5clZaMAocCywnGerGT7cMMKq
	f4SlwJquTSqpwTxYaGoCfk306QfpiWQzLGBnml5sJ/+2C24+Rn6PPPvZTdADdBHEAPG104o4f2f
	rgd8lHPCgEpYKOERupc4YRsm/1lf6kcqckIiD24BPXwx1Wg2KG2dlhKxxtbxucDgTI+CyfUI/vO
	0ft0g==
X-Received: by 2002:a05:6122:2212:b0:566:26ce:546e with SMTP id 71dfb90a1353d-566a0018ca0mr1379205e0c.5.1769801985624;
        Fri, 30 Jan 2026 11:39:45 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 15/35] doc/bluetoothctl-transport: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 14:38:57 -0500
Message-ID: <20260130193921.1273263-16-luiz.dentz@gmail.com>
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
 doc/bluetoothctl-transport.rst | 78 +++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/doc/bluetoothctl-transport.rst b/doc/bluetoothctl-transport.rst
index 77d8457a5d6f..7e3809e5ac18 100644
--- a/doc/bluetoothctl-transport.rst
+++ b/doc/bluetoothctl-transport.rst
@@ -18,6 +18,9 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [transport.commands]
 
+This submenu manages media transports for audio streaming using the
+**org.bluez.MediaTransport(5)** interface.
+
 Media Transport Commands
 =========================
 
@@ -28,12 +31,23 @@ List available transports.
 
 :Usage: **> list**
 
+:Example Display all available media transports (A2DP, LE Audio, etc.):
+	| **> list**
+
 show
 ----
 
 Show transport information.
 
 :Usage: **> show [transport]**
+:Uses: **org.bluez.MediaTransport(5)** properties
+:[transport]: Specific transport object path (optional, shows current if omitted)
+:Example Show information for currently selected transport:
+	| **> show**
+:Example Show transport information:
+	| **> show /org/bluez/hci0/dev_00_11_22_33_44_55/fd0**
+:Example Show Broadcast Isochronous Stream transport:
+	| **> show /org/bluez/hci0/dev_11_22_33_44_55_66/bis1**
 
 acquire
 -------
@@ -41,6 +55,13 @@ acquire
 Acquire transport.
 
 :Usage: **> acquire <transport> [transport1...]**
+:Uses: **org.bluez.MediaTransport(5)** method **Acquire**
+:<transport>: Media transport object path to acquire for audio streaming
+:[transport1...]: Additional transport paths for multi-stream acquisition (optional)
+:Example Acquire transport:
+	| **> acquire /org/bluez/hci0/dev_00_11_22_33_44_55/fd0**
+:Example Acquire multiple transports:
+	| **> acquire /org/bluez/hci0/dev_00_11_22_33_44_55/fd0 /org/bluez/hci0/dev_00_11_22_33_44_55/fd1**
 
 Note:
 
@@ -54,6 +75,13 @@ Select transport. For transports created on a Broadcast Sink device only. This m
 the transport to the "broadcasting" state, pending acquire.
 
 :Usage: **> select <transport> [transport1...]**
+:Uses: **org.bluez.MediaTransport(5)** method **Select**
+:<transport>: Broadcast sink transport path to move to broadcasting state
+:[transport1...]: Additional transport paths for multi-stream selection (optional)
+:Example Select single Broadcast Isochronous Stream:
+	| **> select /org/bluez/hci0/dev_00_11_22_33_44_55/bis1**
+:Example Select stereo broadcast streams:
+	| **> select /org/bluez/hci0/dev_00_11_22_33_44_55/bis1 /org/bluez/hci0/dev_00_11_22_33_44_55/bis2**
 
 Note:
 
@@ -77,6 +105,12 @@ was acquired by bluetoothctl it can be released straight away, without having to
 unselected.
 
 :Usage: **> unselect <transport> [transport1...]**
+:<transport>: Broadcast sink transport path to move to idle state
+:[transport1...]: Additional transport paths for multi-stream unselection (optional)
+:Example Unselect broadcast stream transport:
+	| **> unselect /org/bluez/hci0/dev_00_11_22_33_44_55/bis1**
+:Example Unselect multiple broadcast streams:
+	| **> unselect /org/bluez/hci0/dev_00_11_22_33_44_55/bis1 /org/bluez/hci0/dev_00_11_22_33_44_55/bis2**
 
 Note:
 If running the setup with an audio server that has LE Audio support (such as PipeWire), it will
@@ -88,6 +122,13 @@ release
 Release transport.
 
 :Usage: **> release <transport> [transport1...]**
+:Uses: **org.bluez.MediaTransport(5)** method **Release**
+:<transport>: Media transport object path to release from audio streaming
+:[transport1...]: Additional transport paths for multi-stream release (optional)
+:Example Release transport:
+	| **> release /org/bluez/hci0/dev_00_11_22_33_44_55/fd0**
+:Example Release multiple transports:
+	| **> release /org/bluez/hci0/dev_00_11_22_33_44_55/fd0 /org/bluez/hci0/dev_00_11_22_33_44_55/fd1**
 
 Note:
 
@@ -98,7 +139,14 @@ send
 
 Send contents of a file.
 
-:Usage: **> send <transport> <filename>**
+:Usage: **> send <transport> <filename> [transport1...]**
+:<transport>: Media transport object path to send audio data through
+:<filename>: Path to audio file to transmit (supports WAV, MP3, PCM formats)
+:[transport1...]: Additional transport paths for multi-stream sending (optional)
+:Example Send encoded audio file via transport:
+	| **> send /org/bluez/hci0/dev_00_11_22_33_44_55/fd0 /home/user/music.<format>**
+:Example Send to multiple transports simultaneously:
+	| **> send /org/bluez/hci0/dev_00_11_22_33_44_55/fd0 /home/user/stereo-left.<format> /org/bluez/hci0/dev_00_11_22_33_44_55/fd1 /home/user/stereo-rigth.<format>**
 
 receive
 -------
@@ -106,6 +154,14 @@ receive
 Get/Set file to receive.
 
 :Usage: **> receive <transport> [filename]**
+:<transport>: Media transport object path to receive audio data from
+:[filename]: Path to save received audio data (optional, shows current if omitted)
+:Example Show current receive file for transport:
+	| **> receive /org/bluez/hci0/dev_00_11_22_33_44_55/fd0**
+:Example Set file to receive audio data:
+	| **> receive /org/bluez/hci0/dev_00_11_22_33_44_55/fd0 /tmp/recorded_audio.wav**
+:Example Set file for broadcast audio capture (note quotes):
+	| **> receive /org/bluez/hci0/dev_11_22_33_44_55_66/bis1 "/home/user/My Recordings/broadcast.wav"**
 
 volume
 ------
@@ -113,6 +169,26 @@ volume
 Get/Set transport volume.
 
 :Usage: **> volume <transport> [value]**
+:Uses: **org.bluez.MediaTransport(5)** property **Volume**
+:<transport>: Media transport object path to control volume for
+:[value]: Volume level (0-127, optional, shows current if omitted)
+:Example Show current volume level:
+	| **> volume /org/bluez/hci0/dev_00_11_22_33_44_55/fd0**
+:Example Set volume to 100:
+	| **> volume /org/bluez/hci0/dev_00_11_22_33_44_55/fd0 100**
+
+metadata
+--------
+
+Get/Set Transport Metadata.
+
+:Usage: **> metadata <transport> [value...]**
+:<transport>: Media transport object path
+:[value...]: Metadata value as hex string (optional, shows current if omitted)
+:Example Show current metadata for transport:
+	| **> metadata /org/bluez/hci0/dev_00_11_22_33_44_55/fd0**
+:Example Set metadata value:
+	| **> metadata /org/bluez/hci0/dev_00_11_22_33_44_55/fd0 0x03020100**
 
 RESOURCES
 =========
-- 
2.52.0

