Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA524E01E7
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616785; cv=none; b=GK63JGadQ+ddf5O+cyFuFLZQLzTuzxq5FR3dW7Hh/PPw8NTjjopiqEejzJ9ZWqyNOmiqBhfQsTxQ97KHvGlew+V+x4BUvLIGLlvgTxPslHwIUMSqMK/RfIgeJptpZGErO2hP5JZp/JLH4pjQCVjXpRMtUUi/rf5/3NYoeBhizJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616785; c=relaxed/simple;
	bh=YM0r7xxtXMoLEnGYeG7e+mrH60r3vZCekGYC7YHNpNk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjcKCKGnxqXI03AinS+9WdL91IbS9/kVLNRTrhV7X7lImeIqTTkm935kfFF4wAMibWAioXEQbVMMericTp8y8QS3/1LGZAOZsxu4djTUEuzpl6NQDGiWUDcKc8EtcysRmSQlr0tjEFvVI/pHVKd/IBsYXiAWYDiLBs9N+GBYt+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPw1JXCo; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPw1JXCo"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-78fb1fb9508so46151137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616782; x=1791221582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wz0+U4lflQ3l+q5328i73UaBVx4IiRSY7OVxG9dYUxA=;
        b=jPw1JXCowXKXvt2ogCKdN+CWXwuMEF03gWHIgVqQFFqnIvZktJ2ckxGflp2lvRG0Q4
         UAvXJ2j0dhtH+Hq7LyAHw1lLgAEZs8YcmCpfNr0+WldpKDrObHuJmwY/AdOQlHfOne47
         tYs4w9HRFnts75307BN7ONn8XwDLE0pX4vamPZB9IuuOVffcNY7xTvOQtPidoABOfkN4
         lxWsV4SPJcPju38PjB91MNeBlb3gkWiy+9m5bieBC4rvyotQcjfj3ftlYZakWOFx3h69
         s/ycHOu3MKsnKNCiaXNbtmVVesQ7FCIhOdZMuWXjECa8M4CrQivlCIySbSLCAa+T7/M9
         EeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616782; x=1791221582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Wz0+U4lflQ3l+q5328i73UaBVx4IiRSY7OVxG9dYUxA=;
        b=QJkukkPiznhs3Guc981uS8QpBLqIGmRtC7U61uMy9uzpTot/QnAivb6jojzBQd5JVs
         +bDAPw9oNj45RKiRwcpDGbupMa4kaKg5GIooES076DsISCTWuHWo9TgOFe3ZfeTEaUij
         whI36Tbv5iYMXhPCAnNMc9KmZmn7H/UJDv5AW3DFec4h0aAb9P9tKl/o30EPySrdtEur
         JD+XHt1ElGprkKDjPfwYNsCqmdJY1ceRxcKwbWo6qZuTI0VDDNQrZZ0r7Y/8jpzrIcuz
         YHEzwgx9LZ3da4QV/tumy48SIHGX4TTov8klKwIknVj7JvRtjS0Wo3PYnTiAbo6w7PMK
         FFWQ==
X-Gm-Message-State: AFq9FYIv3rNZX/vVM7K4Dtl5+X58qBMAmexOVpBsXzhVoWJY9eysNPeF
	66HlTTnjWwd2Ygf4R/PCRpiwK2oeLvCbs3IojFjjzH4e+vRYqIoJLJL1WnP/S9/BGQg=
X-Gm-Gg: AYBFou2gMmoVnti+FpskG90gH7CwUggJm3dLucQykgjSyG6IsNqs433YDXXo4W2wou4
	4sPeK+f8W5cDl9eBHAeQXEe/NM/X3iRnaeYWJLMBFtRpn29MBi2oveBfHjk49e1XL5cFG2Fev7L
	3rLT+AB1RB2oMvPSgL9eyiPgQkRs3oPaqemYmbYN45DcfutLBMOpAM7sIreXJuuPbqJr0zGk9BC
	99Su+UuG7RqWIMJo6XhV/e0wucNiOMH0dTjS3kBOifpzuIRLx9pfqmjZjIHWmxNMoG/o5K65JWo
	iliJ50LhdAKZTO6S6ErLfehBaGGhx6Q8n7a+R5HaTiN9e5adrDRjKzG7vvHCoarxmpIs6sTNF1f
	nU7QRbs+PKpYHuZV8YGzWynSuspb4yGqc+i2D9zvwCG4w5i4sgfNOQWTHm1/Qvk100UzW0aUoGt
	NSbfLnvSV3KDu3RsaU8nD61yXownq+9wEPWOPO88CupXyQm6/OgTlp+ghwgMvW7RinJx+hy6NAM
	h9yGTdeyiSwYtqRuwl/hTQoKjL3ZUAPEcVTxyOmU2lrKngQbB2Fw16630lofmQs
X-Received: by 2002:a05:6102:8508:20b0:7b1:3ecd:3d8d with SMTP id ada2fe7eead31-7b94edb180bmr24086137.7.1790616782136;
        Mon, 28 Sep 2026 10:33:02 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10038880137.7.2026.09.28.10.33.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:33:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 05/21] client/scripts: Add HoG device scripts
