Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27C2594AE
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944943; cv=none; b=UXpqHeJrVKoG1IigdyPVTEAYgsCpsDVIAFcFWTjfjTpp4jetplU6vf7pj8AhrgFR1PgklaB8ETuxe+1HohJDCfzBtErpXU5JdQzMrrmpxh6MJBFbc+rASz+Se8nFLoSOwYwJrWPaWecieymRqywyDX3oY2ab2YKBz+jMcQBvcAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944943; c=relaxed/simple;
	bh=AjbNtTdS/KXTZrwdXsupcRXxF1muOMCNwwctJF4bcXM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=up/c8ud5Mv7rk8B/ThfdjzBOHMgdXhbB7XzwDooDTpMZIoFTofNeysisiCvrAfoSHenVLmDFCe8FfGxCdkcaLtwd4mfwg5Y8jbV7mEVeWe92vkAbI/M7G37Wah0ZZ53pq+XH33zXA+mVBzO9iXXgkwjwZ95niHoS9ITM90OHPlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcu1QcOy; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcu1QcOy"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ef4b6719d1so58728737b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 11:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733944940; x=1734549740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPBoz2qEF1fWP1SAvR8FUf06FJch3gclKnfh60XCBnc=;
        b=bcu1QcOyT3tFBMDQdfxI8XTCjeLhavEE6mtrCnn9q0NKVVkVBAH+Q4SwQ4KYTl9Pp0
         qJy47P4UOLT0k3n9jrwyVVEvOGWOob1JPp33GKwV6D8SCKnlT2PbN6ivC6DFD81MnUOj
         Qyn02xwQvxH1B7qLgCExpxGSJhTso2Z8WeopjiEMvzX7d5c8tKhLVoDwm1m+OyaY84gy
         vVIi6mC/HhCcm1do1f7DD1jrPLCgSsYOY48mzG+SnrLMKdZOw0tEqVZ5xJPB4Y9ZfWbV
         BJ9q6M9tcW8DiIPe/T7r5+yQ/9C3+46LykGOYOtyWVM0mhbWyEV/qplDZZvA2SdFn9in
         VxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733944940; x=1734549740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPBoz2qEF1fWP1SAvR8FUf06FJch3gclKnfh60XCBnc=;
        b=DaLImgk1ifthlVcaEl296d1TcP3t1fKOkFg2K0OkwA6xudVPu1ggTTb/yY8qFKx/FZ
         PriQxfwZc3bn9FJ+O5I7afohlrFSVjom5sep63xInuWn83wopsuZno16d0G8ZmLRHnQU
         LDSGal4hkt2I/nymsTlxiswRcOUu+DM34aHPaWhRNvTI7+WSvtxMrXlkp4NAOvrZJBH0
         bOgGRLJnS/eBVUz2TzGfDTCfB69x+ezUaRkMh43h0HyN8eimsscTU16lmDyWMmocnKGq
         anuqI6tP7cTka4gAljuAX71JBLNpvK5o3826RJEc+OyZJP6WLsV5dC9Ps7neQTSnj+lX
         PHGQ==
X-Gm-Message-State: AOJu0Yw80+SIXTaey3UDbxFP4qRyGRQ7zoWHQxEEJuxngj/Ib/62BbIw
	i7NjtX5FgrLVXvtX9v3rGBcB/m5nH/L55f7c911E29bVYVuG70U7uArtlw==
X-Gm-Gg: ASbGncu/xaQxIgYb9uMUHw4XB/XW5A+MHVCiaHLjx+bZo2LjXQOVrmuQpzEuy9eQ4YH
	e1JxdGlZgkUlYwRtZGNzxpVcVav2dAZTIxjdmg/UzShpazQqVb5btnn9nfQEeB48lNpNxd5duWG
	olQ3e+Qf7wZr8eOkGzx9EwkoJSSqeHh0pd4HZywOpJIBIAOe7OqlZRvTl4Z2yVEggcUoRTdl2x2
	vY1R8YajNIKa5ES02FnGFkB5atoAPkeL+oChbvXWLbPcGc4DVOngY/Cjv1gC6b6CjFdYv4EakwE
	9DTACats8wpsSXvMU5pbeuphhg==
