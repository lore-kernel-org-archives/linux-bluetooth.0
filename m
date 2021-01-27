Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A4EC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0348B20771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbhA0LGn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 06:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbhA0LEc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 06:04:32 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EA2C061756
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 03:03:52 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id a7so1235972qkb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 03:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=URiwdmGOqpgVVqXu7rP3uLwP+oCfyiNhQuLiCSMCPGE=;
        b=S7Ztjm3rliWQtLN0Fz9Dnpv1hf0eVXUPXFTq6WmhAa18BgvuTCNJjZaUmq1MhaL58p
         urtFvE0hLZX5awZJ7H5DpQxesbwtNOeW+xMHV22tuLeNRazJTOf94XV2KrflJg2lwmw6
         EkEQYVQ0Whv1cu+DLuiFnb1AQ4Bef5vNA0lRdwV5xmeefXrXI2Ov0+4GSpSlVWk3cK60
         vuNox90P4h32Har5rgwLqzyP4CksHwfmnPhd//VmkUSTx9l8IM1ERn+Ye9uGkOztqwoH
         Ffh5CMR8Q03c1W6L164Q5JmA6rRYeLe8/vZXoxbkk5Rws4OWzPJlWxmQDkMU7y01wPOw
         iIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=URiwdmGOqpgVVqXu7rP3uLwP+oCfyiNhQuLiCSMCPGE=;
        b=fMv88SktX6U8Pv7085o5e7G5Y5pGlraW4CnUM9NNgoEVYEzHWuselg31LcgfqUq/Kx
         9u4X6oixioYsBHZW/aQb01is1j2PM4iFnMA3ggHl8q4/L1sG/jpfK5CKmG1ySwZVSuMe
         ierF+BuxDPyLVJ4eziEqZ8tx4ncc249l7lIOaRTl3ifMYI7GAxa4yq2lexcognzSliIA
         ocSnP3Q71otqWIsZiGQ3O+6E9Yr0zmGcZnZJi5R7Y1w4yJLB/hUvs6bZ4x8bq7g4LfKo
         1LmyI9DHBkNTrTfBBYRvdqeoD4/4YQPwXAegDlo1bhkmwW50cFYQPEbagdSdqq1K9Rxz
         Anlg==
X-Gm-Message-State: AOAM531906rc3uCW0p7Mx0PA3AcHvEMq3VseT9EPHgtbXhrk6sB0u+yA
        kd/Dr9akA+jyMY97X1QvQf3FHyQhoE89ug==
X-Google-Smtp-Source: ABdhPJyVJyTxPZQWnropsjdq8f1loTkJdsaHs1iruC3/n8dWZPhLuHN0IB5roUL5ZOzIgHGyaxa43w==
X-Received: by 2002:ae9:e805:: with SMTP id a5mr10053949qkg.485.1611745431609;
        Wed, 27 Jan 2021 03:03:51 -0800 (PST)
Received: from [172.17.0.2] ([52.179.186.48])
        by smtp.gmail.com with ESMTPSA id u65sm924040qkb.58.2021.01.27.03.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:03:51 -0800 (PST)
Message-ID: <60114897.1c69fb81.65309.5785@mx.google.com>
Date:   Wed, 27 Jan 2021 03:03:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8121364554431799232=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3] tools/bluemoon: Display FW version of firmware file
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <0abc1bb90aa6426c6030c06e8a95beff5e521707.camel@gmail.com>
References: <0abc1bb90aa6426c6030c06e8a95beff5e521707.camel@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8121364554431799232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=422803

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============8121364554431799232==--
