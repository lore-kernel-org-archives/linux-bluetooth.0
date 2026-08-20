Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C16C33B6EF
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250655; cv=none; b=h1++T6v6+/j6Sux4r1Ommr7ntSnZ5HU2iaB+K64U9UVPmOWmstaU2yyWWs4BGv6lcpPp4XpzSTZLwIcXGUrGWed9y8PbHRIjR2kkc8PTyx8Hk6gx5KTqlxysstgXoUFDJaMbcSFyB3QNRFhTkKqz99p2pI4yfZ/MAZSFE7fpt3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250655; c=relaxed/simple;
	bh=h4dzsuSzjM9oneLefODgz0Sy3RRZBWcugjsQliVMsuA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIKAHeh24i8tI/mJt9TU3wnHxY+uhsVN8Qbi1MU6YO6AdGfIqr/dNwhzrS80JS1DboM7I/EajbvVQVu/w1+r0GxJBfTqxBIpLeI+m0OdYOHgc/nCFauP8X7N2ipE2IdZHk4L0JVbh81FBLdLq/BgtVOHkO2g+zDJFGQVLkPbfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrkvEmmf; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrkvEmmf"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bfc54558d5so106074e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787250652; x=1787855452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Gv7oHT/KUkxsypStyXBW4s44zwyerGbg+3rWB0c7b08=;
        b=XrkvEmmf949pXtt+ox1O2+4rXDTPehm6VQ4yPba48+WNOk7hnXuJ3CMro+b9HewFxN
         hsEriq3RUlFDyB9B2nOsy70KcRBapSRLcK3VESRxufQK1VGqD8Z1pRV9s6J6X/I2Diz+
         sHWYZ5/ETHlRqSXIeUyIsw2PNOORWCliAqatDYAhKjCgbYFgawrzs+9hVESceFUgL6e3
         UU1XgOIXjotqCSeA4GxPiB4jEe9iVz0HKvCQSUVZj+gc2AAilx9UZhZeaNtCJRhYOFKR
         KlUWjNlyRkMYhqs1p0sgxQmSNAGRwTth2Bt3hrShFM0IxqAfC80FERmt1P9xoiC58Ke/
         B5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250652; x=1787855452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Gv7oHT/KUkxsypStyXBW4s44zwyerGbg+3rWB0c7b08=;
        b=awH8XhtxSGE75ouolO57bsTnVkBk4pKoy3dl89JyMmk1G7V0yc4b5mxNs0pr5zj+54
         cHxaYXNvZUHqOKYjGUU9ia358b1StJI39dYQ3Mfq41HiO0irsfAsqdhklyHuRsD/6t4q
         Ap9HqAkdhvItky8bH/RX+RpoNZ9Or6sK5gIoMdK22yfXKPelEMhOp3bG7V2SjS8ToD46
         fyDR0DshVFg9Qg0ksbn8wH3MLHKHFoz6WZu6ck/3XtMDLCdZSR6hdTgtU1mHjoRA+xaj
         cJrC8dgbwYrTS1+oCyKvGx9ZYFzxz+XhUW86w7cblnKlyrrgvOk1kWv5RNr05G5VrhL6
         bDlw==
X-Gm-Message-State: AFuF++kdOK+iVIj2jAUWfrzYHKbiinFXNmBvM6O0SDJSyxRrVsDmOsVv
	+QnBMLapueE2gg6oaLoX9tVzUdrYCkfH3KK7JAAgYYkciOZd0eeixRsyOSjJpARZ
X-Gm-Gg: AR+sD12wbvNE3E0qAMatRCefwuJRv2NFIyUQGgeWIDMsEl3pHhaXSPU72P64UvxUE5A
	zKnm0Y2fXyG11iI6qlLjI/kON8J7aaskaQJ9ipk5RV4ddVlfOTtNul4P6F24Izl80blsN9B6bz3
	Q9J8hapcNutqp5qCx0MdTSS0Dllm7oMe/zwEN8NzwGpj0w6N5RftUrOUDKPX/4UCtK/4TTD5OXe
	y5uCTjaxiLsWXBmOe/++yzgwuzCjC3gSXSS3QEmewGA7GjZ/GJZe9gdehh+NVM0Tg8QcDCIlWGd
	t5V9T915BbW5rJknc1bx3pb94BgENGPI78ECwlKRP9Y0Kou6mlhzbdf34xRjKRIkzzyx0GU5SNm
	t2st67IdZlgWU8wVtZYlQ24A0uvHMnTy55TrhHEtaEM0kzPiJ0Wb5FFNFOBUZUnTBKBCZHAtL/N
	71FVQYKdNDMIQnRWMQb16WNIrpudy7F97MBSEJrO2azLkPuTHC4UXZc5+rvyMS1gEjzxBIr/owg
	v5iILuX7v2iIxaloM99NS91DCNNMDBBPadMQKKc5c8i4bP8YHKdJ5wm5Dxb2AqDnw==
