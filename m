Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE075EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 15:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjFTPhh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 11:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjFTPhd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 11:37:33 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4A31A2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 08:37:32 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77e457319a6so64943339f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687275451; x=1689867451;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5JCylCCJ9EP83MC0q/uHhCipkb3wanpCldjqGNvnbz8=;
        b=RG3lxQCYdW33NaxxNpi4sP8U9LPxdZeBlok5kqe7tmaI/CZWSknkJ1YzWQAHjhG5hY
         fLvwlMz2gDu9oswcCjc1PRWfwtsA2m0WMXyjQnz2thSC90Y6UgNXWBCqMK49fvTt+d9Q
         sq60O9tB2+zNfxy/PkAyl7VMnI9vA8QoAd9RMdrRI6tRyXIobnrhQ7eVNmWzodAIc/Bo
         P0JYsvpLaYiB2svkKexwiw7A7EmhX4CT5KR6+8AyuG52Ezw58o/kdw1Kff7UWeFXInB9
         D9MTG5vtvK8XryxDWDqf/4HrRRYnwD8vYEcPVOePRjI7poPM8INLLeYuWdhPNF/RmFrr
         h8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275451; x=1689867451;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JCylCCJ9EP83MC0q/uHhCipkb3wanpCldjqGNvnbz8=;
        b=WOTLan09pQEfMPriyU34J0khdGKPNZPzE9KW6f4NYT0AIy8xfhqfx/WxfPET9xva/F
         J9oYc14qBOqNTOOT8cOU3YEZHItra/D6HlgerYtCyvVKAp567I+4Z87ygScrlZ2Ex8kE
         Zq1pa7GCXBN1ybztRuDtXeoKRDEhLQrKEtvPz9afAs6XbR/Bc2uXPtuYsMBNI73Fn/Ho
         zyYZF0n4bv2wN/FSYDW3/6DkxurQwQBKlEjoygywt/k1CAk/37IyAigit6kX5pHPETCH
         uVFqRMpCurzODtBBQpHWQm8wZEqZSU6+slxjg1++pBlBo7F3Wh7U+TqC8eGKr6RscFyb
         VCcQ==
X-Gm-Message-State: AC+VfDyWqSWqpeHKmafLtUyiCDnhJY//cC2CHrvaaiKq8I9BwAZhHIGN
        76MFy+W9FvtQcfLX+GJKLLS5BlZaVcY=
X-Google-Smtp-Source: ACHHUZ5H486i5C0bj0kbMSRsCkpj26gGG1WhnxAs0sTc/U4CflK+rrHULzJhbvfhtENuS7Bc7YMhog==
X-Received: by 2002:a5e:c012:0:b0:76c:6711:2e95 with SMTP id u18-20020a5ec012000000b0076c67112e95mr10107174iol.8.1687275451564;
        Tue, 20 Jun 2023 08:37:31 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.22.120])
        by smtp.gmail.com with ESMTPSA id e2-20020a02a782000000b0041f66bf91e6sm678801jaj.110.2023.06.20.08.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:37:31 -0700 (PDT)
Message-ID: <6491c7bb.020a0220.1b45a.1146@mx.google.com>
Date:   Tue, 20 Jun 2023 08:37:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8966791898793697870=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neil.armstrong@linaro.org
Subject: RE: bluetooth: qca: enable WCN7850 support
In-Reply-To: <20230620-topic-sm8550-upstream-bt-v1-1-4728564f8872@linaro.org>
References: <20230620-topic-sm8550-upstream-bt-v1-1-4728564f8872@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8966791898793697870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sm8550-qrd.dts:22
error: arch/arm64/boot/dts/qcom/sm8550-qrd.dts: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8966791898793697870==--
