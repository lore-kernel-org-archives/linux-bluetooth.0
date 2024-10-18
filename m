Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8355A73477
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280257; cv=none; b=Wwfk4aFwbAWjqnB9VaNR6BLT3NFflKh6qqsp2TGipuT0Uevfll1Dk8i9xOxFBDw33ywiTawRiZvhSBEXkK9/mxgiD3DJUmKuCFrfBoHNzadDlS8MteTttKrJmunuwL34b0gKygrhxLeQTx3vq+B6M1TVvMybbr415XSY6H5bAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280257; c=relaxed/simple;
	bh=j22au65HdaBV9/wxL1mQFKCZDlgy5XTGw6cGGb6JwdU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jqmoVCUD8vp6Q3Em4lAhOPWqaGrPJ8J2zbgyLPe/2xQ2azMII8F3yAc5CvZztokZGtRcqwCmFM9dZI45onO5CzRqghgzlYPHSoULYdOO/4hX3MMT4s5Bqqip6YIo3Uoid/4zxjOeDOF4kMjpZt8BQhAgAruXFIZ/Jib4sUNFMWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/U7seUk; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/U7seUk"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4a482cb53bdso856739137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729280254; x=1729885054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4YNLMaRUgS6hyjz/qIg09m8X10vksBIUw8WhuPEfJ3Q=;
        b=U/U7seUkXldPkpOCTcMwVtE7a+5vh57fpHOxFA722fGpA8LHqRxSyCqZPTjZGqcr37
         3cjyuxbIeQYK/9jrWjpbJVqBysPkGe9Kp+GfLDj53g/D/PqaTjIIvFo6/JN1veSaiN2O
         vgSQuPhuwF9WLhisP0d+9k1d1HasQ4rl59d39ECTjiC7Fzu/jgBSJwlUHQzmVV4OFKrv
         5/vokN/9E+feZNz4R9yL65H1iA7nPvd8VGSrE/HvVjGoVdl+q0LVkVUs9xCdLDSLF/eM
         Kgty6nORb4sX7GJ1JZJ3CCdy7oycLc6nniGpHigVLoSmmuny+8YHs9ujRKSL62Z3UF/F
         AvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729280254; x=1729885054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YNLMaRUgS6hyjz/qIg09m8X10vksBIUw8WhuPEfJ3Q=;
        b=w8xW0x3we7QS8Df/QPV3snO2aolZC4TaS902yHUy6YO8LPU0dB2yCaNsBjNnJEU+xp
         r3P0Ad0jpHkcn1OEya0uSbAdHNhCH1hJ6biNR3l5UCrnzmMv7YBNAUgid0CXTT7bOSy3
         fcJWQ3nKkVC8uWGTPsuDV7y0xyz5Bz1E423h5Dj5y50l9Dg3DOPI/AkCsLij7r77zuqb
         tHqpQUR7B8pGJCOm6rYaO0IWWw+fniK8/4+0x2oCCumPIjHjYJdYzbnJZnLwT8EE3VeT
         PCysLIalhy0minqFsdqnryHMZjjcTmHq3yLKqLVB4Lx9ZmO/u3uZX3GSsNxZhiHUNOU1
         hyng==
X-Gm-Message-State: AOJu0YwFjdPr9rLucfBUTk4Z6OWEufW8aRVkjaevjiKDvQFUidS0Dtp6
	2tb9nvDvijtjQGOx03HDk2NmVYRrPGClJaM/VIRlCn2SgCA+JfaoNLgENg==
X-Google-Smtp-Source: AGHT+IEpaAFzsHvkQWpjulQOLXcG6X411eXddMuL75sPZDLo0u8qvZL8s0S8RGZdy7Uh7gxHbjjDiQ==
X-Received: by 2002:a05:6102:c04:b0:4a3:cb2b:9745 with SMTP id ada2fe7eead31-4a5d6bb5f1emr4075047137.22.1729280253563;
        Fri, 18 Oct 2024 12:37:33 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a5d636b663sm330466137.30.2024.10.18.12.37.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 12:37:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] doc: Add initial HCI(7) documentation
Date: Fri, 18 Oct 2024 15:37:30 -0400
Message-ID: <20241018193730.1177359-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds initial documentation for HCI sockets.
---
 Makefile.am |   6 +--
 doc/hci.rst | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 3 deletions(-)
 create mode 100644 doc/hci.rst

diff --git a/Makefile.am b/Makefile.am
index 3eb0a5302737..3ced4f87a56e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -352,7 +352,7 @@ CLEANFILES += $(builtin_files)
 
 if MANPAGES
 man_MANS += src/bluetoothd.8
-man_MANS += doc/l2cap.7 doc/rfcomm.7
+man_MANS += doc/hci.7 doc/l2cap.7 doc/rfcomm.7
 man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
@@ -386,7 +386,7 @@ man_MANS += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.Image.5
 endif
 manual_pages += src/bluetoothd.8
