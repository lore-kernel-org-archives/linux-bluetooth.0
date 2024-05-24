Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9F22BAF3
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562037; cv=none; b=MDZriGkBejiEcB8rDYGOn1UYRZd1gfVv7PfOG/nNbE04+EpOUvaukQWxm3dyIPo+4H1BYpUNmgSLKfoMLYtllL5DYB1YbZo5jvVyV4s9u/Vcpv8UhIN0dgeFTzYUBeBHot2YykR13coE3bfx4oZIBKNiYlTr7UCRGadFGi7LRg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562037; c=relaxed/simple;
	bh=COgE1isDTvu1cSkdqQLnEpFl9jrDc03B6vLX+iqVrK8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7+3VNL/G3A8Wv4NTy6iiuSF9HTGGVbP/7H6hWepLT3mFQ7Hdi5p33uM6qsWFko1ZJ7P6s4pIYTSdJwnZwLnWT3qhDgWfo4oTAlyrIenQPiWdwjK3Dw0FHcy2+iFGsDq109hFtLN/8L1AWP1NN/QYTq/350OJi8W1afntJQTn/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YByM+Rlu; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YByM+Rlu"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-627ebbefd85so34471327b3.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716562034; x=1717166834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjB6hUUAV9xb9RLixiMvZwJ1FgM7gjCdKDmof8xTBSA=;
        b=YByM+RluRQNjCvLdJm8c8Pc/GWlRxG2BB06dJTPBb3k4sjMpdXETyBm1hEP8UGwwmX
         6UFr/Bi0WEW3veMINCCw5xYoiQpgDMipThSaesO5yN+CNuH8tJN7BiTKqimu05jU/Tdq
         c6/b0+0rxJ/T7Kt5R5NPZP76iBlWAlC5FLyUGT7Avzz17NQPP5etzBsWWY4gv8WgguLW
         Wd5s7D/Qoh8phAXJZN9yldPoeQ/jvp3RLcjGoQ8nN6P7HCQoTAttuEeaAOxuZ5a6M4tO
         z7O6ItjEXekdrMv08uGVJVynDLb1nHXDuGlEfPzMfIECVym7wnjTkBuSfk/UnPb3NkAt
         NSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716562034; x=1717166834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjB6hUUAV9xb9RLixiMvZwJ1FgM7gjCdKDmof8xTBSA=;
        b=CEV2JOZHml+L9dJyeKvBG8LE+MWcWlCItr0ra2QLsZUgU/ukOiH+9EUb3L4GOgLpEn
         nEo9ce6snmhb+QVsNgn6Vufd3pCzOnUEduUdSPkOwwDRLiOMGI+jb0GbXs4oS4L33h1T
         hqz/Q+CkeVqBx1+Thz4iPXZeRTWKGspgzb/lG1tej9uCFFc7rAQssAFMm4V/kh+IZSRX
         P4ICmbelW9TuHlkYiwwIvUJTyTMjfB+Y+HmHy01ezTuY3DWdPR7Zq/h3D9kTVy+PE+jy
         UuA6EZY+bAvRZWDtbbVHMo0IHyM7LSxbTOaxnLnQSuMaYxvGZiAX6VnnvrGF+tyO/J8h
         COSg==
X-Gm-Message-State: AOJu0Yyc3fXy8XtK/WdEz2T3/GDT4cH4rpc5HYq0AgbtHTAanifl1nnm
	M3p6wS4QKz3JwnlM5ootwW7gKT4KO6FMU4Oir0YQzkv2OhfafFCMHuVPig==
X-Google-Smtp-Source: AGHT+IGZjTWI8BNb4dgmE5lxUPPTURpdyck/2x0Td01mGurxa8dQvVv/1OV9kGVzvd+yQQ/9LGF2qQ==
X-Received: by 2002:a25:8041:0:b0:dc6:aeba:5aaf with SMTP id 3f1490d57ef6-df772185bd8mr2448338276.19.1716562033859;
        Fri, 24 May 2024 07:47:13 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4e4f07ee2d6sm228625e0c.56.2024.05.24.07.47.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:47:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/2] doc: Add initial RFCOMM(7) documentation
Date: Fri, 24 May 2024 10:47:09 -0400
Message-ID: <20240524144709.2274991-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524144709.2274991-1-luiz.dentz@gmail.com>
References: <20240524144709.2274991-1-luiz.dentz@gmail.com>
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
 doc/rfcomm.rst | 225 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+), 2 deletions(-)
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
index 000000000000..4e43094b797d
--- /dev/null
+++ b/doc/rfcomm.rst
@@ -0,0 +1,225 @@
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
+    rfcomm_socket = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
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
+Example:
+
+.. code-block:: c
+
+    struct sockaddr_rc addr;
+
+    memset(&addr, 0, sizeof(addr));
+    addr.rc_family = AF_BLUETOOTH;
+    bacpy(&addr.rc_bdaddr, bdaddr);
+    addr.rc_channel = channel;
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
+                         sizeof(level));
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
+    :header: "Value", "Description", "Authorization"
+    :widths: auto
+
+    **0**, Disable (default), Not required
+    **1**, Enable, Required
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
+    **BT_FLUSHABLE_OFF**, 0x00 (default), Do not flush data
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
+    **BT_POWER_FORCE_ACTIVE_OFF**, 0x00 (default), Don't force exit of sniff mode
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
+    **BT_CHANNEL_POLICY_BREDR_ONLY**, 0 (default), BR/EDR only
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

