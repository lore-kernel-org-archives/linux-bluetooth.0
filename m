Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795732614;
	b=aE0daZmJGWu5nxVH8/JwwLKfzkVyZpNs6E2Rdbgld8AAzYR36wOMHLb/rYhjJhDQxOs6
	 QAGHN6HR0jQta0UWAfmCVeKb2uQ3iuBSSrnrgVr5XQpWvmJpP99Q2VnzJPkbhgShBVjfN
	 zBvzzp8wUGTViXhZ6GdhmP8CAw4T7FrtNTQNRIFk63baNEBeMR9Ixa8pFVZVi0imOJN9w
	 kmVwYNSbBJYg+Mi+VcZ6cp/E35AaxGwPzh0bHUMZL1sEl/hBMAbx6oCiO4tWmEjnlkIGX
	 y5FCrtpZJXE7MWDyIfsqmYUnE64uXSRZU5KXEI08xpXKCfQfubeEPBnsM0gRMbzUwfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795732614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hFB9I1ji+DKyQjCZIA+oAoIBZp+G9JdoQjveyaRURac=;
	b=DLEvmVVxXjd5yWDzRt3WpcaTDt9hq2je0EtmwQJtB6Lz8BJFgzrsE2C6VCNij+/9dRne
	 mq/5s9yic2LRdq+JkJlkfT4cpc3JcK4LlO9Q+UcL3cxuLZgQl5wOSaX43HoBz3Z1C3cpj
	 iRISrKElYJSY0X4kQAVw74HIoC7VxjufKBb70dcRR5dITznv2UXzJ0c2LpP0t/iPb+fFa
	 g8g6T2GLXETslwedvKRPEAIAwNMBgZYBRA8mRM+w9ZJY2klXVJi5DMaQupofReFSwAcwV
	 cPxCzwoBL5B3un0uFKb6N6zA8x6MPuRJp7t6C0Ynqd+LwmBA3CJLDARr8yDq6l4nOvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oivl0OiG;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D431606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 22:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D431606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oivl0OiG
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-86156081432so1705326a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 14:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795732611; x=1796337411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hFB9I1ji+DKyQjCZIA+oAoIBZp+G9JdoQjveyaRURac=;
        b=oivl0OiGYvWQn+0XT61OOAeyq3Zfv8SKVCwY3eELWmgrEP/W4RHuDrs29Rd1+6KQai
         tJ20w0yZXBC46kg+a+iu2TDdp163y3zvJkYdoYISzHTyyK6JFLTNC/kxoHq+BXL0Oq7l
         jT6rQPRBQdrB9xbPjnMxp+TOmlvMgif1li+mH/gY725LyAP1WTjfoTmrFed4lzj4P1HT
         EzS3tpuYI2pZx2QhNusorbGnRV4YnrQfGTFbSB0b2y14aFuutg5qakbwjix2UptVvwCD
         n5xcvtXsJ+cxPXf0bIk54NpOhIitpbQ55nMXMtfuO3sRo0q4HsUH+1fUmuVwoqIndEe5
         5wUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795732611; x=1796337411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hFB9I1ji+DKyQjCZIA+oAoIBZp+G9JdoQjveyaRURac=;
        b=rVT1zPgQHBHv1b4j+fjR2xaMg7FAtzaRbtuKDhpVJWx51bhXbjZKTq6evR7mBNQG53
         +CXrEfOt+IPW/e+WhzrY747Y3GoUr0wIvOXp48VD52dIB5YoCS6Il8pNGmKOE4x+ggCJ
         46RVf1n7gRAclVI6OWSIbjErMrWCdOZ8itmV1/LT0S+qIroh2U89O7nvekC1Zq+hYj82
         pfdQZbTBd8f5xFM6K9ss4GNZmf1uYett9VVmzeqU0WqVqNRCMURn4W+KAUQzSVyQugUL
         kFM1ddmTbSnjqSJNw1W6+4tcwl3yNoEartGZsjPnbvjhgypvUuL2LrJhJNGiUZ1CWGNu
         h60g==
X-Gm-Message-State: APuU4Z8nfDQ6xS3Kh7K2isP3LN0KvksmxvMRa6Pkw1CXnX7ap0bl719P
	sejiTLX0bfbdI6PcAcP1Fe6sEmToRL4tRG25rVIZg3fRhWQ+mKWlVo/yd8h1m8/tu4Y=
