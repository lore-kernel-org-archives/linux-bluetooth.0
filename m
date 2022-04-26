Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B47C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Apr 2022 23:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355987AbiDZXG7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Apr 2022 19:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbiDZXG6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Apr 2022 19:06:58 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF3B8BF23
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 16:03:49 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p62so659391iod.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A7LzyN3BLdbjimxUb8J0gDuiLBJbokhGYzF2kcOy5uA=;
        b=kmNDYJrQGSXzfwutaKhdRntfJx8SlDjf5gjZKlGrgaOIZ11Ki5dvJqqPkV8Mdtuc3E
         CseR8uy4YNiSJ4oWxk8+ZGf18ZNC5r0UEJvOjXHV7Y8JBRfYor49nUGNYgZ5EkONaqLD
         3dpbXcCVOBKQ8IRepavOGpS4r/vSiEhbfX57R7697n0QnIyii8Dskaw+mPtBTMmS6EPA
         0iEVftNdBSC0mHGpdjDn/MOKdSkHc8WqSr9qj/qqOKWEEFTYrjAGynH8+RUbTWpJvw+A
         NqrneV959JE8AJwms1Qx3BWQ69HA5svKGS7gUcKr2vaDOSS/vuBFyRoO7Z5IKWn/7ZWj
         7CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A7LzyN3BLdbjimxUb8J0gDuiLBJbokhGYzF2kcOy5uA=;
        b=Jze7cOmLtQ0MOwFNIFfhpqdo/r/sdibFNvf66w6g/Kn3EnoTTwfai2cQXCgba91wnx
         u0CPRtZcmbu/9YK1OFiXjOAMLb935S8tnxEAC60vabl0voV26OSy5BMhE6zep+oOpcT8
         K0a4YvQ9TbrlEa2FGFeXldzqiLKV/5LD2G62/rswOciCwgVuCbaeoSXvaEFXh94VC36J
         FHPhDh/T1xPhR1SFO8eFf0RiFr/PRJb70KuSa1Qrb8pCWAFrJ55JGl/8zcI0PatXsz8t
         5oJgJVO2FnLw4gov6EBqlcS7N/0sBuJKy6AEZZM6snY3Ddn15OtFOWEqtGC9AvERR97m
         /+XQ==
X-Gm-Message-State: AOAM5322fnozKw6dGh0Zj3mWkfdIsiGggkhaluzwvxNCN0Nokw2TQpjh
        G6qeZa8UzbiWB3RDSzW2BDIU7gKm4nQ=
X-Google-Smtp-Source: ABdhPJzeQYIA7QKZBOd6bLpZhmdp7hSNaVvNCm3oV/CEj417bgjEI4BSC5Z3IQG7nhyhtdfuQD+SFA==
X-Received: by 2002:a05:6638:1487:b0:323:7543:6cb9 with SMTP id j7-20020a056638148700b0032375436cb9mr11076614jak.98.1651014228730;
        Tue, 26 Apr 2022 16:03:48 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a056e020df000b002ccc1d58ca5sm8437194ilj.54.2022.04.26.16.03.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 16:03:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] btmon: Add proper decoding to Service Data UUID
Date:   Tue, 26 Apr 2022 16:03:44 -0700
Message-Id: <20220426230347.857783-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds proper decoding for Service Data UUID:

        Service Data: Apple, Inc. (0xfd6f)
          Data: e6b07e19815e902100b8b2f4a55255fd18f0c6be
---
 monitor/packet.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 6ef2fba3b..471b0dd4d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3301,6 +3301,14 @@ static void print_uuid128_list(const char *label, const void *data,
 	}
 }
 
+static void print_service_data(const uint8_t *data, uint8_t data_len)
+{
+	uint16_t uuid = get_le16(&data[0]);
+
+	print_field("Service Data: %s (0x%4.4x)", bt_uuid16_to_str(uuid), uuid);
+	print_hex_field("  Data", &data[2], data_len - 2);
+}
+
 static const struct bitfield_data eir_flags_table[] = {
 	{ 0, "LE Limited Discoverable Mode"		},
 	{ 1, "LE General Discoverable Mode"		},
@@ -3703,9 +3711,7 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 		case BT_EIR_SERVICE_DATA:
 			if (data_len < 2)
 				break;
-			sprintf(label, "Service Data (UUID 0x%4.4x)",
-							get_le16(&data[0]));
-			print_hex_field(label, &data[2], data_len - 2);
+			print_service_data(data, data_len);
 			break;
 
 		case BT_EIR_RANDOM_ADDRESS:
-- 
2.35.1

