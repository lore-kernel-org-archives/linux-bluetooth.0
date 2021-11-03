Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B232C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 09:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C42611F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 09:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhKCJFr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Nov 2021 05:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbhKCJFp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Nov 2021 05:05:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53165C061205
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Nov 2021 02:03:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b126-20020a251b84000000b005bd8aca71a2so3206416ybb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Nov 2021 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1ba15R92iDLtdAosS9I3xgQG4qhaOlyBbyIkYWCKw8I=;
        b=LF8jocn0iekS/C3t/RX1cGOuwesZ4e8To2amBbMwtKK+r23hpXu6AEDfYDASEKa4iP
         9bqn+bBZ0bSrN7guhv3IJI9MRzAIguRm0KDDHqMMpzlK4oATvxXNcpy/spiNxk4ULZU2
         wHVtRAIyQ1cXPVtsUVHhum+Bs7vaUiWDicMSK5QIUo9zc+IzqsG5fOuVt3YuMdq3Es7W
         ZY2+jJAoK7E58EtckMUD1XBxtjqriEYddAaN+mqt7LcEpgrgYdLC2wQUZESQSql6WVL7
         gqzRwWNaiRIsktMOTPWtxJvrtM/7iPntfnxG9XIUsTPmGP/G/ejK9wY1utdOZHK/wn4n
         Hopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1ba15R92iDLtdAosS9I3xgQG4qhaOlyBbyIkYWCKw8I=;
        b=eAm9iPJMzCKpQVJp2xLyKla8qd5OJ/cvkv+xRHVHY5lozeF8TzNbTz62N+OiFVUj3x
         KAJVCkoGpou5VPNRfz32MKOCpvEBQeAnWaYdCt4HxF8oZ3ojViX33G3DmQ9vS76SPDOd
         dOuJREG6JV2b9n/RJCtCWJ79CKDy8toiRDC6ll0Z0rfCR4HsZYIO+k7522n5A2HXur8o
         fcbyrMmcFt7SoI+i5ml00+0pWWwXaQzDqyQIQvjl8eL7A1M72F9qY843EQCOarFYSAhS
         BRJixUvcB5QsIehZGlec3sRtOy/Kdp4ozS05xpfWZTOx76L/VtSpaTjx4P7blTDkNiN3
         6vpA==
X-Gm-Message-State: AOAM531n0lyQegxL7ldzgYsx8DkAmSMD/9chSbyyfjDL+FV56OeIQ1iK
        W33PG5RPOtkzXaAgR9kKg7OT2AbOGMUtIpjhtSVsDq1NJcr/JHHtzmlasDlAXBpn4I8J27DkXIF
        TBdnXNq4TmAsOtkkG16hLjeELdQD2MqTtgKx2N4UOi1TBL9roINl7Q7zEyJ6HnaxPHSQKLd6dy8
        ML
X-Google-Smtp-Source: ABdhPJwgIuRMrKckuisCSKiBQPxntjEDm8ekiRE3+ZcnlK3+BU6U1SOVrLZFCDsU5UdaGA9aFc7gSnlMSMJ9
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:7af7:a937:5810:b542])
 (user=apusaka job=sendgmr) by 2002:a25:a268:: with SMTP id
 b95mr44659568ybi.35.1635930188549; Wed, 03 Nov 2021 02:03:08 -0700 (PDT)
Date:   Wed,  3 Nov 2021 17:02:54 +0800
In-Reply-To: <20211103170206.Bluez.v2.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
Message-Id: <20211103170206.Bluez.v2.2.I1e75e215e52ece8017840d4df309c4ba4ac84510@changeid>
Mime-Version: 1.0
References: <20211103170206.Bluez.v2.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [Bluez PATCH v2 2/3] doc: Add PeripheralLongTermKey for storing LTK
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Update doc to reflect update in adapter.c.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

(no changes since v1)

 doc/settings-storage.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 1d96cd66d9..3c637c3521 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -314,9 +314,9 @@ Long term key) related to a remote device.
   Rand			Integer		Randomizer
 
 
-[SlaveLongTermKey] group contains:
+[PeripheralLongTermKey] group contains:
 
-  Same as the [LongTermKey] group, except for slave keys.
+  Same as the [LongTermKey] group, except for peripheral keys.
 
 
 [ConnectionParameters] group contains:
-- 
2.33.1.1089.g2158813163f-goog

