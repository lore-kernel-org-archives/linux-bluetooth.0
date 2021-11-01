Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FD1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 22:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D182060E52
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 22:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhKAWaE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 18:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhKAWaC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 18:30:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C118C061714
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 15:27:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u11so677539plf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BezZN7HhKcq0XblW0N65xaduHE0GNakfYPCwNuOqclI=;
        b=kqQhDyUavZz6hvNtcescsRz+lhDTi6eGWGQDDSNdETvLd33mBjDzHNzibdOzadaokw
         jMxk2EN3lvX/WcnS6HERmIN7gyxlaLytSw6cnV3D+7YdshlqIWYK1tOuj9dleUIDxfKL
         RRlZJqZmbH95n80ww2EI8rQSsRRHJdTMRehkaZpkUaonsI7S6PTcKAXd2C6IoHQjlSPv
         n5VyGhu8qOb1hsoRbsrlRDgtX4RvO0JKZ4E1IX4XVdKsLovb7MPJj9Iq2eL915AMWGIC
         JonEFDYcjAALB3kCp9Iu8gj/eYdvYGGNA9TPi0iyYWVjzRAhhZuBGiHnYHpOIQBbKQPu
         ewgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BezZN7HhKcq0XblW0N65xaduHE0GNakfYPCwNuOqclI=;
        b=4zY17S3gekCPaC7SWq0ClIpus7DUQ07pxOZVR4uxb0I/YDhWdBSHnT0p15G/kCL7KW
         YVEp3mAbvjeLpdcDsA/9N+IbAgicRCQhsjOg+nwOR5iD47vyvH/ccOxULlZ60poRPnAO
         zNEieBTOvoGozDRz+6QDafrqaY540+ka3qvLtuu34vqbbtn0SHtiT3gFs2PEjthC+L05
         QG7j357BYPeC0T4jobDAQxtgm/w5MZ5nUZ+Agpwva9PJbQHiWG+X7CZO+z+qnBFv+AZv
         sLZBHuwy3jykMkaykefpi6xYYNll/RHRpcWF7q1LTMKK00eSCpjrHkInivw3qfcIQlyV
         RZcg==
X-Gm-Message-State: AOAM533rHoOq+1taqmCw4xQT6rHicKANHDXWFd6cz+9aN2kSKvlvYqnp
        r2kJDxYPjuDD1g7wnbxJhIyHK2yP+IY=
X-Google-Smtp-Source: ABdhPJw8xps+1ciTR8EuV17iotfeHOTNWWzLxjnxFImJCjn7XIVHyz3gx79CPI/rAvwvozzFn8VOHQ==
X-Received: by 2002:a17:90b:3908:: with SMTP id ob8mr2031679pjb.78.1635805646454;
        Mon, 01 Nov 2021 15:27:26 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x20sm387915pjp.48.2021.11.01.15.27.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 15:27:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] advertising-api: Clarify Duration property
Date:   Mon,  1 Nov 2021 15:27:24 -0700
Message-Id: <20211101222725.2766736-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Duration property refers to the rotation duration not the actual
lifetime of the advertising which is controlled by the Timeout property.
---
 doc/advertising-api.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 6c0e52358..c6ee93450 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -120,9 +120,9 @@ Properties	string Type
 
 		uint16_t Duration
 
-			Duration of the advertisement in seconds. If there are
-			other applications advertising no duration is set the
-			default is 2 seconds.
+			Rotation duration of the advertisement in seconds. If
+			there are other applications advertising no duration is
+			set the default is 2 seconds.
 
 		uint16_t Timeout
 
-- 
2.31.1

