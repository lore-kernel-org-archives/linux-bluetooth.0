Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ECF22DA0C
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816943; cv=none; b=oyMhcMToUA4bzEw5a2mE1M1YGwCRy+XkdXSvNc13Y5EgkG+l8rOKQeFL/hfW6hnYn85qaJLDQ8vGcQEYtTLlp8RTbXlw8BbS8a7YOLy+lgTRt2elBzc3NDYvN2izX83Rdt881vDZxTA8FJqYfKctkeqokIwmxjoGemOkEFW/YYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816943; c=relaxed/simple;
	bh=KBGkSHlm1w6IocCjeb3x0fLCzZuHGoCkAxrRANFppCc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T54w9NM5pYx8UzftIo0rj6qTz4gN3zW3EcVLAlt1xLo6LWMRHf9RV+gbNLyjtD1sjyMhNy3nClCfX+RpYObTsgFObOhMKT9ISGOxjEi02s6c8o7ZR39kREyOmpR9ji28tbD70JGvbcWMY18ofyYDThq+qtTIj8IIj5U/GJLX/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lneuMsDB; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lneuMsDB"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-884f7d29b85so1366163241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 12:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753816940; x=1754421740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUp+cOAtOWhf21iDulaggvRmv0HuauOd52SNVWYf5bU=;
        b=lneuMsDB/J+pzUT/tTCQ9JK57er3gfqOkK3WC0jnOVQX0xvZiUEsX5IjibRRnB4VzA
         Wwst42rOXPV3VjgAcSPUrE2hTuYAzLwzLM1Ad32dtq4wJP4K9DOMvXGbmelC4ex57q26
         OM92+OOFzDVatoe2++78lsVvto1ssY4IzuZsblUxEZzB5+A8Va4xpTkKKllK2SByqMkE
         cXgg+9K8Zd6ZjsT9nggidntzSOXlsBh/VT8dEvF7YvfXWD16yDq5iY9Uq8mIQ8krfHia
         mUtXnbI3IS8mUKafbnW7gr7LiXth7m5NvQ5mSXjvZjSg+YgHdJ3wRTEFNeKXCPLdTL7K
         UPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753816940; x=1754421740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUp+cOAtOWhf21iDulaggvRmv0HuauOd52SNVWYf5bU=;
        b=MB27o0zdRzPXwFHc9z1pQphwHGPduwpWClaP8d23cQ+kIm8TT829IopZKxWMTGhKbY
         GiG2UXSWfWNIQBttrfJusnqGR95RZpndFJAo6JC9yNEWXaljLjQRqCYrWKNmFRWIyKN3
         b8u4peuePdkBOwWRlkbegi0djA/7D0cZoyGnFhD+ztJ2H0qakFoH1LLw8C0BvZRs+2BB
         s9lFlY8oheVkm1AGH+SGHw4RJLDq9hr12lYdokJHmTSbvXA+uF+4DWOLR3j+5Hpt1eZk
         O5KS8eiP344Ep+fDkaCEoJ5j5lG4c6FO25ZTHK7cVnoXw+xUZKgZc1k7r265ti6tMy+v
         3rIg==
X-Gm-Message-State: AOJu0YzgcfvGAp3f3cHiwnVJZ+XOTtJfF22GU1OjbtU5znTrm5H9yW0a
	Acq4GmitJlge5gIp2T2srBKbh77siHWnC85MyjHzjQsgaZPhszAMIeDIRa7w0Is1
X-Gm-Gg: ASbGncsjncBM5SBjv7Y05bpFFAlrHSPSeccx188EvbG5VqnEtf7VOjuaZu8UCj9K8pE
	XyHfp2Zc2Ok0Ml3IjBURjAwr+Pa1t5EMaoXeJRgWfa6PTjPWr2nsMx58qaoHcBiP6p1nNRjgQBp
	pOUy98rmUAhk0KXpgSlikKDE4z9vBVs3OZg0Orc0ju5cEV/DZC59AoRXWvaO+Ar6t9s5eTrnmcC
	bjuqV4VwsqTKLiVpIPxY4SgPqWcH5MkAH+XNPHZkYPoWjMVIW/Qtuk7aXNcflmxgJYbzaQM0KYk
	wd+qIw1yMmR6/26z5WrlTOwAkOJHaKNKCfYBtQxgJN2Qga/rqkTnmQLU6cEAONhlbfW4fCmEajo
	dvzDxB8LAHaqT1ArH352X+2ft33taNFM+Rz8GAbR4dfeTZuE3hOpfBq7/ysHfMOC5
X-Google-Smtp-Source: AGHT+IG53PtHPkNbRGYrolUlbUw+GxvQ7W4YWii19wNd0qvMSIAPwwgwAn2sQ1s89JaQycuVKndJUw==
X-Received: by 2002:a05:6102:6c6:b0:4e7:c14c:9e30 with SMTP id ada2fe7eead31-4fbe87dbe49mr747910137.21.1753816939706;
        Tue, 29 Jul 2025 12:22:19 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4fa46d0745fsm1684577137.5.2025.07.29.12.22.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 12:22:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] iso-tester: Add Reconnect test for Broadcaster
Date: Tue, 29 Jul 2025 15:22:04 -0400
Message-ID: <20250729192206.272462-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729192206.272462-1-luiz.dentz@gmail.com>
References: <20250729192206.272462-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following test:

ISO Broadcaster Reconnect
---
 tools/iso-tester.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 40465a5f7cc5..7c0cfc408952 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1420,6 +1420,15 @@ static const struct iso_client_data bcast_16_2_1_send_sid1 = {
 	.sid = 0x01,
 };
 
+static const struct iso_client_data bcast_16_2_1_reconnect = {
+	.qos = QOS_OUT_16_2_1,
+	.expect_err = 0,
+	.bcast = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
+	.disconnect = true,
+};
+
 static const struct iso_client_data bcast_16_2_1_recv = {
 	.qos = QOS_IN_16_2_1,
 	.expect_err = 0,
@@ -3477,6 +3486,14 @@ static void test_bcast(const void *test_data)
 	setup_connect(data, 0, iso_connect_cb);
 }
 
+static void test_bcast_reconnect(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->reconnect = true;
+	setup_connect(data, 0, iso_connect_cb);
+}
+
 static void test_bcast2(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -3942,6 +3959,9 @@ int main(int argc, char *argv[])
 	test_iso("ISO Broadcaster SID 0x01 - Success", &bcast_16_2_1_send_sid1,
 							setup_powered,
 							test_bcast);
+	test_iso("ISO Broadcaster Reconnect - Success", &bcast_16_2_1_reconnect,
+							setup_powered,
+							test_bcast_reconnect);
 
 	test_iso("ISO Broadcaster Receiver - Success", &bcast_16_2_1_recv,
 							setup_powered,
-- 
2.50.1

