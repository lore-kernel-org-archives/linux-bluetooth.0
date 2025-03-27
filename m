Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D155E69
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743107415; cv=none; b=uIuUB+7tU6KIWsC30kQ9Q+760x5Lse5lETZngc5OJoKBfKL5O0XgDfGVgMmnJGROKH2WRaqW1t4/XPJ//ivt/AHxVmIpMchoPxMG1LotCbfAFEqS/ZKY9aLDM0PLqqi+L83K3dpUVtamnemeuPKgXKOCp0GsIk5OI2kM0/zMyxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743107415; c=relaxed/simple;
	bh=ZFTIB+xW9nvzj4z6rF9KDYqHZazw+amzsvA8zu74QW0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L17T9VvfUTelYZqb5szmX5I0pNRj5vqF1WE+am+IPBs9VEcMS8erD4Uo4O/xYnkHp0lGk7fdEXr+Zt2nO9eif9ZZTgqtvdwMCoB+J21PdwZQJlKxc1Fj5IeqNppnRn99DtKI6D2dXo/uVOUnQGQ8nxM5DLd5lvRnkLOp/53d3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ1w42Fb; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ1w42Fb"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86d5e42c924so1350397241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743107412; x=1743712212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hfsZxVZbAKvntK6riFsn6pEvVDctEtAxLk75q/spNKw=;
        b=kJ1w42FbqhZKsTLVxqb9v7F43S6DINPn3Jcloanpnr48ukQpXZNA++cXUSCVyJqxou
         RzJimg3iJ1kRsu/UyCNw2ZHAvi5vkvwyl5L/sMyuvcmv8gET91KKQ2DRTACmDL/A51CM
         A2iNCrHaGlGPyImWfO4j9blH3Ii7YzfPwHe0GQ9DMw8IRSu5qR5lTgq9XXHqviCIRCYK
         r+XGbH8IPm5hORhdD9yuVgZHbB3LR4l4cLD/sprMlLf0M4VkuC7gNqmp12eLfMgwcobk
         AqxWbNOis6/8F4UFGNGYTzgale6/e55YjfI2NfOulpviljE0P+Qlv4FJyyoy8s+wLlco
         cz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743107412; x=1743712212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfsZxVZbAKvntK6riFsn6pEvVDctEtAxLk75q/spNKw=;
        b=wVweKIOQai3QBu7xu+2OxjindSIQyMrIEh9fnSWX10BBV9YAcTeDdXKLiCvTBPuX9D
         hdhcF74lV+kufGUsKOS4DHoZBTyjOrWtXDGtEj+ay7Hb2Yh7ZY0wFMNUDMjQ/gfzhuaa
         dIEXo1dROYJ13K//HEaZ7Sb0QGeFf0ov29sN6aUuoRGqifuqDuKCGm7kSLWLoEYCD9A5
         G4P5xJ9XazCYXxA82NqTzKCUyXC4syeTXrsQGUg37Npf2yufG129TiIQ3W0AqCHvwMsP
         wfIaiSsGT9FIDzQSGelVZw8KrWmaB0sOoYvPi4D312jkDDMn6/GpDt5bvGC0Nf7SF/iQ
         K+OA==
X-Gm-Message-State: AOJu0YxhqADG25of7hWLjVm2HDSogA6Wmug3F6T6y0+TZ5dfzV9fksq+
	Auqk4e+HctxS9syEgE5Va/GbMAxLa+18gMnhjh6U4TLdUluCoxxN7hqOphsh
X-Gm-Gg: ASbGnctVm99oupSvVoItV5VcjMIX1qCC9n56jELaiX/Posy46AZSrOF3HOg3Ghd0lmx
	cl6y7mt1lJJ7UsR/G/nV886wEJEhhfNoVoPE8Z70LVG8jfVzeWxF2tbJ1btthsqZQop51oaV1Db
	vd9rAxmRzI0lwNLsxezKNrD/LDbH4eKvJ1VOxm4epINvAf9d+bhxqiLclWKKyBkJuduowExrehG
	I59wdIMfaJFAqVTz7NeV+E+h679K0k1ueQtQrFklO/fMvMThLbMMdVrX20xibE3hFi2/19ZDTGe
	Ql0FB8ZygGSZMK2hsRAhx2GMYOH5ouezM7kga8BIDr7yIS7ePw24Auw8VAWI9uOHnkxNvSCam6z
	Lc4mUFI+xiK0c2Q==
