Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F11126B765
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602882; cv=none; b=qvqeRz3ISJSIeDshqqqPsI0tf2r9XbshQy9xuy/XbSzLEVZvK87V/KbwI1quAQ1NmVtwKFLrJ/AieppYg985ShAVUnmEKOM9GKnds5c9eGZlJ5mPOPvwL26IfnJwZItnp9cto1FkN6n0f6e93a+YSTFyEU7ufSzTNgO4mQTUQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602882; c=relaxed/simple;
	bh=M3uv50lMsRbDzxnYkEx5Xw9Zwstxqv11tp/TF2IvhsE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=H4nc/weeRLV9XvAVLKXFFJ5jbQjUzRuvKiCvylK+1eUsBdiW8u6JAwANcytGOV+KJ5eDhVYLxsNFx30U2nuMQlG7veeWPUJa/dRknAwAhXv2h8DBZA3AyhaPTLzZ8tKbwUaJ0qASwELtulr1FHgwEuO+deQkhGpEGX/hYX0WK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGUKnLR+; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGUKnLR+"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-87f04817bf6so5282450241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752602878; x=1753207678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jJwhH1m4IEaPXlEYF6CfFE8CUBcRc+GNcW6uVJFsMqM=;
        b=eGUKnLR+Y1nps7xx0SDspuA2IM9ax+nozGJCLjasLmHueAWHwCJxSdLKQK84ZnY+oG
         NFlQ1LiwCiUlNE+nYjPrXXQKUws7pxQSZnrOOog0pdKLV7Z6qaqF1aR41FnAi+Hlc1/U
         oh/Xzv8CPs0gWHK3enO0fKqSdcw+Kcg+aTI4A1Bj5l05dmbqLm/NABvLaMmlt0qZ9Usq
         2xEgyLYzlqfvr1Fi41fCgkNc/NQXM4DiZgxjVZEgctEiDJzlGA6dX/TX5VmgFBWXcuEh
         NFEFDyBi45x8bCteZvEBY/uYWwHNkU2VHO0oPWq+fvPYFRKr4OdStoNLZmJKPwg1l2v6
         X9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752602878; x=1753207678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJwhH1m4IEaPXlEYF6CfFE8CUBcRc+GNcW6uVJFsMqM=;
        b=kywsrmrtDIC0zwz+aX6WNEvcexTMm0YN5Mtam2JiEZTrR8a0AtZnloiogTwV0gchVr
         JrKYct6xmSMtLgVgP1tRifjN+erSTx5R1OaHAa4OsFxklGsgbvVleNroj7gPn/WhohKo
         lNSX62mnsGUReV8y3P0dz875WUMFOs3335Oh+gYMBmiGAvCMezMCmf64gbBHJQ5Ovjdi
         pSoyYxkKOpIh9E86tE5/eBFf7kN9fzrPlLPFXQ6EkTxV9uYVCd5RxnSxGMpRpV1jQO9R
         nKgmhFusgtBzj7VacXlYMCogco+moFzf5Bu2si3cgZhBfZsZn+Jl6/h8q8Uu1FS0GLN9
         WSWA==
X-Gm-Message-State: AOJu0YwbrMHfKPrwBaeLn/MuKpdek7B4ukhwvRRlnkLWNbr0UF7mPJv4
	Q5QEk1JTtM/6HYILKmuhsE33rGKe9dqj7e6U1HtNuTy9LCXzEbDc74NLyKJoj7DU
X-Gm-Gg: ASbGncuEvdv5ua5lBrOWJbbOO+zmgtPJVboN575M2CdvP/M619vHYND7qoL4BAzMin4
	bG5CxnUJL9hd+O7Hp8cs5XYMvJ9V/ZkYnjIvg9xm8OYoJOZaWpqBmuBt+yLEzbxRrP4gMTgQIqM
	qf5lJCFfisS+eUZJNLUn0KzANKfsjfVwrz+sLp7hbg5MpxC8VVHbLIKv5PW4qJJoZDpkyhHyHhz
	2uT1KZpgz/I0si2a+dKutcq5WxFg1riXezFAIP5vEAJIn0Js6WA9/B+rSv5lVO7KO8tdf79r4gQ
	/OlFQ96wh86/Vfdftjhx/UqpPm47lIV+EY4eL8NnxKi5fGlk/3Xis+HtmakRi8X/9EwUCuG6MMV
	RM2buX5pKxkYGFEi0rXzFMZ374jD91OY4f+4mkpV2W0yTtL803xfZnbzFJRgwoRnV
