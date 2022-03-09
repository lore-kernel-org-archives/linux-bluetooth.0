Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F0BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Mar 2022 02:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiCICS0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Mar 2022 21:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiCICSZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Mar 2022 21:18:25 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CA53A185
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Mar 2022 18:17:08 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id b67so693145qkc.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Mar 2022 18:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/dWW74r7Lv85vIS5npZKgR8IxSzxeUvaREYzwTA7Zrs=;
        b=epTnuq29YtJ0PGsLf4wxzhEZjKawQ1gyAl/3x75qj/9gYVFOb1nDgjKO6FC3E8JKLs
         SNLZop50+XFZAOpTScFe7ZsIumcmshvDeSx8B9IT8fxsRzMC7OhzimIwm3TUJy1UsCS5
         0JDetZGSeBPUdiIdZourt/BkTyqYHc6H3Jot5dya0W6FP8OW/oudbCsZgzNsh3+3jNf2
         XA02KbLOImz2r8WjdKo6ocTc6QQJrtNiAQHgE/UQTm2XfsvdsLOgLLc8qfKo/HO+oPkj
         sT9EaMqIuYxxjqM0rvk6Gr4nV8Xx7PKrJdnuRhyNFxjJAVqDQ5WPjhEW1fFfahMRsWPw
         iAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/dWW74r7Lv85vIS5npZKgR8IxSzxeUvaREYzwTA7Zrs=;
        b=UKT1snv8wb3QkbxsArA5GxLhzzpgGKgtLlWfrOEaLt6QRBh8e976dmcPmcBTai8xbp
         ZFKtN17MiFVAinwBfC0Zsnx5v44/HmSLype/90DpGVqx/2Jg16UqyUtGtGXCuWwclx68
         +K403GcP83HETuP9hkQu32QnZaLNomgyC/3Z5wtaGnd8SQ+CQdoUc2yhKItfnA2BP8KZ
         3nqNuFd2UibwinmBBGZcu91qaHv6NXlKJL339xvH+lYMEMqRLuVG58d1j3yDIVhfWUV+
         nhB5f/LRI9m37t2BQCccDype9UEuzOD6BWig9RvsQ5Hesqh+u5F6pmk7/7G6q0/xpuOH
         gVzA==
X-Gm-Message-State: AOAM531QALq+nUwcNRlze8BJYlRw6OgeR/TMcYH6ZQWeJ8pvPF+28iHv
        Fy2ESlDpN3xxZWKkcCfjU+QlaWRDlro=
X-Google-Smtp-Source: ABdhPJze+uPyTGhLvI6Tzlv+DuPgOVjjQ2Bi4SAjvY9U1WxWl+e+Wg5tZq8OJuFcBjqM8FoOQJkMVQ==
X-Received: by 2002:a05:620a:c4b:b0:67b:148e:6a35 with SMTP id u11-20020a05620a0c4b00b0067b148e6a35mr9399213qki.281.1646792227896;
        Tue, 08 Mar 2022 18:17:07 -0800 (PST)
Received: from [172.17.0.2] ([20.97.164.255])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a10aa00b0067b117eba82sm340643qkk.124.2022.03.08.18.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 18:17:07 -0800 (PST)
Message-ID: <62280e23.1c69fb81.a862b.1ca5@mx.google.com>
Date:   Tue, 08 Mar 2022 18:17:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1545048504797323491=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [1/3] Bluetooth: btmtkuart: rely on BT_MTK module
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <f0167a9631fd0b392490311825ff0f826c054bc1.1646783737.git.objelf@gmail.com>
References: <f0167a9631fd0b392490311825ff0f826c054bc1.1646783737.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1545048504797323491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=621709

---Test result---

Test Summary:
CheckPatch                    PASS      5.30 seconds
GitLint                       PASS      3.01 seconds
SubjectPrefix                 PASS      2.69 seconds
BuildKernel                   PASS      30.30 seconds
BuildKernel32                 PASS      26.74 seconds
Incremental Build with patchesPASS      47.71 seconds
TestRunner: Setup             PASS      462.52 seconds
TestRunner: l2cap-tester      PASS      15.38 seconds
TestRunner: bnep-tester       PASS      6.03 seconds
TestRunner: mgmt-tester       PASS      98.68 seconds
TestRunner: rfcomm-tester     PASS      7.74 seconds
TestRunner: sco-tester        PASS      7.46 seconds
TestRunner: smp-tester        PASS      7.50 seconds
TestRunner: userchan-tester   PASS      6.29 seconds



---
Regards,
Linux Bluetooth


--===============1545048504797323491==--
