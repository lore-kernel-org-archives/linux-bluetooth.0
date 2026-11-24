Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530971;
	b=uytS19mM2Zv0o2XE3YR3jym8VfwitJLxp7Od6CdFFATGO9ve/DlNNFY3wGPU5uJoFoqZ
	 DlobUDSXY2Zr+RW+ONBy0DqvsgN/8JWG9DWtN7cYy1veP1fsDcQMSknjUCqzukf0j5Ozu
	 9AahZtbP1/5DRNUBGvcXhAIQDsFl0Z57jHCTWOkbKwVFbwt5t5kACXCqiglOwxPsaGMZw
	 4d6jlevoYQ3sCGGsf2sOoj3RtikbwCIlcLdPzMsxiGhEyXBrcRiw4cnUSS+wSGR5tWGBn
	 zCMBgFjjjhW/F0aTtyHYb3gC8C/b+Hte7o4tmd2UAAB89oEFaY07lbIoK0E0koidvOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2KzXvxGiIOukg0a8ua6bzkwvZksRr78Z2TtZ040CjuQ=;
	b=CpdBMFWdDr5h4su1m+xRHjaeYWAvm/qd4qCHmbk7ETm1jU1+msDTt5o+KJDlrYOBUTGb
	 0Hl+n3YJla33EOoVSyk732f3jTZv/hYEXw6svvDuJG+hsUuT/4egq0uGJBshF7reVP5KG
	 IdGlu/tlPHJ4TBXV6kv6ixdR6GzTMKt/vOc98lEpwSgdtexDQ/ipKzuuUJNAVwPxgzFE2
	 aITo8OJlwXRNMU9o0btI8zEwOlWlOlJyiAXC6Iw5qXtnYE3zNOr62FpxEgjKXrEuI7Qui
	 UUhQkWVsXcsROKFHhVG8gDfJodKqgAGClkaS5jFiJLQlwOZCdTZHdsyPDuZzIc9pVyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=v9h22mS9;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597C606A326
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C597C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=v9h22mS9
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so29745015e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795530969; x=1796135769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2KzXvxGiIOukg0a8ua6bzkwvZksRr78Z2TtZ040CjuQ=;
        b=v9h22mS9YRZFKktiwJK1TApE5qfHiD95Eeeqieulwv1Zygo9Z0DB4NYkcoz/hX9EXd
         rUJwoPI9opEOTJTilEP0HqN2/V2kiBIfPtOotUQ19vt70ohZwaxCw6rPnRP9aBW/NG88
         Q1pPftKA/TegS7LXbefDbOYR+LABO/HnSbbDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530969; x=1796135769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2KzXvxGiIOukg0a8ua6bzkwvZksRr78Z2TtZ040CjuQ=;
        b=tSHKd/ihevFr7JeXsiB41wklPl1cFVhKmGYyspAp5aymD3N/s+9UXPsGhleqeFZ91y
         99yq+5yu9DXMYveN4QwZ8KfkSAimhy1/Oz8c2RGobE+a2ED2Yq9NADKT0mP1Y3ta8G7F
         y2SKE4EoZGHS0615cKRIPVgJ6Y+yhJoubzMzivaDBkp+58z9qeXdO1JBWd01DVUuj9Qa
         +AfDy5SkQ86Zzm37BzHQ80ZM9DUd+iZgZMx6LRYaG3htAF4xN9fH/s+cLKoRZQuejDTv
         bnKT4ZT2+PArVfqtBysdDgwnd9gF6LxOrUrJGVn3uJkllwTL50lduDhiqe4FIVCaBnKS
         o9yQ==
X-Gm-Message-State: APuU4Z972AwuhIL+Ln6gm7fsWrj5brtlTh5B6GC4JnZkl4RhooXQD3vs
	H5S+JyINHCiQalEzrSZhGygpvw+xAtF3Sx8LA7jYSkmEnz89TMSqBM+K8oB+VLANLSdMLbkes6G
	15KOb
X-Gm-Gg: AZFdTZfX30+jXluxCBOAkbRy3B/eZOlrwPZViY5IIY8ve47tI6XGYwmkp23dnuxeOoL
	cWJ4gVHu8EjquaAbbLps/X83BFBV/KqqsovpFuYzMX/E/jEiu0t1XEm/cUyk0gWlFqSSHe/dVrH
	Lyh0QnQPCWhc8SCQAG+OpirKhkeG2Wgr2tB3ivBNvzX6Xwz/ehZ+gmKgkBgLRURwLf8zdJwWZ0G
	d1+BN9BW97rXqaE5EMVpdDcdCFJd4qHi80ux5S1/ruTGNJWSdFXUoeLzRhCQjg1//hqUgeRtzV/
	H6tfS71CVLpAmdg9vxBCeDncdF6aKQH9hPC5quFkQL9MbHwD/Af+wxiqUCJzd87ynuWf7T4uRRK
	gdY0BbIoaLogA79qZic/fqjJG6eHAc54BhMBmWR+REEhWAe9z/tbcF0M1yCmDeEeb+GAixWeSr5
	wrHXDAxAwaPo61yGiuqVNNMB/0bWOTzlyCR/Rc7ztuPupDloAY29Ag+Bw/X85nS+KuYm5eDNqhw
	4tS0cWfRWuvRtibCj9YwAbuBpeTD/0WAMe23b+JEuadIecgy0xLA4dXXH1XPrH3LwhZO9pCgFtj
	s8BTh8C2YpULrqG8Amc2uAAIGvpehbaa53/3GH6J+wy+wYZRDecFYd8GIcnM6gQxtkyMWhvD
