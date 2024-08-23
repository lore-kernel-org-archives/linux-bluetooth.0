Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E201885A2
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Aug 2024 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426412; cv=none; b=XQ/KK3bteNK0nCKj2aVBN8r5dbNFevm6o6C4S5h2FWWjQP3oo1qqyrDin2AVano3U7vWTx92+r+k8/M0TKQHN6FVa9+pxXYTPYatk+zDDvOKv3nITs2P+MH9uyeFLqglxC77BE1PSO6oRjGykgFLwlAtC3G4qX2s0oIH7Tt7l5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426412; c=relaxed/simple;
	bh=AJZV/kb+lT292FrUieLg66FcKZqQbxLjA3bqWs9SVZs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gwskZCFhBA0vYotGcmuMp4i/tUIcC82CIJMHoO4yCRs83IciTP3EL2+i0MF7d8Q3yOutVCNBbKgTr915LSt5W0wlLSvFzERdZ73jivNOmM46uii/rnmfaM1qiZ+oegvGxV2huRbCm28/korL3Yo6Zd8NeBqASkt/MvUcfKdvkJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqgZoJh0; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqgZoJh0"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-498dccd3ce1so697459137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Aug 2024 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724426408; x=1725031208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dLZv57jkrihwRH/n2AnFtVR4VVlJY5E91+7yVr135qU=;
        b=AqgZoJh0M/xuBedi4/QzRlfVEybxqNu8BWCLXxF1Rk0/Q/7J4x0JF6Lb5z0FBmvF5c
         oC89CkRSiMXHD3m/5UjkcyQn9gJVWeldTs6yr5qB//POoM2kE9SCLy2T2HUzSAVleyFn
         TtmnzseuSVVzkQho/3en/5T2SFtmufZncMXAL0dQrvUcvAO8aN/6/ir4m324s/C6LzdJ
         09zT2i25V2hP1lTvb0O8qxNouXPbJBAB3wyYY2SSF3atUewawau6p7OPs4L5OPWuysM0
         KvMr4pgrddUPU4hlPpP2TltsJgAN4u0WWFwxRpgZ/f5LtuXaT35qfArumzjaQDglliEM
         I3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724426408; x=1725031208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLZv57jkrihwRH/n2AnFtVR4VVlJY5E91+7yVr135qU=;
        b=g0oVikSsW0stWwYV/Zlr6P89gLfEk48LRrJKRjhhiLilji9OLvyAkA813lcxKkUV/H
         EHgegdiaqKclBpuojyEdVatofgOJzOWan7Ie5CPBXbFdO8PnP28/slGyi8t+vzs4snIZ
         1YVkTkmt09FKusmP6LRcspPPDCM+yYaes817eT+0pO/TT30W0vK6Jdepy7gLgCyfOMB/
         XPxNi57d1R2fGCc/Ll0/Ifmdn4hFQLPCZIcainS7QD5H5VFbBRQMvNJMEa1g+mRdURQv
         f9/1/meoDw9AtqTU8KPlN0MdJpGC2ZRzUfXQU5QdBw5eTeU4rIPiuVAMAtfgrn+Zly4+
         qMKw==
X-Gm-Message-State: AOJu0YxktemUO0QdcIw3GYljJpGO4kZU0bQV3evWfXBZwCS9oIVS+M3s
	J6rbiPM9qlLzkgDTPfv2NP5pZmZlHXxaoTR7m9mX07QuTlwLwTBy6sNbuA==
X-Google-Smtp-Source: AGHT+IFM7RNQxjgVXS5jUMbJ1a0cz6KqWfs9DeY1oryg6ec+lt8nc+pmjyHFALLkyodqwR+GKsck6A==
X-Received: by 2002:a05:6102:5492:b0:498:d39b:b0ef with SMTP id ada2fe7eead31-498f4548657mr3521125137.8.1724426407913;
        Fri, 23 Aug 2024 08:20:07 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-498e490463dsm575933137.33.2024.08.23.08.20.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:20:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] test-uhid: Fix attempting to run when bt_uhid is NULL
Date: Fri, 23 Aug 2024 11:20:06 -0400
Message-ID: <20240823152006.698937-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When running under root there is a possibility the bt_uhid_new_default
doesn't work (e.g. fakeroot) in which case the test shall be aborted
since it is likely a device specific test case which would require
proper permissions to run.
---
 unit/test-uhid.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index 2765feb72b06..6871c22eeaa1 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -201,6 +201,11 @@ static struct context *create_context(gconstpointer data)
 	 */
 	if (test_data->test_device && !uid) {
 		context->uhid = bt_uhid_new_default();
+		if (!context->uhid) {
+			tester_test_abort();
+			context_quit(context);
+			return NULL;
+		}
 		return context;
 	}
 
@@ -255,9 +260,13 @@ static const struct uhid_event ev_feature = {
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(data);
-	struct test_device *device = context->data->test_device;
+	struct test_device *device;
 	int err;
 
+	if (!context)
+		return;
+
+	device = context->data->test_device;
 	if (device)
 		err = bt_uhid_create(context->uhid, device->name,
 					BDADDR_ANY, BDADDR_ANY,
-- 
2.46.0

