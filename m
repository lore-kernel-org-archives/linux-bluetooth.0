Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E39770EA
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716410579; cv=none; b=ZtvW7HYdmUXlR6SBo8EgupLagRUyoRYgnd14a0c0bVDorIlb6qYVOdULAn6ImD63t5RXCjGz78Yu1WrNsA2FE+BYw1Q+EueB+67v3xC7wIan5QkhvUDlsY9Z1BUu4hRMAoZCTM4BSEmWFyIL0sUAtxVf39adXOC/rqDVzmnUiN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716410579; c=relaxed/simple;
	bh=17zB42KjqnDIMm2UmNpJ1oBOCEhVQimS2IrccfCAwCc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uw1dk+o8l8+YV4teMtqzfTeRJT/BWhcEUZ+zcZvGTFlwAiEgDueASTikFTMpZL5AqzhQabvw0Z7TK77gX5761A99u/y4zLxU6HoZqx1oj0Sik7gpKG4iyShlkfcW9qvrX1LqanEON6ksL5TC+H4868wI6kySyhc4AbSPgJas3pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AA4ff4Ls; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA4ff4Ls"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4e15ef06569so700706e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716410576; x=1717015376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3hjf6CRrFMxjq3B9ns7PbIfvbdpD9likKacRSDiYvk=;
        b=AA4ff4Ls3AE0iRgzbChh8ujSfwiwhOdYvWkSg3gqguaTHv0/rRw0otNqjMy5JIns58
         kTiUt8zTny8KtBH4M0nhkLtzH6aYJZRlNCLPAXaT+PTZYGaI05+T5WhvfXyYEngt3bZf
         4jLJLSfhMbZOfyMp7hdgstg6GJK7MF7KTYTiaZK40EtEXt0IpEJWZXjTiq015dghwrDk
         YRq+HgKJizCQvpZrA3hSDmIR/xqBERRY7v2YSxtBxe9y6PcClUYNXfC4dAudRjdN/x3p
         ZisT5aeUFBraP7ryQReiW3aWOJyNrGw6L88bUlbxtdwmTWez5w0dMCq6rMI0f/iunKh8
         ZfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716410576; x=1717015376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3hjf6CRrFMxjq3B9ns7PbIfvbdpD9likKacRSDiYvk=;
        b=Aww3LxkP6s3zxHWPJ5veUbIByE2/aquyq2v/2LG+wJX8l4m6S93M+JLNJuyznssvA6
         gFmymsPrPF6ySOc0S0Da40nZJ4BTjKmYCvxcNluM73J+pcBPT25+9sgoiWGU9TWnYbC0
         B0Du8pyELi14qATt/1BB9JhUjNt0am2BDfZzbkXzPlAmPyxVPHmunyAusw2FBR/hsf+j
         w5jGWm7KnXWUIc9+6CwbnFTFbJMrjByTc1n+SWl40/wImubX8Tp8Gb9oV6lyTvmr3XpS
         oE+edUUIVsPyUOFl6iZpUvKAyury2gbHzlziCxWKiWoleqybgLL42NzryE2FPhk2ZAUk
         wyRw==
X-Gm-Message-State: AOJu0YwZ8uYFQDsy7ZNJBOc6K613CEW4aUTB2InsPY4Xoa+BwXu+Ks9G
	PTjpC5qECpQMmHkVtjxVFHFa3eKi55gJWNPdREDYcWJaRv4YL4iVlIui+Q==
X-Google-Smtp-Source: AGHT+IFixKYzntuEKPgv2Z1wSf8ycI/h50+ijaHlgCHKK6g4c0dU/XtjzVYVNvpLi1j4N1qGLsPLpw==
X-Received: by 2002:a05:6122:1078:b0:4da:ddb4:feca with SMTP id 71dfb90a1353d-4e4e4d30f9amr282385e0c.8.1716410576441;
        Wed, 22 May 2024 13:42:56 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4df7c050c57sm3749913e0c.36.2024.05.22.13.42.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 13:42:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] doc: Add initial RFCOMM(7) documentation
