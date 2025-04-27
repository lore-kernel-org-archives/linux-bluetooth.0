Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A7BE555
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745762656; cv=pass; b=DE1MFt2oF0VfaQCE2yZ0PHrrJk6un1ulzGcTNYkM19w3sQU+fEvF6AfkoZM6slVGBlVUBmez7Mog0P/2KBjStFHC6am1dUtgiYQzGmwNurb15uEYlQdXFXCwxJH3sZMmLpYQLDPdKENZh6P0KiLyJXuCQ4K/+B5Ljnbrv0NwBes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745762656; c=relaxed/simple;
	bh=dGhcSenYGsIHeyPV0HuSUo6skCzLrMTTXkN5C63IR1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq9GFdCP0I2QhYnvwwJ2ippUEzLl4JwtftpXym2Zv8nguZ2dE/6QvBYZT5ZFBv2Hgn33UYTuUrjmk/zFo9YDI85I6Ff/cw/iCopeIuHQ5uVuh84SQZRnfrt+wEuZUpl/2tM3hY4zegzu+H+ELGtaGfCC1wKAPoRML73Nd/qdzC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=hlsK6evu; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="hlsK6evu"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZlpGb1vlHz49QKM;
	Sun, 27 Apr 2025 17:04:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745762647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtcTYUaxJfmH07a0++G6xx+x+0SWjDw1NZTScnXZglU=;
	b=hlsK6evu/SNyGMgdzHUKI3Ol+SCUAm+zRAfXmhS3F8mQKjx2DHKQ4f435Kz3nQ3dGQmtij
	Mdhq+pB16la5rb6HZhbdsdAU+YLdsqS975xM4nxPLn+hY4T2wq3x68RinC0Hb2RwL1NsXj
	jAqJCyCo+jSxisKQR2UQV9Gs1A88B7ZL3xYuZEDw+Yu7E/wOO5RXwkLjqROWuYVJi2p6TE
	6a7twY4vFmpnsk7ouoFF6G0b2MTm2+tU3/lpnnuusqelm215pJjIHwiPxg5r2hEYiXADmi
	CyTEL24rEB/AWACJdaOQWI0nAgo8JH9Ka2FYWTlNKF/KBjy3bAAwTWEagMSlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745762647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtcTYUaxJfmH07a0++G6xx+x+0SWjDw1NZTScnXZglU=;
	b=uo58w1frdxXIPuUyNQUhWFP+0sRD41d5T10f+Xg31eTlvXs+xe/LwLa+K21aEVr65XbDcR
	hurdUwyDExnkIEz6Re1kV7kIIUwCLOYl2/xsLE+A8d204Vg1Qb5rsw0DhrVM9O5On8gIyO
	RXh7zCt/ry/VBalqyh4Pl7APE+nWH9NTpCoFyZqSQftEUXYRLKr2HStnPg0eXlzd73fwcO
	hsfZMBwFkykx8LriOVg6tcemVqe/IVqgkklOrhcj8+2YLdak1kQ0+6l38jiB/0qptYIceS
	Cs8YkljUH+YMnr5uASDGJEzhzT6d8mgMOI7OF/bSywn+o5JYp17yHvFHTEZg1g==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745762647; a=rsa-sha256;
	cv=none;
	b=KM0VFTJbU9GE0vygfKW8evSq2sHjuGSFpbYZywlNnswEWpX73fRo7bTyyyzcBYAJ+0PgI7
	2wMk5RYaEQ5J/2AboK6F4fBvDRzCKsnmuHTI6acBHkoLE6FP6Hmrt9yWm3/zg3s/FM37oo
	T55sZwzqU2+E/RD0oPWoxlver+PmLC+FGYTcjrh9Ii+LVQNZrqQT63mjaeQAWJQREpk6lA
	7gDC4L4wM0L1lUi1UV9bl+bTM3ikEHhwF3bBEVlVzWt/KQZRw3qGoZDYIMiCCUlx+CXtiz
	3+u+8ZYDXsWRyaIOxj22D2VepXMr6gVJzyI31grK1zK3JY80JQtHVzQj1hOeZg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/2] media: implement SupportedFeatures property
Date: Sun, 27 Apr 2025 17:03:55 +0300
Message-ID: <78f20a0242e5633c13ae8fdf2252498eb174522d.1745762308.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <c304d0b98ed0ce4504549e43a99adcfcaca77521.1745762308.git.pav@iki.fi>
References: <c304d0b98ed0ce4504549e43a99adcfcaca77521.1745762308.git.pav@iki.fi>
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
    v2:
    - use SIOCETHTOOL to get kernel support

 profiles/audio/media.c | 71 ++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h          |  3 ++
 2 files changed, 74 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 69c6dc671..3b25e5d97 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -18,6 +18,14 @@
 #include <errno.h>
 #include <inttypes.h>
 
+#include <time.h>
+#include <linux/errqueue.h>
+#include <linux/net_tstamp.h>
+#include <linux/ethtool.h>
+#include <linux/sockios.h>
+#include <net/if.h>
+#include <sys/ioctl.h>
+
 #include <glib.h>
 
 #include "lib/bluetooth.h"
@@ -81,6 +89,7 @@ struct media_adapter {
 #ifdef HAVE_AVRCP
 	GSList			*players;	/* Players list */
 #endif
+	int			so_timestamping;
 };
 
 struct endpoint_request {
@@ -3340,8 +3349,69 @@ static gboolean supported_uuids(const GDBusPropertyTable *property,
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
 
@@ -3383,6 +3453,7 @@ int media_register(struct btd_adapter *btd_adapter)
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

