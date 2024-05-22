Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7198D7E575
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716410578; cv=none; b=tuY0ok1+bk/urfzWQ579xoHJ1Xrt4wqCsByXUpwh4aXWCQ0oEII/fYm/3eeRJqzmPpnBqwrFhCuW2fsGc41meygf2A0P7SimIh3tFOzVLwSO34qI2G7FBU4M4yVQdVr3nfFTQU4/kf0DZqGOlXHH0uSYpTn5uRtS5GxcMochOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716410578; c=relaxed/simple;
	bh=5jvbGWvClORCs8ssqPzjT4tzJhfsBs6UHVltYH78Wgs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DSKyWSJ0hwn3vVFGiNu//tKxAPcelHGXY1m78zyKaTFDUZIwQfAhLFRfUZOFqqXF+Y+z6FyRMi/ye8+VIH5oH7npU9QFfKieDv5bCEP7XJqCNHzez43tErJBP4okbiP4K54SiQZE2gmyQ67v57o3Fltw+a67cyXBKU4NMuqGsIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcRNOXyf; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcRNOXyf"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4df3e3c674fso2132031e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 13:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716410575; x=1717015375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GiTad0WkrpOGxdvwu/Vf6Dg3jk9yXPS+P/Wgz6N97X0=;
        b=GcRNOXyfcVeo+YTA49UfgHqwXiFZv4+SoCKdN9IlJiniMxMdroDJcsGNwOnKZpICu1
         kmlPtndMV2cQIP8nP9oUw+ACXityRd3EacKL+698UWpFbLoVlzzpU83O3pCjrzyTwvXE
         Y11pgVxcIfo4I7Chy6WvHLAdCqUkZeSs9Cg0OhAgNGjOOzp2+wy6F/zzKYAslUHizKMY
         sJV3UeM14YqrbnIIDvHMWkcPf3E91PSEwJhMiZhEagQaNTGrAlaQzdzrXETZv4+ZDugb
         cr7xmVXbIIkTWAg9YZiVFnd5P9GRRzZqHV+ipvJm52L34GRWZAhjPjsAqtF+VFNBxR1K
         gqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716410575; x=1717015375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GiTad0WkrpOGxdvwu/Vf6Dg3jk9yXPS+P/Wgz6N97X0=;
        b=WcBANrskX21AENcle4f13QBQU29ys/HJzQOH6aqAnbSxFAO1q2SGZjyVyYm1Mr5v/3
         /6zSnO4WRHW7reY9qZT/16pBlHx2l0LU6ZqfRboIlOqgxYS5mTFrxk6LIWvMP0Aoz1SW
         fVaXfjxj87+pyeScNwY1jw/FEW5Mb2qukNGebs6J3lfPNpOFGms1dP8Cytg7CLFSp1Mj
         tkW8sDP5PAZ9h7DfRzhBnTv/qxQfK3FphOtnWJMDtXGSnwGNBhPjE43vODIDPoigwn4/
         isFgJ/IpIXjHt87U00X3ZxBbcjz5AimEX/sZy/46aO15eP0lCl4slObZEBvPD4sFHezM
         QDcA==
X-Gm-Message-State: AOJu0YyoshSlswpEipKQTLsHcE1KmpWtZtlvzzMombeGRK1rr9HyyIS0
	w9SPKYB1PZEy0SIMOI+aKDRwrjxV30aTcbLNcoqFVwfzP+nJjhUj4gr9mQ==
X-Google-Smtp-Source: AGHT+IGFLfJdLdFHHMjbfTXf0RNXOBV8lVw9CGWH0WWfVhonrYtB/boH+B2UeDPqztvwQoy0Bw5C6w==
X-Received: by 2002:a05:6122:318e:b0:4df:31f2:a4d5 with SMTP id 71dfb90a1353d-4e2184e9739mr3094991e0c.4.1716410574515;
        Wed, 22 May 2024 13:42:54 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4df7c050c57sm3749913e0c.36.2024.05.22.13.42.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 13:42:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] doc: Add initial L2CAP(7) documentation
Date: Wed, 22 May 2024 16:42:51 -0400
Message-ID: <20240522204252.1891896-1-luiz.dentz@gmail.com>
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
 doc/l2cap.rst | 241 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 248 insertions(+)
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
index 000000000000..cad0c54f08a6
--- /dev/null
+++ b/doc/l2cap.rst
@@ -0,0 +1,241 @@
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
+    l2cap_socket = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
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
+       sa_family_t	l2_family;
+       unsigned short	l2_psm;
+       bdaddr_t	l2_bdaddr;
+       unsigned short	l2_cid;
+       uint8_t		l2_bdaddr_type;
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
+    int err = setsockopt(l2cap_socket, SOL_BLUETOOTH, BT_SECURITY, &level,
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
+    :header: "Define", "Value", "Description"
+    :widths: auto
+
+    **BT_MODE_BASIC**, 0x00, Basic mode - default
+    **BT_MODE_ERTM**, 0x01, Enhanced Retransmission mode - BR/EDR only
+    **BT_MODE_STREAM**, 0x02, Stream mode - BR/EDR only
+    **BT_MODE_LE_FLOWCTL**, 0x03, Credit based flow control mode - LE only
+    **BT_MODE_EXT_FLOWCTL**, 0x04, Extended Credit based flow control mode
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

