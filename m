Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0A83542E1
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810602; cv=none; b=ppi7cD/t8JpRNNRjNhh5RF+Xi57XUa+2qS5FY9nq+x94+LWfFMe2sw7fSNTsGuRlS70qS/AIXQ4T6jykF5sVcFyJXFu3v+FsTZyFRkMyCwMEI1T6nSH3yezxqK+wIYosUDJU+JeNqDBsPHBlqBV7BVXa3Gehc8464kResXwpfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810602; c=relaxed/simple;
	bh=alrDjDXdWGyrfY4U1CSRpYaHfKt91PVLuRYm3RrVq6k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kN9p75XuTgn4kpye88ax4o/RmcugMquedlpKV9WxOia+zYKWuAVZiu05X1KNyVFOWD9a2YxkgPudAdLKiG2BCSLrdDWJ//8Vg8JjcPUMbi5opRbxhKbvESvbC9DpkM2kn2IMfAfLw6j8wKUJz0WVpM9PIwi2Qy3qf4c1kRezAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fby12EcN; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fby12EcN"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-563497c549cso1435005e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810600; x=1770415400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NBUMxmmdn2a24HGvGfJdHYDoE5juDRKe3Fdqo/VbTk=;
        b=fby12EcN0SVJ2hs6MlS03Yu/USs/WUvi1uCFuIyeOPJ+kfoYo0Zszd641zHrFerns0
         sQHyPsV/MiPf3Z05wt1QGwV8Oe8lMygSsBIrtej5jv6fFhTWM53mlEEyDblGo3+47ExN
         oYaqTOTtw7iG6we9x+HyK+2StPZKXXpTzI6mUXuK0ZECoghD3tHqhVJihymbSgdGY+WL
         Um2Wk046tbticqsCY7vh+5hFlIrj+mcetCqO87UFn6NEebYwo4udmQJU909qPkE7FdWN
         id59hBGNqEJTGZmyh5+KvuuZELybrU16UbbSonuXApcYV5XGZXO/BgZVdAdWeBbAh5/z
         WBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810600; x=1770415400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5NBUMxmmdn2a24HGvGfJdHYDoE5juDRKe3Fdqo/VbTk=;
        b=AADfu96qnkb0JBeWTPIXVpGgRWqktnpc6TpdoV/vITGfMXQMH+AIjhOyziIDPm0xWm
         TAr13ZLCdWElCJ6bN6uLmNO+pmoq47td6hh+c1ynHyquXlqUTLQINpTpou2mN4vI37Ah
         6sBq8qiIqLZmxtBT0O5pILHcciQvDeh0my4vCSuSURUExHlfFKYWVefp16WIX89ytG2b
         V/KgyhwntPBO8TYkPGXOunlE49gT0dDvHS+RwWKLvroHTWQ+ExSd3BldX1r+T8Rw7nRP
         MiJ8vm31BRi+VcCLwWoCXx2v7KWyf0ed3uaex7r0NI9Ca7mpVR3vDUPDMzyi2X7v5q9l
         TizQ==
X-Gm-Message-State: AOJu0YxmvxsLqnBuJoJvf2st7zGefQtsHmUfX7gw+VP7K1q2oiIH4K5c
	QM6kxFRfrMr0DwQyQsWVHxsT6FYXdfnW/v7LpN9pL7hWy2wDSClgNsCTGx6W2Q==
X-Gm-Gg: AZuq6aLbMbZBySd4bnEMVZjj3evux+lYPN3ODX0lP6PMt7oBDAkozhZI600VqhyFpva
	s7wvah/laU/fOz6UJOp6A27h1euMckl5A3lIYW4hmXdXKpao0WXczwgHAw3z604bMHjrI4A5mtz
	5rMKEkXJrFHC47jid+GptdWw+uDzeNz6p3ZOihYkqcHzZYXLriKhU+BTj1Ze5kqehz4G4mRNLJI
	A/CFbS+r/HmCaFdNrkc4vvw8ip4lKIzSTymi5oXUe0G3qj5spM18AlZaTnGEe9RoayzwfsYRVio
	Ja1sJW6kSsJ9AY6iaYJkXls2qldZW/G8cDGXjnJ0GfbK1uzERaKtvPFcxnsq7hHsyp3QjAWtpQ6
	Lpsn3njXMYUfcKjwKY5hYonBEe63TpnyGQe57DY45jz05T0vLOJ/eqYZaJkezkge6jklmYSAw4g
	DmzOjNeHT5hNA3qe4gw4nMZqfVg0TAl4RUbMlfpnB7czGsko+fOdI4y0l7jt4rEnNUs0YOu/me+
	pdA5g==
X-Received: by 2002:a05:6122:2a44:b0:566:38f4:4753 with SMTP id 71dfb90a1353d-566a014b5ddmr1432772e0c.18.1769810599695;
        Fri, 30 Jan 2026 14:03:19 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 33/37] doc/org.bluez.MediaPlayer: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 17:02:24 -0500
Message-ID: <20260130220229.1346261-34-luiz.dentz@gmail.com>
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

Add :Used by: field linking to bluetoothctl-player and Examples sections
showing corresponding bluetoothctl player commands.
---
 doc/org.bluez.MediaPlayer.rst | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/doc/org.bluez.MediaPlayer.rst b/doc/org.bluez.MediaPlayer.rst
index 14768cf433ac..336992c66538 100644
--- a/doc/org.bluez.MediaPlayer.rst
+++ b/doc/org.bluez.MediaPlayer.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez (Controller role)
 :Interface:	org.bluez.MediaPlayer1
 :Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/player#
+:Used by:	**bluetoothctl-player(1)**
 
 Methods
 -------
@@ -31,6 +32,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > player.play [item]
+
 void Pause()
 ````````````
 
@@ -41,6 +46,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > player.pause
+
 void Stop()
 ```````````
 
@@ -51,6 +60,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > player.stop
+
 void Next()
 ```````````
 
@@ -61,6 +74,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > player.next
+
 void Previous()
 ```````````````
 
@@ -71,6 +88,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > player.previous
+
 void FastForward()
 ``````````````````
 
@@ -82,6 +103,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > player.fast-forward
+
 void Rewind()
 `````````````
 
@@ -93,6 +118,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > player.rewind
+
 void Press(byte avc_key)
 ````````````````````````
 
@@ -146,6 +175,10 @@ Possible values:
 :"off":
 :"on":
 
+Examples:
+
+:bluetoothctl: [player] > equalizer <on/off>
+
 string Repeat [readwrite]
 `````````````````````````
 
@@ -158,6 +191,10 @@ Possible values:
 :"alltracks":
 :"group":
 
+Examples:
+
+:bluetoothctl: [player] > repeat <singletrack/alltracks/group/off>
+
 string Shuffle [readwrite]
 ``````````````````````````
 
@@ -169,6 +206,10 @@ Possible values:
 :"alltracks":
 :"group":
 
+Examples:
+
+:bluetoothctl: [player] > shuffle <alltracks/group/off>
+
 string Scan [readwrite]
 ```````````````````````
 
@@ -180,6 +221,10 @@ Possible values:
 :"alltracks":
 :"group":
 
+Examples:
+
+:bluetoothctl: [player] > scan <alltracks/group/off>
+
 string Status [readonly]
 ````````````````````````
 
-- 
2.52.0