X-Gm-Gg: AZFdTZfFGuCy7WWsD1f/t8dWffa9JHBmd7/f9xlZOJvNQv7J0puDQTl6J+i1Apfh7EY
	OwKID7l9FHsqkv1NxfyO59gJegH8zHRetJ/+sjRdh4KGTyMH9g9FDNZ1lMTC2wqk+laSf22/pU7
	58Ng5zl+5o3+SurCMLcDFiyJHADEAsWZtUZdtkMNqnu7YG6vjtYFwVrxjpXAGXCpAOyfdvQOPf9
	YxdnSuRTW1rdKztyuICzCBPutUZe9QJOiDOovDzrx90irXyMH8m/W/7/Yf2IW9OZTTeOiX37BZA
	UEHjaoGxlHgWlI/CppxWIzQfAInE56Ok8ROQujP+2ehXqYQoHwYJ5bSK2jwNOOEvviQaFks2bjm
	6MyIUvx9bbshBYHelJb3qj99Uv0mE0QoYh4fb2Sw7XOwM1BoNSNHQNwU94cykKMv82ArF9eE++4
	naf8SCEaAJuqOvFKBFhDftYQxojhDcm4xZyrvxo3BkKXN56wbYuHDAq4L7Gi/RiRoioRASPUAC5
	y+0P2wQ24L9q7Q7tz53jHzjMb6FG5F3fWxCIC3ATKAK6NWQQJgd1TV4msuCvh8RkYXRqvB++m3+
	zslUWl5uKo4QaHHxIXhYNGAjYeI4d3cHNa+sj/M0TxgFy9SNw/vz0qq6kM1JuUkUCyXt/Yz8TtO
	QLRrpMBnlrhUxy6UfQhuSsx2H+IaKfg==
X-Received: by 2002:a05:6808:4fc7:b0:4c0:c8ee:adb0 with SMTP id 5614622812f47-57a035c3666mr33015228b6e.0.1795732611330;
        Thu, 26 Nov 2026 14:36:51 -0800 (PST)
Received: from localhost.localdomain ([149.40.56.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm19146780fac.8.2026.11.26.14.36.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 14:36:50 -0800 (PST)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mgmt-tester: Test a lone advertising instance 2
Date: Thu, 26 Nov 2026 23:36:10 +0100
Message-ID: <20261126223610.1073605-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Read Advertising Features lists the advertising instances that user
space can see. Add a test that adds only instance 2 and expects the
reply to list exactly that instance.

On kernels from 6.1 on without the kernel change "Bluetooth: MGMT:
Fix Read Advertising Features hiding instances", the instance is left
out, because the kernel compares each instance number with the number
of instances instead of the number of advertising sets.
---
Kernel fix: https://lore.kernel.org/linux-bluetooth/20261126161933.923041-1-yaroslav.voytovych@gmail.com/

Without that fix this case fails, because the reply leaves out
instance 2 (kernels from 6.1 on); with it the case passes. Applying
this test once the fix is in bluetooth-next avoids a known failure
in the kernel CI runs of other patches.

 tools/mgmt-tester.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 18dbd3f89..212980da4 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5183,6 +5183,22 @@ static const struct generic_data read_adv_features_success_2 = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 };
 
+static const uint8_t read_adv_features_rsp_instance_2[] =  {
+	0x7f, 0xf0, 0x01, 0x00,	/* supported flags */
+	0x1f,			/* max_adv_data_len */
+	0x1f,			/* max_scan_rsp_len */
+	0x05,			/* max_instances */
+	0x01,			/* num_instances */
+	0x02,			/* instance identifiers */
+};
+
+static const struct generic_data read_adv_features_instance_2 = {
+	.send_opcode = MGMT_OP_READ_ADV_FEATURES,
+	.expect_param = read_adv_features_rsp_instance_2,
+	.expect_len = sizeof(read_adv_features_rsp_instance_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
 /* simple add advertising command */
 static const uint8_t add_advertising_param_uuid[] = {
 	0x01,			/* adv instance */
@@ -7197,17 +7213,17 @@ static void setup_add_advertising_not_powered(const void *test_data)
 						NULL, NULL);
 }
 
-static void setup_add_advertising(const void *test_data)
+static void add_advertising_instance(uint8_t instance)
 {
 	struct test_data *data = tester_get_data();
 	struct mgmt_cp_add_advertising *cp;
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding advertising instance while powered");
+	tester_print("Adding advertising instance %u while powered", instance);
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
-	setup_add_adv_param(cp, 1);
+	setup_add_adv_param(cp, instance);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 						sizeof(param), &param,
@@ -7223,6 +7239,16 @@ static void setup_add_advertising(const void *test_data)
 						NULL, NULL);
 }
 
+static void setup_add_advertising(const void *test_data)
+{
+	add_advertising_instance(1);
+}
+
+static void setup_add_advertising_2(const void *test_data)
+{
+	add_advertising_instance(2);
+}
+
 static void setup_add_advertising_connectable(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -15461,6 +15487,10 @@ int main(int argc, char *argv[])
 				&read_adv_features_success_2,
 				setup_add_advertising,
 				test_command_generic);
+	test_bredrle("Read Advertising Features - Success 3 (Instance 2 only)",
+				&read_adv_features_instance_2,
+				setup_add_advertising_2,
+				test_command_generic);
 
 	test_bredrle("Add Advertising - Failure: LE off",
 					&add_advertising_fail_1,

base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0

