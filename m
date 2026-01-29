Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com [209.85.217.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485353446C0
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728956; cv=none; b=KHcD90HfGZlyhz5H6xIiB58fg+ZvIvK/zCKKZOgrEjMNXTcfbeV8xHWtvDjspTrDmCSdIkx4Y3qYJUnjTsBoZdUYNSTItYEx8lo+s2ytlkfPQ875K0UTdRqfKusdF/dmU5cgeXQ9EJdAJPSKJ2dDC2wclJNyHwXX5HZ17wFd4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728956; c=relaxed/simple;
	bh=F+7KcWOkQG1yZ+JYolgMj9hCEJTnxPRbZIeEUcWNCnM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh/JQN3fkR2wBOilH8xYp55CdfbEnCpq0flRie4QSxvlQ/dSQSITHk+UgsvYvZ1zk79LRVFmEJvfeqTLTOFr+sXVlhJncIsjxZO30dFfe/zDCr+ybuvAGMgobG3KT8xYFK0ZXfNUgWT3dFYuEOwvCeK+EsUyo+F2CoELIxFFz/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUh6Efdd; arc=none smtp.client-ip=209.85.217.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUh6Efdd"
Received: by mail-vs1-f66.google.com with SMTP id ada2fe7eead31-5f548b7ab61so910681137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769728954; x=1770333754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdcJDDL+us0yQfwzA9PMVwUC8EV33x7Xl18e6GRtDHs=;
        b=XUh6EfddxgsYqt9qBREkZ5m6GsS6nmy3ZOW+zmuVnLarfX5bytkrQwg3LKdOMIoNXm
         Ioo3IqhaF+XDiT0XOzztp1ZfBLLvOlUBnkpTAsVxQalg4CNIrcbK4agpV3Ha5uSN0G6L
         HyYRwQl9E8SKulaapqtrtbLV14G6F6l4KvVe6nXIAy2KnTObVsZEZU3zKX+vlknd2A9G
         rcS+9dOrHGbLW6VsyuRsoUR0ruHVusS0099m61oIXP6zdMTe+E5xVpQLjqo/w1/NA+Xs
         dn2RBOZnBE0Ks9IWxDbGTlGvV4i4TBPbsG4dzfMq36It8hqYNwvPrUNKp/jQ1rGTTre9
         eZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728954; x=1770333754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MdcJDDL+us0yQfwzA9PMVwUC8EV33x7Xl18e6GRtDHs=;
        b=n1jbztB3pu4mOCk/r0UxH+jrwl1aN7gvC1yUzsLNaNZNX1XukEdx+W22F1uDh+PksX
         rTlSxd6dpTPTta6NQVfIMaGaMGPV79tfy7O0hSdNMN1mgqcqg4b4MZFLuXv2j+GeJa9g
         RFIIsGM4Rkc2wPlw7JMv6RLQRxZJBZA7oI18anCPBo7XBDQ39WD28o8f6ne8+xxjBQeD
         HTvTXsbW+b/qnXxjEveI6C+8Qz1KUXEVorkFpY6zkUHWBqHX5zoDdHI8hsiYNdlB1RaU
         25Omoq6C/3QxBZvO0EoL6qd48ymivOyt2CkS6DpHCq7wa3LjzFaLxewekZTMbkQpxbNu
         D0VA==
X-Gm-Message-State: AOJu0Yz+q+TGijY+rCuXkd+7sbCb1ta/Ihxevf+7ZDUgBoEA905mVuci
	dTrCgVHPb/W0PPF8IagbofuVebAbEiYbxVkcW7z36/dmVm3z2zOy1Hq6Ftb+WMNUavs=
X-Gm-Gg: AZuq6aIoppMTi15/LkUUeahUfwSKm4Q/zCkMDNoPii9C4UWmNcV0xQePahw9yzw2J1g
	1cBhbPhUQKTArIsbBmZ0gbSQqlt10+lJicWVp6mfB1PNTVEx//qqUE047UKkO4IxPGhi1f4tJwm
	Mte4HLvG1icvQM2DvqXS+SwrsGVcj6+nOF7UPplSCE+9F0ux+z2tw5TYpsuPDh7i/M3KU49YpBh
	nQ07sUHtPQoXVmsVydDkO0/NQ/cvQMDNP+wkR7GyvjRoyOzV3DhMoyqUBvz5RJcY+w1rAkZkKzg
	yyCMaxy1uqOQ8EnaKTyD8H0zqJ7p4h2tvqAKx7Zs1r8Aakrfn19Ad8epvQA5wD6iXCfKZRjNNEv
	bMkCIPTFjuioXxLJQ3QogxIMtYGVAc/rYqyT5gzYwVMtYnFLO5dkGdhWkxnoByhGvNDeWYdOMsl
	Xb/cvl5juXXPqIeoB0WOnx6rpz6hQeAfmWOM8LGIFjKBRnnQZ2Sv0dHyBWzU0cAjEJiEvB2B/G+
	Tev3ccZYiYVAAlV
X-Received: by 2002:a05:6102:32d1:b0:5ed:8e3:b66a with SMTP id ada2fe7eead31-5f8e25b1b6amr437941137.28.1769728953902;
        Thu, 29 Jan 2026 15:22:33 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948724cb7casm1535890241.9.2026.01.29.15.22.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:22:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 15/15] doc/bluetoothctl-transport: Document arguments and add examples