X-Received: by 2002:a05:600c:3547:b0:4a3:5991:718 with SMTP id 5b1f17b1804b1-4bb88809795mr311306745e9.16.1795530969083;
        Tue, 24 Nov 2026 06:36:09 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b33a596f9csm9019187f8f.12.2026.11.24.06.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:36:08 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 3/3] unit/test-vcp: Add tests for Volume State changes
Date: Tue, 24 Nov 2026 15:36:01 +0100
Message-ID: <20261124143601.245340-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124143601.245340-1-simon.mikuda@streamunlimited.com>
References: <20261124143601.245340-1-simon.mikuda@streamunlimited.com>
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

Check that a Mute notifies Volume State, and that operations which
change neither Volume_Setting nor Mute leave Change_Counter as it is.

Assisted-by: Claude:claude-opus-5-5
---
 unit/test-vcp.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/unit/test-vcp.c b/unit/test-vcp.c
index 4ec4da428..ef27fda32 100644
--- a/unit/test-vcp.c
+++ b/unit/test-vcp.c
@@ -2761,12 +2761,85 @@ static void test_aics_unit_testcases(void)
 
 
 }
+/* ATT: Write Request (0x12) len 4
+ *   Handle: 0x0024 Type: Volume Control Point (0x2b7e)
+ *     Data: 0600
+ *       Opcode: Mute (0x06)
+ *       Change Counter: 0
+ * ATT: Write Response (0x13) len 0
+ * ATT: Handle Value Notification (0x1b) len 5
+ *   Handle: 0x0021 Type: Volume State (0x2b7d)
+ *     Data: 000101
+ *       Volume Setting: 0
+ *       Mute: 1
+ *       Change Counter: 1
+ */
+#define VCS_CP_MUTE \
+	IOV_DATA(0x12, 0x24, 0x00, 0x06, 0x00), \
+	IOV_DATA(0x13), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x21, 0x00, 0x00, 0x01, 0x01)
+
+/* ATT: Write Request (0x12) len 5
+ *   Handle: 0x0024 Type: Volume Control Point (0x2b7e)
+ *     Data: 040000
+ *       Opcode: Set Absolute Volume (0x04)
+ *       Change Counter: 0
+ *       Volume Setting: 0
+ * ATT: Write Response (0x13) len 0
+ * ATT: Write Request (0x12) len 4
+ *   Handle: 0x0024 Type: Volume Control Point (0x2b7e)
+ *     Data: 0500
+ *       Opcode: Unmute (0x05)
+ *       Change Counter: 0
+ * ATT: Write Response (0x13) len 0
+ * ATT: Write Request (0x12) len 4
+ *   Handle: 0x0024 Type: Volume Control Point (0x2b7e)
+ *     Data: 0000
+ *       Opcode: Relative Volume Down (0x00)
+ *       Change Counter: 0
+ * ATT: Write Response (0x13) len 0
+ * ATT: Write Request (0x12) len 5
+ *   Handle: 0x0024 Type: Volume Control Point (0x2b7e)
+ *     Data: 040010
+ *       Opcode: Set Absolute Volume (0x04)
+ *       Change Counter: 0
+ *       Volume Setting: 16
+ * ATT: Write Response (0x13) len 0
+ * ATT: Handle Value Notification (0x1b) len 5
+ *   Handle: 0x0021 Type: Volume State (0x2b7d)
+ *     Data: 100001
+ *       Volume Setting: 16
+ *       Mute: 0
+ *       Change Counter: 1
+ */
+#define VCS_CP_NO_CHANGE \
+	IOV_DATA(0x12, 0x24, 0x00, 0x04, 0x00, 0x00), \
+	IOV_DATA(0x13), \
+	IOV_DATA(0x12, 0x24, 0x00, 0x05, 0x00), \
+	IOV_DATA(0x13), \
+	IOV_DATA(0x12, 0x24, 0x00, 0x00, 0x00), \
+	IOV_DATA(0x13), \
+	IOV_DATA(0x12, 0x24, 0x00, 0x04, 0x00, 0x10), \
+	IOV_DATA(0x13), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x21, 0x00, 0x10, 0x00, 0x01)
+
+static void test_vcs_unit_testcases(void)
+{
+	define_test("VCS/SR/CP/BLUEZ-1 [Mute notifies Volume State]",
+					test_server, NULL, VCS_CP_MUTE);
+	define_test("VCS/SR/CP/BLUEZ-2 [No change keeps Change Counter]",
+					test_server, NULL, VCS_CP_NO_CHANGE);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
 
 	test_vocs_unit_testcases();
 	test_aics_unit_testcases();
+	test_vcs_unit_testcases();
 
 	return tester_run();
 }
-- 
2.43.0

