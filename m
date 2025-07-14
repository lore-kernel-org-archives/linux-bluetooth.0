Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED226528B
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514608; cv=pass; b=XUOU8js5wp3zYg5KxYxqUXcg6CX854KmRZmWuSsXU/XsPJ7IxXzk4R1KORvKc+e1XPozwQFdMYv9W9cDHq91YkvO4LTDdC/mjRYBSjdYafhLJVfENcam0RhBaJhsL+tAfsvBtqdYKuZGPlqoGZSgUeJndW0R/t00PAAc/VIYa34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514608; c=relaxed/simple;
	bh=JQHw1zEfuppHRu47jnwlJUJNrf9i4wVDsWtc8hPWBLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4VeF/i6l02YyPShPQNQHJSjZ9MqEMLOTdRwv6jgZTwjNoflGTwQpm/YJ0BhJqNUh7eXGkFDu22HOHLUxNC1NC83z/RKzFULQQkEz1Hes35kR/fAdby7zvqviNF8RTr/kvyYihaKf+ovV4svst3Vf9S6O4DVB7GSLpsq55uvtS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=flLzHeza; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="flLzHeza"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bgqHq2mp8z49Psw;
	Mon, 14 Jul 2025 20:36:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1752514599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y5TyKPfHbT1qIyz5HHgp54Vs/U3Wcjwm4BtCN8Sh1DQ=;
	b=flLzHeza/pIZLORmhyaJYkR9PQkrKHaDWGn3pv5kQWQhr9yTt5qGM/6Mkg2JWJCWGdFyed
	eZdyV+2N75wuFVeNRns6TLGeVElF2JjCDPooKTu2sdusNpP3Svn+GKYsfAIat83u9rcNRP
	hMLaw6ODqOrFGtyl/yqaGNSjbmX1qt3nzCRhOznlNk48X9TEL1gmVUKt8W+XrPxjiW1LnI
	1OHDw0S9TUcHFbvbZyL+vg8wAlNed8lFdpp/6XUJ/d00hamjJyuS2Q8fIjM9Ikh8UBcqkR
	ExL8snW8myNlH+GCWQpc4K5q0nCgYr4x7pksAUsUagtZ/geyDXQB9gb347apbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1752514599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y5TyKPfHbT1qIyz5HHgp54Vs/U3Wcjwm4BtCN8Sh1DQ=;
	b=WEwFXWf7ORjDkSo8o2/wuL8F+mKYlUH4cXgXbIMDwqTk5/YRdXPvJfcjsYzSXx6IQDVHIh
	mhXIjfi8L/Tn/kKLvHbgz7H+GYtpUj6P29FBRDcDKBUeDec7EzWoLf3fVOET/pSr9j40d3
	R8388cWUCpZUrq085O0hKRjsDarbJf/Cj3aNrTot5BKLKqom+E3y3BxVuLmTv2gJy6/D9K
	lKO7xA6qnz3a3VfWVfGvAJPhua9wUWjuaFDRjvB36kX8XYo0Ku+KnwkB8fsXzOCVrmK045
	Qnn7TS7H+kpkbHebjYWvmd5aCvskN23xekX/OC3kkP4/opL/TNyBncMGlagSjQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1752514599; a=rsa-sha256;
	cv=none;
	b=DCvpVP5i9j2/zuRktt+/7NgHgG9sfDb6QyVW5qlpq0uAUxR0ODIEVm4GKk/o9V7Xm9c8gs
	WZyBO4MRXaXg2uve/FSw/WbpNNaX7OQC3JcKSvUqW9KdOF/DfI9kmnPYIpT0mXGp9aTpP3
	QxbrT+7lVPAwVV4pPFn8VNfIVy55WgfFPF6nfOX4F1HlH9hxAiuI+kAKJ31HK8PwpTNYWc
	JKzxFxWmc5tgTubyHPnooPnR/36NS/sDnOBgLVlOnitrPOjIn4db9Fj/8gjXmysYj9yjSk
	Zd7V78dbYVaH0W1V9tUzSsEwfNn4GyZYLY9WT/4VHqrElCx3Ba8OJEjVenn2eA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] doc: explain SCO and L2CAP timestamping related socket features
Date: Mon, 14 Jul 2025 20:36:35 +0300
Message-ID: <8968b3ef55340c6d7b16c33685aa87e3368b526f.1752514576.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add explanations and examples for SCO and L2CAP timestamping-related
features.
---
 doc/l2cap.rst | 166 ++++++++++++++++++++++++++++++++++++++++++++++++-
 doc/sco.rst   | 168 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 330 insertions(+), 4 deletions(-)

