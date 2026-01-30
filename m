Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com [209.85.221.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D7A274FEB
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801982; cv=none; b=GvBTOuLQeo/1VJ+HHoe37Sf2x20ZxsXsBaLrz4G3zZ5A4UY5WUEAzBX2J8sPZyAiAKDJ+p5CsvHBVyfB1xpilneW3/NrQN8K4nA9HThv5ewo0DJkf1kPmgjG41zA5ZMJ0XOv7SnFYhBvnYTI/tNaCMQzmJ1N7eD5asBQSkW/eV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801982; c=relaxed/simple;
	bh=d9dZoNo7g5TXn3o2aw62KlA73fT6o38IGNkAhknTVHw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWiNshyD+Nboe1y1pD5RHPJKO8EJ4XjQtYrAMiYKoLDoTqaNu50CQ4J1oK5NL3UYPylU65qs+xqJ9BUbrXBNHKlEohDYxIw13RdUi3gI+V0qBk70Ag9p1SBFTUN4JTYG9GU7yXa8hY9/4qX8oF6zL+ucsqRZCHi2xUXOJJM65qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpG+Fk2M; arc=none smtp.client-ip=209.85.221.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpG+Fk2M"
Received: by mail-vk1-f193.google.com with SMTP id 71dfb90a1353d-56643f72af5so874884e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801980; x=1770406780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkF72W+Olr1cWxBAbMglgj7E/Gk8247G0rxnWjbgskw=;
        b=BpG+Fk2MS81sTikAD4DL49jo4U7gZEnayyliyNh0HNvsBO3oMSTPJ7BX+Sv1xazIO/
         BcW1NNfUNzQBTm0rdTIfCWgdB8qpePG2csZGP6F85s/6ZUOUdXBz11P65V8u8MDJb8nd
         9Vg8O5nq5vrZcCT0Xq4dy6arC25xXVkqE2mpcGEvcQ6+odfiFpTCQFD6yDRSUs6eDY7p
         FUDrAWg1ZrG4YLpQBU+ZdLeUJnTPqWEfW4eIriu6DYo7aJDnVgosJqp4pJ6+1+fjYZLY
         xfqzySuUCjptmZ3zWcvVFqf0ncNglXW9zKYXrnY01tKGdHUD6+coMO0Svi5aTxPOAPWk
         I8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801980; x=1770406780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WkF72W+Olr1cWxBAbMglgj7E/Gk8247G0rxnWjbgskw=;
        b=N+Rf9PghB6+JmtHnwE6rSc5USOlAXmvyPkHZywxZWTkp+j8BCGgrgEr1UP84uZ+ebG
         orHzqnvz4Cx1ujce50brja9dCOFmmFMxWgztxA7YqvrN2IBOOJEqVYArdUJrbkiehuq6
         gV6d5t1uGieCEn/Mr6Iqq/t7GIMXpC8OVAN4+rTRtYsQ4C0gRB++FbGX4dyFuUqI36xH
         KZEpU2ZOByJVxftBFxHwSyqBaB6nA20QPuJKcGI49ns51bhN8aUeLJM2ORpJTWSIXzy2
         D4VSQgB6OQU+YeInNnZvyQGNH6MRbgoWB9sJ6M6dsqE29fb7ftcf4qlJIBMskNVm7IH6
         EYLQ==
X-Gm-Message-State: AOJu0Ywgsh/CduWWNPVhrqtfvU2CKOaZSAGkPYSIktHDlvK6KlJmahwi
	8xf2XGSYaV7Vo9h8psPu6VUGO6vmYA8+fGQkHf5eB+py7HPC0qtT9axBM37nS7Hg
X-Gm-Gg: AZuq6aL3olL4ZWbZweJ8CyOUwfovttVjp/vq8yXRiBAVScT1K9qEWCz+9RhfC72giMU
	CXd9AQSy10YOBtvqajnKXyKg4n/4K6nzU/UAgwlIyZ4GxyBi2Jw1ybgZPM3/DaSCBFhfGpN3oA9
	T1WySZvEpwOevok0O+StBMvQOPKC5zAtP8xa0X2OGsHytZqx/tDBICD+mBpFiVzRpeRjEnlNB7r
	lOwwngO1Zu7OPQfTPG5sGrtp4prt9GhY50iP1hUV9aht83/IP6YSn9dHf8tkDZXR4MUN2xTF603
	PGuL5fiEqvmaKJNTRUJ3zpfp/k26YdUIfmSnQ30QztLeFv0fE1lQTQ4Zkb6tNSr4uMC6bpbsgsi
	hk5wdEupz1oQIjOXV9DFb/4lPyB+pkvd6be8wvMQLwl5Fu65AI7yYq9pkaJZvicXrjAIVkd0QtV
	h0MVrWPzQ0ecj/0FMlPc6rj/lGXm485yoH41Y+KU6QWA6qmnqaM1v2F5HnS6wOF0MLcoWPfTNlp
	hke9w==
X-Received: by 2002:a05:6122:1692:b0:55b:305b:4e45 with SMTP id 71dfb90a1353d-566a0143c31mr1087914e0c.17.1769801979778;
        Fri, 30 Jan 2026 11:39:39 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 09/35] doc/bluetoothctl-hci: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 14:38:51 -0500
Message-ID: <20260130193921.1273263-10-luiz.dentz@gmail.com>
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

