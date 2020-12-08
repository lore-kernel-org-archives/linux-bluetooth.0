Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB57BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 13:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E2323A53
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 13:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgLHNzN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 08:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgLHNzM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 08:55:12 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE1DC061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Dec 2020 05:54:26 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id 7so11949540qtp.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec 2020 05:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=gklq9BNqSi6x9am7/62V+7nL/IwS0V+jGDu6x3Dt83o=;
        b=QZ8mt609gND9yBeUncsCLXtPwsQGcq8/VJy0drAXhy/CWNlt/vrXezccQ/0VpaQXAD
         fqg2Crd/xfUbtPJjQ5FOwJY0kN4fkRiV5unf/kOVuEPZA/PpFFTGezCQ1iQZ0wuJncRV
         3HG6BxrmKmgnH3dRRGPhW0VO65pLiBwUmPWIF0VKsD2CG0oSzU47J7/Bn0b/MitgxKir
         T7uC1tNgeKWna8pCYsFwSOeWA9KSrNnq80oO2rxdCeOH+XloMECkE/ByKKOeJJdIlOrv
         q0yxco7e1jYXbUfKrQQ3PY8FYmEG6zOcvpMlkv5OPicg5m8EmUNs1IrWW1qxY7IrMpWZ
         7LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=gklq9BNqSi6x9am7/62V+7nL/IwS0V+jGDu6x3Dt83o=;
        b=EV0A0xhkK5W5Fxs2FcsPGlsOuxXxs5zqNQIY+SPLXhpLvuxOA7mNWS24IIHiEXfqGE
         tDoFEG6FjlwRXpbxTjLoSEYcQwaEONN1fmJRCQPxJRTc11BVtQYSnMMYoBWl2DMz5kk4
         ybfoa6CRykNJUcU+mS/hMg900IA/yQUz1GsNFLeS3lwQWwG5jKM04YazADnz4b98Q/VM
         VAUFMFzyAprO1Y56TCx/q01VtbPlSMxp4kZxS5bcOKzfp764E/r+BSdCsxEMmeQAoXyV
         LXb3PtrZmCyAIoIohTwnreEIB2w0l3sDwnd6E4nYg8tC3fXhyLmH6LzLEz3eD6V3yREH
         yoiQ==
X-Gm-Message-State: AOAM532/byKmZIebbB3t2sPBFNfpW/gCAJTUs/dBYlgG80Vk8UvXSxFD
        3SSS1jZJde0lxFj6Tbcp02DWEPBMYVXFBw==
X-Google-Smtp-Source: ABdhPJzYCExfvNphXo7UujoKn7KCD6YMZF/zWG7GYJQ6jzIL0BABik1moBcdkNSprcYDteSeNI+x3Q==
X-Received: by 2002:aed:3865:: with SMTP id j92mr29134693qte.318.1607435665686;
        Tue, 08 Dec 2020 05:54:25 -0800 (PST)
Received: from [172.17.0.2] ([40.79.248.89])
        by smtp.gmail.com with ESMTPSA id c7sm3015849qkm.99.2020.12.08.05.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 05:54:24 -0800 (PST)
Message-ID: <5fcf8590.1c69fb81.6a592.2b12@mx.google.com>
Date:   Tue, 08 Dec 2020 05:54:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5426501592712988690=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gubbaven@codeaurora.org
Subject: RE: [v4] Bluetooth: btqca: Add support to read FW build version for WCN3991 BTSoC
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1607428529-26629-1-git-send-email-gubbaven@codeaurora.org>
References: <1607428529-26629-1-git-send-email-gubbaven@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5426501592712988690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=398171

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============5426501592712988690==--
