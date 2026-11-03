Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737843;
	b=BQrQ86uMjmtRI5LbE+WAWECiMhVVMsbgJOvL876+ikonyfsDDJHMsDOCdzsCLATp5oUA
	 7sDkDepEgfZfZitqVYK5eZ4WKp1aE8tiBLbNxvIzvUrswC7qBCdCm6r1tPYaigaUldVyF
	 sQRc+90gTIJDLUJWBBfw06kcphtUD8H2o26FE+4HY/jyn+EMLflW+uMOIP/mAWc8Uqcj3
	 zF5cYyDGEdsmpebvfKcch/J+rvOrpSXLrpjMROkoeUvUYzFNqOvycXVVQA+PvGkEIIAW9
	 ajZnGT6VzbiXFnfAE3opWbg+DFrRHnO4NVJuWXxjrgVggcwEscUvpVbzLh+85ccrVOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rCFw/wHJd/u2CTxo3A7lkSztzsNUxKo6MOK5Efevu84=;
	b=kgCOGgB0Zq0ytF6dE7unqC8l3US066Vx30xngZ4vbvgZPCLv9SfPLwT+SngM6YKaapGL
	 Fb5tjnO6XF46QUb2emROZBE9yGAYwRapyh0V1ogFeHDaOCWfVfopeX55rYP4Foiutu4iI
	 Myby/iH/IiH8OaU5fmlAzzSun/cs+DtQU9ReJuphIJYeHUFhXRmt55AvmKc9RfwyzdPNY
	 eUE0ResP96/B+nnZ5Cdv/eQdUjHBwuukvx2JQMEiDXfJQQ+GHv25bSQlJc9R+KE9W+MrR
	 kfaQVtPS8TuOGSe7I9Kcm5o99d6HmQG3amiGGkTKL4WvxJUfvyLhGXzxktWnDnoPTKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dVFmv5zY;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D2C606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8D2C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dVFmv5zY
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7cc0892f92cso1528441137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737842; x=1794342642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rCFw/wHJd/u2CTxo3A7lkSztzsNUxKo6MOK5Efevu84=;
        b=dVFmv5zYrv9/I7Y+dXiGS+N2G8PMBiQSycp6RpFzyI378a9SWOEnyCurMVferB/R52
         mCwzHrwxED1XMM1sofysAHIwNI6gwKUeV9GnIn42TrawXFNvgVo0MEU31KzcGmGZPsGU
         4uT0kuZQuBhKIVEm6VjnZ0dD+oEOE6s/ILskudx7XHXBTPcGRbU2jYPVpkEqURo5W4+t
         4K9BbMtQMGOMXlrrlAod6N9D7lVPAetMPvjGC7ICi37xDKGzBr+7Wwy2v3Zmgz9ERp9U
         fM7eZwWMOTdmLHRD5JRpY3g7mlxUlXEWyYOthWLPK5upd6DkVgrP6ozPIvr1L99cWb81
         Z/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737842; x=1794342642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rCFw/wHJd/u2CTxo3A7lkSztzsNUxKo6MOK5Efevu84=;
        b=wFUOKHbrbezWuWX/H20V1By+TrQzK+VY8xWRa/ebmEbmqG06SLHMQPuryaQrMdF8p7
         FT4U3J26lnngGKgwZvOA6r5ca1UH2nY0lS9PMGDl3jTwASco/CKYxfqGv2LfA8AWt8B0
         Dz4bMJq/FPdRB709ty05MIW+isV/W/o8pVtV+1PhUN/myBF5Iy7EvoDr4mzfMWSrjMHM
         4MZm8BGfTYR0lHsoejNEKMl31p1UDWwmSrSsc4BAln/AtdSP8bq+rR/CJ92sucM/Lydk
         KaDiez5Dur9ew8ns0YzHJdFA+pmfTYhpIyC8Xw8sE9alB3UyaASdu6JhWXV8kSCAoGHB
         m9kA==
X-Gm-Message-State: APuU4Z/78z2K2FsALwefASzwGWQYoE8R9DGLCXFWG6G1MJUyv1LHq0Hm
	tnObvwf+O+EgJTHC1E/ItHLwlth/E0SmKUgrjvvvsH0HjSSAW00uGkCAF69lWw==
X-Gm-Gg: AYBFou0S9osw8cZgf6uNmrJNcl5aRfKLVIbSNgaXwWP+dEalHdjhF5vIXRXDTA1cBk9
	kmNtQWsHKbn3j3TpitmqkBPuKeOoTdg2YEox6zSp5/yGZntV4YhaG7ulZVwJYn8IFlqRZti4J+i
	92NCyV55P57wMe95JOm4U8M2PKfwCbdHf6rdos7HDLe4G7Tpfw9SVvSRs5pSXl18frau9bOIfzz
	Ch7LWsg/KsA2dnVbfjkrtD6GKp7O2hVPCBqENI+bqECSipxvN9OHM3MlZUc9f4Uc7ulw44xGzL0
	XEMzn0aTWpU5/j/l9W+aXlOLj5Iz/62x+fWuG+E+WQF1cnVTrUh9YdcXabGYS27wNg7iPECTW81
	uEMZ+l2rvOSqdhqr1cbESFTSJPi+i1ZpZed/0AP4zKGATm31OQd+MvscpnIFS9Qwp7lTbzkCdQ/
	IWMIRsVkeEcmnI1f3H2sjQpV6QwDv1w8xj5NrFoJ0bqlsvef0IOHbgUB61mlEXks1vu+sYtKoBr
	sEOoIuFboiNc9UhRwbSO9YmUiNKJwEdG9m7JysGmBmhZNc7VjaF8n8mia1PbxmqlrqfEcpWz0Aw
	Nj6McqJWSffyTZ8DnY+jTqG1RndeAZbhu75wEd4m24prQtmgd9aTN83p8A4y5SCDL7oeYPhNMql
	Hsq6JmVdSuAQWRxtZkWIlQKgG9IEozTouTzq+WzJyhopWfTg8RlrfD1ddb4CfyuRbDxrYX5GReW
	pBUi/g
