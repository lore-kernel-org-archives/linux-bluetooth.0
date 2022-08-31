Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27119ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 19:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiHaTnD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 15:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiHaTnC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 15:43:02 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C7A95E6C
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 12:43:01 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id e28so11833481qts.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 12:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=/1pkgruBUkQnb/tulUkeKcLOiVoxGyBP1TSzNZqP7Gw=;
        b=BUWjNZIup1xGCeRzKbbQ/junlHLrfBsgtwYoecwryP9M5/0EgHvmwnsamjK3SWYbWg
         G9cyeOy47V6L8K2BRqi+r8HbEhJrrYFM/dvSSOuac+leXam9lizsX0PNjEw4sS3AXu2d
         e9QgGbBhFHFtFFizlln1Yev244Hc9jeISSwXVWWVv6Axo37W5Np00PBSASiPPy6J65hx
         61GV47WDWKkMF6Wmsp+oS53USOFjyOATgOxfuXzGDdPXTDwRcBrnHYIJ1drf8JPvV5u7
         uGd6aajvI7L14SMldX8cIiluQGrWsmtZzS2yL+Fi6Iqpytp2RLHlmpdj7CVrIdZD2/97
         fCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=/1pkgruBUkQnb/tulUkeKcLOiVoxGyBP1TSzNZqP7Gw=;
        b=iBTu30CbtP74b696wmM2S6cBzuLIpL5qObbYo6u2+Hffhg+6fxunAwKdgo0By/02+z
         daMJjdkl3JW9BdfWKB05Os5dk5qVnVlImEs5gzcfCr8ASngdbSZ8bhYZNtQv/71REepJ
         mNjaShSzoDi1g6NwPNVD5/gYMfiIY9rn1w0ma8GgfYXzq3/zRM4xW97hwNnaUPlV4G1S
         rlkiWT9HG1Yt22ptv8BsSAKtJBym+awFw9gU+scguuyAVRAh87pROtADkQ/ptpxMP85x
         aW0FiEh642JEvsAzNi9r22YrIdgrDqWKL57ZnyHTmieg7aGXCXx4ukmTl35ueDtceeQC
         B6Jg==
X-Gm-Message-State: ACgBeo03BE3o/foyKrBjWj4vKHm+zN3qZpvx8Y2bF6f/fhl6B0YPgE46
        lxADhNpjbMYHAN+lK522ZHHHEm1Fub0jXw==
X-Google-Smtp-Source: AA6agR6HXVOcI3rIztMEqsHmevGXVCl64X7YNUACPgYuR9TgjgyNxmu9YbVWvdnYgcFfWZpAmd4Fgw==
X-Received: by 2002:ac8:58c8:0:b0:344:87c2:c495 with SMTP id u8-20020ac858c8000000b0034487c2c495mr20492060qta.631.1661974979973;
        Wed, 31 Aug 2022 12:42:59 -0700 (PDT)
Received: from [172.17.0.2] ([40.117.34.159])
        by smtp.gmail.com with ESMTPSA id t2-20020a05622a148200b003434d3b5938sm9717374qtx.2.2022.08.31.12.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 12:42:59 -0700 (PDT)
Message-ID: <630fb9c3.050a0220.79b59.e778@mx.google.com>
Date:   Wed, 31 Aug 2022 12:42:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3461317534563190060=="
MIME-Version: 1.0
Subject: RE: plugins: Do not try to autopair with Nissan Connect devices
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, florian@ubports.com
In-Reply-To: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3461317534563190060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: plugins/autopair.c:66
error: plugins/autopair.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3461317534563190060==--
