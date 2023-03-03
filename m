Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9861BC6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 01:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCCB1s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 20:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCCB1r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 20:27:47 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78C276A5
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 17:27:45 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n6so1179288plf.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 17:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhvXbrbfD2QqHIchqkMG4mmNdrbycE8pNBVZPDJ9Syc=;
        b=kp6dGRlXAzl35+v2taIxeVjj15Yh3cVl4HktYg4IllHkkl03Y16Cm0KGqZsJ8b/d/E
         JdBo2AgeeTUTlsiWRj7VzmMmUfAk391Ul7yshN2sBcDd2s9g4PSkOc+aJ2i92eyWc41b
         yaLZGjHsOWD30zCW0VFDAhAUyUunqZYWlcxoAzpC+fc5vTIo8581q83Ab575W81v9T1Q
         HYd9m3jj8a7Zvuq+U130dtYfosnxeSoP1ZIwfAnGpO6YSq1STlhZyuekBm+85vK+4AnT
         x5Sf0N7Gymyavl90R0gE8FnW6er9e6A6rh6p8cXGH8y4DgROQF3L0Y1aJHFkKbxKQTZf
         /JHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhvXbrbfD2QqHIchqkMG4mmNdrbycE8pNBVZPDJ9Syc=;
        b=MdQW/4km/5ejNsXEARkka9AF9v3AGjIcg14fEhxXt9KNnijG1UZv6UCTiM+y7FSzvm
         4ItySE+vSLAghFP4icVI13S+oial4O0gwMvqkCdUEEIuflmNL6fs6RcTjC8JtlexHeng
         JLkLPPcqUw8CBgyDBgE/5Q9/52KUHnzMp6sR9gt31RIdwSITsQgRRAFPsl/pK9cG3o1G
         cfu6fHiGacsYrHfFphTXSsyVOrIzMn/Gjm12kxgZ2B9VA2h4s4PjhMmrDntH9vgQBRnX
         M0GtbRQgeEmpRnuaBo15hGjC+TWCSwxsODAWSzHWJ0qO9VQAUXVKO1ie9mLFPSwz9AIr
         MZHg==
X-Gm-Message-State: AO0yUKUTp/+vNJS8dvqL/u5TS3uvLpjHKsUYpYZ4N1rUr7ECztIQDzEq
        p+9S/4xrJX+D/HdBUjaUraEnsugpU4A=
X-Google-Smtp-Source: AK7set/Z+L/TNinsHXCnHV5SK4A4UgRa/VryTShSAMhRv3NXptq3HNBpdCF0yngrjwZobup5drB5WQ==
X-Received: by 2002:a17:903:1245:b0:19b:fed:2257 with SMTP id u5-20020a170903124500b0019b0fed2257mr317952plh.26.1677806864771;
        Thu, 02 Mar 2023 17:27:44 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id kd3-20020a17090313c300b0019a6d3851afsm284622plb.141.2023.03.02.17.27.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 17:27:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 2/9] shared/ad: Add RSI data type
Date:   Thu,  2 Mar 2023 17:27:35 -0800
Message-Id: <20230303012742.1386291-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303012742.1386291-1-luiz.dentz@gmail.com>
References: <20230303012742.1386291-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BT_AD_CSIP_RSI advertising data type.
---
 src/shared/ad.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/ad.h b/src/shared/ad.h
index feb712f508cf..b100a6796109 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -57,6 +57,7 @@
 #define BT_AD_MESH_PROV			0x29
 #define BT_AD_MESH_DATA			0x2a
 #define BT_AD_MESH_BEACON		0x2b
+#define BT_AD_CSIP_RSI			0x2e
 #define BT_AD_3D_INFO_DATA		0x3d
 #define BT_AD_MANUFACTURER_DATA		0xff
 
-- 
2.39.2

