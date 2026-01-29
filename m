Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com [209.85.222.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42739322B7B
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728946; cv=none; b=MQnLkM1jsP9OtIqzwzEQ2n77aEH/FbNAzdACQDgGHwBPU5kw4kGP207grKFAlRVXs71YaDDN6OLIv23FebjCrg/s5fjwsrhbKQ2Oa8dPpzfAJhKb7f70ZdbQjdGekE80wVHDOghsss2qWnCmD4coMTvojp11Af8G8XvDdwMTjFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728946; c=relaxed/simple;
	bh=RqLtVF3ZHLU7OJxp3e55EzXoX0HEKs4At3iMBTTqHbo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjFY2NE7aHeTelT6N6syOkwqkMkz+9F/45oCHabK2B4P8BDkXulzN2cf5HL00HonZOBbsUV96cvEsUMvxt7LGF+6zDeOCf+nH5qqxB6ISNpgCr9N63yt7nDnSyXFtoMYybFWDeSQtWzZCY5vVpVTJnAmyGTv980g284VNGwSVqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JI8CVMR5; arc=none smtp.client-ip=209.85.222.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI8CVMR5"
Received: by mail-ua1-f66.google.com with SMTP id a1e0cc1a2514c-947fe9e92c3so909021241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769728944; x=1770333744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiQqdxxoO55oUtSN2AA5OGLhK50VhFDGHXmpGJ8wo2U=;
        b=JI8CVMR5qyv5F9GWBUq5jdTRha8lhJJf3Mbqn46f/26vRlDksFpb5+VqDrtrMpx3Ou
         jmN2TXkehycndpN+RIZu/1B1HyYcMWJzkOc/VLoNcy4uCDhFs0lUdN9w4J33JvJ+ez+F
         24hrPLVVXgkLVnJs2BNbvQRMGjpEop9giH9uARU2156K808lkho+w5flJIiJxaezuYqL
         ou+0SUAgKhqFulaMg7ww2plsoFZj9Ovm7QUpyEcugFEtQHL7pQMgWyor6vm295g4LWgR
         oOQPb/idnLExBB66DZU5/9Mzkx7WBlwYl4S8gqYbxlb4RJTMN/u7EnlHcT4b9SQKK21R
         jlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728944; x=1770333744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IiQqdxxoO55oUtSN2AA5OGLhK50VhFDGHXmpGJ8wo2U=;
        b=B1hS0I7xkkwVKV/U7KIZuc6sTeiMV89kADnTUpFO76rwB/l7+ue2UtcYPSV9Bg9MGg
         z4RgQvgf7j2G/QABqtOlARi4Mzv6YhOwmTOp/S5Lyv0roZd2EYuot3Bv2aY1puUabypI
         tsWBRyfVwOR2qc4SPZLjCtaJIXayC3T7+fXH40GJljqb39CLDel2PIFLmRTC6xe7ftjd
         NkLl51KK5BwW3EPBPDG25Omb9OyPjPhsXYLSVOJNg+6mDliigchb7jYtj3G2+NYvfvU/
         5LoHuMA6voOmqLJcK3SUlU3KI3DY1/aQwuFNn6OlMbo+f2C2H1MhAEplrjFf3ZBjBZDO
         TqxA==
X-Gm-Message-State: AOJu0YzBbzuGsHWYcciaX8FQJf1NcZWkXJVskQGGT8TmXnBoEoRvClZj
	A8vZBog80WNhjLBlt6bWeFTHXrMfQnFWDoNKcoxBv0jxqBBB4vLKwk8bX7ilfbnGxu4=
X-Gm-Gg: AZuq6aJ6vp6vh7xyWXqWuYrtRpuQYCxjMBIKXwseuq4U1mxah+YL+Gm4B1fxx1vPPP8
	QQJZgr9ow2p0rvtokTBFeZqf7OIbErJLkk9rsW7DRaA/4xMS0NOloe5qC/GdqhBuk0zu1wqtsR8
	QPb3cl0Hi1/+nZN35g6UElAcDxlu1a7Dmd4eSRFhPy7htMEj9xq8rS/usygB7enPls7cKZ/jkeQ
	rVN/L/TeRL+GhfvBwprJuAFupNXujtDq/IlfJKIwTO8h364WMCI8y8v4iLjoB29a/XFTlVAhMik
	lKYvdMbNHzONdtztCz4dPQYupRmCvJZZvW7RJ8AW5xaFLjXu1oh5Ymq4ZyZh4tAhv8k93sN0wEa
	Vj01ZN7tOhdxyjYpvXwgiqqcGORWmh0JuMZKO3XV/OU41TvnXN407ZFdX2gOyh0B7h/nEWG7MgL
	YqITCzGLu7MDTTQAVABKojq3dbQSGaSGAA8Z4OtW16tpdaS+WbU5YyCEUHnALX+/Ke0kiT5Smvz
	bTMWq61rA6jfR2j
X-Received: by 2002:a05:6102:e08:b0:5f1:bcb3:5577 with SMTP id ada2fe7eead31-5f8e265d6a5mr408670137.32.1769728943978;
        Thu, 29 Jan 2026 15:22:23 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948724cb7casm1535890241.9.2026.01.29.15.22.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:22:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 09/15] doc/bluetoothctl-hci: Document arguments and add examples
Date: Thu, 29 Jan 2026 18:21:48 -0500
Message-ID: <20260129232201.1049568-9-luiz.dentz@gmail.com>
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

Add parameter documentation for all HCI commands including open, cmd,
send, register, unregister and close. Documents controller indices,
command opcodes, packet types, handles and event codes for low-level
HCI operations.
---
 doc/bluetoothctl-hci.rst | 107 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 13 deletions(-)

diff --git a/doc/bluetoothctl-hci.rst b/doc/bluetoothctl-hci.rst
index 70aa5e7afaa4..a0fbf4f37dc6 100644
--- a/doc/bluetoothctl-hci.rst
+++ b/doc/bluetoothctl-hci.rst
@@ -27,12 +27,22 @@ open
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
@@ -40,10 +50,30 @@ cmd
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
@@ -51,8 +81,29 @@ send
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
@@ -60,6 +111,21 @@ register
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
@@ -67,13 +133,28 @@ unregister
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

