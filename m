Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com [209.85.217.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6559C3612D5
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810574; cv=none; b=TytkCHr4laVRYWXgyLxENk8R8rcyYPOL+frJ3/JOGcaQrE7lq5y3hkIFrLNQFS8thYroJI9Fh11G3fi5YTsGK76Svr7x2YT3lJF63sCLfaIDGWQmiYTskFr/w5tj2DyEFrVWXQZ6Q2O6y82P/yFD4Nqk0bNHERRsAZLZTTNlZBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810574; c=relaxed/simple;
	bh=d9dZoNo7g5TXn3o2aw62KlA73fT6o38IGNkAhknTVHw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2+J/+W4lCdlAx4EgHAVLEZFGtKgVD4+gWwJcXmND069jppAQlS+KLJlxkHjNe2XV2H/WSqKX6cihDiMaNczQxFwQ1hh6KUF0RGhWQOAEXxNBcoGuCMVSu1ydFygXmwXohAD56R0oFEufHnItcUq86QQVJilHcwLLhMb1OJL02w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aa2avTi4; arc=none smtp.client-ip=209.85.217.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa2avTi4"
Received: by mail-vs1-f66.google.com with SMTP id ada2fe7eead31-5f5423b0980so852922137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810572; x=1770415372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkF72W+Olr1cWxBAbMglgj7E/Gk8247G0rxnWjbgskw=;
        b=aa2avTi46XsMHBNRBs0M8IgNU91qrJ4MwGtf5Y+AXLM1WlZMPvT+7d0Fcag1CKKUTN
         MQtQ+yCfcfMS6WSVit7tn4gwOlv8K44p0EQLXawD0ZUCBT0ogI3c6Hr/tOPUTjkXRzIQ
         U51tJrhnE66GCK0kixyaQVc+oi4kwRj/Dl60TwIC7BTwJ1CaKHRQXIhLs9j0GlrOBFzt
         Yb5oKAeB9EZYbWW15QF4FVNrI0tb1Rwc/smIB+rS1elB/yYqorCNi0vI+bzpk5r54hWF
         ZkpUQLpSrb4Tn/Qj61cWbse2DWXqpSgDchBMOoHanDTIW6uZzS9CYG2xZiZza4UBVtjV
         xStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810572; x=1770415372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WkF72W+Olr1cWxBAbMglgj7E/Gk8247G0rxnWjbgskw=;
        b=RYihqsGNRaeLIjVwD50P/u0T+9U3bHjjT4alwG405GOlhXt2QCqjExtenHBUOZWBJN
         0jdaIliON4lCT4BvcdllRzON2g8CWWUsEUVy5G3R0uqNltTu8IUi08mBafK1B7gWjz/N
         nHtQKbr7Id+vJfjGo/3itlDz+Kdd9ObrsQ80iRfm39VJvd6YsP6YEtFpRd/Igp2sLfeY
         lHXOxsCUdV6BewGAwmJzhPuevwnwELKU7gLeElZGkdeT24hgNP9kE/2WtOPj0KBNm72C
         dqTA/DFrtElf9bjmv21XxOFdFrXxyigkJn9SwVg9hyyfVNDHr002S8pjy3TzNaMeMUwh
         q63Q==
X-Gm-Message-State: AOJu0Yyd8dT7xZjtQzZ/JbAai1sKGNkJvN/WRjBtSydSz8oco6c0039p
	NOavtzm8a+B7YSWS+nY4L5/MTB09ONLN+TptTfXMyUarFGUkcujp/H2RdInw9p8L
X-Gm-Gg: AZuq6aJLK/hUQz/tIgZBADEJ4OKKFbz+ZnTQeVF1ZI9zkkCtnEfaIcMwfg7e0fBXGfH
	UtxyqAluzSlNkf5JfnQEaJ3Gt5egoOaL6mC/sC8Beb6YynSHRU1grUAlr7dSzK+yjXSK1/5a0Jj
	GM6CfTu+iPej+nSv9/pjgMS8XOup210hFrObP+0GB/K/qOiP0MYD6y97MoiLz9g5YLXFDkT8Wue
	Ci6Fh1jqEGe7mlhIdRzSpBn5BEIw4TuF77xdb3FDd2XEHVvV4Wm5Si4WmRH0c529eKwye3/3jzw
	lBa6QQvtPZPcnFEfP2LzO3fKs+uNLopjfpMXZSfHaUDas06iW2FTLpPUi+wcD58LSjMYxyS5R1x
	AUf3ros/H0s+tqnsfpPMMNMRe0n8dJPimODth/mhkoNWieBUQ5TcwrjXLurv5alyTpBF46bNvKq
	KrRSW2ktGZvg2iaEP9Df9wGZFvqVXqftww1lRNEZwZCjFyWiCyr4H0MdbbMJup/7iTEV2JRBK1G
	lQHoA==
X-Received: by 2002:a05:6102:f0a:b0:521:b9f2:a5ca with SMTP id ada2fe7eead31-5f8e258d2c3mr1190227137.13.1769810572000;
        Fri, 30 Jan 2026 14:02:52 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.02.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:02:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 09/37] doc/bluetoothctl-hci: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 17:02:00 -0500