X-Google-Smtp-Source: AGHT+IFh505pfqmfbzCmR4UfFlacSvu3FpM1D7BKS0+ndBmF+rx2aA3CNHm/HcaOv+E8fRwZISBHpQ==
X-Received: by 2002:a05:6102:330f:b0:4c4:e414:b4e4 with SMTP id ada2fe7eead31-4c586f977a7mr5601462137.11.1743107411552;
        Thu, 27 Mar 2025 13:30:11 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c6bfe5e190sm102306137.27.2025.03.27.13.30.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 13:30:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] doc: Add initial SCO(7) documentation
Date: Thu, 27 Mar 2025 16:30:06 -0400
Message-ID: <20250327203006.2936448-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds initial documentation for SCO sockets.
---
 Makefile.am |   6 +-
 doc/sco.rst | 260 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 263 insertions(+), 3 deletions(-)
 create mode 100644 doc/sco.rst

diff --git a/Makefile.am b/Makefile.am
index 0821530e68df..dc9a27e8069b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -356,7 +356,7 @@ CLEANFILES += $(builtin_files)
 
 if MANPAGES
 man_MANS += src/bluetoothd.8
-man_MANS += doc/hci.7 doc/l2cap.7 doc/rfcomm.7
+man_MANS += doc/hci.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7
 man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
@@ -390,7 +390,7 @@ man_MANS += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.Image.5
 endif
 manual_pages += src/bluetoothd.8
-manual_pages += doc/hci.7 doc/l2cap.7 doc/rfcomm.7
+manual_pages += doc/hci.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
@@ -469,7 +469,7 @@ EXTRA_DIST += doc/mgmt-api.txt \
 		doc/health-api.txt \
 		doc/sap-api.txt
 
-EXTRA_DIST += doc/hci.rst doc/l2cap.rst doc/rfcomm.rst
+EXTRA_DIST += doc/hci.rst doc/l2cap.rst doc/rfcomm.rst doc/sco.rst
 
 EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
 		doc/org.bluez.DeviceSet.rst doc/org.bluez.AgentManager.rst \
