Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0801A239E
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 May 2025 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746257089; cv=pass; b=usUyp0QUNA5eXbvXFkfQj5ta32Y4RYHciATOm03/Mn6WT+sT+d7cJmCXdbwrElAThEp3LC7iZNlSoarLGGejemSVJtHvyd+FdzIujhX+smdGAszTD0gkh6cQg8IrkM92uwxL9nviufVWc3J1RQ4MVsN7pgSVF31LZJXwEMYwZhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746257089; c=relaxed/simple;
	bh=hRlrn2tr3CyXqJPnn1gpfEtTApDxAtqkoh+YPmy8wUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wps2ke69p7SYbJVjrQlUAQmk0xU/jllo7dBdOnlQ1ithKmlethHT+0ezPZVQiBuNhp5SLj/1YANerYExhWMw0Dvt96RWbp0ikElAh0Zo8L5UZhfDh3Nvve0xdm8ym2mgBYF5IapNfJ/RaB7tcpbX7lxn4srQ56S2qIjhmSB8+ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=u6cnVVNI; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="u6cnVVNI"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZqK6n649Pz49Q9m;
	Sat,  3 May 2025 10:24:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1746257074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pu22mXGLh0fAvOPtoLotDADEg6JHukUibIqDCn6wJXk=;
	b=u6cnVVNIwFYosiNDS+GSPvuRyv38zzzl1lvmkajn6CWgAmTQNbxbqihbM7NNz9wSl3jsDa
	b1hGZe1b7d7p9miF+pSZ/3V2TEt7M3ydGDZK38GP3GV9waiH5j9ygzuLYq7aVNV0XEwghk
	z4SWMmmYDxjIpDVGM+3IlB1YWNDRvsuQr3oYf+vyg43UmlwuGQ2WhquyFf1zX5NGgUaOeD
	c+1qhrGVhjiMi+uOWWH6HoK7NR8faCIOBRSG4AM6CY/gV/n8lhPi0lYh825gZ/yFn2ice0
	9dOlUr/T+pkEwBbVy9P3n2qKLpHtOi6NZBT5I69jcgJzUqHthW20gBVFGMxdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1746257074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pu22mXGLh0fAvOPtoLotDADEg6JHukUibIqDCn6wJXk=;
	b=GNxWtIogSq/yEbRhUPlh6EVkYdRonSC53+2Ck71ROzF1Rm9dM58b4QlHp9Gl2/1StLXcgi
	3A/OQZ7gE0jopndyJfNGvPam06cmuJdAbeUyDKjIRXOQ/3AAFJ13M0opgzn7tvqd+fvM/T
	HryaTOZ20JecVw+jSaPQpSLNzIiaX19ItLmTRa/5H9HVkvgmVVpU7KF3JTlTsVy+Yg0pqd
	nUDOvAJ7peIiOxgV9x1K12saJ7mnNE6AYmJfraFANPo4p36lEC+apRllfVtdEUule9PRln
	hB+0et1oiL9kSyeUUpijTMTq0ZVr//d90IzMzRXEyytoU6jDx1Q44GfWWgDPMg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1746257074; a=rsa-sha256;
	cv=none;
	b=lbMOM7lQ7qwy8mqYOWXREfgvz/lv9zApM+wqoqZ6SxDSRP/Hq0X/Sd5EhZ5oMSIwdsj2Nm
	Gp7ihxv33n66D9YGPgT5R248ZnIeZyTpjGRdkA+HIMG2AmRaSvO92QydVJmhfV5pF45HkT
	GmPyAcw+/CSU3xMpMTb9gon6PBekpcuUfzBi21w9Pzyc5WfP30CPDcDcDjSBa5VCN1sngg
	RvexsOtG3vUVtt8b17JlMvy9ApFDJ40rzahR/GDiNowW2NV+atfV/qFYj26Dwt98nz0ovX
	oQLyaS1mGH4BeKi9RGsTNNZGT9x4exuHKM2UsUwQTKhWd7gZBWVoygMkdU/sRw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 2/2] media: implement SupportedFeatures property
Date: Sat,  3 May 2025 10:24:26 +0300
Message-ID: <d7fdd103da8b594055f6343b2689c1663827bedb.1746256909.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6df15922fc4f602c9b10baf640e07859c4d3e958.1746256909.git.pav@iki.fi>
References: <6df15922fc4f602c9b10baf640e07859c4d3e958.1746256909.git.pav@iki.fi>
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
    v4:
    - add code comments
    - remove stray change in adapter.h
    
    v3:
    - fix #includes
    
    v2:
    - use SIOCETHTOOL to get kernel support

 profiles/audio/media.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 69c6dc671..a18ddc9fe 100644
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
@@ -3340,8 +3352,78 @@ static gboolean supported_uuids(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static bool probe_tx_timestamping(struct media_adapter *adapter)
+{
+	struct ifreq ifr = {};
+	struct ethtool_ts_info cmd = {};
+	int sk = -1;
+
+	/* TX timestamping requires support from BlueZ in order to not mistake
+	 * errqueue for socket errors in media stream sockets. This is always
+	 * enabled (io_glib_add_err_watch), so need only check kernel side here.
+	 */
+
+	if (adapter->so_timestamping != -1)
+		goto done;
+
+	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "hci%u",
+				btd_adapter_get_index(adapter->btd_adapter));
+	ifr.ifr_data = (void *)&cmd;
+	cmd.cmd = ETHTOOL_GET_TS_INFO;
+
+	/* Check kernel reports some support for TX timestamping for L2CAP. If
+	 * yes then kernel version is new enough to have TX timestamping
+	 * available for other socket types too.
+	 */
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
 
@@ -3383,6 +3465,7 @@ int media_register(struct btd_adapter *btd_adapter)
 	adapter = g_new0(struct media_adapter, 1);
 	adapter->btd_adapter = btd_adapter_ref(btd_adapter);
 	adapter->apps = queue_new();
+	adapter->so_timestamping = -1;
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					adapter_get_path(btd_adapter),
-- 
2.49.0

