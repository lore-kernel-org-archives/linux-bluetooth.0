Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684039;
	b=WMmOcNMAC5hm7L0Gz4BOitIqumLVEpkrtwbx/cchKoQ8p5uIYymVKLKjzNIwQ1MISXvQ
	 eSrQyQeEdX+CimHpIU3QTEEiMJqfLPh0l6JfOVT4qNL0Jen1LBcztyvEGEh921t5bvOTf
	 KLDS/BHjCRs7h65F0baIAmcqHCypeLVkVsHSCX/0YM6HoaSv1sz/ZVdk6/uATJkJQd5kb
	 /X5B+S8O6R3FYXYAiPbOeiBmj8RP+Vt/8mQPUWs0RJ0VGv2sGkoTtVp+ljJkpH7oyAd8O
	 CPTI8mQL5X7oI+Rv1KNfarYWXcCGFxBTD4km3+skL3hD7ozuqAJfcPs8WLaUHYrhbHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4FrQPSI+zkHh/AowSy6eLY7D7cZ6pwjY2qi58l+ZLoE=;
	b=J8RZIjDy3wVLqH2bdiUnoDQnOkXXxIcXysU5zzJCWe/oZGkezRuDywkkNonyE0Sjxzv6
	 4H95hmHB/5jNif4SQveBYXK4seUDpbgpQSCN+zjxravP0iz5sLz2OnEr3hr7kU3LbFQWi
	 BX9JNEidBm6u/FdpQaPxtN5jW3zoGUPeh+G7u93yp0Cd7RDY+dww5bfOwcevrczfWUlkU
	 E3KshCyc7PoRudtmGn5Rhkni7MKnGIBuiKhtLHCXqZPWBQkOUqClIDRl7sll7cLbeGDkG
	 xShnN0mH09HM45F/1xdAHuyeId2Dd4rFdHW4zOrzxyD9PfLm5JFrL+DTXs9Dp7Vku0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hTK9HnJ9;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CCB606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14CCB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hTK9HnJ9
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so10929e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684038; x=1793288838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4FrQPSI+zkHh/AowSy6eLY7D7cZ6pwjY2qi58l+ZLoE=;
        b=hTK9HnJ9cVuH0z/nKg8Z3APe7ZshBlEsyFkum8ndsY+FDRQ6dTgb/4G4zfyCbKBRot
         X7f4/7WD7ggzlwyc5eQ/5niOWmgt89UFe38Cwi2bednfTrpL4/GyOBsdizFfor2ZsfUb
         g7bFKUmr38FPcUf1p/ecq+BhkpuPtjCQ9+bZr5eqX323I74jg/v83XxZdR0ut5M01oOD
         dBSYV2Nefbjpb2sgAgkGYW4l/lnZ5PyE2UXXOsWgGv4/RBpNJzc4jFTKKTTpTTrZkwfc
         G6ZVoQyqXXCzNw/dWlUYECMa0Sc2ckgF3aws+sBbTcu/AH4ScFwU7TpPuMhOCljFlA1Q
         7DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684038; x=1793288838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4FrQPSI+zkHh/AowSy6eLY7D7cZ6pwjY2qi58l+ZLoE=;
        b=KfFWetATSI1KprseQ9T/3LnEkAdIRHH8WN9/MDtw7khYBBJzcK2Ibtn8se7OnjUKF2
         SNAGJaodXzYyMbxse3h+b9mbqQzwXBg01A660HRampSyI/ux0Pmr/l6r4HBqi/quNY8v
         KfYL6p3Uf9b2CGW8LnkQqTT2XToEMUPDM1gqEcIcPFqevGNySkvkTXogOemJEVACaGNm
         XG70/E4xyteXwRhxIfodmtLooBnFE0LcutLy7U1BN0gmDUMyzW2jZKBPGLZtM9/zTiOf
         +JYMvMKWPkzWblCNMeNkYvI97J88eEATmO1hDJaRVcm9Zi6aiFpNNEIBK6ildw/qpJ3w
         VefQ==
X-Gm-Message-State: AFq9FYKdCWD0oFC9/kWeLWZ/6XnrkRHhKA95p79bkE6fttv4z1DOX9KM
	Zutju8i4IQdE8qglKR0STfTFaZmwlSy6GWIrgy2DOekAyf2SC7mnME7Lo90u3z51TjE=
