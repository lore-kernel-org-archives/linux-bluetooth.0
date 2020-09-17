Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638C5C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 08:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9BD20872
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 08:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qXt5f0VO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIQIrj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgIQIri (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 04:47:38 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B01DC061351
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 01:47:37 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id a14so1129810qtp.15
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 01:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UhuK6+MhkgaxqFHbZntBmCr9unC/T/VqbfwHczdbfRY=;
        b=qXt5f0VOk1NuPgsYlWvkIK0xsQnwgp2Ib9s9qNNRYd2jjziI2ZkbqiZEZBy98FogDJ
         VkQH+qcfsU34O/22zMmtsfltxbnOCDtMgwsX5Lc/8k2R7cjQi1onQqjZ851o8nTg/Dv8
         oZeMwO8/vKRK61+eC+t0c1rnhq1va2f3hQ2nYCo+jNWzFQ8GtCX7sZLpwf5M7C8vhWZA
         pqk86IdYJNlRUkB6lyzfodAMn0NZvW7zupX/Q2VOt2ig2Jxt5lVTT9aUjoEfUj49um6v
         Zbl2j7AfHKhKAPRyRigq2h7vqLeyDTWtGAJwyewpwVbDjlj8KD16Dh7BRY9T3yxWXmd9
         uLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UhuK6+MhkgaxqFHbZntBmCr9unC/T/VqbfwHczdbfRY=;
        b=WqgZqH79BXzJZe0y2J6p092I0e3qspT1VbNA8Wc59uKaD8LyPB+vIFwIHQnya45DnF
         0heI46P+fEAW0oVGruia23vJlFGcnAdYQCckT5qJ8YWKuLidKc6F0y2Onon7psi6x4cx
         ezqf3/rgnwTZpBBrvjbVg63ZMroOCSOanbjhhfpV7jSmpslzfvhp3/BTEBSokoP5yUUD
         QLIlVDeAUujvuVeXX0eU0+t8+RZVxcXqKWtiuLV9FV9gZHFODo/qK84iZrH0DoEBNI14
         JkhdXy+0gzN+TnVJDzOxRA0PgML7cDFTHeI7SShhin34K4FkezR3bFwovBJbvDWDxSxW
         TkPw==
X-Gm-Message-State: AOAM532fjYyHqNrtRNHrpmCLI+3lbrzq631jGRMERBKpknTvQWbIOeXN
        EYP1cBp1lOkNiwfRENQnEuqKJCvIaT3mFexVNogUWUXUp/NGwegEFpMrOP47DuKwjYrPInKLFKp
        d/ad8E8GawW6CdUA1UiS8YpkjfDi0USBvUuaWy6pQVa82P9zumB9qrFOMXRd1AHD+MiJNJYnSez
        AYcnMw80xO7A0=
X-Google-Smtp-Source: ABdhPJzmrOX6EdMHFDJQGtaf1jHPst8t8hO4cIyNRCqT0Rc+SxpDoI51AMdKKtlEiFVuWa5OuFK9wrM0HWg3g2dx/g==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:58e3:: with SMTP id
 di3mr11174814qvb.54.1600332456529; Thu, 17 Sep 2020 01:47:36 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:47:14 +0800
In-Reply-To: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200917164632.BlueZ.v2.5.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v2 5/6] Bluetooth: Handle active scan case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, mmandlik@chromium.org,
        mcchou@chromium.org, howardchung@google.com, alainm@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds code to handle the active scan during interleave
scan. The interleave scan will be canceled when users start active scan,
and it will be restarted after active scan stopped.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v1)

 net/bluetooth/hci_request.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d9082019b6386..1fcf6736811e4 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -3085,8 +3085,10 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	 * running. Thus, we should temporarily stop it in order to set the
 	 * discovery scanning parameters.
 	 */
-	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 		hci_req_add_le_scan_disable(req, false);
+		cancel_interleave_scan(hdev);
+	}
 
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
-- 
2.28.0.618.gf4bc123cb7-goog

