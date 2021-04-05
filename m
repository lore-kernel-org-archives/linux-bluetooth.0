Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F849C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 23:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17665613DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 23:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241795AbhDEXdh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Apr 2021 19:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbhDEXdg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Apr 2021 19:33:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0F7C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Apr 2021 16:33:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f75so18483826yba.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Apr 2021 16:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=to6Vxja+Arjc3jgF2y75CIMjsTw24v2WgNqXzBAN2G4=;
        b=jEYZqFK4qYXZjXqxm8kJnUCJ/HGf/4pQIRB3IfRcS9nSXWq37L5cg4Hi2cjXeoec+Y
         QnyrSCmtSZLs/Wo+mR1kcl0lYR1DdUH485SifgpfypYPOhxj9SOOkLl5fZZ4tsAIQ9Qf
         rDIgDY5ZuSYQt3oPjxqLelVRZdVuEfncudKq9I++0cqVs9dEy1LV5rCOV698B0jjw4J5
         CI39vHBdXuePVt9HTbWvUfu/6q6I4jfkGC/jm8Hx/STZPVNilKzwWk3DvjDaHzxLqAEX
         emx3YEzYVMaedIFqzd3/NrmWhZNUOa/AQb1U60F1GLzo9Bfpp6VOWQ8til8ccyzxFDBD
         woDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=to6Vxja+Arjc3jgF2y75CIMjsTw24v2WgNqXzBAN2G4=;
        b=PByaCQugq5r6Il2q4vvZTra61OMZjlNj1gkQtI1+c9otmIYCmvHEYsEUpFsVf1sHo/
         iAIgXMru3M0gHb43Zesgaxk8i/mot75+ntoB7IaDlxj9iN0P5BwFbEPKBNyTVRhg39Vx
         r8+Rfd1cHbZXEAcA7vJsLaw4c6qF6+MZCqXyyVMy9uexlU9UyenCVjaoEHruc//h1d0s
         lcpzwfzRnZWzDl7BeSf1UNsuL/ZJ+YohXswm5I0e8BOVKMfdPGRP8ZuYRU7n9y1Dk93X
         EkrbFuuHbsuPsQarEREbtg49kcnTbH3Vgg4k+L8PCQ5DWK4XwMTF21n+9peQE1su4WgZ
         6ntw==
X-Gm-Message-State: AOAM533Ed6d7/B5MkygbyFU3AUHOU9UeoZZD7O0Pe5eLGUW9Y+JOClDY
        BZyMND8ACyjwVG1nlnK6ocDbOCdyIomx7SLdAls4
X-Google-Smtp-Source: ABdhPJxACUkz/6Pr+kJuu/6e3/KOIdlQcw8bE7vaqlYhTWwjONXYmo90PEfWYGytXsD0uf87TrfxIxGk2snIXjvSmRN5
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:1cb3:ad22:2ed6:7c62])
 (user=danielwinkler job=sendgmr) by 2002:a5b:448:: with SMTP id
 s8mr37252543ybp.363.1617665608348; Mon, 05 Apr 2021 16:33:28 -0700 (PDT)
Date:   Mon,  5 Apr 2021 16:33:05 -0700
In-Reply-To: <20210405233305.92431-1-danielwinkler@google.com>
Message-Id: <20210405162905.2.Iaac4fb40841e46f9ab815bffee439c91e44f0639@changeid>
Mime-Version: 1.0
References: <20210405233305.92431-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH 2/2] Bluetooth: Do not set cur_adv_instance in adv param MGMT request
From:   Daniel Winkler <danielwinkler@google.com>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We set hdev->cur_adv_instance in the adv param MGMT request to allow the
callback to the hci param request to set the tx power to the correct
instance. Now that the callbacks use the advertising handle from the hci
request (as they should), this workaround is no longer necessary.

Furthermore, this change resolves a race condition that is more
prevalent when using the extended advertising MGMT calls - if
hdev->cur_adv_instance is set in the params request, then when the data
request is called, we believe our new instance is already active. This
treats it as an update and immediately schedules the instance with the
controller, which has a potential race with the software rotation adv
update. By not setting hdev->cur_adv_instance too early, the new
instance is queued as it should be, to be used when the rotation comes
around again.

This change is tested on harrison peak to confirm that it resolves the
race condition on registration, and that there is no regression in
single- and multi-advertising automated tests.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

 net/bluetooth/mgmt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 09e099c419f251..59f8016c486626 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7979,7 +7979,6 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	hdev->cur_adv_instance = cp->instance;
 	/* Submit request for advertising params if ext adv available */
 	if (ext_adv_capable(hdev)) {
 		hci_req_init(&req, hdev);
-- 
2.31.0.208.g409f899ff0-goog