X-Gm-Gg: AYBFou1mv3yC8D4bZHcM6IxVfC6N+zDmIG+5c5rxYMcydjnOcwRMNcOfO6iEtmBbKnV
	izavSmsfCMG46or9YPoElA5C0aEbs3o4k4m09Wz0qj2rU0e6b67mgBk0739FBRnM+qF3dDPaxnT
	C6JTTnvsA75mYcbWSGRqDrd8Xz5Jla4TPRtyvbnLyYt+dmEITFy7Y7Oua+NZQDEwWI2k4tYX1AT
	b/4B/hNPeScEhY77yH1USgcQRc9/OhWEj0SDbD3CcqecBT0JwCad64FwaAzgmUCIZ/+gEZJgsOC
	S69q69ms/nmvBeqE/7z6QlzNGMx0m2j7sZJ7HvKNoEE/UkiwJ19tRhu/YSpHeRmxxRhCSl4STBP
	dkOtepOwtONiaBbOJHY76rr4YwJ0ZugoMF1HGaQObO7tpxMZazy6cC+gp91ajdXz5LmoRTe7KtH
	OmqHQYvEdYuOf3CrJnjoOEZOSTVaLYhJQ4TnKyxJXPpWLmqzkJzC2J/Fma3ZeH5yo0EUOQ+1oCd
	cahO94WMINBwhT6VCfny4g9fiLTvN9TR2xcafdN6fMPUopTn+57k0zY6PS70wtGcwdDmm+aaSZn
	pGzKMmbI1jZ+W7XjpYu3+kuugyK4pQuiTQrZHIi5wq/iOw==
X-Received: by 2002:a05:6122:1b05:b0:5ea:d5ff:3bc5 with SMTP id 71dfb90a1353d-5eaebc48b6bmr2299614e0c.2.1792684038023;
        Thu, 22 Oct 2026 08:47:18 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 08/27] 6lowpan-tester: Find the interface of the controller
Date: Thu, 22 Oct 2026 11:46:41 -0400
Message-ID: <20261022154701.3959500-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The tests open bt0, but the interface of a previous test may still be
there, removed by the kernel from a work, in which case the interface of
the current test gets another name and the test waits for packets on the
wrong one. Use the most recent interface of the controller of the test.

This shows under User Mode Linux time travel, where the receive tests
always got the interface of the previous test.

Assisted-by: Claude:claude-opus-5-5
---
 tools/6lowpan-tester.c | 62 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/tools/6lowpan-tester.c b/tools/6lowpan-tester.c
index a8faf6eb5976..e407684a9e4b 100644
--- a/tools/6lowpan-tester.c
+++ b/tools/6lowpan-tester.c
@@ -22,6 +22,7 @@
 #include <net/if.h>
 #include <linux/if_packet.h>
 #include <sys/ioctl.h>
+#include <dirent.h>
 
 #include <glib.h>
 
@@ -590,14 +591,73 @@ done:
 	return FALSE;
 }
 
+/* Find the interface of the controller of this test, the most recent one,
+ * as the interface of a previous test may still be there, which can also
+ * make the name of this one other than bt0.
+ */
+static bool find_iface(struct test_data *data, char *ifname, size_t len)
+{
+	char path[PATH_MAX], link[PATH_MAX], hci[16];
+	struct dirent *entry;
+	int best = -1;
+	DIR *dir;
+
+	snprintf(hci, sizeof(hci), "hci%u", data->mgmt_index);
+
+	dir = opendir("/sys/class/net");
+	if (!dir)
+		return false;
+
+	while ((entry = readdir(dir))) {
+		const char *name;
+		ssize_t n;
+		int index;
+
+		if (strncmp(entry->d_name, "bt", 2))
+			continue;
+
+		snprintf(path, sizeof(path), "/sys/class/net/%s/device",
+							entry->d_name);
+
+		n = readlink(path, link, sizeof(link) - 1);
+		if (n < 0)
+			continue;
+
+		link[n] = '\0';
+		name = strrchr(link, '/');
+		name = name ? name + 1 : link;
+
+		if (strcmp(name, hci))
+			continue;
+
+		if (strlen(entry->d_name) >= len)
+			continue;
+
+		index = if_nametoindex(entry->d_name);
+		if (index > best) {
+			best = index;
+			memcpy(ifname, entry->d_name,
+						strlen(entry->d_name) + 1);
+		}
+	}
+
+	closedir(dir);
+
+	return best >= 0;
+}
+
 static gboolean client_open_iface(gpointer user_data)
 {
 	struct test_data *data = user_data;
 	const struct client_data *cdata = data->test_data;
+	char ifname[IFNAMSIZ];
 
 	data->io_id = 0;
 
-	data->packet_fd = open_iface("bt0", cdata->sk_type);
+	data->packet_fd = -1;
+
+	if (find_iface(data, ifname, sizeof(ifname)))
+		data->packet_fd = open_iface(ifname, cdata->sk_type);
 	if (data->packet_fd < 0) {
 		tester_print("Wait for interface...");
 		data->io_id = g_timeout_add(500, client_open_iface, data);
-- 
2.56.0

