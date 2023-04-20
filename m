Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DBAC77B72
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 18:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDTSPZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 14:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDTSPY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 14:15:24 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713C2269E
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 11:15:23 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3ef3298307eso4206741cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 11:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682014522; x=1684606522;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IgGv9GANoPWHuqQkogqhkjCBLD7xLjy4xel+zH3S93I=;
        b=rQCcLWeZx1fUgo0zfIcA4M5MlMRLeQoSrV5iYR1OF9igidqwKpIWhdZW6KJihcJt7l
         BQU1iwjbGUl3RehyX/itcrJBhX3y0bAXx0tSC4E/THA6rD0Sukmac69ZodW1CyMb7Iiy
         tTsnVqQ2quKqkanouNlKZ7EgLVeQQ56VO2xHMlYZUGlH6YHKz4RVs6Hl4REW+EjU7+/+
         JTQPdwmG2FkbGsZo330LPvK51IQEf1is6ah4jud4GCvxwTp4cyD+6DpgJjA7+muL3hvV
         UvDnCOEbyQeYdRPQoi7FPEYZeHCUCWkBmBGPGDASsKSWrVwf6wVt6sD2KM0UOWcLrInC
         SLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682014522; x=1684606522;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgGv9GANoPWHuqQkogqhkjCBLD7xLjy4xel+zH3S93I=;
        b=iH6xephWA/nbQ1bFC+W4TE+3M79yWs56PDhZHTz5QJtX0VsgPo+B3bd51zqS0G076v
         jMnrg5gAzMlj6jB4RMhyGo/5tfZFOIsiRRGgVNVaQHouis5SeLQ26qAqNo3D3NtM2dqp
         xz8Zrz+c/OtRSztL9R7ElLQXT2OwLgmkLZ/p19kVUKa/lj7csqev0eqw69/Eo99qFygU
         w6ZPFlU9+t+PZyriyKtPQJ1NzajlL6FZ0466CdWuwyqYi1TOTILFRowmbZuccKQhZM//
         JAoeRBrtoYHSk9ey/Q6/foj9r91HmKiGqZtUroCdKZYM1hl0rUFopZ2EGXQSpXM3idfr
         TgGQ==
X-Gm-Message-State: AAQBX9fT9RLAITdwmVaezVglrdaTUtIZM8iNYv8iCemd5OH0bolBM+Up
        x+5GQJdKfknMxmLvpcyxq4Ux5GpWigc=
X-Google-Smtp-Source: AKy350a7cJ8I8HnBGt9ITRMI7knYWUbDHpYOYi6zyazcBt4eAxOlPfyoRkMVAfP+SfXIbbSRA9jdGQ==
X-Received: by 2002:ac8:5f89:0:b0:3e4:e4c7:586a with SMTP id j9-20020ac85f89000000b003e4e4c7586amr3661521qta.4.1682014522495;
        Thu, 20 Apr 2023 11:15:22 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.74.40])
        by smtp.gmail.com with ESMTPSA id r2-20020a05622a034200b003ef42f84532sm665835qtw.49.2023.04.20.11.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 11:15:22 -0700 (PDT)
Message-ID: <6441813a.050a0220.a7153.38c8@mx.google.com>
Date:   Thu, 20 Apr 2023 11:15:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5595822601241306874=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
Subject: RE: [Bug,60824,regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle unusable
In-Reply-To: <bug-60824-62941-SqdUgpH0Xp@https.bugzilla.kernel.org/>
References: <bug-60824-62941-SqdUgpH0Xp@https.bugzilla.kernel.org/>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5595822601241306874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sync.c:3605
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5595822601241306874==--
