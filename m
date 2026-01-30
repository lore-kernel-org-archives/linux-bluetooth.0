Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com [209.85.221.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8622EB5CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810581; cv=none; b=iLvlItJr1Ldz0qcE7uH1ffa9/OQNzjIwZgFvTbqtvlSFjtMLwMU9u58zORJeNd0AZKVWZSCwZDePFLtFQf/HbaCqNtdxKeZuEjH2jQiNwYiW6P6rCM6MRyd4sogXCqgzLHkoyCzBuOd0mnOhrTNkdOjnpKs6M1J92SdLXbmHmHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810581; c=relaxed/simple;
	bh=U12YggAc//1bv+uspaYqXIzKsHI1nWTvAPMCd2E7IwQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1VAmX3aQe7Z+Qb2QF7CGttuUEvXuLWotV5Bxo+zPfONILojtN14VmAr1T8tCCHZhoE4jkcfOR8+hMVm8ej/+yCiP6WMLIPMe7QBHzqWUiM7TSRi73L0COfv+zxxu+/Rqdv+NC8SGBCK8DKrvmzGViObV5Vzr7xK9V6XAfXBOkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuYKpmqr; arc=none smtp.client-ip=209.85.221.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuYKpmqr"
Received: by mail-vk1-f194.google.com with SMTP id 71dfb90a1353d-56637ab30b8so2207022e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810579; x=1770415379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhlgYY9r5KTZIeBhSzNDjcbZ4V0gtimcWaWiuie20Oo=;
        b=YuYKpmqrV2Dom48w+BjNVEubxkcwC3V6Df5fwfvDacAvYxAVd0J3PPhNLQMTEmVXQg
         Km9OlZzGgAIucBNfJxP9ymNGFrk0gfNb9MYDAy4aQ82cw19rgxlXo91ng6H411iAYw/c
         xAP8aGinwuAH4yjLo8v9+HZta1LDLdEfnuc4UKuKRf2FUukwf5Si2zbhCcFcoVXgQRKI
         d3ZZNLQq2fsgQYQXJ0pe3TmdJ1K8BkedM8dlee2akGTaGN3bKHK41tK39aWDo/2reAl2
         aezy7n3IApofNFGo7qFllcxecEQu7V71lMW1qny1cnF144mERunevuxW5AZsLI6GPg4t
         ShvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810579; x=1770415379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jhlgYY9r5KTZIeBhSzNDjcbZ4V0gtimcWaWiuie20Oo=;
        b=OEl66iqcWP9/SWz9zC57uyK8bu3sQqyDUmxisTLFAGBiyfEjzwOysyyzqS4dOE7Waf
         c5Q3oOfnT/5b7uV0zsKQ7Cu/reimrbYtNY8LHaqEqoP1W52N+m52s50DAj1wb4Q9nTD5
         TSa9znK1tCwdvg9arHImJdfYW7wzaa9Vubi2HuroRobOoGwrLP5Acxhuv1YdwVNliqjN
         amrmjanxa5//ql8ExH6EVUM1PRDH/jdvnZXEh07oRe8wWxQDoCUwYakpSoc5BjsWrNQc
         0npYvXUEZj8F03hhps5PSxVAlAa1QQkK9WbAxIvehcPTHTTPiYQCt/toWuzXblhoiPh3
         /K6g==
X-Gm-Message-State: AOJu0YwG3TxLF08FSXcX5TyxJKV+9zejcQJE1K0//OfTPgagQqlqY4OP
	1t/ANhfvBobDIaVCHNuRJNK1uQ71MADoJv/FuBz80s1643G+l3g+ceH+CTId8e43
X-Gm-Gg: AZuq6aLOB/FILvf6LYQkzWC6Kmm5sk35jO9kJlp+tuYMGle8+CJC0lMpFe3GW9sRSay
	lIZc7dJVdEmQCnNmMBxZO9G/WgjHt9haeK2JO3a7JXXf1YgkTQp8+nRltUHkhaQVtv5q0+jslcc
	GserhsCpz44V5PLNWQw0a/kyVqjaB/Hhrp3UQUgqwxgMB/2BV1DsRKsiUCJjebHFzL3t6Nxc1qr
	31MwHyw29FzpcsZ/U9xUMBUIYA+QPbmnxLP2oi26U6RO5kTbYRsE8YNZQixteg9PmnSvfRx7t+I
	QkoNMPM/DjxReRFOnF8XvUBxPNIz3N/8fGMbc9YluRZL74j8lS22cF1WsppmOP+kLFBmntGVZ6Z
	p8wdAV5Y3JfH+Wlr+SP9GPFbsF8R3SrBA4/9UWl/3XppGkagJX1ipIrGOSjKAnfYDf0euZhoBft
	NrLP/NkhtjdGlNDqdRhKnBx/qfLQM0D47QtKPjbpjGXg/Td5XJq5qsAP5Dz0Rr9rBqAAQvTETOd
	R14FA==
X-Received: by 2002:a05:6102:440b:b0:5ef:a416:be63 with SMTP id ada2fe7eead31-5f8cdc8e1famr2858846137.22.1769810578732;
        Fri, 30 Jan 2026 14:02:58 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.02.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:02:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 15/37] doc/bluetoothctl-transport: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 17:02:06 -0500
Message-ID: <20260130220229.1346261-16-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
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

