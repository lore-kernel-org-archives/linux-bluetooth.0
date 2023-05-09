Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837D7C7EE22
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 May 2023 23:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjEIXzN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 May 2023 19:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEIXzM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 May 2023 19:55:12 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF8F2D56
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 May 2023 16:55:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaf7067647so45576435ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 May 2023 16:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683676509; x=1686268509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=btX1OLaWAeL7ZxitxiWdF8CUZTFL/d22j4eEs9fxNq4=;
        b=A8UEKSOzBVyUPLCANJKVMTRezeyr2wesfXLTehdHc0a6zEvlDtsB/l0o+YAOtA6pXv
         jurNkXG93k0OER9YC+y4I9YSML2DZMx2jjpVFsYxUxa7oKdeV9Z1Zkv9SQECpf50Y6FY
         LZmD8Jo4RRyyGZJA+27iV+eepq48RlzJ98Zq5cB4EwQtVQnvXUcv151IXCnZWT7k5XKN
         /KWIM7Vxslx+Ji1MYM3UUzyqWpYEXzIIt91/dY59PONwiYOrK9JsfC8UR9JH8ogPyaSx
         APMrk3/2RIPzC0+o2aF1SbrF8fC4DD88oj3MrS90N3o1lMR2mzLVcGfviXT06tZi7StZ
         wS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683676509; x=1686268509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btX1OLaWAeL7ZxitxiWdF8CUZTFL/d22j4eEs9fxNq4=;
        b=G54Pf9e46B++35bDY3pMvghabtDRVMjKRM0zltupMO5a9vBKPtuM9TixLR2Cm37Nxb
         4CozFB64SufpQoL2XUZq438ry7mn6JaumNgNEXqD8ftaZBJZyuu80lJ4lRRvDMlL1udF
         ulxg8QFiEH6ctyitJcm1iesicZLOCxv751WBNGCX0Xd0wuMhzmKQifqGChRsP7hu/2ou
         XrmfX7/8qbh8iDaNHM3MLFZSkbl5Dqx1+rJl+kLNl7aap4yV+AgOXqa4nluPuCJ7jC5c
         bSzFJ2XYrU/SLs1UNujBmJAz0qCVj+1LeOwVtbvjjHGBIeIF6Udi21Iot1QxdDMoR+me
         ZzhQ==
X-Gm-Message-State: AC+VfDz2D7gAbNEowNMXM0pqiijPRbYWPh1lF16FHh+nCPqaoyqwiNxT
        Hqe5IHJwiab6uMjXPJhBN3hwY0ixdEI=
X-Google-Smtp-Source: ACHHUZ6ycHeOyjQ3DFyZRsCtsa58hg0CS/HmSvi2cDr/NSYSQ12axwbu0izYHDfRA5tbYvnnbqU8Zg==
X-Received: by 2002:a17:902:ec87:b0:19f:87b5:1873 with SMTP id x7-20020a170902ec8700b0019f87b51873mr20783606plg.62.1683676509405;
        Tue, 09 May 2023 16:55:09 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id y5-20020a1709027c8500b001a98f844e60sm2202437pll.263.2023.05.09.16.55.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 16:55:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] monitor/intel: Fix not skipping unknown TLV types
Date:   Tue,  9 May 2023 16:55:06 -0700
Message-Id: <20230509235507.3424068-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code was stopping at first time it detected an unknown TLV type when
it could continue:

> HCI Event: Vendor (0xff) plen 82
        Vendor Prefix (0x8780)
      Intel Extended Telemetry (0x03)
        Extended event type (0x01): Audio Link Quality Report Type (0x05)
        Unknown extended subevent 0x81
        01 01 05 81 04 88 13 00 00 82 10 6a e6 6c 00 00  ...........j.l..
        00 00 00 4b 45 53 00 00 00 00 00 83 04 00 00 00  ...KES..........
        00 84 04 01 03 07 19 85 04 3f 08 00 00 86 08 00  .........?......
        00 00 00 00 00 00 00 87 04 00 00 00 00 88 04 00  ................
        00 00 00 89 04 00 00 00 00 8a 04 b9 49 0c 00     ............I..

So this changes it to:

> HCI Event: Vendor (0xff) plen 82
        Vendor Prefix (0x8780)
      Intel Extended Telemetry (0x03)
        Extended event type (0x01): Audio Link Quality Report Type (0x05)
        Unknown extended subevent 0x81
        88 13 00 00                                      ....
        Unknown extended subevent 0x82
        04 97 6c 00 00 00 00 00 68 44 53 00 00 00 00 00  ..l.....hDS.....
        Unknown extended subevent 0x83
        00 00 00 00                                      ....
        Unknown extended subevent 0x84
        01 03 07 19                                      ....
        Unknown extended subevent 0x85
        3a 08 00 00                                      :...
        Unknown extended subevent 0x86
        00 00 00 00 00 00 00 00                          ........
        Unknown extended subevent 0x87
        00 00 00 00                                      ....
        Unknown extended subevent 0x88
        00 00 00 00                                      ....
        Unknown extended subevent 0x89
        00 00 00 00                                      ....
        Unknown extended subevent 0x8a
        9f 1a 2f 00                                      ../.
---
 monitor/intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/intel.c b/monitor/intel.c
index f5e9f5932cf4..416f52503ebf 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -1606,7 +1606,8 @@ static const struct intel_tlv *process_ext_subevent(const struct intel_tlv *tlv,
 		print_text(COLOR_UNKNOWN_EXT_EVENT,
 				"Unknown extended subevent 0x%2.2x",
 				tlv->subevent_id);
-		return NULL;
+		packet_hexdump(tlv->value, tlv->length);
+		return next_tlv;
 	}
 
 	if (tlv->length != subevent->length) {
-- 
2.40.0

