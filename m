Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5BBC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1802078D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qzvr/acg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHZUL7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHZUL6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 16:11:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF1CC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:11:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p138so4294840yba.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=5f/lN0/70bYXYJZSh5TJQuXrKMG7Gi5D2DcObKSQfRQ=;
        b=qzvr/acgzGXq4XXO3xIy8JzkmTbtIVpkmg18jniacjglkZOwEowJB5WHQx0h572jJL
         xAvBM+343LMsPZ+WhBt+xd6zDgDeGTfl1VRnW3cgLpf+AA1wzUT32CD4R9RBUu1ENK/i
         AOrVzpVehNQuy5jIAriVFMid/bzMsDEbBpVm4vbM3Ynneswhmip1CUk388WJVkkzLaSc
         VUpT2zlNjPOlg39b6SrhirHEilmZQpKIaW1GVfUDpKYqSKn2LIu28dlgZJI0OvDb/pT9
         K4qXwZmMJpSPmEmDA6Zl5GqT2LC4KZXfwrhkAhbqdozjftElEbrg0yRhH75SRk95J0r5
         i/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=5f/lN0/70bYXYJZSh5TJQuXrKMG7Gi5D2DcObKSQfRQ=;
        b=nZz1lw+64nPAyyDqTaILzUNAXG1IkftrW/cHICyzRGB4SbZ6wo5ryHFuC3BhbxqoOM
         W1xpu7wVOvO6VNFyapzaI4M3efCYmawtQ3tXi1w1/TvLfc//podxLsbgIIQ214IG6kn/
         eRlkOiTBpISwqUljzccUQUBDAshmtvFquQ/vlEtQyLJlQzefmMLRjawqGGd1HuOR3bZH
         Dj24cbv1ksqqasGzHTCpIInuk9cZ8jnLeMhkXMXV6QrMQasZRSr6bM+dYr/PxTQ963Wi
         cgHKjUUY5bOqp4Hu8PKvcaOFDFivzMlRYzU0bH01jfD0vjpZ1v2D6IuWa5t5Mbfjxme8
         lIlA==
X-Gm-Message-State: AOAM532hjew0i0iwayolBWVKwSq5v9aUy0132euRYS0tnqpgOmnJXf55
        pGCjWGbZKXo+P+jPDotnpINzbpZhy6vqUUOiZRPmS6D5cTTd9JWY7KNteXWGe6FLRoqjTT2beqN
        gJPk1Y/NJAsVGOMrYABl8PFlOIJupBkNEhbqCjbnsIMANumKEUji5XOd5AFikk/WL5Mnoto2seo
        MCSqd7XTaI4ctrTcwG
X-Google-Smtp-Source: ABdhPJwGuuu1mPYxTn77xWiXmzXF5OjbPRy6ojJ21ttBG0W7k9W/boOjKj5LE9e74xoDBcAD7nG5cH5pEgg1JJtlBl7I
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:6d86:: with SMTP id
 i128mr10244044ybc.61.1598472716974; Wed, 26 Aug 2020 13:11:56 -0700 (PDT)
Date:   Wed, 26 Aug 2020 13:11:44 -0700
Message-Id: <20200826201147.1908411-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [Bluez PATCH v1 0/3] Expose extended adv feature support via bluez API
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maintainers,

This change adds a SupportedFeatures member to the LEAdvertisingManager
interface, which allows us to expose support for hardware offloading and
setting TX power on advertisements.

Best,
Daniel


Daniel Winkler (3):
  PRE_UPSTREAM: advertising: Add SupportedFeatures to
    LEAdvertisingManager1
  PRE_UPSTREAM: advertising: Add adv SupportedFeatures to bluetoothctl
  PRE_UPSTREAM: advertising: Add adv SupportedFeatures to doc

 client/main.c           |  1 +
 doc/advertising-api.txt | 18 +++++++++++++
 lib/mgmt.h              |  2 ++
 src/advertising.c       | 56 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 75 insertions(+), 2 deletions(-)

-- 
2.28.0.297.g1956fa8f8d-goog

