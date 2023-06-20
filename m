Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627CCEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 20:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjFTUlB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFTUk7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 16:40:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7CB10F8
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 13:40:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6685421cdb3so2280346b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687293656; x=1689885656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfJlV4uFVV27FiltVJHpRvmY01BObC3HVfVeREeN2Pw=;
        b=kuPgWFW15eoSryhqzJz7NNliC7G7+vJhU6e7eT1V5YFXlZSNmRF5amkvO0Pz0CnXyb
         zNEEzMwgGm1Gz6zAbuhvt0fTIaN54Zq0vBSWz48e1GPFZ9xISA8Bw8C59nNEwXRwgIae
         hBsohsU9Lqi3IM1OaftTZDPGDHmneUfxsL9lE8JhzKr5vNFqlaMjJjV+8Erqyh/ynV7B
         KU5AqR3RvzwpIFRFQUoQjA1Kd+8IesivF7PhGMjfVs2WhyJXhWOE4nSns2f6Iyst22wW
         PJP6vz/Ror1Q7LUcYMf6UuZz9J/KFiTOTc2DRofeQxYLN58Hp1Qt/OJGlzK9pu1ZjfuM
         tjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687293656; x=1689885656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfJlV4uFVV27FiltVJHpRvmY01BObC3HVfVeREeN2Pw=;
        b=by5mXnqvB2xMAxprfdWoPBB+U/+RH0nx1UaDPBT1Qb7sIxsVMD3AYci0o485wQB0sr
         YTSBhvaiXYjmSjwkZjWTNJ+y96rGQWkplXOrqg5e5AeaePZf0Rwi8eNx3fdx5FaWze+l
         hEiK/1j94bkyra3JtGN4CXh89lbyydI66zMTZmSfxfUWDDWw/XFeKdsiT4tBeWgOHT+Q
         FqGMhf22pjWf55f9dbpr71a7jVKXtZCKGBwHBMhlSAVkNSIVn49QILa0ZJe2N1Qf7b4f
         2Oxo1XPf4yeFKQiSs6HjR73PGEHJ2gge+hA3aWbY7fbBlHNU5lqjd5cgVrt+dweT1yZh
         it1A==
X-Gm-Message-State: AC+VfDyXrnq0d9BYrMdF/g9c627NdNHc+q1v/6/xfYr5TFEi3GdiRE8J
        aMkteLkkOTDzIMZ4aMOyi9nwOM+QXHKfCg==
X-Google-Smtp-Source: ACHHUZ7jayvG8CAIV1dYoLJkTGA9qcU+XIG0wRu/Byyx4RjRde1u49Tfj9MXdVTBffnq4LG5oK/L5Q==
X-Received: by 2002:a05:6a20:430c:b0:117:3c00:77ea with SMTP id h12-20020a056a20430c00b001173c0077eamr18829359pzk.0.1687293655934;
        Tue, 20 Jun 2023 13:40:55 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id x21-20020aa79195000000b0063a04905379sm1691596pfa.137.2023.06.20.13.40.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:40:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] mgmt-api: Update Device Found Event documentation
Date:   Tue, 20 Jun 2023 13:40:51 -0700
Message-Id: <20230620204053.643608-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This updates Device Found Event documentation to mention the new flag
introduced to track when the event is generated due a interleaved Scan
Response that couldn't be merged.
---
 doc/mgmt-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index c7191a028238..59e61d361dc2 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -4399,6 +4399,7 @@ Device Found Event
 		2	Not Connectable
 		3	Reserved (not in use)
 		4	Name Request Failed
+		5	Scan Response
 
 	For the RSSI field a value of 127 indicates that the RSSI is
 	not available. That can happen with Bluetooth 1.1 and earlier
-- 
2.40.1