Message-ID: <20260130220229.1346261-10-luiz.dentz@gmail.com>
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
 doc/bluetoothctl-hci.rst | 112 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 99 insertions(+), 13 deletions(-)

diff --git a/doc/bluetoothctl-hci.rst b/doc/bluetoothctl-hci.rst
index 70aa5e7afaa4..05cd763f5465 100644
--- a/doc/bluetoothctl-hci.rst
+++ b/doc/bluetoothctl-hci.rst
@@ -18,6 +18,11 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [hci.commands]
 
+.. note::
+   This submenu communicates directly with the Bluetooth controller via HCI
+   socket, bypassing the BlueZ D-Bus API. Commands use the Host Controller
+   Interface (HCI) protocol.
+
 Commands
 ========
 
@@ -27,12 +32,22 @@ open
 Open HCI channel.
 
 :Usage: **> open <index> <chan=raw,user>**
-:Example open user channel:
-	| In order to open a user channel the controller needs to be power off
-	| first:
-	| > power off
-	| > hci.open 0 user
-	| HCI index 0 user channel opened
+:index: HCI controller index number (e.g., 0, 1, 2)
+:chan: Channel type (raw or user)
+:Example Open user channel (controller needs to be powered off first):
+	| **> power off**
+	| **> hci.open 0 user**
+	| **HCI index 0 user channel opened**
+:Example Open user channel for HCI controller 0:
+	| **> hci.open 0 user**
+:Example Open user channel for HCI controller 1:
+	| **> hci.open 1 user**
+:Example Open user channel for HCI controller 2:
+	| **> hci.open 2 user**
+:Example Open raw channel for HCI controller 0:
+	| **> hci.open 0 raw**
+:Example Open raw channel for HCI controller 1:
+	| **> hci.open 1 raw**
 
 cmd
 ---
@@ -40,10 +55,30 @@ cmd
 Send HCI command.
 
 :Usage: **> cmd <opcode> [parameters...]**
-:Example send HCI Reset command:
-	| > hci.cmd 0x0c03
-	| HCI Command complete:
-	|  00
+:opcode: HCI command opcode in hexadecimal format (e.g., 0x0c03)
+:parameters: Optional command parameters as hexadecimal bytes
+:Example Send HCI Reset command:
+	| **> hci.cmd 0x0c03**
+	| **HCI Command complete:**
+	| **00**
+:Example Send HCI Reset command (no parameters):
+	| **> hci.cmd 0x0c03**
+:Example Send HCI Read Local Version Information:
+	| **> hci.cmd 0x1003**
+:Example Send HCI Read BD Address:
+	| **> hci.cmd 0x1009**
+:Example Send HCI Set Event Filter with parameter 0x01:
+	| **> hci.cmd 0x0c01 0x01**
+:Example Send LE Set Advertising Parameters with 2 parameters:
+	| **> hci.cmd 0x200f 0x00 0x08**
+:Example Send LE Set Advertising Data with length and data bytes:
+	| **> hci.cmd 0x2008 0x20 0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08**
+:Example Send HCI Set Event Mask command:
+	| **> hci.cmd 0x0c05 0x02**
+:Example Send HCI Write Scan Enable:
+	| **> hci.cmd 0x0c2a 0x01**
+:Example Send HCI Write Class of Device:
+	| **> hci.cmd 0x0c23 0x00 0x08**
 
 send
 ----
