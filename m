Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1841802B
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562035; cv=none; b=AGIJGMNL6477oS1L9PhWAGYz8zl8Wung3yn9D0R1Rk91xYVz2viI9DDkAjBiHkoXysIPlpTJ9bUFBgFSj3R7Nen82eNF020BeVQqLc6B9T/4xwpo+vJPEsVNlgE6u3EPl0N1fjqvOSptM9iIoKRoJxtZYLQi1yuRGdXoW/KKm7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562035; c=relaxed/simple;
	bh=slLkFIQQwp4YCR46UuwSs0pkpKboq6Or+sBKJOb5LCE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QxCl4kti2JQq8v7AX1hf+1fgFEjkFuSyLiSvzT2Q8zy7Aj1zJENLJ0JMOEGgNAvX1q8vqH51tAWSjxIpYcaPAQwXCwtgJHMT5JZDtjZxlSdcKH9mzAB4MoZatW/PHwUDpVETH7AbJnWARsRCZcHwNHZP535Y0sOqoKJbYswUeQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNIGb7Y2; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNIGb7Y2"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4e4f01fd479so378965e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716562032; x=1717166832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPktvztnnJjTcO+WqhDZpBrbuDpjY5IcZpSTsnejYbU=;
        b=aNIGb7Y2TFnrdPGz4edGJhSx2aFF8D7rKJynU6c0Nwu+eYh8YpQKpeqH/Y4v+Lsc2t
         9NB/81SvkzWk0pJ4DJZoZoC9p/Kg2VBSxtpbHMc/Rz+5JXUkpuaWHWqrJ1vHWn32jpXm
         8nLKOON+0VAoKBJwiRqNseL6m7xoTlezT7ETRMYPKQK+uWZkXdsHxKE+3/JK9SLXXfEl
         6EuvFUTPkVJvJlcjRMuhGsb66WJaquokUsHFGGUsS4HvklT3XdxQ4E8b4GBngLc/x5V4
         9yYfim0Iec9e6yspJMu6S5NCVLb3gIqI5fE6PUTMh5ZXOKtLZ1hIcbk7UuA5ddwPvRI7
         eqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716562032; x=1717166832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPktvztnnJjTcO+WqhDZpBrbuDpjY5IcZpSTsnejYbU=;
        b=bwoIbnNR/eNPMEpih4b87kDLiV8BLs8XH2lBM+vdoZeByyy99s0GyiwQJxgM4wvB6w
         aI2X3JL9nzbUwP/4HH0PEfUlV0JEZjiV1KQzzfxQRwp+1cifp0SuA9RqsMzuyXRxKSFX
         aN0Dt4wAfanqJCa8CU99eqptXFGHF2QjI/PE51+kLR1ZKPlwKDRpDwhVnzxa8xh/UgVi
         fDJquGwlCIC/tfx7yMnwcljin8BNHTGfCzFAKRP9n6LqvC4dSCZlVmWzazSQsiEl6szk
         okxy/Kbt+d1j68CQNirOUAuuNRclEyX0bBEgYMdoHtjgBBzPT1PnGpgfs0RerNkhI47L
         HHZg==
X-Gm-Message-State: AOJu0YxqSv8jkeK46CppDUqldYLnawHdkLl3ViATAkatVKb292ZuU+td
	PQtGS41v5FOtLTKhgcnABrOJ7Dr0bFP+vGoHy/E5xorrrDdwgBH3DrjQzw==
X-Google-Smtp-Source: AGHT+IHGMpWR4nP8CXoozCr9xgkod2umltqiW+91xg91oV9a8dLEzoDBa9FFXA4kjzi6PtasjvCbWA==
X-Received: by 2002:a05:6122:2512:b0:4df:1a28:5e3c with SMTP id 71dfb90a1353d-4e4f012040bmr2706349e0c.0.1716562031725;
        Fri, 24 May 2024 07:47:11 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4e4f07ee2d6sm228625e0c.56.2024.05.24.07.47.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:47:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/2] doc: Add initial L2CAP(7) documentation
Date: Fri, 24 May 2024 10:47:08 -0400
Message-ID: <20240524144709.2274991-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds initial documentation for L2CAP sockets.
---
 Makefile.am   |   7 ++
 doc/l2cap.rst | 258 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 265 insertions(+)
 create mode 100644 doc/l2cap.rst

diff --git a/Makefile.am b/Makefile.am
index 05d02932f205..8aedbb20d0d8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -348,6 +348,7 @@ CLEANFILES += $(builtin_files)
 
 if MANPAGES
 man_MANS += src/bluetoothd.8
+man_MANS += doc/l2cap.7
 man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
