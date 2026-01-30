Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043E3542C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810566; cv=none; b=eET3pty+qLLMa9KpcfyBhgrYryDECWmxnGx0n70IU1mbbbOEx8jbSOntiKaLY5jQy1wmtM9gADKc8Fmn5WbVdKGb1rj+F+ZE9xjJKAReSZFUVsQsc3iHItL2+M13SOWFkAxtiOXTTPefmsAgYifzjAwWF60+OTQH9xXCJDAU1fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810566; c=relaxed/simple;
	bh=CwPpmGN3ApXn86Bg7GaUZVN/wLn7BbwChprXc0U76Mc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TI+bU/d5RXVoGboUDq9bv1xDpCj1Lt5IVE/y5Tl2zDkY6Q2G8UmvbWjikzokf9Q83BQEsV3jDgmD0E7BUeuPKtKhVSimDbe9AnFmr3pKWUkHONMPF3bRfbOyUuXehLSW+dAcCJQ9VlHbKEz0J8vy3BclT0UKNWuDgoTxc1q5Aw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSJOmNur; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSJOmNur"
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-56641b5a471so2205900e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810564; x=1770415364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUcAa8npKgiv0Wva9MgYBhAmp71KHi9k6p2Tpy6UWcA=;
        b=PSJOmNurErFams74cf5gT8b572P8SmDARjDqGO9xTwG65smjM4QsZmO6i8p7m6YR+x
         Af2/INjFyz24yF0nFhIxnCRl2JhBRDziTopiD5lsVIpsaNhT2fxUauz0fxprasPhoUQF
         tPBVrmsBz4jeu2ve0GkInNOwnxRJXWZm7vXwWC0R3/Siy1ZCYqjr7Kz6hrPECmsEJau+
         GgJPDFi/xYn+w3Mpl6Zsnu7sDWvDnxz4PYsU5Knyx58q89NNr15HrlDNa6pifra6bHuC
         abdyZFj4tHNS/ICud6UKWMViZY4f8be49kyLVrmLH+ErIkrW4iGypXLvjJlYg5jFxtR0
         +Euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810564; x=1770415364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nUcAa8npKgiv0Wva9MgYBhAmp71KHi9k6p2Tpy6UWcA=;
        b=XviTXob/iVTGZimBXjJ5zHt4NW2nayityqvPd+nm4Q84Jg6ZIIIDeV9OPI4huuuPNi
         Y4X+8ffvesXB/MrIbyqB6STZVLC42zIxDfDyayKbD2Bm7K59uRP379PB0wtaYN1eSlj7
         PUyAFwoHRtItcgUsKV5Bq3+Rib6Fiis4ISQsEMgZ5swt60RixoGXChW1EmX78EcwakKZ
         ENEgqITHd11iwrGOwSGaOqYKG4mpRrQ/dc0rkvorTGYjhL4dxFV60l+xFFLQclN4cjl9
         z5Qd2U8yQ4HATDMpT9Q8B/3wumnMA0h+HHHUU4eFo8lprm1a6yY8A8o6ZXG31qeK9084
         b46A==
X-Gm-Message-State: AOJu0YyqhH6XOxuotROKvkvVd2stebG3M8HpQpISF94GGWAE9NgWTO4q
	Zdk5ClX4VGqsS0ACmktZX42fjAzUmc082U03tGtpjLJIldrXohHgyUdyS8KGxGPL
X-Gm-Gg: AZuq6aJ3rGiCl+bit9w7WS8nLapAgmwWGH2mYuL+feoCh7zSJabeXgQ59MW763ZlvKY
	HHY/z3LU/P+a29LQCAK2QqSYQedHCOi9mzwQ1K0X3zAmD4mIiM0q+iVXoyh4CmAK0G1JmIAerqG
	AtKhTcARJEWjSSoH1Pwl8p0sIKJjFHmBSX6Si5GTIop8Ot4oZnpOP7XYtNOltfPaB2bZwxkiXME
	V+BNNI12VhiObyKVU6LBsASAZCCyaXUwJTBPOXGEvO02O1Ag+JJdczLTsiqAozy5WOlwVVoWa9S
	01znLQNT+MWeZGYJ8QojE5aaJceq/Fz/lryf9TD50RqOAdNiJ5nAXKjvrNMFKzQ8KVlkszvltH7
	yHf+990hnT4tkViydLNOF1urLXG3BgHpUDs9dIMQCvXugoEivRPczZnW/LK5jqHp/+reirBTT97
	e6l2ncU8WxqWQXHTYF7RuCbFjd0I380XpOKRBBkO/seUAl8a1QwlTJNSrIhkOr2LuNE52JCDFGg
	mURxg==
X-Received: by 2002:a05:6122:1daa:b0:563:618f:b7da with SMTP id 71dfb90a1353d-566a012a242mr1579078e0c.19.1769810564217;
        Fri, 30 Jan 2026 14:02:44 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.02.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:02:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 03/37] doc/bluetoothctl-admin: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 17:01:54 -0500
Message-ID: <20260130220229.1346261-4-luiz.dentz@gmail.com>
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
 doc/bluetoothctl-admin.rst | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/doc/bluetoothctl-admin.rst b/doc/bluetoothctl-admin.rst
index b0f7f94c18cf..d4446ce95e5f 100644
--- a/doc/bluetoothctl-admin.rst
+++ b/doc/bluetoothctl-admin.rst
@@ -18,6 +18,10 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [admin.commands]
 
+This submenu configures administrative policies using the
+**org.bluez.AdminPolicySet(5)** and **org.bluez.AdminPolicyStatus(5)**
+interfaces.
+
 Admin Policy Commands
 =====================
 
@@ -27,8 +31,28 @@ allow
 Allow service UUIDs and block rest of them.
 
 :Usage: **> allow [clear/uuid1 uuid2 ...]**
-:Example: **> allow 0x1101 0x1102 0x1103**
-:Example: **> allow clear**
+:Uses: **org.bluez.AdminPolicySet(5)** property **ServiceAllowList**
+:[clear/uuid1 uuid2 ...]: List of service UUIDs to allow, or "clear" to remove all restrictions
+:Example Get current allowed UUIDs list:
+	| **> allow**
+:Example Allow Serial Port Profile only:
+	| **> allow 0x1101**
+:Example Allow Serial Port Profile and LAN Access Profile:
+	| **> allow 0x1101 0x1102**
+:Example Allow Serial Port Profile, LAN Access Profile, and Dialup Networking Profile:
+	| **> allow 0x1101 0x1102 0x1103**
+:Example Allow Advanced Audio Distribution Profile only:
+	| **> allow 0x110e**
+:Example Allow A2DP Source and Sink profiles:
+	| **> allow 0x110e 0x110f**
+:Example Allow Serial Port Profile using full UUID:
+	| **> allow 00001101-0000-1000-8000-00805f9b34fb**
+:Example Allow SPP and LAP using full UUIDs:
+	| **> allow 00001101-0000-1000-8000-00805f9b34fb 00001102-0000-1000-8000-00805f9b34fb**
+:Example Remove all UUID restrictions:
+	| **> allow clear**
+:Example Allow SPP, LAP, and DUN using mixed UUID formats:
+	| **> allow 0x1101 00001102-0000-1000-8000-00805f9b34fb 0x1103**
 
 RESOURCES
 =========
-- 
2.52.0

