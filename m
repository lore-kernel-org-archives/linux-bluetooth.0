Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353B3DDAE2
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 05:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919990; cv=none; b=YH3WaJx+l8Xn1VlF0qz1sw8GvHyAA8hkBwiDpMrPSvV29ZGuFl1yXefidqXMI17zQZBILkCipw4f4HYj6cGCU0TbW4aE6thgGJc76AW0s16Sr5G2rclNzj15G2EBGWuM9Et2SB16aU/8zFNu3LciDS8Vhsb9AKat4con0y69GqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919990; c=relaxed/simple;
	bh=64/NvjUZMuPng9dVKVl7hKkSGZ6nzdq8G6STAp+AL9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVlA6mwBi+QcnwiWHllitoMVHky9J0xRDig6M5oQzhA6MamLW3UduAal/CBeDPr/OL1jT72NUn5LtdZ5j1D13LozsjxPUP4ojH8FbeEVZNi1EUF8lIMfyl8fH7fUqCaxhnQhotgtu18dxrzV+RHYhPBU1f5tQhfq9zuALtw4K+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=igsIFQ0s; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="igsIFQ0s"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bb8b31660so2309334eec.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 22:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1790919988; x=1791524788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H4LanCTM6LPkrMU3jvONgU5trWzvN2Hft39Vp4eEn0Y=;
        b=igsIFQ0s9xx2u2iFu7ADjT48213xeW/MAHvu0HqGERpwB7tHJxo7S7Oa3Y4+6Cv2hq
         U5STllGbzlop75pwOAT/Ojv5L51WyGFY6KbjbVLDa3Nzl6QtWdYwAoZ2+w/Gkb+aGGu4
         0/dUzg5xrjRHk0bimbEQ5jFq3bz+7dygJNFL9TxesLA+tSEUdNOlEyhhdr6qyE0q8vbY
         VGoYoMgOq/v6p3uD3OELW379IzaB8cW0VQtJdzLA31tFTmYAkRgyXxLM3cq6oP19xAgq
         RgopTVBuQE8B0m4PI6EJqhP128ys1ew19ipfC9CD6SbxCj5kxi2R7gRWI9YyxDoWmYNc
         25VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790919988; x=1791524788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H4LanCTM6LPkrMU3jvONgU5trWzvN2Hft39Vp4eEn0Y=;
        b=yTFxHCBHTwhduMfVEqn+JmrjwZIiak2tT2gHxLJ2/u45kraiDhWOKdSYepDZsz3Wl+
         YzwznmzJjZZoVFAVskdejYLU8ztimujQfjM2HSbB3q8bw7BCtyfv/+w4zlCzdnaGjixq
         nH0SAbCzRaCQUmJiZ1/brZaWvGWoaK3Eiiwfvxs3oLl0PzqGzoe9x/r9/OkJsaH7GBsY
         1T5q2PGZEtPrdpcBuzNXtZmIXzbcMjANFJS+o5lWNWpcgtkn+qwPSS2pl0ETUprnm21F
         tdUoAAsp6O0fCBU9DxUA/XpO3txR+oZRby3nq8u6hT9RB0wf6wTw85w6c7ZnThPehmlj
         PsZg==
X-Gm-Message-State: AFq9FYIruzE87sU7Y0NDMmaG5T7od6CJyT8/ZE9cdq1f2GrKlJYfkdlh
	dIL5akGGhQVOaFJ2Ga9ucxzAugLqB+Quk95oH1yEWevFRXeWOZm5MpmrwHs4BflhpGKFLzf+sRW
	VUNYZDOY=
X-Gm-Gg: AYBFou2nPzoDCH6DRQTqtusqlh85ctD1GMACS0bHa4+VH3jog/lnvQW5OuYCAuj8bdv
	6im+ytr07QmQntV5S+fPpMsIY1cwHxA6gbchsvT6h22z8+ICBoTrR7IqN4DerBZwRXbIHs6X0rM
	nJS+7FYkbJD4ahMK00ssoyqLCPEE/lo5nKtXNoV/AwBKU3TGj6rHmHp03XEqP/SQil8Wel1Q+Pz
	z1mOB51mNIz6LCrrqzzVf3SKHtSKJZmsQXjBw5fPEs5latCGysmMuMtSY6q4eWQ3s30kK0xbIxE
	o6aMb5Bj6kgzMz5VpIkiqYbOFHw/kSZFlCo9wikNXHNb/whh4Pax8eP/if2Wl6JHdozfdRG1vdM
	ZyMhYYvpw5PkCdem2SAbIgzIbr+yrxisjN5cHvMilDBHLBiCIzzaVR1zM786VBTCe8OkXplE9Vb
	VrPaGUOvQGjD6KaSkyAMw/4BKjASEIV6u3/5Egej0BGvb+EqGc2SdcvyCAwnixE4uj8WMOgUP8s
	ChwGP+ynRI5eO531L7YcuIvKIuoF0Ar41EPtzRKpFqHHFry7/czBxe2fDDsEj1HK7yC4Rl4UPk1
	Gpm9wMTjPwpQrD8qnEvoaA/vTxcdcTwHp8N9smRg
X-Received: by 2002:a05:693c:6385:20b0:34c:b75a:ac14 with SMTP id 5a478bee46e88-34f219c13camr1635991eec.40.1790919988311;
        Thu, 01 Oct 2026 22:46:28 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f15019999sm3064217eec.29.2026.10.01.22.46.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 22:46:27 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 6/6] client: Print discoverable broadcasters in red
Date: Thu,  1 Oct 2026 22:46:17 -0700
Message-ID: <20261002054618.30994-7-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002054618.30994-1-kevin@simpleble.org>
References: <20261002054618.30994-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prints devices in red when they set the discoverable flags but are
not connectable, to warn the user they cannot be connected to despite
being discoverable.
---
 client/main.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/client/main.c b/client/main.c
index 35cd427..ad2c3cb 100644
--- a/client/main.c
+++ b/client/main.c
@@ -183,6 +183,19 @@ static struct set_discovery_filter_args {
 	.set = true,
 };
 
+static bool device_is_broadcaster(GDBusProxy *proxy)
+{
+	DBusMessageIter iter;
+	dbus_bool_t connectable;
+
+	if (!g_dbus_proxy_get_property(proxy, "Connectable", &iter))
+		return false;
+
+	dbus_message_iter_get_basic(&iter, &connectable);
+
+	return !connectable;
+}
+
 static void print_device(GDBusProxy *proxy, const char *description)
 {
 	DBusMessageIter iter;
@@ -227,6 +240,20 @@ static void print_device(GDBusProxy *proxy, const char *description)
 		return;
 	}
 
+	/* Print discoverable broadcasters in red to warn the user they cannot
+	 * be connected to despite being discoverable.
+	 */
+	if (device_is_broadcaster(proxy)) {
+		bt_shell_printf("%s%s%s" COLOR_RED "Device %s %s"
+					COLOR_OFF "\n",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					address, name);
+
+		return;
+	}
+
 done:
 	bt_shell_printf("%s%s%sDevice %s %s\n",
 					description ? "[" : "",
-- 
2.54.0 (Apple Git-157)