Date: Thu, 29 Jan 2026 18:21:54 -0500
Message-ID: <20260129232201.1049568-15-luiz.dentz@gmail.com>
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

Add parameter documentation for all transport commands including show,
acquire, release, send, receive, volume, select and unselect. Documents
transport object paths, file parameters and volume settings for
media transport operations.
---
 doc/bluetoothctl-transport.rst | 70 +++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/doc/bluetoothctl-transport.rst b/doc/bluetoothctl-transport.rst
index 77d8457a5d6f..d8c996822472 100644
--- a/doc/bluetoothctl-transport.rst
+++ b/doc/bluetoothctl-transport.rst
@@ -28,12 +28,22 @@ List available transports.
 
 :Usage: **> list**
 
+:Example Display all available media transports (A2DP, LE Audio, etc.):
+	| **> list**
+
 show
 ----
 
 Show transport information.
 
 :Usage: **> show [transport]**
+:[transport]: Specific transport object path (optional, shows current if omitted)
+:Example Show information for currently selected transport:
+	| **> show**
+:Example Show transport information:
+	| **> show /org/bluez/hci0/dev_00_11_22_33_44_55/fd0**
+:Example Show Broadcast Isochronous Stream transport:
+	| **> show /org/bluez/hci0/dev_11_22_33_44_55_66/bis1**
 
 acquire
 -------
@@ -41,6 +51,12 @@ acquire
 Acquire transport.
 
 :Usage: **> acquire <transport> [transport1...]**
+:<transport>: Media transport object path to acquire for audio streaming
+:[transport1...]: Additional transport paths for multi-stream acquisition (optional)
+:Example Acquire transport:
+	| **> acquire /org/bluez/hci0/dev_00_11_22_33_44_55/fd0**
+:Example Acquire multiple transports:
+	| **> acquire /org/bluez/hci0/dev_00_11_22_33_44_55/fd0 /org/bluez/hci0/dev_00_11_22_33_44_55/fd1**
 
 Note:
 
@@ -54,6 +70,12 @@ Select transport. For transports created on a Broadcast Sink device only. This m
 the transport to the "broadcasting" state, pending acquire.
 
 :Usage: **> select <transport> [transport1...]**
+:<transport>: Broadcast sink transport path to move to broadcasting state
+:[transport1...]: Additional transport paths for multi-stream selection (optional)
+:Example Select single Broadcast Isochronous Stream:
+	| **> select /org/bluez/hci0/dev_00_11_22_33_44_55/bis1**
+:Example Select stereo broadcast streams:
+	| **> select /org/bluez/hci0/dev_00_11_22_33_44_55/bis1 /org/bluez/hci0/dev_00_11_22_33_44_55/bis2**
 
 Note:
 
@@ -77,6 +99,12 @@ was acquired by bluetoothctl it can be released straight away, without having to
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
@@ -88,6 +116,12 @@ release
 Release transport.
 
 :Usage: **> release <transport> [transport1...]**
+:<transport>: Media transport object path to release from audio streaming
+:[transport1...]: Additional transport paths for multi-stream release (optional)
+:Example Release transport:
+	| **> release /org/bluez/hci0/dev_00_11_22_33_44_55/fd0**
+:Example Release multiple transports:
+	| **> release /org/bluez/hci0/dev_00_11_22_33_44_55/fd0 /org/bluez/hci0/dev_00_11_22_33_44_55/fd1**
 
 Note:
 
@@ -98,7 +132,14 @@ send
 
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
@@ -106,6 +147,14 @@ receive
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
@@ -113,6 +162,25 @@ volume
 Get/Set transport volume.
 
 :Usage: **> volume <transport> [value]**
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

