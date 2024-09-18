Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAB9A2D
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Sep 2024 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726685326; cv=none; b=X8E1vXU1XSqPlC7i8riO6KyjRWZFQAxXc4GeK4GuL6Wbhd7vjBrhI6SiwvRT8cus4+3AXZ7wYPmEF7Cq5TW9dh2T9qR0Age34cK2nM5ErPuNN1n8hyx6MephiHL7j8cXE0sNEtN1aXWOvZJgYOnyKkSut+muDivF2ZuBEuWmRCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726685326; c=relaxed/simple;
	bh=ooFmydlRbQA3GG9eX/5cvuiEBGkGh2mGW+tFtbvqbag=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QYeC/KOF0CndDpfIaZB1Zz+Az7DDeYteAydQL5a6d8+rgDXChW9WK2REwU9/pHFszn7n6l8WCxP7kIGm1DT9TXilKbPcXCF50gZtTMYvgEinJR1t4gfOZPkKstnMu32HQh1S0Fk8XPDDDlrTiCg1d+SfWaQy1t9MAAIKemmSBGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV6eXcss; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV6eXcss"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-50108b3749aso4580e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Sep 2024 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726685323; x=1727290123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QpSlyRFQutHtRmfSB2Ioyxpj+vnreSWH2+I/wWqoDyk=;
        b=cV6eXcssv6hSN1o9aZtCFt6wT1bC2ER8pJepThBmQZW0KziUth+uCkP0GBSBwDRLow
         2J5yF+tcaz6HL/3jDlrzHWX5eHtF7SOy4ELzQxaRI2nY+bnLSxxGQDwRqpmD/ILUc3w+
         wl3ECqbEVPpPonMlZdgt324ZMJ20Gf6vFv6OUnUycEGWQF25KNTuod2pIPPbTgSRNlPL
         D8yy91sFC7fKQLt585zl9974CvV7+C3sLFt9mthcpB5MfbGuIzlMdN+nGNqn3Typb9qO
         IBOIF+mtQS2cwuxcS1t2TT8cqWlMMGkp7vgNke2sVBFVST40BJ06AZihYW+sj+UKlxWp
         oZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726685323; x=1727290123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpSlyRFQutHtRmfSB2Ioyxpj+vnreSWH2+I/wWqoDyk=;
        b=XPqYu8IHB+RA2lnYfZgzv1tpUdBm74rUpo3thNvaorK4kCZtYpqtYgpH6jq9+mhwEK
         bJPge1t/CTXkBfP9eU401bw99inpEABnOG/OL7jmxZMd3MNWxc0EckGhYn6k2g8hSIQE
         G+MlMzcZJ0LmXuzsZwlJcj/+bTMWuNQtastdAgHvO3MNJo25eXlGJYuLOIsxIdXT1o0e
         isRc6Wpf1aVklWTvzrqs7ICMrloiowJTkhEOZivimm4CfYyDcxN6i5PA7F4dCSf7NdE5
         k3W3Ojkdr0fml43Tutdllrg2euiqbGkO4/y9a/ZRBzTomM9Na9hh/kqeSvoilcAVizNE
         nDPA==
X-Gm-Message-State: AOJu0YwF0s3Cz20D2rXB6ITwsXSBah17DiW//E+7BiWqyueiQIaeG389
	X5ERyCN38e3IrZHpUc+1jd21DHxcBMglWbyqdm0R4rBVOcJCw3IPwfivog==
X-Google-Smtp-Source: AGHT+IFUWwsumrE5n18oiV3mNCiB92Jj1ti6l4mHIZZJNqbh0BoTcZ0YMADan1jW3DqPylULRKh9Rw==
X-Received: by 2002:a05:6122:310c:b0:501:be30:2abf with SMTP id 71dfb90a1353d-50344b63a4dmr13832230e0c.1.1726685323348;
        Wed, 18 Sep 2024 11:48:43 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5035bc6a40asm1036826e0c.46.2024.09.18.11.48.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 11:48:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] doc: Remove Pygments dependency from manpage
Date: Wed, 18 Sep 2024 14:48:39 -0400
Message-ID: <20240918184839.662364-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This patch removes the Pygments dependency from l2cap/rfcomm.rst file.
When the code-block type is specified, the rst2man throws a warning
asking for Pygments package.

Fixes: https://github.com/bluez/bluez/issues/950
---
 doc/l2cap.rst  | 10 +++++-----
 doc/rfcomm.rst | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/doc/l2cap.rst b/doc/l2cap.rst
index 2486f7c6f55a..f90f88222ae8 100644
--- a/doc/l2cap.rst
+++ b/doc/l2cap.rst
@@ -16,7 +16,7 @@ L2CAP protocol
 SYNOPSIS
 ========
 
-.. code-block:: c
+.. code-block::
 
     #include <sys/socket.h>
     #include <bluetooth/bluetooth.h>
@@ -40,7 +40,7 @@ connection, allowing for concurrent data transmission using different protocols.
 SOCKET ADDRESS
 ==============
 
-.. code-block:: c
+.. code-block::
 
     struct sockaddr_l2 {
         sa_family_t	l2_family;
@@ -52,7 +52,7 @@ SOCKET ADDRESS
 
 Example:
 
-.. code-block:: c
+.. code-block::
 
     struct sockaddr_l2 addr;
 
@@ -90,7 +90,7 @@ Channel security level, possible values:
 
 Example:
 
-.. code-block:: c
+.. code-block::
 
     int level = BT_SECURITY_HIGH;
     int err = setsockopt(l2cap_socket, SOL_BLUETOOTH, BT_SECURITY, &level,
@@ -116,7 +116,7 @@ authorization at profile level, possible values:
 
 Example:
 
-.. code-block:: c
+.. code-block::
 
     int defer_setup = 1;
     int err = setsockopt(l2cap_socket, SOL_BLUETOOTH, BT_DEFER_SETUP,
diff --git a/doc/rfcomm.rst b/doc/rfcomm.rst
index 4e43094b797d..b20c7544b64f 100644
--- a/doc/rfcomm.rst
+++ b/doc/rfcomm.rst
@@ -16,7 +16,7 @@ RFCOMM protocol
 SYNOPSIS
 ========
 
-.. code-block:: c
+.. code-block::
 
     #include <sys/socket.h>
     #include <bluetooth/bluetooth.h>
@@ -36,7 +36,7 @@ the 9 circuits of RS-232 (EIATIA-232-E) serial ports.
 SOCKET ADDRESS
 ==============
 
-.. code-block:: c
+.. code-block::
 
     struct sockaddr_rc {
         sa_family_t rc_family;
@@ -46,7 +46,7 @@ SOCKET ADDRESS
 
 Example:
 
-.. code-block:: c
+.. code-block::
 
     struct sockaddr_rc addr;
 
@@ -78,7 +78,7 @@ Channel security level, possible values:
 
 Example:
 
-.. code-block:: c
+.. code-block::
 
     int level = BT_SECURITY_HIGH;
     int err = setsockopt(rfcomm_socket, SOL_BLUETOOTH, BT_SECURITY, &level,
@@ -104,7 +104,7 @@ authorization at profile level, possible values:
 
 Example:
 
-.. code-block:: c
+.. code-block::
 
     int defer_setup = 1;
     int err = setsockopt(rfcomm_socket, SOL_BLUETOOTH, BT_DEFER_SETUP,
-- 
2.46.0