X-Received: by 2002:a05:6122:2c32:b0:5c5:924a:4616 with SMTP id 71dfb90a1353d-5c5eedf40b6mr1963390e0c.0.1787250652447;
        Thu, 20 Aug 2026 11:30:52 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e276d416sm6840662e0c.12.2026.08.20.11.30.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:30:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 03/10] unit/test-eir: Add tests for the longest local names
Date: Thu, 20 Aug 2026 14:30:30 -0400
Message-ID: <20260820183037.2713973-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820183037.2713973-1-luiz.dentz@gmail.com>
References: <20260820183037.2713973-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Nothing covered a name anywhere near the size of the buffer it is copied
into, which is why the missing clamp went unnoticed.

Add two tests. The first uses a name of HCI_MAX_NAME_LENGTH bytes, the
longest one that fits, to pin the boundary down.

The second uses a name of 253 bytes, as large as eir_parse() can be
handed given the EIR length is a single byte, and which does not fit.
Run against the code before the previous patch, it dies with

  *** buffer overflow detected ***: terminated

Assisted-by: Claude:claude-opus-5
---
 unit/test-eir.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/unit/test-eir.c b/unit/test-eir.c
index 62164ca993f6..326bc899e251 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -440,6 +440,64 @@ static const struct test_data iso_2022_jp_name_test = {
 	.tx_power = 127,
 };
 
+/*
+ * A complete local name of HCI_MAX_NAME_LENGTH bytes, the longest one that
+ * fits the buffer eir_parse() copies the name into.
+ */
+static unsigned char max_name_data[HCI_MAX_NAME_LENGTH + 2];
+static char max_name[HCI_MAX_NAME_LENGTH + 1];
+
+static const struct test_data max_name_test = {
+	.eir_data = max_name_data,
+	.eir_size = sizeof(max_name_data),
+	.name = max_name,
+	.name_complete = true,
+	.tx_power = 127,
+};
+
+static void max_name_setup(const void *data)
+{
+	max_name_data[0] = sizeof(max_name_data) - 1;
+	max_name_data[1] = EIR_NAME_COMPLETE;
+	memset(max_name_data + 2, 'A', HCI_MAX_NAME_LENGTH);
+
+	memset(max_name, 'A', HCI_MAX_NAME_LENGTH);
+	max_name[HCI_MAX_NAME_LENGTH] = '\0';
+
+	tester_setup_complete();
+}
+
+/*
+ * The longest complete local name eir_parse() can be handed at all, which is
+ * bounded by the EIR length being a single byte. That is 253 bytes, more than
+ * the buffer it is copied into, so this used to overflow it.
+ */
+static unsigned char long_name_data[255];
+static char long_name[sizeof(long_name_data) - 2 + 1];
+
+/* The name does not fit, so it comes back clamped to HCI_MAX_NAME_LENGTH */
+#define LONG_NAME_LEN	HCI_MAX_NAME_LENGTH
+
+static const struct test_data long_name_test = {
+	.eir_data = long_name_data,
+	.eir_size = sizeof(long_name_data),
+	.name = long_name,
+	.name_complete = true,
+	.tx_power = 127,
+};
+
+static void long_name_setup(const void *data)
+{
+	long_name_data[0] = sizeof(long_name_data) - 1;
+	long_name_data[1] = EIR_NAME_COMPLETE;
+	memset(long_name_data + 2, 'B', sizeof(long_name_data) - 2);
+
+	memset(long_name, 'B', LONG_NAME_LEN);
+	long_name[LONG_NAME_LEN] = '\0';
+
+	tester_setup_complete();
+}
+
 static const unsigned char bluesc_data[] = {
 		0x02, 0x01, 0x06, 0x03, 0x02, 0x16, 0x18, 0x12,
 		0x09, 0x57, 0x61, 0x68, 0x6f, 0x6f, 0x20, 0x42,
@@ -756,6 +814,10 @@ int main(int argc, char *argv[])
 									NULL);
 	tester_add("/eir/iso-2022-jp-name", &iso_2022_jp_name_test, NULL,
 							test_parsing, NULL);
+	tester_add("/eir/max-name", &max_name_test, max_name_setup,
+							test_parsing, NULL);
+	tester_add("/eir/long-name", &long_name_test, long_name_setup,
+							test_parsing, NULL);
 	tester_add("/ad/bluesc", &bluesc_test, NULL, test_parsing, NULL);
 	tester_add("/ad/wahooscale", &wahoo_scale_test, NULL, test_parsing,
 									NULL);
-- 
2.54.0

