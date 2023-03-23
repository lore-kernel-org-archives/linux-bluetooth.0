Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885E9C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjCWKbg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjCWKaf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:30:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C699322785
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:27:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o12so84251745edb.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2M8ZS5DPkk4FU2yyrryJViRll0PsOCpoJq9idZw+8k=;
        b=imxOblQRax6ZLDwSqD8m0eEsfv1gdywb1j5TUTYQLZIgNWMjONsDEUMzSK6lbXBnRJ
         AAhiUJxypCdpMdmYprgBvvuUY+jDnW1GaQWsibvtaqPoXrVuli/3Eq2O8WYH46P7nUfl
         uft5CrdsZC6Y5ZeeF+XlTV0hpBJBGaQDelQPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2M8ZS5DPkk4FU2yyrryJViRll0PsOCpoJq9idZw+8k=;
        b=hBqvgkp5PnkYYaADrZov628N2xAw8RU6AesdxQ3ZkYIyrpIGa+rPbu2sIw1hvH3iYy
         Vu9Rqss6eFTyFic/T/Zj9DHVov6iISiTms+zaY6fFPiFMTN+ZVqoxHXpG1OnGjD/qs16
         zWMbj4qsMW8T+31PkCqWvvIQbAVizTHVtxxWdLO2U2mSQ5yjytlzUHxUk6jVHZhwDKu2
         5aAQjX2cqqD30GfHujBPbouu+xWKdZ5cmLq/VI03rsT2BtSNGg2RfrMeIoZe05XTG0am
         gozy5391e+b3jAlLEeMYRVQveOB/vrogQf9PqhCgwNCZKfLC/uTKWzFbMMKxR690uwHd
         VHxg==
X-Gm-Message-State: AO0yUKVddZrvfurupVmMUDL9fcoMvdClrvu4ifA3mkZLWhBca56a2yVI
        TKeX9GzK+D/fPyN/G5UsGa8WBNloym2rZs3/iM8=
X-Google-Smtp-Source: AK7set8DmZkjArYMAGIFMsY67TDlk1JsONDwqlsu4/ST5uw9mfmlxwn4DTeMuCo0bWRyPMsuI68w6A==
X-Received: by 2002:a17:906:3999:b0:933:3705:a9f0 with SMTP id h25-20020a170906399900b009333705a9f0mr10810374eje.19.1679567255178;
        Thu, 23 Mar 2023 03:27:35 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id u25-20020a50c2d9000000b004faf34064c8sm8880564edf.62.2023.03.23.03.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:27:34 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/2] l2test: Enable hex input for PSM
Date:   Thu, 23 Mar 2023 11:27:31 +0100
Message-Id: <20230323102732.566440-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323102732.566440-1-simon.mikuda@streamunlimited.com>
References: <20230323102732.566440-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/l2test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index 5aae4b687..595f1dab2 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -1416,7 +1416,10 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'P':
-			psm = atoi(optarg);
+			if (!strncasecmp(optarg, "0x", 2))
+				psm = strtoul(&optarg[2], NULL, 16);
+			else
+				psm = atoi(optarg);
 			break;
 
 		case 'I':
-- 
2.34.1