Date: Mon, 28 Sep 2026 13:32:24 -0400
Message-ID: <20260928173243.1073509-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928173243.1073509-1-luiz.dentz@gmail.com>
References: <20260928173243.1073509-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add scripts registering a HID Service (HIDS) acting as a HID over GATT
keyboard, with and without Shorter Connection Interval (SCI) support.

HID SCI Mode can be notified so the device can confirm a mode change.

Assisted-by: OpenCode:claude-opus-5.5
---
 client/scripts/hog-device-sci.bt | 49 ++++++++++++++++++++++++++++++++
 client/scripts/hog-device.bt     | 38 +++++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 client/scripts/hog-device-sci.bt
 create mode 100644 client/scripts/hog-device.bt

diff --git a/client/scripts/hog-device-sci.bt b/client/scripts/hog-device-sci.bt
new file mode 100644
index 000000000000..1bf3a0a90db7
--- /dev/null
+++ b/client/scripts/hog-device-sci.bt
@@ -0,0 +1,49 @@
+#
+# Register a HID Service (HIDS) acting as a HID over GATT (HoG) keyboard
+# with Shorter Connection Interval (SCI) support.
+#
+gatt.register-service 0x1812
+# Primary
+yes
+#
+# HID Information: bcdHID 1.11, bCountryCode 0x00,
+# Flags: NormallyConnectable and SCI Supported
+gatt.register-characteristic 0x2a4a read
+0x11 0x01 0x00 0x06
+#
+# Report Map: keyboard with Report ID 1
+gatt.register-characteristic 0x2a4b read
+0x05 0x01 0x09 0x06 0xa1 0x01 0x85 0x01 0x05 0x07 0x19 0xe0 0x29 0xe7 0x15 0x00 0x25 0x01 0x75 0x01 0x95 0x08 0x81 0x02 0x95 0x01 0x75 0x08 0x81 0x01 0x95 0x06 0x75 0x08 0x15 0x00 0x25 0x65 0x05 0x07 0x19 0x00 0x29 0x65 0x81 0x00 0xc0
+#
+# Report: Input Report ID 1
+gatt.register-characteristic 0x2a4d read,notify
+0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+# Report Reference: Report ID 1, Input
+gatt.register-descriptor 0x2908 read
+0x01 0x01
+#
+# Protocol Mode: Report Protocol Mode
+gatt.register-characteristic 0x2a4e read,write-without-response
+0x01
+#
+# HID Control Point
+gatt.register-characteristic 0x2a4c write-without-response
+0x00
+#
+# HID SCI Mode: None (0x00), notified when changed
+gatt.register-characteristic 0x2c39 read,write,notify
+0x00
+#
+# HID SCI Information (intervals in units of 0.125 ms):
+# Minimum Supported Connection Interval: 0x08 (1 ms)
+# Number of Supported Subgroups: 1
+# Subgroup[0]: Min 0x0008 (1 ms) Max 0x0050 (10 ms) Stride 0x0008 (1 ms)
+gatt.register-characteristic 0x2c3a read
+0x08 0x01 0x08 0x00 0x50 0x00 0x08 0x00
+#
+gatt.register-application
+#
+# Advertise as a keyboard with HIDS
+advertise.uuids 0x1812
+advertise.appearance 0x03c1
+power on
diff --git a/client/scripts/hog-device.bt b/client/scripts/hog-device.bt
new file mode 100644
index 000000000000..42b324eda020
--- /dev/null
+++ b/client/scripts/hog-device.bt
@@ -0,0 +1,38 @@
+#
+# Register a HID Service (HIDS) acting as a HID over GATT (HoG) keyboard
+# without Shorter Connection Interval (SCI) support.
+#
+gatt.register-service 0x1812
+# Primary
+yes
+#
+# HID Information: bcdHID 1.11, bCountryCode 0x00,
+# Flags: NormallyConnectable
+gatt.register-characteristic 0x2a4a read
+0x11 0x01 0x00 0x02
+#
+# Report Map: keyboard with Report ID 1
+gatt.register-characteristic 0x2a4b read
+0x05 0x01 0x09 0x06 0xa1 0x01 0x85 0x01 0x05 0x07 0x19 0xe0 0x29 0xe7 0x15 0x00 0x25 0x01 0x75 0x01 0x95 0x08 0x81 0x02 0x95 0x01 0x75 0x08 0x81 0x01 0x95 0x06 0x75 0x08 0x15 0x00 0x25 0x65 0x05 0x07 0x19 0x00 0x29 0x65 0x81 0x00 0xc0
+#
+# Report: Input Report ID 1
+gatt.register-characteristic 0x2a4d read,notify
+0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+# Report Reference: Report ID 1, Input
+gatt.register-descriptor 0x2908 read
+0x01 0x01
+#
+# Protocol Mode: Report Protocol Mode
+gatt.register-characteristic 0x2a4e read,write-without-response
+0x01
+#
+# HID Control Point
+gatt.register-characteristic 0x2a4c write-without-response
+0x00
+#
+gatt.register-application
+#
+# Advertise as a keyboard with HIDS
+advertise.uuids 0x1812
+advertise.appearance 0x03c1
+power on
-- 
2.55.0