@@ -51,8 +86,29 @@ send
 Send HCI data packet.
 
 :Usage: **> send <type=acl,sco,iso> <handle> [data...]**
-:Example send ACL data packet to connection handle 0x0000:
-	| > hci.send acl 0x0000
+:type: Packet type (acl, sco, or iso)
+:handle: Connection handle in hexadecimal format (e.g., 0x0000)
+:data: Optional data bytes in hexadecimal format
+:Example Send ACL data packet to connection handle 0x0000:
+	| **> hci.send acl 0x0000**
+:Example Send empty ACL packet to handle 0x0000:
+	| **> hci.send acl 0x0000**
+:Example Send ACL packet with "Hello" data to handle 0x0001:
+	| **> hci.send acl 0x0001 0x48 0x65 0x6c 0x6c 0x6f**
+:Example Send ACL packet with custom data to handle 0x0010:
+	| **> hci.send acl 0x0010 0x01 0x02 0x03 0x04**
+:Example Send empty SCO packet to handle 0x0000:
+	| **> hci.send sco 0x0000**
+:Example Send SCO packet with audio data:
+	| **> hci.send sco 0x0001 0xaa 0xbb 0xcc**
+:Example Send SCO packet with sine wave pattern:
+	| **> hci.send sco 0x0002 0x80 0x00 0x80 0x00**
+:Example Send empty ISO packet to handle 0x0000:
+	| **> hci.send iso 0x0000**
+:Example Send ISO packet with sample data:
+	| **> hci.send iso 0x0001 0x12 0x34 0x56 0x78**
+:Example Send ISO packet for LE Audio stream:
+	| **> hci.send iso 0x0020 0xa0 0xa1 0xa2 0xa3**
 
 register
 --------
@@ -60,6 +116,21 @@ register
 Register HCI event handler.
 
 :Usage: **> register <event>**
+:event: HCI event code in hexadecimal format (e.g., 0x0e)
+:Example Register handler for Command Complete event:
+	| **> register 0x0e**
+:Example Register handler for Command Status event:
+	| **> register 0x0f**
+:Example Register handler for Connection Complete event:
+	| **> register 0x03**
+:Example Register handler for Disconnection Complete event:
+	| **> register 0x05**
+:Example Register handler for LE Meta events:
+	| **> register 0x3e**
+:Example Register handler for Inquiry Complete event:
+	| **> register 0x02**
+:Example Register handler for Role Change event:
+	| **> register 0x22**
 
 unregister
 ----------
@@ -67,13 +138,28 @@ unregister
 Unregister HCI event handler.
 
 :Usage: **> unregister <event>**
+:event: HCI event code in hexadecimal format (e.g., 0x0e)
+:Example Unregister Command Complete event handler:
+	| **> unregister 0x0e**
+:Example Unregister Command Status event handler:
+	| **> unregister 0x0f**
+:Example Unregister Connection Complete event handler:
+	| **> unregister 0x03**
+:Example Unregister Disconnection Complete event handler:
+	| **> unregister 0x05**
+:Example Unregister LE Meta event handler:
+	| **> unregister 0x3e**
 
 close
 -----
 
 Close HCI channel.
 
-:Usage: **> close <index>**
+Closes the currently open HCI channel.
+
+:Usage: **> close**
+:Example Close the current HCI channel:
+	| **> close**
 
 RESOURCES
 =========
-- 
2.52.0

