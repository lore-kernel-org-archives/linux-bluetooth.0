Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19CFC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 17:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 920B16113D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 17:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbhDBRBf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Apr 2021 13:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBRBe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Apr 2021 13:01:34 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB29C0613E6
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Apr 2021 10:01:33 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id a16so5216959qtw.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Apr 2021 10:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tmfXuVeVaBLzI87pU+VEYf2H5GxRg5O32Na5XY27BcY=;
        b=ploELpDCq62b8flUFAIekP1dWFJXaXpqGuE9HTYF451aaQfKfv3/5XNfneCF9cv/Cn
         v+gLodEU8z8conuiX2719+E2+ksti9rl+ogrFTMRfyEIsamjj8G9N29zKwDOOESwSIPM
         BCLG99eJyRWLuS22wU2mENy6oNxFAo/ZQMl+Ia6KAmyUrJOPOIMakW9yg+LoCXoBImUo
         fz1Lz7xeBRgWQy2QkWmthn68SCn6z0AUt5OLNmjfljDXczWiGAH/aFkB1YgVpyCZpOX5
         gFiricWgjtDolXAEXPbMm4pWsoDTtemK2VfdPphzkfJpUKJy0B4mAr+6HDSyEu2ym2D1
         1O5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tmfXuVeVaBLzI87pU+VEYf2H5GxRg5O32Na5XY27BcY=;
        b=cuvowtnrlQZutmkBNcgBc8o4qw0qnjSmjkeLDh4vOqpEig3FJdu4vfeZroW3+iXdv7
         BW5laccgFOrvzxrFblWvFjAB6EIbbqpFiQfqL05O5xQOmkUPB0/tTfj6ZZtl70WYrKcD
         CISmNiZfK3LarZcJkMYxRe/jCp25uPzuaxbmGODs3aX6PGqZCa0fMOcC4KZg3MR3UhYg
         cAYhqhIZFMVM43wqUpJkFoD0/SduWOyiaYBJvBliTNnHVMOk0S0P+UggQbXQPgtsRbbh
         uSXGU5RsAU1RHmCBnFp5Ulu7QXmYitgSmus/zk70UVqtRgKQnxk8Dy7sZWhJwifnOJFi
         x+Ew==
X-Gm-Message-State: AOAM533by85CHFKYybC9jDVBdSZdKWi6X2pSRqbcWaaZlAbeSwIHuHqC
        P4rVHLa8H1mlQZunJq1GOSrLdsAA4nbHTpXMpmYLxpTo837B+QoOQz1GUyrRPP0sdybXPfObXKE
        Rzdr+hy44rt9u7i0S7+SYxGnMQZKixXgwTZJyB9ZKwdzpzOsZsf1jtdp4/dvVnfW/tTEhB57IzR
        zg
X-Google-Smtp-Source: ABdhPJwlsHpJPN2NHCqhApoeT9n9hWdD0Xic9b9oYO0rxbKVZnsMuJHUf2/CHl95C196XrhKNTZNh2jL5cZH
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:a4ba:ce38:21e0:52a5])
 (user=yudiliu job=sendgmr) by 2002:a0c:e84d:: with SMTP id
 l13mr13709021qvo.28.1617382892526; Fri, 02 Apr 2021 10:01:32 -0700 (PDT)
Date:   Fri,  2 Apr 2021 10:01:28 -0700
Message-Id: <20210402100124.RFC.v4.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [RFC PATCH v4] doc/mgmt-api - Return connection direction in Device
 Connected Event
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org
Cc:     Yu Liu <yudiliu@google.com>, Miao-chen Chou <mcchou@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When an MGMT_EV_DEVICE_CONNECTED event is reported back to the user
space we will set the flags to tell if the established connection is
outbound or not. This is useful for the user space to log better metrics
and error messages.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v4:
- Removed Signed-off by line

Changes in v3:
- Reserve it in Device Found event

Changes in v2:
- Use next free bit

Changes in v1:
- Initial change

 doc/mgmt-api.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index cab1fffc5..5355fedb0 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -4088,6 +4088,7 @@ Device Connected Event
 		0	Reserved (not in use)
 		1	Legacy Pairing
 		2	Reserved (not in use)
+		3	Initiated Connection
 
 
 Device Disconnected Event
@@ -4261,6 +4262,7 @@ Device Found Event
 		0	Confirm name
 		1	Legacy Pairing
 		2	Not Connectable
+		3	Reserved (not in use)
 
 	For the RSSI field a value of 127 indicates that the RSSI is
 	not available. That can happen with Bluetooth 1.1 and earlier
-- 
2.31.0.208.g409f899ff0-goog