Date: Wed, 22 May 2024 16:42:52 -0400
Message-ID: <20240522204252.1891896-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522204252.1891896-1-luiz.dentz@gmail.com>
References: <20240522204252.1891896-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds initial documentation for RFCOMM sockets.
---
 Makefile.am    |   4 +-
 doc/rfcomm.rst | 214 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 216 insertions(+), 2 deletions(-)
 create mode 100644 doc/rfcomm.rst

diff --git a/Makefile.am b/Makefile.am
index 8aedbb20d0d8..8f5d2fb553b4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -348,7 +348,7 @@ CLEANFILES += $(builtin_files)
 
 if MANPAGES
 man_MANS += src/bluetoothd.8
-man_MANS += doc/l2cap.7
+man_MANS += doc/l2cap.7 doc/rfcomm.7
 man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
@@ -381,7 +381,7 @@ man_MANS += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5
 endif
 manual_pages += src/bluetoothd.8
-manual_pages += doc/l2cap.7
+manual_pages += doc/l2cap.7 doc/rfcomm.7
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
diff --git a/doc/rfcomm.rst b/doc/rfcomm.rst
new file mode 100644
index 000000000000..989d3c66dca9
--- /dev/null
+++ b/doc/rfcomm.rst
@@ -0,0 +1,214 @@
+======
+rfcomm
+======
+
+---------------
+RFCOMM protocol
+---------------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: May 2024
+:Manual section: 7
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+.. code-block:: c
+
+    #include <sys/socket.h>
+    #include <bluetooth/bluetooth.h>
+    #include <bluetooth/rfcomm.h>
+
+    rfcomm_socket = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
+
+DESCRIPTION
+===========
+
+The RFCOMM protocol provides emulation of serial ports over the L2CAP(7)
+protocol. The protocol is based on the ETSI standard TS 07.10.
+
+RFCOMM is a simple transport protocol, with additional provisions for emulating
+the 9 circuits of RS-232 (EIATIA-232-E) serial ports.
+
+SOCKET ADDRESS
+==============
+
+.. code-block:: c
+
+    struct sockaddr_rc {
+        sa_family_t rc_family;
+        unsigned short rc_bdaddr;
+        unsigned char rc_channel;
+    };
+
+SOCKET OPTIONS
+==============
+
+The socket options listed below can be set by using **setsockopt(2)** and read
+with **getsockopt(2)** with the socket level set to SOL_BLUETOOTH.
+
+BT_SECURITY (since Linux 2.6.30)
+--------------------------------
+
+Channel security level, possible values:
+
+.. csv-table::
+    :header: "Value", "Security Level", "Link Key Type", "Encryption"
+    :widths: auto
+
+    **BT_SECURITY_SDP**, 0 (SDP Only), None, Not required
+    **BT_SECURITY_LOW**, 1 (Low), Unauthenticated, Not required
+    **BT_SECURITY_MEDIUM**, 2 (Medium - default), Unauthenticated, Desired
+    **BT_SECURITY_HIGH**, 3 (High), Authenticated, Required
+    **BT_SECURITY_FIPS** (since Linux 3.15), 4 (Secure Only), Authenticated (P-256 based Secure Simple Pairing and Secure Authentication), Required
+
+Example:
+
+.. code-block:: c
+
+    int level = BT_SECURITY_HIGH;
+    int err = setsockopt(rfcomm_socket, SOL_BLUETOOTH, BT_SECURITY, &level,
+			 sizeof(level));
+    if (err == -1) {
+        perror("setsockopt");
+        return 1;
+    }
+
+BT_DEFER_SETUP (since Linux 2.6.30)
+-----------------------------------
+
+Channel defer connection setup, this control if the connection procedure
+needs to be authorized by userspace before responding which allows
+authorization at profile level, possible values:
+
+.. csv-table::
+    :header: "Value", "Description"
+    :widths: auto
+
+    **0**, Disable (userspace authorization not required)
+    **1**, Enable (userspace authorization required)
+
+Example:
+
+.. code-block:: c
+
+    int defer_setup = 1;
+    int err = setsockopt(rfcomm_socket, SOL_BLUETOOTH, BT_DEFER_SETUP,
+                         &defer_setup, sizeof(defer_setup));
+    if (err == -1) {
+        perror("setsockopt");
+        return err;
+    }
+
+    err = listen(rfcomm_socket, 5);
+    if (err) {
+        perror("listen");
+        return err;
+    }
+
+    struct sockaddr_rc remote_addr = {0};
+    socklen_t addr_len = sizeof(remote_addr);
+    int new_socket = accept(rfcomm_socket, (struct sockaddr*)&remote_addr,
+                            &addr_len);
+    if (new_socket < 0) {
+        perror("accept");
+        return new_socket;
+    }
+
+    /* To complete the connection setup of new_socket read 1 byte */
+    char c;
+    struct pollfd pfd;
+
+    memset(&pfd, 0, sizeof(pfd));
+    pfd.fd = new_socket;
+    pfd.events = POLLOUT;
+
+    err = poll(&pfd, 1, 0);
+    if (err) {
+        perror("poll");
+        return err;
+    }
+
+    if (!(pfd.revents & POLLOUT)) {
+        err = read(sk, &c, 1);
+        if (err < 0) {
+            perror("read");
+            return err;
+        }
+    }
+
+BT_FLUSHABLE (since Linux 2.6.39)
+---------------------------------
+
+Channel flushable flag, this control if the channel data can be flushed or
+not, possible values:
+
+.. csv-table::
+    :header: "Define", "Value", "Description"
+    :widths: auto
+
+    **BT_FLUSHABLE_OFF**, 0x00, Do not flush data
+    **BT_FLUSHABLE_ON**, 0x01, Flush data
+
+BT_POWER (since Linux 3.1)
+--------------------------
+
+Channel power policy, this control if the channel shall force exit of sniff
+mode or not, possible values:
+
+.. csv-table::
+    :header: "Define", "Value", "Description"
+    :widths: auto
+
+    **BT_POWER_FORCE_ACTIVE_OFF**, 0x00, Don't force exit of sniff mode
+    **BT_POWER_FORCE_ACTIVE_ON**, 0x01, Force exit of sniff mode
+
+BT_CHANNEL_POLICY (since Linux 3.10)
+------------------------------------
+
+High-speed (AMP) channel policy, possible values:
+
+.. csv-table::
+    :header: "Define", "Value", "Description"
+    :widths: auto
+
+    **BT_CHANNEL_POLICY_BREDR_ONLY**, 0, BR/EDR only - default
+    **BT_CHANNEL_POLICY_BREDR_PREFERRED**, 1, BR/EDR Preferred
+    **BT_CHANNEL_POLICY_BREDR_PREFERRED**, 2, AMP Preferred
+
+BT_PHY (since Linux 5.10)
+-------------------------
+
+Channel supported PHY(s), possible values:
+
+.. csv-table::
+    :header: "Define", "Value", "Description"
+    :widths: auto
+
+    **BT_PHY_BR_1M_1SLOT**, BIT 0, BR 1Mbps 1SLOT
+    **BT_PHY_BR_1M_3SLOT**, BIT 1, BR 1Mbps 3SLOT
+    **BT_PHY_BR_1M_5SLOT**, BIT 2, BR 1Mbps 5SLOT
+    **BT_PHY_BR_2M_1SLOT**, BIT 3, EDR 2Mbps 1SLOT
+    **BT_PHY_BR_2M_3SLOT**, BIT 4, EDR 2Mbps 3SLOT
+    **BT_PHY_BR_2M_5SLOT**, BIT 5, EDR 2Mbps 5SLOT
+    **BT_PHY_BR_3M_1SLOT**, BIT 6, EDR 3Mbps 1SLOT
+    **BT_PHY_BR_3M_3SLOT**, BIT 7, EDR 3Mbps 3SLOT
+    **BT_PHY_BR_3M_5SLOT**, BIT 8, EDR 3Mbps 5SLOT
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
+
+SEE ALSO
+========
+
+socket(7), rctest(1)
-- 
2.45.1

