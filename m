Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com [209.85.217.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5AA3542C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810571; cv=none; b=DCt/DDiuw1oOns/3P+IPj6aD2O+fTBP7IP4bvAGJmkeyO/DvHUvKfpzUD8Fm+gfDwOwySncEsenw1TP7waEA49uKRiRLe1wWniIW0TmiYbz4mBUhBX7ooEa+OwzCqhK7Y5Z3i8W1NSxv7dPtKcFjGziwoZmneDNl4ntmqKEtRaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810571; c=relaxed/simple;
	bh=9c7R2N5seOTyjsS0aWHZe8B7abWwqUBQ0sGVTLdFo/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SD36zE7TOnxbGa3QVZ356XpPItttCzD0lAmo/QJ85/TlF6T056gwkuZTZqXu3X4uuNkeac+dLd0XUmiX/FrCUjobdG+SXdvbf4ce8OC9yIZ+CHlUqkZlJMVtfoK7uD8ElydDwTAhtsRfP+OKIMpAbWADGOZyHIzdFY4tNsNXp9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iS9Rr9Dc; arc=none smtp.client-ip=209.85.217.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS9Rr9Dc"
Received: by mail-vs1-f67.google.com with SMTP id ada2fe7eead31-5f52aa95279so1641613137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810569; x=1770415369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SnVJ2CRjkqiLXMMFesIs3WyqsEpTqadys+AoA+Zu/zQ=;
        b=iS9Rr9DcoWVbn9gzDCYxbLv0BYvvNmQJe9iht/IZ2ABeh2qluTNDiMiYinooEhaekT
         J8PZgmA+itKJoACurSlRrcykpeWaS7eJxSQr9uZlXOE7fO5avAG49QWsvi28n2A04NJG
         Eps6L7sCZA/19iV1Y5Gx1v9SZsAqD8ghFSgR8zlVi8WocEB2QGSc/0bd64/JnYCoWhPZ
         T/JkafLSaUbIkTriRgKXt5hoswuWkn8TCiLWqS2+FautCKxG7jW68xdj7LjPet2Ei2t4
         2IYorLSABEvRG7xL8iV03lQr/REAEeTadjG5r+w7ffjAgBAkl1kNqU0oA2XY9bCAMbrB
         +P2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810569; x=1770415369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SnVJ2CRjkqiLXMMFesIs3WyqsEpTqadys+AoA+Zu/zQ=;
        b=cmR/tzhYnEMCcXwQ1XFflNKgNUJLK0NTJWNRrWPhfEotcStr6c+Z5zqbn3IIwYbToP
         jeQwo+v1wGVjKZqKiLdhcZT4aPx9VxX3whCVkGCLSiDRWRCbOKVSP2kssVf0g2HXlhNa
         6Br1eLA4SYHgacEo2UHM8v3sn198cVAqKUpNU+56/n+KlwOCF40GoLXVLas4GpNTuuCP
         00KxLY7rYrtIm9OPXea3aippA517QBdMJvzVFLNNRjm2Ipu5BU+humbf6Uh5cPVn4Q4r
         wiKyKm9iYPXRC/HzluhdKrMRPeY638Zh3iwz2PtS2mjKH2DjjXAqTng+zEfaeom0hygq
         dyxw==
X-Gm-Message-State: AOJu0YwlDB3nY2QmEHY325Js6VJjaXjRdN/4TlLe9t2ca0tS4OjK+HRW
	k494mXTqf/FJYZHAvWsUkododOuIcGSDqHfb4LnLgZlFtpsx+EhjFlnmFXchK4QE
X-Gm-Gg: AZuq6aI102kzYT7yuk/UBG5kgGdc/ji6cgWLZEFgPUF7ksS6wabGWxQzxLYHyD0Ijah
	f7eGOvYyARG8z593Eh/Ncih9HwLcCErCBgco9v12nwUMEzfA67115V25p1M52odU1Xju8CQU9Xl
	pmf/3kOdDkPA0trqll2Xuh2P9ww7QphKzabMKpdBTRoVlk0tquwwpSmjugBkvwXOt2i6IykiR4s
	qAKCI256eZv7Qtg8WHyDbWH2TR9Gemibi2KaX+WRtIkXvt4f65tSCPU+VpnRCuhaQOAueK3/GGB
	CdzbefRhqgEUS2gKRz1YO6hfdf1FvnwSVX1eyO567Areih7T56xCOImWRxiZT3hK51RIqK//cfF
	qThkFmN2lcKJr5xh5iGPHEmgKTlYx6pFhYJKtdNlaTPQLmbLYEn7zTbqldG7nShT5DCg8pPVUUo
	RB+o2PRyZ112po06e481G7/Xt1+gibu31kuFBmZt6FDmxKyh8cvdFqafH5uaA/acekNexiQqm+5
	BbN0g==
X-Received: by 2002:a05:6102:e12:b0:5ef:a3c1:86e1 with SMTP id ada2fe7eead31-5f8cdbcdd81mr2615696137.11.1769810567670;
        Fri, 30 Jan 2026 14:02:47 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.02.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:02:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 06/37] doc/bluetoothctl-bredr: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 17:01:57 -0500
Message-ID: <20260130220229.1346261-7-luiz.dentz@gmail.com>
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
 doc/bluetoothctl-bredr.rst | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/doc/bluetoothctl-bredr.rst b/doc/bluetoothctl-bredr.rst
index 3ec702a59ff3..2425707f3285 100644
--- a/doc/bluetoothctl-bredr.rst
+++ b/doc/bluetoothctl-bredr.rst
@@ -18,6 +18,9 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [bredr.commands]
 
+This submenu manages BR/EDR (Classic Bluetooth) bearer connections using the
+**org.bluez.Device(5)** interface.
+
 BREDR Commands
 ==============
 
@@ -27,6 +30,8 @@ list
 List available bredr devices.
 
 :Usage: **> list**
+:Example Display all BR/EDR (Classic Bluetooth) devices that have been discovered:
+	| **> list**
 
 show
 ----
@@ -34,6 +39,12 @@ show
 Show bredr bearer information on a device.
 
 :Usage: **> show [dev]**
+:Uses: **org.bluez.Device(5)** properties
+:[dev]: Bluetooth device address or object path (optional, uses current device if omitted)
+:Example Show BR/EDR bearer information for currently selected device:
+	| **> show**
+:Example Show BR/EDR bearer info for device with specified address:
+	| **> show 00:11:22:33:44:55**
 
 connect
 -------
@@ -45,8 +56,11 @@ This command initiates a bredr connection to a remote device.
 By default, it establishes the bredr connection and then connects all profiles
 that marked as auto-connectable.
 
-:Usage: > connect <dev>
-:Example: > connect 1C:48:F9:9D:81:5C
+:Usage: **> connect <dev>**
+:Uses: **org.bluez.Device(5)** method **Connect**
+:<dev>: Bluetooth device address to connect to
+:Example Connect to BR/EDR device:
+	| **> connect 00:11:22:33:44:55**
 
 disconnect
 ----------
@@ -56,8 +70,11 @@ Disconnect device over bredr.
 By default this command disconnects all profiles associated with the bredr
 connection, and then terminates the bredr link.
 
-:Usage: > disconnect <dev>
-:Example: > disconnect 1C:48:F9:9D:81:5C
+:Usage: **> disconnect <dev>**
+:Uses: **org.bluez.Device(5)** method **Disconnect**
+:<dev>: Bluetooth device address to disconnect from
+:Example Disconnect from BR/EDR device:
+	| **> disconnect 00:11:22:33:44:55**
 
 RESOURCES
 =========
-- 
2.52.0

