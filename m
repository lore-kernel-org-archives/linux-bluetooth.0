Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A0118C03F
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745771141; cv=pass; b=hIrSqneNo69PxTfYMe8ntux+tA2M2FycHMLTxZDGiIgsC1LPqduAb+S1B1XrL/N8yRydXT3b753dj8Q/eEZEqXQis2xD2++AIKBiv+MDaBC9XdVFo0IWs06+G3OOoCWKd6Fu/tGF5viSbvC+apI1RdG+1/yYZ0oZtxI3ce/Z608=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745771141; c=relaxed/simple;
	bh=s0vguNMAvycIk0qCDpXcUdq85zsxmaE4okP6ikVtavc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8aGzKkxnrNwXmAJQgLc6Abtley1Vk8WPRptxmzr2gy19dTk0Tniph0Df/yGU0dw7c3IpYiudBBmiLgbjchsSfEXFEYn91pB4Y+5QFMOo2cjk58C34vPZUCSj/qUCR+ezBIpYisobXU3N1maTlgD6OElQWgLTEnBoxg1RjP8XyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=XtD4jgGd; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="XtD4jgGd"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ZlsPq53btzytj;
	Sun, 27 Apr 2025 19:25:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1745771136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jhph63JJT5O3GE9zFS1M2JE0OfrBEKzHmp2lbIj3lY=;
	b=XtD4jgGdo5uN8KMgacG+d50Y0Tn0vPQtDGQ7ZXy8kUa/CpgAZtUmh5wlN4f3TztjmArMq+
	vedHJB4Tl+VY8h/NDmQPjGb1HxCi4o3F5c/QWWxg2cIiUFgGGLVfTfTNiJTDfdbNPvI8Td
	kQJvPvESt0gk9ALc1s6+nGZIvMmIhtc=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1745771136; a=rsa-sha256; cv=none;
	b=SHB6KT+K1ASdAr4a6Pa1evDFfHbt0Y/QHrZpINIW/3f+8ITn4bqgbh8UdK7xQmpREtK+zA
	0A+JebgYW9UBLBKx/Omu0X9c0gyQMmnHw9Dk8fV6Z+ktrGcWKRGIknQFnCnB5vC8PQ/A4X
	X1ezj/CFqF9mEvIavfoxWuXFFzP4dnw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1745771136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jhph63JJT5O3GE9zFS1M2JE0OfrBEKzHmp2lbIj3lY=;
	b=lezvhnKp2zwzxiuRKSmmSPpCPy61HyVBfPHIQWYdKakwJbJxokmyaGqEooeecH3gcsQnMR
	bi5o9jdt7FnwitQz4ImmhGCNKxnTuPwoHbH94FEa3U9cYVFmNbNnZ25F7hXSf/b1t/CUzK
	ZSyrRleYYh4WDHnWdC7rHQgMF2l04d0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 2/2] media: implement SupportedFeatures property
Date: Sun, 27 Apr 2025 19:25:30 +0300
Message-ID: <ed970951e6eaef866ebec82f47fb49929a9f1ea2.1745771127.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <c304d0b98ed0ce4504549e43a99adcfcaca77521.1745771127.git.pav@iki.fi>
References: <c304d0b98ed0ce4504549e43a99adcfcaca77521.1745771127.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add org.bluez.Media.SupportedFeatures. Add feature tx-timestamping.
---

Notes:
    v3:
    - fix #includes
    
    v2:
    - use SIOCETHTOOL to get kernel support

 profiles/audio/media.c | 74 ++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h          |  3 ++
 2 files changed, 77 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 69c6dc671..07264cfa1 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -18,6 +18,17 @@
 #include <errno.h>
 #include <inttypes.h>
 
+#include <time.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <linux/errqueue.h>
+#include <linux/net_tstamp.h>
+#include <linux/ethtool.h>
+#include <linux/sockios.h>
+#include <net/if.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+
 #include <glib.h>
 
 #include "lib/bluetooth.h"
@@ -81,6 +92,7 @@ struct media_adapter {
 #ifdef HAVE_AVRCP
 	GSList			*players;	/* Players list */
 #endif
+	int			so_timestamping;
 };
 
 struct endpoint_request {
@@ -3340,8 +3352,69 @@ static gboolean supported_uuids(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static bool probe_tx_timestamping(struct media_adapter *adapter)
+{
+	struct ifreq ifr = {};
+	struct ethtool_ts_info cmd = {};
+	int sk = -1;
+
+	if (adapter->so_timestamping != -1)
+		goto done;
+
+	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "hci%u",
+				btd_adapter_get_index(adapter->btd_adapter));
+	ifr.ifr_data = (void *)&cmd;
+	cmd.cmd = ETHTOOL_GET_TS_INFO;
+
+	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+	if (sk < 0)
+		goto error;
+	if (ioctl(sk, SIOCETHTOOL, &ifr))
+		goto error;
+	close(sk);
+
+	adapter->so_timestamping = cmd.so_timestamping;
+
+done:
+	return adapter->so_timestamping & SOF_TIMESTAMPING_TX_SOFTWARE;
+
+error:
+	if (sk >= 0)
+		close(sk);
+	adapter->so_timestamping = 0;
+	return false;
+}
+
+static const struct {
+	const char *name;
+	bool (*probe)(struct media_adapter *adapter);
+} features[] = {
+	{ "tx-timestamping", probe_tx_timestamping },
+};
+
+static gboolean supported_features(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_adapter *adapter = data;
+	DBusMessageIter entry;
+	size_t i;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &entry);
+
+	for (i = 0; i < ARRAY_SIZE(features); ++i)
+		if (features[i].probe(adapter))
+			dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+							&features[i].name);
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable media_properties[] = {
 	{ "SupportedUUIDs", "as", supported_uuids },
+	{ "SupportedFeatures", "as", supported_features },
 	{ }
 };
 
@@ -3383,6 +3456,7 @@ int media_register(struct btd_adapter *btd_adapter)
 	adapter = g_new0(struct media_adapter, 1);
 	adapter->btd_adapter = btd_adapter_ref(btd_adapter);
 	adapter->apps = queue_new();
+	adapter->so_timestamping = -1;
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					adapter_get_path(btd_adapter),
diff --git a/src/adapter.h b/src/adapter.h
index 6b2bc28f6..9371cdefb 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -262,6 +262,9 @@ bool btd_le_connect_before_pairing(void);
 
 bool btd_adapter_has_settings(struct btd_adapter *adapter, uint32_t settings);
 
+int btd_adapter_get_so_timestamping(struct btd_adapter *adapter, int proto,
+							int *so_timestamping);
+
 enum experimental_features {
 	EXP_FEAT_DEBUG			= 1 << 0,
 	EXP_FEAT_LE_SIMULT_ROLES	= 1 << 1,
-- 
2.49.0

