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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A73BC433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 21:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2C5619CD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 21:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhCWV4h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 17:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbhCWV4U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 17:56:20 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55266C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 14:56:20 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id p133so251816qka.17
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 14:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+Zxg5t2ZyoUUKFwFpZvi+k75qYQr9vChV+ESGln1WDA=;
        b=eKbVZq8+jcIuedy70v7bvfwOJVhmTVUczGIZ9NUfGU2WWVS+WZAmrDhPznHp/A916u
         Sh1mk1W3UQpKjRFwfgUenIVcMTKXkKBpFHxLkmP4srTSYrLrSu3sadIEAq0uSggid4It
         Dy2DlSRYYM0zL6aCIn3Xc5rcaNnZxtqWVtRmce6YcT8ahtmI1L0/m8xEow1+RjvLw+Fr
         J9V9C6RRZOldoKs4FSdDCyGU3kryjuFqQch7ijq6DknFM7PSY4fQi6ypdBj9xhG5tiOa
         G1D7FTzLHRbBATiilWn7DBUQvNCaPLORJ6bOnTFSi/WovQKRLk1HPaEz5GuuRhUDZHfp
         skBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+Zxg5t2ZyoUUKFwFpZvi+k75qYQr9vChV+ESGln1WDA=;
        b=q8YwHwJoi9pKTi+CaZRifMX1aC8hfOA30QuOBIi74orAIeCPnfArXi9oK1FQ1/52T1
         QcWo66bTCjqcJkaj1NbWg+BG1jNTp66A8yAexAHUnlTt8l2bN7leI2YPJr/9j+tkZd5a
         3ELA2p7Sa4P5cccX3RjT0CiSlc0TV3K+NvYwqGv0CicIfzCYKwLS1HfAlVP3rgnZA7Gk
         4h886lZkUO+svDf4IdoctHMEGsPQdMZ0tskNhwkpj6QqCfHKEPaBskLU4uVlL6qMbe9U
         pDxhGR2HRWKB2AEbNo6kq/RwJ9c4oyTRdtdnw/G84fwyqCsa753CrPi2eRkfqX4KR1Kf
         +Ekg==
X-Gm-Message-State: AOAM533hd8t02U0kUIMeXrjrSz4/PFHcFHSTu1rQtLD1z/7Ap+oermWp
        XeU7uumTjZGt47+qnxSxdkccQhP841B2yVBK+n/GVVb49H43MFNZDfL2suXrCO5l2Uf3k6ETGgg
        p8FrUwzBUDYSOLv9BJc8sJlTQ9UIR/R8KuxQ1UR3IQU/7G+Re0pm7rtCs6zHRstMVu3xMSluE49
        P+
X-Google-Smtp-Source: ABdhPJzChviw9Bl4XI28C5rSn11QFS8IQHk+fa5X4nIx19oDPqHV4l5y9PlhiavYFJ3hpsIq4whMNIioKL94
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:a916:b584:a08a:3fcd])
 (user=yudiliu job=sendgmr) by 2002:a0c:908d:: with SMTP id
 p13mr271722qvp.11.1616536579460; Tue, 23 Mar 2021 14:56:19 -0700 (PDT)
Date:   Tue, 23 Mar 2021 14:56:15 -0700
Message-Id: <20210323145555.RFC.v1.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [RFC PATCH v1] doc/mgmt-api - Return connection direction in Device
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

Changes in v1:
- Initial change

 doc/mgmt-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index cab1fffc5..534272045 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -4085,7 +4085,7 @@ Device Connected Event
 	start using its identity.
 
 	The following bits are defined for the Flags parameter:
-		0	Reserved (not in use)
+		0	Outbound Connection
 		1	Legacy Pairing
 		2	Reserved (not in use)
 
-- 
2.31.0.291.g576ba9dcdaf-goog

