Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E832ED30
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765925677; cv=pass; b=kLlYf71e0dXdgEq8TZ96FavpvPvaFaV5CntSzhC4cdxsn80TGIU2pd3qAAY1vVw9GxvwrtCWCPE3gFQrvQZJnuCwbR9oNQNO1mw2ClmrYufp/yZX+VyPFkIBK6ATv1M6bq0GrczGX8e3FPQB1HelSdgMrjXNaXey1ubZpP70WAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765925677; c=relaxed/simple;
	bh=KXl3Kybtp1Pk+l7K2GktmmSnaRoaG6P53RKKT5mLQxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7U5ukzVoZ538iEXCA8MVGBYn4jIgk146ilV9bpH09R1UOSs0ZHWX7jspG4aoHFHtsPUFqLlkxNZrVVN5xtUZaLBR9hNuOf/HKBzlE/RKmvFFUSU4sx9kAsiw0hY9HkaXNtvnMTBitbQIjQ0qZTkiG+zehlWNF4oqUBRiu4zxnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Hf0DRqmm; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Hf0DRqmm"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dWC143gclz1098;
	Wed, 17 Dec 2025 00:54:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765925672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUTEkl5wtaiD3VlSWqOIusNDJCc2Uh4OTiwG4BseWiY=;
	b=Hf0DRqmmVeVAlmQVaYLG6JYm63SvQ1UirccT1bVP9zQHb8TbCdDlHFNWRKHFuV0n98zJKt
	TFFJu8CBUKIP2HzTXMEUYkRZnzaadgRFTESLfCOAeBHd3VqxD3vnuAlD21tLkrfQrNCmoG
	8CU5NqGCMShvM2UaVR+Vhs8AlJ3o/0I=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765925672;
	b=cCI6aEli50qOVsrYUzZBu763C5bIOdplMe2goRo7tRNJ6pUGxflu/Xr1BSnqUwcM9sPKmh
	RzRHWHeO0XXEUaksRsQN3jMAgSwZHmf1raUQZBdZJC2GiNPnbdZVkym0Gg9v0ya1hyaKTW
	HgZaHUSbPn8y2T38k66u+rZJkApxqZk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765925672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUTEkl5wtaiD3VlSWqOIusNDJCc2Uh4OTiwG4BseWiY=;
	b=Ni/v/2TGcBYm+lfNj7/p+sQs5IDmNJCGJgjCuWjaOnKIgG1XxiRGWPcGETVFQxWGeTHIz9
	w6o8R0J8LvkxJJ0lb7KQ7WQx6mwmOtHVU5EobhokfcY9ogcfZCgeIbbbrsWSvI8NGa5sIr
	4xDMY+gqNEXBJTkY5pTT11sP5erxr5E=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/3] tools/mpris-proxy: allow selecting which adapter to use
Date: Wed, 17 Dec 2025 00:54:29 +0200
Message-ID: <83084652378b7e6e7aa8ff271408fc91da1212d1.1765925485.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765925485.git.pav@iki.fi>
References: <cover.1765925485.git.pav@iki.fi>
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
 tools/mpris-proxy.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 2774bcc1a..c01c6af77 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -62,6 +62,7 @@ static GSList *obex_sessions;
 
 static gboolean option_version = FALSE;
 static gboolean option_export = FALSE;
+static gchar *option_adapter;
 
 struct tracklist {
 	GDBusProxy *proxy;
@@ -753,6 +754,8 @@ static GOptionEntry options[] = {
 				"Show version information and exit" },
 	{ "export", 'e', 0, G_OPTION_ARG_NONE, &option_export,
 				"Export remote players" },
+	{ "adapter", 'a', 0, G_OPTION_ARG_STRING, &option_adapter,
+				"DBus path of the adapter to use" },
 	{ NULL },
 };
 
@@ -2349,8 +2352,11 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	path = g_dbus_proxy_get_path(proxy);
 
 	if (!strcmp(interface, BLUEZ_ADAPTER_INTERFACE)) {
-		if (adapter != NULL)
+		if ((option_adapter && strcmp(path, option_adapter)) ||
+							adapter != NULL) {
+			printf("Bluetooth Adapter %s ignored\n", path);
 			return;
+		}
 
 		printf("Bluetooth Adapter %s found\n", path);
 		adapter = proxy;
-- 
2.51.1