X-Google-Smtp-Source: AGHT+IHg6XO2BX94pM90HUCxGrm74vxsmFbgl+Ip5Bn2v6ktQQ+tjF9QdeQLJHzuEmxwRdCWhpK70g==
X-Received: by 2002:a05:690c:6706:b0:6ef:8c41:defc with SMTP id 00721157ae682-6f19e4edb84mr6612797b3.11.1733944939851;
        Wed, 11 Dec 2024 11:22:19 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14ce8be30sm3670077b3.79.2024.12.11.11.22.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:22:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] client: Add bluetoothctl-hci.1 man page
Date: Wed, 11 Dec 2024 14:22:10 -0500
Message-ID: <20241211192210.1864347-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211192210.1864347-1-luiz.dentz@gmail.com>
References: <20241211192210.1864347-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bluetoothctl-hci.rst which is then converted to
bluetoothctl-hci.1 using rst2man.
---
 Makefile.tools              |  5 ++-
 client/bluetoothctl-hci.rst | 86 +++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 2 deletions(-)
 create mode 100644 client/bluetoothctl-hci.rst

diff --git a/Makefile.tools b/Makefile.tools
index 51a5af6af77e..0dca43327fdd 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -354,7 +354,7 @@ man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1 tools/isotest.1 \
 		client/bluetoothctl-advertise.1 client/bluetoothctl-endpoint.1 \
 		client/bluetoothctl-gatt.1 client/bluetoothctl-player.1 \
 		client/bluetoothctl-scan.1 client/bluetoothctl-transport.1 \
-		client/bluetoothctl-assistant.1
+		client/bluetoothctl-assistant.1 client/bluetoothctl-hci.1
 
 endif
 
@@ -487,7 +487,8 @@ manual_pages += tools/hciattach.1 tools/hciconfig.1 \
 			client/bluetoothctl-player.1 \
 			client/bluetoothctl-scan.1 \
 			client/bluetoothctl-transport.1 \
-			client/bluetoothctl-assistant.1
+			client/bluetoothctl-assistant.1 \
+			client/bluetoothctl-hci.1
 
 if HID2HCI
 udevdir = $(UDEV_DIR)
diff --git a/client/bluetoothctl-hci.rst b/client/bluetoothctl-hci.rst
new file mode 100644
index 000000000000..2002763176b0
--- /dev/null
+++ b/client/bluetoothctl-hci.rst
@@ -0,0 +1,86 @@
+================
+bluetoothctl-hci
+================
+
+-----------
+HCI Submenu
+-----------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: December 2024
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**bluetoothctl** [--options] [hci.commands]
+
+Commands
+========
+
+open
+----
+
+Open HCI channel.
+
+:Usage: **> open <index> <chan=raw,user>**
+:Example open user channel:
+	| In order to open a user channel the controller needs to be power off
+	| first:
+	| > power off
+	| > hci.open 0 user
+	| HCI index 0 user channel opened
+
+cmd
+---
+
+Send HCI command.
+
+:Usage: **> cmd <opcode> [parameters...]**
+:Example send HCI Reset command:
+	| > hci.cmd 0x0c03
+	| HCI Command complete:
+	|  00
+
+send
+----
+
+Send HCI data packet.
+
+:Usage: **> send <type=acl,sco,iso> <handle> [data...]**
+:Example send ACL data packet to connection handle 0x0000:
+	| > hci.send acl 0x0000
+
+register
+--------
+
+Register HCI event handler.
+
+:Usage: **> register <event>**
+
+unregister
+----------
+
+Unregister HCI event handler.
+
+:Usage: **> unregister <event>**
+
+close
+-----
+
+Close HCI channel.
+
+:Usage: **> close <index>**
+
+RESOURCES
+=========
+
+http://www.bluez.org
+
+REPORTING BUGS
+==============
+
+linux-bluetooth@vger.kernel.org
-- 
2.47.1

