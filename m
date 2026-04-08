Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0243DB64B
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672558; cv=none; b=FB8FvH9lXo8zvOScmpyWWonnxW5veC/guHynQx3cRh1Qfotya2fMBZ/ZBo3YQvNQApOzSyHTEP5bMSOj42Sqrj6a0rbyS2Ro6dB/iwtK1lFaK5Lvv9siTVTfixmCvKAlDykKjzaZEj012jcRz/xN4uVC8T5OQEbYg27cgCTMwsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672558; c=relaxed/simple;
	bh=eRat0/iRow9E7zayqAtErXmDKGEq4SHSxrolJYOJGKw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYlsVWywdaff5z1xMO8/ifj/ZuAS8Iv4f7H7Mjtl6LJEVWxlzFYNTTst3JtbJfDxXf9DDoAogfdHGvVRd8OHTwd5wOVwRptjDcXiz1ghjaOoF1gNsrPvcCqBqmeQtAE3/QEkms5jKo4EBm/fjdxlWPD6iqxx4R4BnlJj16leCVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byam+YF7; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byam+YF7"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56dfd007d31so8323e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 11:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775672555; x=1776277355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkzAO3a8YXZmbtWjGeg3hlRLSLNtQANlCDdTt+vS+Qc=;
        b=byam+YF7sksds5cw+PsoDSeVm9/wLwX7f2yoipzV8Rdfv+W1H1qEzMJ2xrEA8rpUSI
         OecJ4wBpQ4OFC6QnTImwpauazUKybm9sDQsKMh5aadxLP28fK2bgqdqWSfCMTK8P88Pd
         8mSRe5I0RBMktKyBAA7H2PnCIuqN1HOpU9QSLBfeQtnb9vYkZgh4wiovu8biJJC14AFN
         uf36JbX0jIco9rcDTADlA0zAae8pZGkq22co73oAqHebqVkZIH4KFPPdcD/Hu1B2vfig
         MvU4N800QqbvOEns/q++1fdd5lVSiU+v5O/wiktKBJZ91n4n6CoY4gx8oyhgY8GQHuwY
         A0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775672555; x=1776277355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LkzAO3a8YXZmbtWjGeg3hlRLSLNtQANlCDdTt+vS+Qc=;
        b=XxqG9ht/rFw3efDY0SEbtRndNaCzVH2aaC1EMkth6xva2OUj89SiF1VuB4mnl1ApCq
         sxi7Yn0Zn24v+blLzaZv9D/xS8ZI1M7XZ6W4RCIOOQyiV5V949PVuVb1+9ECt9Bz8qaC
         rmkbyjbB4Rf3Lhbki6nP2kw0fXChHoHjtOjpGAxZhw2SXFJkqLG3cdAQBUfob06ENFvB
         iRq2rnpp/fdknoj44fF8RQo8f3I5h58p5lDQvZl1VjHo31dlfxXA+GZVDfe1rDqqTMUp
         1GHmClEcLQzOsSr4oj5uLqs7Hyo7lC6bjw31TWckJx15+22WfE91UlQ5qPZJf4hsPJKQ
         hBRQ==
X-Gm-Message-State: AOJu0YyfQK3J+JXIgH5vvbVWYyhfnvhdEXAwxJ2A1PYns0YvGoQq0Mxe
	oCKQATVETmNOvOS9dUavKnXm+LzV23rIHmxjfRCEx3mUzUg5bJGnoUYS+oxWXLH/qYM=
X-Gm-Gg: AeBDietwAqZpHCkL/Tjx3c+vptzpyKvWVAek2deymBDW1LetLEMQ1mAYCuzN61vrxlm
	R7BIqkev15UFdhEdGWbt93W5IQDHUHCOZuVFtK2SPjjfvIn7KpJYj7cDroUURNWWLh49AqPoWW2
	L9UNLCBmN0S0yj3129d1a7bLaN+JN4AvmJx21iE3wuYTrTmDBFxt2N7wy8xjDPf0QBJzeO1mu46
	FuuVZFwU/JDWlMdv2J6U2UuYleRaM5lcgyhs6QKMNdu9KCHs144xzPsOx5jjpZRMoBMppTRibqM
	Lu7BReUankUHlHcE3W8/rBIjnWCpVvbFlX8rmbnpnyvLV0Ebhv9HqOgyx1j1GG3i10xlHyNqKv2
	+fVpDwGkD6zudm37NJa7fBcxeb8gFqges9nnG5kRrz9dN2zri64TNLWiZ++nll3NrwP6ZKebC7L
	7iSpW72xqPBpGOqE7kYz2ze1o25UFC/Kb5WUijon2HwjaYhbVKpi02N6giDTDMaZukn+1invOaT
	AEV2s/TiTNm5X4H4A==
X-Received: by 2002:a05:6122:3384:b0:56d:8927:12df with SMTP id 71dfb90a1353d-56dab98a866mr9323373e0c.9.1775672555636;
        Wed, 08 Apr 2026 11:22:35 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bce02f3sm20486962e0c.14.2026.04.08.11.22.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:22:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] client: Stop discovery when connected with filter.auto_connect
Date: Wed,  8 Apr 2026 14:22:23 -0400
Message-ID: <20260408182223.295711-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408182223.295711-1-luiz.dentz@gmail.com>
References: <20260408182223.295711-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If device was connected via filter.auto_connect method (e.g. connect or
scan.auto_connect) stop the discovery session after the device connects.
---
 client/main.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index c04998bb0a9a..57fa138880ed 100644
--- a/client/main.c
+++ b/client/main.c
@@ -687,6 +687,14 @@ static GDBusProxy *find_proxies_by_path(GList *source, const char *path)
 	return NULL;
 }
 
+static bool filter_match_pattern(const char *pattern)
+{
+	if (!filter.active || !filter.pattern || !pattern)
+		return false;
+
+	return !strcmp(filter.pattern, pattern);
+}
+
 static void property_changed(GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -699,12 +707,11 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 		if (default_ctrl && proxy_is_child(proxy,
 					default_ctrl->proxy) == TRUE) {
 			DBusMessageIter addr_iter;
+			const char *address = NULL;
 			char *str;
 
 			if (g_dbus_proxy_get_property(proxy, "Address",
 							&addr_iter) == TRUE) {
-				const char *address;
-
 				dbus_message_iter_get_basic(&addr_iter,
 								&address);
 				str = g_strdup_printf("[" COLORED_CHG
@@ -721,6 +728,19 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 					set_default_device(proxy, NULL);
 				else if (!connected && default_dev == proxy)
 					set_default_device(NULL, NULL);
+
+				/* If the device is connected and the filter
+				 * is auto_connect and it matches the pattern,
+				 * stop discovery.
+				 */
+				if (connected && filter.auto_connect &&
+						filter_match_pattern(address))
+					g_dbus_proxy_method_call(
+							default_ctrl->proxy,
+							"StopDiscovery",
+							NULL, NULL,
+							GUINT_TO_POINTER(false),
+							NULL);
 			}
 
 			print_iter(str, name, iter);
-- 
2.53.0