-manual_pages += doc/l2cap.7 doc/rfcomm.7
+manual_pages += doct/hci.7 doc/l2cap.7 doc/rfcomm.7
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
@@ -465,7 +465,7 @@ EXTRA_DIST += doc/mgmt-api.txt \
 		doc/health-api.txt \
 		doc/sap-api.txt
 
-EXTRA_DIST += doc/l2cap.rst
+EXTRA_DIST += doc/hci.rst doc/l2cap.rst doc/rfcomm.rst
 
 EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
 		doc/org.bluez.DeviceSet.rst doc/org.bluez.AgentManager.rst \
diff --git a/doc/hci.rst b/doc/hci.rst
new file mode 100644
index 000000000000..d7f192a27d19
--- /dev/null
+++ b/doc/hci.rst
@@ -0,0 +1,152 @@
+===
+hci
+===
+
+----------------------
+Bluetooth HCI protocol
+----------------------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: October 2024
+:Manual section: 7
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+.. code-block::
+
+    #include <sys/socket.h>
+    #include <bluetooth/bluetooth.h>
+    #include <bluetooth/hci.h>
+
+    hci_socket = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+
+DESCRIPTION
+===========
+
+Bluetooth Host Controller Interface (HCI) is the standard protocol to
+communicate with Bluetooth adapters. HCI protocol provides a uniform command
+method for the Host to access Controller capabilities and to control connections
+to other Controllers.
+
+SOCKET ADDRESS
+==============
+
+.. code-block::
+
+    struct sockaddr_hci {
+        sa_family_t    hci_family;
+        unsigned short hci_dev;
+        unsigned short hci_channel;
+    };
+
+Possible values for hci_channel:
+
+.. csv-table::
+    :header: "Define", "Value", "Description"
+    :widths: auto
+
+    **HCI_CHANNEL_RAW**, 0x00, Raw channel - Used for raw HCI communication
+    **HCI_CHANNEL_USER**, 0x01, User channel - Used for userspace HCI communication (disables kernel processing)
+    **HCI_CHANNEL_MONITOR**, 0x02, Monitor channel - Used for monitoring HCI traffic (btmon(1))
+    **HCI_CHANNEL_CONTROL**, 0x03, Control channel - Used to manage local adapters (bluetoothd(7))
+    **HCI_CHANNEL_LOGGING**, 0x04, Logging channel - Used to inject logging messages (bluetoothd(7))
+
+Example:
+
+.. code-block::
+
+    struct sockaddr_hci addr;
+
+    memset(&addr, 0, sizeof(addr));
+    addr.hci_family = AF_BLUETOOTH;
+    addr.hci_dev = HCI_DEV_NONE;
+    addr.hci_channel = HCI_CHANNEL_CONTROL;
+
+SOCKET OPTIONS
+==============
+
+The socket options listed below can be set by using **setsockopt(2)** and read
+with **getsockopt(2)** with the socket level set to SOL_BLUETOOTH or SOL_HCI
+(HCI_FILTER).
+
+HCI_FILTER (since Linux 2.6)
+----------------------------
+
+Filter by HCI events, requires hci_channel to be set to HCI_CHANNEL_RAW,
+possible values:
+
+.. code-block::
+
+    struct hci_filter {
+        uint32_t type_mask;
+        uint32_t event_mask[2];
+        uint16_t opcode;
+    };
+
+Example:
+
+.. code-block::
+
+    struct hci_filter flt;
+
+    memset(&flt, 0, sizeof(flt));
+    flt.type_mask = 1 << BT_H4_EVT_PKT;
+    flt.event_mask[0] = 0xffffffff;
+    flt.event_mask[1] = 0xffffffff;
+
+    setsockopt(fd, SOL_HCI, HCI_FILTER, &flt, sizeof(flt));
+
+BT_SNDBUF (since Linux 5.16)
+----------------------------
+
+Set send buffer size, requires hci_channel to be set to HCI_CHANNEL_MONITOR,
+HCI_CHANNEL_CONTROL or HCI_CHANNEL_LOGGING.
+
+Default value is 1028.
+
+Example:
+
+.. code-block::
+
+    uint16_t mtu = UINT16_MAX;
+    int err;
+
+    err = setsockopt(fd, SOL_BLUETOOTH, BT_SNDMTU, &mtu, sizeof(mtu));
+
+BT_RCVBUF (since Linux 5.16)
+----------------------------
+
+Set receive buffer size, requires hci_channel to be set to HCI_CHANNEL_MONITOR,
+HCI_CHANNEL_CONTROL or HCI_CHANNEL_LOGGING.
+
+Default value is 1028.
+
+Example:
+
+.. code-block::
+
+    uint16_t mtu;
+    socklen_t len;
+    int err;
+
+    len = sizeof(mtu);
+    err = getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU, mtu, &len);
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
+socket(7)
-- 
2.47.0

