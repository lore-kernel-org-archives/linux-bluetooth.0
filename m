Return-Path: <SRS0=ihQD=NM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CBAC6786F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Nov 2018 14:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDF02064C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Nov 2018 14:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sX0TxsER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDF02064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeKAXU5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:20:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44311 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbeKAXU5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Nov 2018 19:20:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id n19-v6so5704354edq.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Nov 2018 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3TtYVsOvX91E45dtR/rlfhVJqaP8hvwZZwjnFW9KXsw=;
        b=sX0TxsERjDPfz9AIePBhe8Vex4ongkI8bl9uWa5r9YCeurk00VgZKx/opKFm0CADzR
         CUe5woFfVJ/RP8UgzqR1pFCEb7/HzdpzqkZJlbeA0i21wBDxIBW1i4zCSJq5gIKTji5f
         xfblA/zOh5wbfEjMQkqgiOGShMP01lcU7juIRMYwRdZuEHCuL67Anr188tAffzSLSCUb
         zBXIhSkoFBbJhJDHwPbqU7EAMmfEp7mKBKEWD3fVzs2AHvGjIVPa6bHX2kPBLeaHb1Ex
         eH9Z/A9mJulSitaWn7hJHY4lZuarhmyhS8Qix8ZZgRLD3p9LzdHZlImBI7DWKnKqCyE6
         plLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3TtYVsOvX91E45dtR/rlfhVJqaP8hvwZZwjnFW9KXsw=;
        b=lHHt7e8Ges80TGTaEdsrv12xDouvEy9fznRTGTPiGU8PRNdUI1gvZWB3Ss0YcbhFxy
         PhEqxzQ8MItfRkOOMhj2Jz2b2nJONS04Lrl4BUrAuEcsqtCU1o/jlN9QQsjOFcGeknQ5
         wxc4IqRZTiTeNeectYrv1qcb4uYUFjY/LBlENfzXKGdW64I2YEaaFYi/EpQ/zLl5MVK1
         W/lNIZ87kCFvpAPlGAOXJBmcEpT1O128RHyTuVK9hgHkyBHtfHEo5Allzv1gJwKAlMcy
         3W0KSOp+vkjy/i+DgL3MOp7WbrYn7rZNlsYKsffUg+m2eviUXtcn50lkqY8wt0Zuz3uw
         dc4A==
X-Gm-Message-State: AGRZ1gLNeXXHEl7acm0otcI0+fTmy3hwjsC6fzMMTEQfAE5xOLsasl7S
        1iGAh9ws1EyUg49NXHwtNk7746LV
X-Google-Smtp-Source: AJdET5fvd5YPBO9jN4PUkY7H6151rFiyHf6JnVsuj+B7l/SOxKB/3zV3gCNfv8dpVV30UPGK2NMZ1g==
X-Received: by 2002:a50:b2e1:: with SMTP id p88-v6mr5192291edd.155.1541081866515;
        Thu, 01 Nov 2018 07:17:46 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id g15-v6sm5452219ejj.67.2018.11.01.07.17.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 07:17:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] sdp: Fix buffer overflow
Date:   Thu,  1 Nov 2018 16:17:40 +0200
Message-Id: <20181101141741.11449-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181101141741.11449-1-luiz.dentz@gmail.com>
References: <20181101141741.11449-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

sdp_append_buf shall check if there is enough space to store the data
before copying it.

An independent security researcher, Julian Rauchberger, has reported
this vulnerability to Beyond Security’s SecuriTeam Secure Disclosure
program.
---
 lib/sdp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/sdp.c b/lib/sdp.c
index eb408a948..84311eda1 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2834,6 +2834,12 @@ void sdp_append_to_buf(sdp_buf_t *dst, uint8_t *data, uint32_t len)
 	SDPDBG("Append src size: %d", len);
 	SDPDBG("Append dst size: %d", dst->data_size);
 	SDPDBG("Dst buffer size: %d", dst->buf_size);
+
+	if (dst->data_size + len > dst->buf_size) {
+		SDPERR("Cannot append");
+		return;
+	}
+
 	if (dst->data_size == 0 && dtd == 0) {
 		/* create initial sequence */
 		*p = SDP_SEQ8;
-- 
2.17.2

