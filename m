Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B75F33C199
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164259; cv=pass; b=iAe/gCA7wAzS9BmhXPexDffUrrLazkftXaZHVTp40iBIBq3509d4WVKFvlPniNNzsrYKF+8RsEsJtTI/Rw1aEi222NuZNHe+NlhY6snhQmnqKMrew2knMxeiLA2s0r18Xgp3rCCUsBufPATiKrRzzgZxvxfGkSaHGCsy98Gjm6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164259; c=relaxed/simple;
	bh=7W+zzMQIPnbx1KY79KILe0Z8LoLdiE1iUk89Pu+57No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IM+Xf+Ik0DYiVIQpBWmIPNH5Qg0PiLtcO9IXttXDkMTMdR+lbwV0Fn75z8WWe1QiT6XC2vuEzuwsGD9hEXJcFgNAdGE6A9uZRksaRUTNRcEQUVCyj08an2VQ92ubOAj7681z6vvOkQ9Nk2Bk5OR1ZX2jPoZmQFiwnTr4Z+34pyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=D8cEXsUv; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="D8cEXsUv"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dXvF24RrVz105D;
	Fri, 19 Dec 2025 19:10:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1766164247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akKv7tnb1dWScoBcFQZDRXjZpKY7xbXjB1iZwXKhYnU=;
	b=D8cEXsUvFzSROLDfBd3KsnDBBXAHTXsXgpUfJRKzW9ixg5O/AgUfdFO2L9hgQI9VGLnfEx
	F31Zw8/eKZ9dpsy9cIQSl2nvoiWQz3B6yfkneGHfwoPNkWp5KoYfjUSyHyk8tAuC4403mZ
	hN8q9NYDdXrahMZMwzNcpVjlJvDyw/s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1766164247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akKv7tnb1dWScoBcFQZDRXjZpKY7xbXjB1iZwXKhYnU=;
	b=wUQcTjEu85RBFQ5MCuA8uUqmKHTjxCNodpS5tXuAoWh/lloMyTVhiPcjvW+jNNLRI8dgw4
	Po4T7KLyh5CGeHAd4GEjQIJKx12H515EHMPoKiKFmt94MufgZXb+SnLOdcnMGF51OiaHWk
	2nrJ3Gh14CPEtL7KITDp62ZhuFzfHf4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1766164247;
	b=rJvn/lOzz+Sqzzjq3mMwHYc2aqx3qaSILDt4ZGE2sy+t8FeWmicPFSD9uhEiE2j5aaifuH
	YC8StMkpC9KPec5FNQPqAFTw4aODdxO717xLN036Z0rLU7J3A72cfsxSkhQrAlPOjfUodM
	ZrOJf+HOSHCnl0Z/uKGZQWeL77WBIwA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 3/3] tools/mpris-proxy: allow selecting which adapter to use
Date: Fri, 19 Dec 2025 19:10:39 +0200
Message-ID: <fc109d9cb3edfa76a05ed747017a42f2ce2ec5cf.1766164144.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1766164144.git.pav@iki.fi>
References: <cover.1766164144.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpris-proxy by default uses the first adapter it sees over DBus.  Add
option for selecting a specific one.
---

Notes:
    v2:
    - use --index/-i option that takes integer

 tools/mpris-proxy.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 2774bcc1a..1d7a421e9 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -62,6 +62,7 @@ static GSList *obex_sessions;
 
 static gboolean option_version = FALSE;
 static gboolean option_export = FALSE;
+static gint option_index = -1;
 
 struct tracklist {
 	GDBusProxy *proxy;
@@ -748,11 +749,37 @@ static void usage(void)
 	printf("Usage:\n");
 }
 
+static gboolean parse_option_index(const char *key, const char *value,
+					gpointer user_data, GError **error)
+{
+	long i;
+	char *end;
+
+	if (!value)
+		goto fail;
+	if (!strncmp(value, "hci", 3))
+		value += 3;
+
+	i = strtol(value, &end, 10);
+	if (end == value || *end != '\0' || i < 0)
+		goto fail;
+
+	option_index = i;
+	return TRUE;
+
+fail:
+	g_set_error(error, G_OPTION_ERROR, G_OPTION_ERROR_BAD_VALUE,
+						"Invalid value for --index/-i");
+	return FALSE;
+}
+
 static GOptionEntry options[] = {
 	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
 				"Show version information and exit" },
 	{ "export", 'e', 0, G_OPTION_ARG_NONE, &option_export,
 				"Export remote players" },
+	{ "index", 'i', 0, G_OPTION_ARG_CALLBACK, parse_option_index,
+				"Use the specified controller" },
 	{ NULL },
 };
 
@@ -2349,8 +2376,16 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	path = g_dbus_proxy_get_path(proxy);
 
 	if (!strcmp(interface, BLUEZ_ADAPTER_INTERFACE)) {
-		if (adapter != NULL)
+		char buf[32] = { 0 };
+
+		if (option_index >= 0)
+			snprintf(buf, sizeof(buf), BLUEZ_PATH "/hci%d",
+								option_index);
+
+		if ((buf[0] && strcmp(path, buf)) || adapter != NULL) {
+			printf("Bluetooth Adapter %s ignored\n", path);
 			return;
+		}
 
 		printf("Bluetooth Adapter %s found\n", path);
 		adapter = proxy;
-- 
2.51.1