X-Received: by 2002:a05:6102:3711:b0:7c8:1fd5:82b5 with SMTP id ada2fe7eead31-7d072695e4emr4857884137.14.1793737841702;
        Tue, 03 Nov 2026 12:30:41 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d69af021sm167865241.1.2026.11.03.12.30.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:30:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/5] unit/test-gatt: Add Notify Multiple server tests
Date: Tue,  3 Nov 2026 15:30:33 -0500
Message-ID: <20261103203034.3904499-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103203034.3904499-1-luiz.dentz@gmail.com>
References: <20261103203034.3904499-1-luiz.dentz@gmail.com>
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

This adds server tests for sending Notify Multiple with the default and
a positive timeout, disabling it while a notification is pending, and
sending with it disabled.
---
 unit/test-gatt.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 535baafc6f70..6d6d0c73ed40 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2336,6 +2336,70 @@ static const struct test_step test_notification_server_1 = {
 	.length = 0x03,
 };
 
+static void test_server_mnotify(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+
+	bt_gatt_server_send_notification(context->server, step->handle,
+					step->value, step->length, true);
+	bt_gatt_server_send_notification(context->server, step->handle,
+					step->value, step->length, true);
+}
+
+static const struct test_step test_mnotify_server_1 = {
+	.handle = 0x0003,
+	.func = test_server_mnotify,
+	.value = read_data_1,
+	.length = 0x03,
+};
+
+static void test_server_mnotify_timeout(struct context *context)
+{
+	bt_gatt_server_set_mnotify_timeout(context->server, 1);
+	test_server_mnotify(context);
+}
+
+static const struct test_step test_mnotify_server_2 = {
+	.handle = 0x0003,
+	.func = test_server_mnotify_timeout,
+	.value = read_data_1,
+	.length = 0x03,
+};
+
+static void test_server_mnotify_flush(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+
+	bt_gatt_server_send_notification(context->server, step->handle,
+					step->value, step->length, true);
+
+	/* Disabling sends the pending notification right away */
+	bt_gatt_server_set_mnotify_timeout(context->server, -1);
+}
+
+static const struct test_step test_mnotify_server_3 = {
+	.handle = 0x0003,
+	.func = test_server_mnotify_flush,
+	.value = read_data_1,
+	.length = 0x03,
+};
+
+static void test_server_mnotify_disabled(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+
+	bt_gatt_server_set_mnotify_timeout(context->server, -1);
+	bt_gatt_server_send_notification(context->server, step->handle,
+					step->value, step->length, true);
+}
+
+static const struct test_step test_mnotify_server_4 = {
+	.handle = 0x0003,
+	.func = test_server_mnotify_disabled,
+	.value = read_data_1,
+	.length = 0x03,
+};
+
 static uint8_t indication_received;
 
 static void test_indication_cb(void *user_data)
@@ -3337,6 +3401,41 @@ int main(int argc, char *argv[])
 			raw_pdu(),
 			raw_pdu(0x1B, 0x03, 0x00, 0x01, 0x02, 0x03));
 
+	define_test_server("/robustness/mnotify", test_server, ts_small_db,
+			&test_mnotify_server_1,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x00),
+			raw_pdu(0x13),
+			raw_pdu(),
+			raw_pdu(0x23, 0x03, 0x00, 0x03, 0x00, 0x01, 0x02, 0x03,
+				0x03, 0x00, 0x03, 0x00, 0x01, 0x02, 0x03));
+
+	define_test_server("/robustness/mnotify-timeout", test_server,
+			ts_small_db, &test_mnotify_server_2,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x00),
+			raw_pdu(0x13),
+			raw_pdu(),
+			raw_pdu(0x23, 0x03, 0x00, 0x03, 0x00, 0x01, 0x02, 0x03,
+				0x03, 0x00, 0x03, 0x00, 0x01, 0x02, 0x03));
+
+	define_test_server("/robustness/mnotify-flush", test_server,
+			ts_small_db, &test_mnotify_server_3,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x00),
+			raw_pdu(0x13),
+			raw_pdu(),
+			raw_pdu(0x23, 0x03, 0x00, 0x03, 0x00, 0x01, 0x02,
+				0x03));
+
+	define_test_server("/robustness/mnotify-disabled", test_server,
+			ts_small_db, &test_mnotify_server_4,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x00),
+			raw_pdu(0x13),
+			raw_pdu(),
+			raw_pdu(0x1B, 0x03, 0x00, 0x01, 0x02, 0x03));
+
 	define_test_server("/TP/GAI/SR/BV-01-C", test_server, ts_small_db,
 			&test_indication_server_1,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
2.56.0

