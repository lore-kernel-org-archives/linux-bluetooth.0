Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D2C207E11
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819485; cv=none; b=cK+dhDPP19lUocoVWQF5nOzLVwv62rSgF3oJhbUS9n+hQ1tsk573nvEtHKpoR3OMa6oaB5kgG2jzo3OXpRCEL84Wu8OCK9f+Fhps9iXtn+64Gn3LYuInggdqvCiGzbmzbBpdtrlV+urA/CJ9Eh1FF2TE07mROh5MERi+iTS37BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819485; c=relaxed/simple;
	bh=DPZ4Fy8hFB79kXhQkjjsaUMg1+lmOHgCZ9nLOHWNdV4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8CBBZNXDI3Ew9GWDwmL+4jRzPer5fSM9AEeIDi13NfwGS+TNu6bpvd2T8yaY7wFz3Yg9joOReNYDMqKiE4McKPowIMiS/xten0b8Sia6lwiAi2IweI3vaTp9bFUnDUvhwuklKtHOffnxL/VhkALubV/fknJZlevGtmvV5SOllg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYajINZn; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYajINZn"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72c13802133so2078980a34.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744819483; x=1745424283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEjjwG5jx2aPU05qIE/xX2hSXaML6GcxiCjF2JKd8Z0=;
        b=AYajINZn+SOQxWCY6TOUPmrX/hxpr2r8N6gJ5oN9kpIx8XcL4bPNmN4up/8HnDZLWd
         O4ho58PVsCyhmz5NgiDPv/UauAEQlP5ywe2VcRIKUSYs1e01b2WXzMvy1ND2d7BiXhxQ
         c5JJu0emOeQD3yRWqgHBZwUiZvmA5H9kfmpyEGxmpecUelaK4gwIvt3rnQ82/JDKWACt
         ckPZvavoZXG9D/WOOK/fV/cwqKGgC1rAiqs4gjehrclRSxClOQnNqmPWtX1XUtUEijgA
         ugOTXsbdTGpAsGknAD5JKb9UzFUbcWscy6ScRHtS0aH33ryJZPy7nmJhb0LJP+h/nN31
         uXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744819483; x=1745424283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEjjwG5jx2aPU05qIE/xX2hSXaML6GcxiCjF2JKd8Z0=;
        b=Dg3mq3bYG5SUId6NjvtxTkjTJRzL5SeXfdCeU+G2rtPUAMTUde1RG2zD+0R2MgtfP7
         W73fbAwTDYQVuf4bmOImC8PL1Do4O6qZ+hvsg3N/548WhpDVf0H+Bch9WDIwoLiZG2KS
         jJEmdoBnjsOFqJ48wS5C2n0htJ90SMPPpsSB7LzqKBd1YWdAL9cKmeDZWwkPhcYtocK9
         B3ymYdYBXMi+egFom0M/LvKvGoM4jQPq0kjq7q12uBBJhrre2f8c7zzueKiNojdhB8Lv
         L6vCLgW+qYyx/DMfCUjLGYAvDK1vjoYu6U/PK/pmU30lJDieM+0w8vqe5KXGRLrUHdYQ
         qOYw==
X-Gm-Message-State: AOJu0YwKYZVoFswd4OqG331QebrJNqmvocINL9WexPiB8xbpzcW5joyL
	soOrhmFNqICmIIDS30tAkKvb9t6NzX9LDbLz93umSpR16DvxkS1FKPqjKdNb
X-Gm-Gg: ASbGncsxnVBuEzssohnhtt2jhz6jZRX10ahlg15dT7TudpU/bTHe2KAFtRoApSHLSLD
	CQaDWPnpEeR1IP3lOAVSWizdXD1R5qen6eNflwop7tT4WIAnntcmAxAQ21Yw2/d+UTAOBMZ698X
	ejxwTO4Levhx+Wdtv4cDa8PfJe6NvvaUPJa6OxAizJhfxfKzUj69zaUPfSsJ/1wbwRzs1xWcVig
	YfvOQwKdpnbYhJaDDuy1smnM9dYwAMH/zTE8Biql0pmLjROrjY/CjOKAV5zsYGm4h/ysu/n2P4O
	WTZAAy6TTF6szqrKtABN1P2+UJyvRrtPYw5hY5oTRKmyOp3r5etokgH9zQzlXn8QbLVMxAUI256
	oF8hg5MNC5wuVaGxCgqxV
X-Google-Smtp-Source: AGHT+IEUW7kT1FIFaHM09GIrwvo+YfPifX/+5COi80gYMTyCgk5xejaBCyrIMDSf2R77bq27Gi8cmA==
X-Received: by 2002:a05:6830:6083:b0:72c:3235:9c5b with SMTP id 46e09a7af769-72ec6bf7f17mr1706273a34.16.1744819482689;
        Wed, 16 Apr 2025 09:04:42 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c98afd43sm3094029137.20.2025.04.16.09.04.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 09:04:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/7] iso-tester: Add test for SID=0xff
Date: Wed, 16 Apr 2025 12:04:30 -0400
Message-ID: <20250416160433.1822263-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416160433.1822263-1-luiz.dentz@gmail.com>
References: <20250416160433.1822263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following test which is used to verify that when
application sets bc_sid to 0xff the kernel will attempt to scan for a
valid SID before attempting to create the PA sync:

ISO Broadcaster Receiver SID 0xff
---
 tools/iso-tester.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 350775fddc96..b362647461c3 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -495,6 +495,7 @@ struct iso_client_data {
 	uint8_t pkt_status;
 	const uint8_t *base;
 	size_t base_len;
+	uint8_t sid;
 	bool listen_bind;
 	bool pa_bind;
 	bool big;
@@ -1419,6 +1420,16 @@ static const struct iso_client_data bcast_16_2_1_recv2 = {
 	.big = true,
 };
 
+static const struct iso_client_data bcast_16_2_1_recv_sid = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.server = true,
+	.big = true,
+	.sid = 0xff,
+};
+
 static const struct iso_client_data bcast_enc_16_2_1_recv = {
 	.qos = QOS_IN_ENC_16_2_1,
 	.expect_err = 0,
@@ -2843,6 +2854,7 @@ static int listen_iso_sock(struct test_data *data, uint8_t num)
 
 		bacpy(&addr->iso_bc->bc_bdaddr, (void *) dst);
 		addr->iso_bc->bc_bdaddr_type = BDADDR_LE_PUBLIC;
+		addr->iso_bc->bc_sid = isodata->sid;
 
 		if (!isodata->defer || isodata->listen_bind) {
 			addr->iso_bc->bc_num_bis = 1;
@@ -3817,6 +3829,10 @@ int main(int argc, char *argv[])
 	test_iso("ISO Broadcaster Receiver - Success", &bcast_16_2_1_recv,
 							setup_powered,
 							test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver SID 0xff - Success",
+							&bcast_16_2_1_recv_sid,
+							setup_powered,
+							test_bcast_recv);
 	test_iso2("ISO Broadcaster Receiver2 - Success", &bcast_16_2_1_recv2,
 							setup_powered,
 							test_bcast_recv2);
-- 
2.49.0

