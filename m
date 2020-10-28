Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46076C55179
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E31A024786
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYMoSWXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgJ1V62 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgJ1V61 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 17:58:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE72C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 14:58:27 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a200so568264pfa.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UfFuAh8ziD5ZytbYG6OnsrcCkKzwbUye/59XOxdwapM=;
        b=EYMoSWXd4MDFdBJe6nqfQkoWdDwoGIERg7ZUHueWqTomm9K/BA6pvaZHPhkS1xWpZV
         Ey2OGNGwVtP/k8/4xxUbCRAJdPcmgIRbBxBYqCDs5poZ23pOj3e4sz1s+XyPJJTRaQPB
         699TI2QkNiiJEpAlbEuG3RHJlvKmn0cX7kssm1D+dm0dcZGJopXXsoqfbgIZkXZHWXKU
         nuI1djpVIgzF+sxR9FFJGhCDAhvWJeghfP2XjiymmDkZpFm+ewduJBg8IBruegUUQiOd
         WksVweHuHe14HWVERYgczSewY8FD+GgXwNGFispKR7/gdvAU0gCUQUvS/xtcIZJdUhML
         zeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UfFuAh8ziD5ZytbYG6OnsrcCkKzwbUye/59XOxdwapM=;
        b=boeCmgx6ER1r+zFVx1Y14/hF0PfyKx+zshBnpPGCEhVrVtKjeb/3yuVHB+TNjTfgAp
         EqZbStBDeJU/wNbT/Rh/jUZKYq4rLjfsEDUs7MKMGLuMOJlVGG941ItZA7oMXUrUfQXQ
         TPvSvnnpYN+J/zriZJKQCW3pr0Z2RtQ3iABRdAf4DwA31dJHqDyowdht1LEfraOhag+I
         /xbk1BHgFYTgrUso3oZ7rAYJg7Ei4Wt2cyIAeuYyvC8v8r9iABQfyH3jZ1o4aPA8AmWu
         xfkpOqV4N6XvQYnhlXbEvyW/cOg2TXBDPVG89wiHm9pSTIZEcVUPc+Wmm59ZL4fwW8gx
         fq9g==
X-Gm-Message-State: AOAM530G+TwRBmqbmkVf1QRz9nivPlrsUSdK9+100M9bJdq4ejkDw4NV
        paJMLOHKQQzARhvSXAEUZXQLE1cK40QBIA==
X-Google-Smtp-Source: ABdhPJxM2i6vJoR4rF0WEA1YVtD7VK/ov8MqVFYpwFZ9mRF5HEXe7w3xZe76vxsB7hbgD88x/Pgfig==
X-Received: by 2002:a62:8285:0:b029:164:58f3:82c0 with SMTP id w127-20020a6282850000b029016458f382c0mr983465pfd.9.1603922306808;
        Wed, 28 Oct 2020 14:58:26 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m13sm355290pjl.45.2020.10.28.14.58.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 14:58:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] shared/mgmt: Add mgmt_tlv_add_fixed
Date:   Wed, 28 Oct 2020 14:58:21 -0700
Message-Id: <20201028215824.608794-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201028215824.608794-1-luiz.dentz@gmail.com>
References: <20201028215824.608794-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds mgmt_tlv_add_fixed macro which can be used to add fixed sized
value.
---
 src/shared/mgmt.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index 74b8befd8..319beb62f 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -38,6 +38,9 @@ struct mgmt_tlv_list *mgmt_tlv_list_new(void);
 void mgmt_tlv_list_free(struct mgmt_tlv_list *tlv_list);
 bool mgmt_tlv_add(struct mgmt_tlv_list *tlv_list, uint16_t type, uint8_t length,
 								void *value);
+#define mgmt_tlv_add_fixed(_list, _type, _value) \
+	mgmt_tlv_add(_list, _type, sizeof(*(_value)), _value)
+
 unsigned int mgmt_send_tlv(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 				struct mgmt_tlv_list *tlv_list,
 				mgmt_request_func_t callback,
-- 
2.26.2