@@ -380,6 +381,7 @@ man_MANS += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5
 endif
 manual_pages += src/bluetoothd.8
+manual_pages += doc/l2cap.7
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
@@ -457,6 +459,8 @@ EXTRA_DIST += doc/mgmt-api.txt \
 		doc/health-api.txt \
 		doc/sap-api.txt
 
+EXTRA_DIST += doc/l2cap.rst
+
 EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
 		doc/org.bluez.DeviceSet.rst doc/org.bluez.AgentManager.rst \
 		doc/org.bluez.Agent.rst doc/org.bluez.ProfileManager.rst \
@@ -758,6 +762,9 @@ endif
 %.5: %.rst Makefile
 	$(RST2MAN_PROCESS)
 
+%.7: %.rst Makefile
+	$(RST2MAN_PROCESS)
+
 %.8: %.rst Makefile
 	$(RST2MAN_PROCESS)
 
diff --git a/doc/l2cap.rst b/doc/l2cap.rst
new file mode 100644
index 000000000000..2486f7c6f55a
--- /dev/null
+++ b/doc/l2cap.rst
@@ -0,0 +1,258 @@
+=====
+l2cap
+=====
+
+--------------
+L2CAP protocol
+--------------
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
+    #include <bluetooth/l2cap.h>
+
+    l2cap_socket = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+
+DESCRIPTION
+===========
+
+L2CAP is a protocol that provides an interface for higher-level protocols to
+send and receive data over a Bluetooth connection. L2CAP sits on top of the
+Bluetooth Host Controller Interface (HCI) and provides a set of channels that
+can be used by higher-level protocols to transmit data.
+
+L2CAP provides a number of services to higher-level protocols, including
+segmentation and reassembly of large data packets and flow control to prevent
+overloading of the receiver. L2CAP also supports multiple channels per
+connection, allowing for concurrent data transmission using different protocols.
+
+SOCKET ADDRESS
+==============
+
+.. code-block:: c
+
+    struct sockaddr_l2 {
+        sa_family_t	l2_family;
+        unsigned short	l2_psm;
+        bdaddr_t	l2_bdaddr;
+        unsigned short	l2_cid;
+        uint8_t		l2_bdaddr_type;
+    };
+
+Example:
+
+.. code-block:: c
+
+    struct sockaddr_l2 addr;
+
+    memset(&addr, 0, sizeof(addr));
+    addr.l2_family = AF_BLUETOOTH;
+    bacpy(&addr.l2_bdaddr, bdaddr);
+
+    if (cid)
+        addr.l2_cid = htobs(cid);
+    else
+        addr.l2_psm = htobs(psm);
+
+    addr.l2_bdaddr_type = bdaddr_type;
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
+    int err = setsockopt(l2cap_socket, SOL_BLUETOOTH, BT_SECURITY, &level,
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
+    int err = setsockopt(l2cap_socket, SOL_BLUETOOTH, BT_DEFER_SETUP,
+                         &defer_setup, sizeof(defer_setup));
+    if (err == -1) {
+        perror("setsockopt");
+        return err;
+    }
+
+    err = listen(l2cap_socket, 5);
+    if (err) {
+        perror("listen");
+        return err;
+    }
+
+    struct sockaddr_l2 remote_addr = {0};
+    socklen_t addr_len = sizeof(remote_addr);
+    int new_socket = accept(l2cap_socket, (struct sockaddr*)&remote_addr,
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
+    **BT_PHY_LE_1M_TX**, BIT 9, LE 1Mbps TX
+    **BT_PHY_LE_1M_RX**, BIT 10, LE 1Mbps RX
+    **BT_PHY_LE_2M_TX**, BIT 11, LE 2Mbps TX
+    **BT_PHY_LE_2M_RX**, BIT 12, LE 2Mbps RX
+    **BT_PHY_LE_CODED_TX**, BIT 13, LE Coded TX
+    **BT_PHY_LE_CODED_RX**, BIT 14, LE Coded RX
+
+BT_MODE (since Linux 5.10)
+--------------------------
+
+Channel Mode, possible values:
+
+.. csv-table::
+    :header: "Define", "Value", "Description", "Link"
+    :widths: auto
+
+    **BT_MODE_BASIC**, 0x00 (default), Basic mode, Any
+    **BT_MODE_ERTM**, 0x01, Enhanced Retransmission mode, BR/EDR
+    **BT_MODE_STREAM**, 0x02, Stream mode, BR/EDR
+    **BT_MODE_LE_FLOWCTL**, 0x03, Credit based flow control mode, LE
+    **BT_MODE_EXT_FLOWCTL**, 0x04, Extended Credit based flow control mode, Any
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
+socket(7), l2test(1)
-- 
2.45.1