X-Google-Smtp-Source: AGHT+IFfcU13d7wOWon/DMOqIR2GqyVeWoTd1plQhILfyx0f7R3oh+Z2SbdYt+gLJgbPij0XzB35yA==
X-Received: by 2002:a05:6102:2c07:b0:4e7:7146:a9e with SMTP id ada2fe7eead31-4f8900c81c8mr123753137.6.1752602877840;
        Tue, 15 Jul 2025 11:07:57 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4f62fa92a3esm1920994137.15.2025.07.15.11.07.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:07:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] doc: Add initial ISO(7) documentation
Date: Tue, 15 Jul 2025 14:07:47 -0400
Message-ID: <20250715180747.670323-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds initial documentation for ISO sockets.
---
 Makefile.am |   8 +-
 doc/iso.rst | 436 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 441 insertions(+), 3 deletions(-)
 create mode 100644 doc/iso.rst

diff --git a/Makefile.am b/Makefile.am
index c4b88d83c962..8319373409cd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -356,7 +356,7 @@ CLEANFILES += $(builtin_files)
 
 if MANPAGES
 man_MANS += src/bluetoothd.8
-man_MANS += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7
+man_MANS += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 doc/iso.7
 man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
@@ -390,7 +390,8 @@ man_MANS += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.Image.5
 endif
 manual_pages += src/bluetoothd.8
-manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7
+manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
+		doc/iso.7
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
@@ -467,7 +468,8 @@ EXTRA_DIST += doc/assigned-numbers.txt doc/supported-features.txt \
 EXTRA_DIST += doc/health-api.txt \
 		doc/sap-api.txt
 
-EXTRA_DIST += doc/hci.rst doc/mgmt.rst doc/l2cap.rst doc/rfcomm.rst doc/sco.rst
+EXTRA_DIST += doc/hci.rst doc/mgmt.rst doc/l2cap.rst doc/rfcomm.rst \
+	      doc/sco.rst doc/iso.rst
 
 EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
 		doc/org.bluez.DeviceSet.rst doc/org.bluez.AgentManager.rst \