diff --git a/doc/l2cap.rst b/doc/l2cap.rst
index 0b6f1bb99..d53438924 100644
--- a/doc/l2cap.rst
+++ b/doc/l2cap.rst
@@ -67,8 +67,8 @@ Example:
 
     addr.l2_bdaddr_type = bdaddr_type;
 
-SOCKET OPTIONS
-==============
+SOCKET OPTIONS (SOL_BLUETOOTH)
+==============================
 
 The socket options listed below can be set by using **setsockopt(2)** and read
 with **getsockopt(2)** with the socket level set to SOL_BLUETOOTH.
@@ -242,6 +242,168 @@ Channel Mode, possible values:
     **BT_MODE_LE_FLOWCTL**, 0x03, Credit based flow control mode, LE
     **BT_MODE_EXT_FLOWCTL**, 0x04, Extended Credit based flow control mode, Any
 
+
+SOCKET OPTIONS (SOL_SOCKET)
+===========================
+
+``SOL_SOCKET`` level socket options that modify generic socket
+features (``SO_SNDBUF``, ``SO_RCVBUF``, etc.) have their usual
+meaning, see **socket(7)**.
+
+The ``SOL_SOCKET`` level L2CAP socket options that have
+Bluetooth-specific handling in kernel are listed below.
+
+SO_TIMESTAMPING, SO_TIMESTAMP, SO_TIMESTAMPNS
+---------------------------------------------
+
+See https://docs.kernel.org/networking/timestamping.html
+
+For L2CAP sockets, software RX timestamps are supported.  Software TX
+timestamps (SOF_TIMESTAMPING_TX_SOFTWARE,
+SOF_TIMESTAMPING_TX_COMPLETION) are supported since Linux 6.15.
+
+The software RX timestamp is the time when the kernel received the
+packet from the controller driver.
+
+The ``SCM_TSTAMP_SND`` timestamp is emitted when packet is sent to the
+controller driver.  The ``SCM_TSTAMP_COMPLETION`` timestamp is emitted
+when controller reports the packet completed.  Other TX timestamp
+types are not supported.
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
+       SOF_TIMESTAMPING_TX_COMPLETION |
+       SOF_TIMESTAMPING_OPT_ID;
+   setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
+
+Example (Read TX timestamps):
+
+.. code-block::
+
+   union {
+       char buf[2 * CMSG_SPACE(sizeof(struct scm_timestamping))];
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
+The following ioctls with operation specific for L2CAP sockets are
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
+   sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+   if (sk < 0)
+       goto error;
+   if (ioctl(sk, SIOCETHTOOL, &ifr))
+       goto error;
+
+   sof_available = cmd.so_timestamping;
+
 RESOURCES
 =========
 
diff --git a/doc/sco.rst b/doc/sco.rst
index a8fe3e87f..766a1bf1e 100644
--- a/doc/sco.rst
+++ b/doc/sco.rst
@@ -55,8 +55,8 @@ Example:
     addr.sco_family = AF_BLUETOOTH;
     bacpy(&addr.sco_bdaddr, bdaddr);
 
-SOCKET OPTIONS
-==============
+SOCKET OPTIONS (SOL_BLUETOOTH)
+==============================
 
 The socket options listed below can be set by using **setsockopt(2)** and read
 with **getsockopt(2)** with the socket level set to SOL_BLUETOOTH.
@@ -244,6 +244,170 @@ Example:
         return 1;
     }
 
+
+SOCKET OPTIONS (SOL_SOCKET)
+===========================
+
+``SOL_SOCKET`` level socket options that modify generic socket
+features (``SO_SNDBUF``, ``SO_RCVBUF``, etc.) have their usual
+meaning, see **socket(7)**.
+
+The ``SOL_SOCKET`` level SCO socket options that have
+Bluetooth-specific handling in kernel are listed below.
+
+SO_TIMESTAMPING, SO_TIMESTAMP, SO_TIMESTAMPNS
+---------------------------------------------
+
+See https://docs.kernel.org/networking/timestamping.html
+
+For SCO sockets, software RX timestamps are supported.  Software TX
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
+supported on controllers that have SCO flow control.  Other TX
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
+The following ioctls with operation specific for SCO sockets are
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
+   sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
+   if (sk < 0)
+       goto error;
+   if (ioctl(sk, SIOCETHTOOL, &ifr))
+       goto error;
+
+   sof_available = cmd.so_timestamping;
+
 RESOURCES
 =========
 
-- 
2.50.1

