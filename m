Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD05C43217
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 16:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiLAQJq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 11:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiLAQJp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 11:09:45 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC13EE06
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 08:09:44 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so1928040ioz.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 08:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M3A9U63C5zRNJMlSkn9yCQLFJ1yJtBALwxjjInLUcuQ=;
        b=Mfq2fdU0eUso6YyXZUIJe6fZ6dC06rUxvt7kGT+GlD+ZLiGC7uvIhw47SXLk1kWZWy
         sct1TODiu/DL9Z4eYYa0n2xEkLEPGgJ/eWVC9YFzSAMsbY4JT3B2EC+IJLEeL5m2k44X
         p62ILeC2MywNwEAM837I4CFyrOnlvY1V0IFxJVrOSOHjR3lnDKw3WH0TPkD+wKxpT3d/
         5ZXHOJs1DpkhVQ6jB2Lfz1OvKhgcAbRac1noS6OlLH0GTfodNOx3tys0wcYS0UWUGDUx
         s85k2kA3TEovWRV/r9GH1Egz0lIijWy/F7grMR/pF2l4tN+POWE9TIVcNVYPtrCvcTAM
         pjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M3A9U63C5zRNJMlSkn9yCQLFJ1yJtBALwxjjInLUcuQ=;
        b=GynM/4aRQSW6RzmAhxvHRaUM97b1Ez7VXHrUhBx1tRlUIJ0dOzRVH41VljuWKhghpS
         MXd8tUsy+0GtNdT9M8/Z8W44UXNB0uZ+jkgXekW5jDbod3s2ZxnSQXWhU9WkdAGZOTfd
         SR1JeB1owN8skVdFFcIsA4j+wEyWmlCMIK6pSiOUE8dQ0qEfUralZosvOvkXaBD0noVH
         bw1oEHVa/vztDMnIAp6ixk4yA5GM2Zattfu0YgPCY7y/ByJKScCD0qbAZ+2ifNOuTnub
         7M8g1wLPdVjO2gGszmN9Ze+jbcY4P1Lx9BDHzFb5h7LHpkxIeeX3a9dOqtWLC3yCDKuh
         1vRw==
X-Gm-Message-State: ANoB5pniMyxfi5iMJt2bwbYg/fpBZr+AUTUz5bKBoUIOH68YcLQmfFch
        XJziLvfR+Kx+BQUdQ+eZfWE+VGYZTlOM7Vmo85uxFvwKBwdvWgZSfCJwW/77lXxQIjXS7i/4/Zi
        oKnJZ0X7enaWH7RXoSg0JEKS5dKCEEbyRLZgqbpFX+rIdjV6HMmvv06685TpZqyFJZyDvCwdTuo
        DoWkcgkg==
X-Google-Smtp-Source: AA0mqf7z8kzh9mhfposTX2evHfbLOjPIRHwa6Brwv6GpQkUBxnDi69GT7MUx8PeSntu8fsoHVwKu/8ymizpzD6A=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:cb99:0:b0:389:e0af:54f7 with SMTP id
 u25-20020a02cb99000000b00389e0af54f7mr10135166jap.216.1669910984106; Thu, 01
 Dec 2022 08:09:44 -0800 (PST)
Date:   Thu,  1 Dec 2022 10:09:40 -0600
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221201160941.1065499-1-allenwebb@google.com>
Subject: [PATCH BlueZ 0/1] bluetooth.ver: Export sanitizer symbols.
From:   Allen Webb <allenwebb@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We landed a ChromeOS-specific patch to make it possible to run bluez
with sanitizers enabled, and I figured it might make sense to land it
upstream so it is easier for the community to find bugs.

The patch any LLVM sanitzer related symbols so linking against libbase
does not fail.

The ChromeOS patch landed here:
https://crrev.com/c/4060017
Note that on ChromeOS we don't yet use all the sanitizers so for this
patch I added the missing sanitizers.

Allen Webb (1):
  bluetooth.ver: Export sanitizer symbols.

 src/bluetooth.ver | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.38.1.584.g0f3c55d4c2-goog