diff --git a/doc/iso.rst b/doc/iso.rst
new file mode 100644
index 000000000000..d08b60d20865
--- /dev/null
+++ b/doc/iso.rst
@@ -0,0 +1,436 @@
+===
+iso
+===
+-------------
+ISO transport
+-------------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under the terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: July 2025
+:Manual section: 7
+:Manual group: Linux System Administration
+
+SYNOPSIS (since Linux 6.0 [experimental])
+=========================================
+
+.. code-block::
+
+    #include <sys/socket.h>
+    #include <bluetooth/bluetooth.h>
+    #include <bluetooth/iso.h>
+
+    iso_socket = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
+
+DESCRIPTION
+===========
+
+Bluetooth Isochronous Channels is a feature introduced in Bluetooth 5.2 that
+allow for the transmission of multiple, synchronized audio streams between
+devices.
+
+For unicast/multi-stream audio, connected isochronous group (CIG), and
+connected isochronous stream (CIS) are used. A CIG is created by the central and
+it can include one or more CISs. A CIS is a point-to-point data transportation
+stream between a central and a certain peripheral, and is a bidirectional
+communication protocol with acknowledgment.
+
+For broadcast audio, broadcast isochronous group (BIG) and broadcast isochronous
+stream (BIS) are used. There are two types of devices: isochronous broadcaster
+and synchronized receiver. A BIG is created by an isochronous broadcaster, and
+it can include one or more BISs. A BIS is a one-to-many data transportation
+stream.
+
+SOCKET ADDRESS
+==============
+
+.. code-block::
+
+    struct sockaddr_iso_bc {
+        bdaddr_t	bc_bdaddr;
+        uint8_t		bc_bdaddr_type;
+        uint8_t		bc_sid;
+        uint8_t		bc_num_bis;
+        uint8_t		bc_bis[ISO_MAX_NUM_BIS];
+    };
+
+    struct sockaddr_iso {
+        sa_family_t     iso_family;
+        bdaddr_t        iso_bdaddr;
+        uint8_t		iso_bdaddr_type;
+        struct sockaddr_iso_bc iso_bc[];
+    };
+
+Unicast example:
+
+.. code-block::
+
+    struct sockaddr_iso addr;
+
+    memset(&addr, 0, sizeof(addr));
+    addr.iso_family = AF_BLUETOOTH;
+    bacpy(&addr.iso_bdaddr, bdaddr);
+    addr.iso_bdaddr_type = BDADDR_LE_PUBLIC;
+
+Broadcast example:
+
+.. code-block::
+
+    struct sockaddr_iso *addr;
+    size_t addr_len;
+
+    addr_len = sizeof(*addr) + sizeof(*addr->iso_bc);
+
+    memset(addr, 0, addr_len);
+    addr->iso_family = AF_BLUETOOTH;
+    bacpy(&addr->iso_bdaddr, bdaddr);
+    addr->iso_bdaddr_type = BDADDR_LE_PUBLIC;
+
+Broadcast Source (Broadcaster) example:
+
+.. code-block::
+
+    struct sockaddr_iso *addr;
+    size_t addr_len;
+
+    addr_len = sizeof(*addr) + sizeof(*addr->iso_bc);
+
+    memset(addr, 0, addr_len);
+    addr->iso_family = AF_BLUETOOTH;
+
+    /* Set address to BDADR_ANY(00:00:00:00:00:00) */
+    bacpy(&addr->iso_bdaddr, BADDR_ANY);
+    addr->iso_bdaddr_type = BDADDR_LE_PUBLIC;
+
+    /* Connect to Broadcast address */
+    connect(iso_socket, (struct sockaddr *)addr, addr_len);
+
+Broadcast Sink (Receiver) example:
+
+.. code-block::
+
+    struct sockaddr_iso *addr;
+    size_t addr_len;
+
+    addr_len = sizeof(*addr) + sizeof(*addr->iso_bc);
+
+    memset(addr, 0, addr_len);
+    addr->iso_family = AF_BLUETOOTH;
+
+    /* Set destination to Broadcaster address */
+    bacpy(&addr->iso_bdaddr, bdaddr);
+    addr->iso_bdaddr_type = BDADDR_LE_PUBLIC;
+
+    /* Bind to Broadcaster address */
+    bind(iso_socket, (struct sockaddr *)addr, addr_len);
+
+SOCKET OPTIONS (SOL_BLUETOOTH)
+==============================
+
+The socket options listed below can be set by using **setsockopt(2)** and read
+with **getsockopt(2)** with the socket level set to SOL_BLUETOOTH.
+
+BT_SECURITY
+-----------
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
+.. code-block::
+
+    int level = BT_SECURITY_HIGH;
+    int err = setsockopt(iso_socket, SOL_BLUETOOTH, BT_SECURITY, &level,
+                         sizeof(level));
+    if (err == -1) {
+        perror("setsockopt");
+        return 1;
+    }
+
+BT_DEFER_SETUP
+--------------
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
+.. code-block::
+
+    int defer_setup = 1;
+    int err = setsockopt(iso_socket, SOL_BLUETOOTH, BT_DEFER_SETUP,
+                         &defer_setup, sizeof(defer_setup));
+    if (err == -1) {
+        perror("setsockopt");
+        return err;
+    }
+
+    err = listen(iso_socket, 5);
+    if (err) {
+        perror("listen");
+        return err;
+    }
+
+    struct sockaddr_iso remote_addr = {0};
+    socklen_t addr_len = sizeof(remote_addr);
+    int new_socket = accept(iso_socket, (struct sockaddr*)&remote_addr,
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
+BT_PKT_STATUS
+-------------
+
+Enable reporting packet status via `BT_SCM_PKT_STATUS` CMSG on
+received packets.  Possible values:
+
+.. csv-table::
+    :header: "Value", "Description"
+    :widths: auto
+
+    **0**, Disable (default)
+    **1**, Enable
+
+
+:BT_SCM_PKT_STATUS:
+
+    Level ``SOL_BLUETOOTH`` CMSG with data::
+
+        uint8_t pkt_status;
+
+    The values are equal to the "Packet_Status_Flag" defined in
+    Core Specification v6.1, 5.4.5. HCI ISO Data packets:
+
+    https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-61/out/en/host-controller-interface/host-controller-interface-functional-specification.html#UUID-9b5fb085-278b-5084-ac33-bee2839abe6b
+
+    .. csv-table::
+        :header: "pkt_status", "Description"
+        :widths: auto
+
+        **0x0**, Valid data. The complete SDU was received correctly.
+        **0x1**, Possibly invalid data. The contents of the ISO_SDU_Fragment
+	, may contain errors or part of the SDU may be missing.
+	, This is reported as "data with possible errors".
+        **0x2**, Part(s) of the SDU were not received correctly.
+	, This is reported as "lost data".
+
+SOCKET OPTIONS (SOL_SOCKET)
+===========================
+
+``SOL_SOCKET`` level socket options that modify generic socket
+features (``SO_SNDBUF``, ``SO_RCVBUF``, etc.) have their usual
+meaning, see **socket(7)**.
+
+The ``SOL_SOCKET`` level ISO socket options that have
+Bluetooth-specific handling in kernel are listed below.
+
+SO_TIMESTAMPING, SO_TIMESTAMP, SO_TIMESTAMPNS
+---------------------------------------------
+
+See https://docs.kernel.org/networking/timestamping.html
+
+For ISO sockets, software RX timestamps are supported.  Software TX
+timestamps (SOF_TIMESTAMPING_TX_SOFTWARE) are supported since
+Linux 6.15.
+
+The software RX timestamp is the time when the kernel received the
+packet from the controller driver.
+
+The ``SCM_TSTAMP_SND`` timestamp is emitted when packet is sent to the
+controller driver.
+
+The ``SCM_TSTAMP_COMPLETION`` timestamp is emitted when controller
+reports the packet completed.  Completion timestamps are only
+supported on controllers that have ISO flow control.  Other TX
+timestamp types are not supported.
+
+You can use ``SIOCETHTOOL`` to query supported flags.
+
+The timestamps are in ``CLOCK_REALTIME`` time.
+
+Example (Enable RX timestamping):
+
+.. code-block::
+
+   int flags = SOF_TIMESTAMPING_SOFTWARE |
+       SOF_TIMESTAMPING_RX_SOFTWARE;
+   setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
+
+Example (Read packet and its RX timestamp):
+
+.. code-block::
+
+   char data_buf[256];
+   union {
+       char buf[CMSG_SPACE(sizeof(struct scm_timestamping))];
+       struct cmsghdr align;
+   } control;
+   struct iovec data = {
+       .iov_base = data_buf,
+       .iov_len = sizeof(data_buf),
+   };
+   struct msghdr msg = {
+       .msg_iov = &data,
+       .msg_iovlen = 1,
+       .msg_control = control.buf,
+       .msg_controllen = sizeof(control.buf),
+   };
+   struct scm_timestamping tss;
+
+   res = recvmsg(fd, &msg, MSG_ERRQUEUE | MSG_DONTWAIT);
+   if (res < 0)
+       goto error;
+
+   for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+       if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SCM_TIMESTAMPING)
+           memcpy(&tss, CMSG_DATA(cmsg), sizeof(tss));
+   }
+
+   tstamp_clock_realtime = tss.ts[0];
+
+Example (Enable TX timestamping):
+
+.. code-block::
+
+   int flags = SOF_TIMESTAMPING_SOFTWARE |
+       SOF_TIMESTAMPING_TX_SOFTWARE |
+       SOF_TIMESTAMPING_OPT_ID;
+   setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
+
+Example (Read TX timestamps):
+
+.. code-block::
+
+   union {
+       char buf[CMSG_SPACE(sizeof(struct scm_timestamping))];
+       struct cmsghdr align;
+   } control;
+   struct iovec data = {
+       .iov_base = NULL,
+       .iov_len = 0
+   };
+   struct msghdr msg = {
+       .msg_iov = &data,
+       .msg_iovlen = 1,
+       .msg_control = control.buf,
+       .msg_controllen = sizeof(control.buf),
+   };
+   struct cmsghdr *cmsg;
+   struct scm_timestamping tss;
+   struct sock_extended_err serr;
+   int res;
+
+   res = recvmsg(fd, &msg, MSG_ERRQUEUE | MSG_DONTWAIT);
+   if (res < 0)
+       goto error;
+
+   for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+       if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SCM_TIMESTAMPING)
+           memcpy(&tss, CMSG_DATA(cmsg), sizeof(tss));
+       else if (cmsg->cmsg_level == SOL_BLUETOOTH && cmsg->cmsg_type == BT_SCM_ERROR)
+           memcpy(&serr, CMSG_DATA(cmsg), sizeof(serr));
+   }
+
+   tstamp_clock_realtime = tss.ts[0];
+   tstamp_type = serr->ee_info;      /* SCM_TSTAMP_SND or SCM_TSTAMP_COMPLETION */
+   tstamp_seqnum = serr->ee_data;
+
+
+IOCTLS
+======
+
+The following ioctls with operation specific for ISO sockets are
+available.
+
+SIOCETHTOOL (since Linux 6.16-rc1)
+----------------------------------
+
+Supports only command `ETHTOOL_GET_TS_INFO`, which may be used to
+query supported `SOF_TIMESTAMPING_*` flags.  The
+`SOF_TIMESTAMPING_OPT_*` flags are always available as applicable.
+
+Example:
+
+.. code-block::
+
+   #include <linux/ethtool.h>
+   #include <linux/sockios.h>
+   #include <net/if.h>
+   #include <sys/socket.h>
+   #include <sys/ioctl.h>
+
+   ...
+
+   struct ifreq ifr = {};
+   struct ethtool_ts_info cmd = {};
+   int sk;
+
+   snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "hci0");
+   ifr.ifr_data = (void *)&cmd;
+   cmd.cmd = ETHTOOL_GET_TS_INFO;
+
+   sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
+   if (sk < 0)
+       goto error;
+   if (ioctl(sk, SIOCETHTOOL, &ifr))
+       goto error;
+
+   sof_available = cmd.so_timestamping;
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
+socket(7), isotest(1)
-- 
2.50.0