diff --git a/doc/sco.rst b/doc/sco.rst
new file mode 100644
index 000000000000..27072330d6ce
--- /dev/null
+++ b/doc/sco.rst
@@ -0,0 +1,260 @@
+===
+sco
+===
+-------------
+SCO transport
+-------------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under the terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: March 2025
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
+    #include <bluetooth/sco.h>
+
+    sco_socket = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
+
+DESCRIPTION
+===========
+
+The SCO logical transport, is a symmetric, point-to-point transport between the
+Central and a specific Peripheral. The SCO logical transport reserves slots and
+can therefore be considered as a circuit-switched connection between the Central
+and the Peripheral.
+
+In addition to the reserved slots, when eSCO is supported, a retransmission
+window follows immediately after. Together, the reserved slots and the
+retransmission window form the complete eSCO window.
+
+SOCKET ADDRESS
+==============
+
+.. code-block::
+
+    struct sockaddr_sco {
+        sa_family_t     sco_family;
+        bdaddr_t        sco_bdaddr;
+    };
+
+Example:
+
+.. code-block::
+
+    struct sockaddr_sco addr;
+
+    memset(&addr, 0, sizeof(addr));
+    addr.sco_family = AF_BLUETOOTH;
+    bacpy(&addr.sco_bdaddr, bdaddr);
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
+.. code-block::
+
+    int level = BT_SECURITY_HIGH;
+    int err = setsockopt(sco_socket, SOL_BLUETOOTH, BT_SECURITY, &level,
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
+.. code-block::
+
+    int defer_setup = 1;
+    int err = setsockopt(sco_socket, SOL_BLUETOOTH, BT_DEFER_SETUP,
+                         &defer_setup, sizeof(defer_setup));
+    if (err == -1) {
+        perror("setsockopt");
+        return err;
+    }
+
+    err = listen(sco_socket, 5);
+    if (err) {
+        perror("listen");
+        return err;
+    }
+
+    struct sockaddr_sco remote_addr = {0};
+    socklen_t addr_len = sizeof(remote_addr);
+    int new_socket = accept(sco_socket, (struct sockaddr*)&remote_addr,
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
+BT_VOICE (since Linux 3.11)
+-----------------------------
+
+Transport voice settings, possible values:
+
+.. code-block::
+
+    struct bt_voice {
+        uint16_t setting;
+    };
+
+.. csv-table::
+    :header: "Define", "Value", "Description"
+    :widths: auto
+
+    **BT_VOICE_TRANSPARENT**, 0x0003, Transparent output
+    **BT_VOICE_CVSD_16BIT**, 0x0060, C-VSD output PCM 16-bit input
+    **BT_VOICE_TRANSPARENT_16BIT**, 0x0063, Transparent output PCM 16-bit input
+
+Example:
+
+.. code-block::
+
+    struct bt_voice voice;
+
+    memset(&voice, 0, sizeof(voice));
+    voice.setting = BT_VOICE_TRANSPARENT;
+    int err = setsockopt(sco_socket, SOL_BLUETOOTH, BT_VOICE, &voice,
+                         sizeof(voice));
+    if (err == -1) {
+        perror("setsockopt");
+        return 1;
+    }
+
+BT_PHY (since Linux 5.10)
+-------------------------
+
+Transport supported PHY(s), possible values:
+
+.. csv-table::
+    :header: "Define", "Value", "Description"
+    :widths: auto
+
+    **BT_PHY_BR_1M_1SLOT**, BIT 0, BR 1Mbps 1SLOT
+    **BT_PHY_BR_1M_3SLOT**, BIT 1, BR 1Mbps 3SLOT
+    **BT_PHY_BR_2M_1SLOT**, BIT 3, EDR 2Mbps 1SLOT
+    **BT_PHY_BR_2M_3SLOT**, BIT 4, EDR 2Mbps 3SLOT
+    **BT_PHY_BR_3M_1SLOT**, BIT 6, EDR 3Mbps 1SLOT
+    **BT_PHY_BR_3M_3SLOT**, BIT 7, EDR 3Mbps 3SLOT
+
+BT_CODEC (since Linux 5.14)
+---------------------------
+
+Transport codec offload, possible values:
+
+.. code-block::
+
+    struct bt_codec {
+        uint8_t id;
+        uint16_t cid;
+        uint16_t vid;
+        uint8_t data_path_id;
+        uint8_t num_caps;
+        struct codec_caps {
+            uint8_t len;
+            uint8_t data[];
+        } caps[];
+    } __attribute__((packed));
+
+    struct bt_codecs {
+        uint8_t num_codecs;
+        struct bt_codec codecs[];
+    } __attribute__((packed));
+
+Example:
+
+.. code-block::
+
+    char buffer[sizeof(struct bt_codecs) + sizeof(struct bt_codec)];
+    struct bt_codec *codecs = (void *)buffer;
+
+    memset(codecs, 0, sizeof(codecs));
+    codec->num_codecs = 1;
+    codecs->codecs[0].id = 0x05;
+    codecs->codecs[0].data_path_id = 1;
+
+    int err = setsockopt(sco_socket, SOL_BLUETOOTH, BT_CODEC, codecs,
+                         sizeof(buffer));
+    if (err == -1) {
+        perror("setsockopt");
+        return 1;
+    }
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
+socket(7), scotest(1)
-- 
2.48.1

