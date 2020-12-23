Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CD7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 01:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A1A224BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 01:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgLWB0I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgLWB0H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 20:26:07 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D356C0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 17:25:27 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id bd6so6913587qvb.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 17:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8La0G01PE7fdhNttetHO6j51Pu6hO4cgpXreRnf/RXc=;
        b=JCf7DcllOBuIqKSC9DpC2TSkDvj21lRQMUHnA+a0CFFgt78Z1GM2QyxDnyoqx1nDzA
         ngWMdLeaVZQnRFubv7swrj+ZVIRW55dtuMB0VTk05a40TfZzYEpH/m2irTU4VknwLC7w
         4LRe+rhZttMMD9g3YuUK0LYA+QujnWYaYxmqdH8iqCG123fI70kxbICt3wMRT32zk3JM
         PGs4tfbclfPh6Ezr+6DrIi3nzemQS0tsJfZHsM+SGjjsWwrvGYGghvWSaR4zIRQGO80d
         K5YAbB9JTLyY3cJr3u3iwdpjtPVijuQ9W1SVQLHUOF/58Zgyzrxg3/D+DheU1JLLSJ0N
         XF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8La0G01PE7fdhNttetHO6j51Pu6hO4cgpXreRnf/RXc=;
        b=piO++QRwfDw3e2fkuWbCMISJL3lesDfUfn0iF8Rf09R7rHSpgMiyRdkF/LeBmSvgsV
         Aq62QiZAVdKZhPNyno77Y1hg2o9m7oEC0clqsenMM13drPI4BH/T2S+4tpPRvKCFBTW1
         y9pBHA9mQVrjwqV9exgha6ILO7OnVsqWUqR9ATEqwVLC8BdqorVRPhgfUUSHgafbFpEW
         WA7pBxXVq0ti+GRwaEY10f3j5IIxs4tvy7wZ8xkXu2gg7iHCs9c5iIO2yrPpNvnYS8Yq
         z3cSrQl+3bl4QXAZngeSqLmWOq3908IoWgN0oS+M6zcyhS8M376FYaARpUkjuBTqDUJ3
         3dSA==
X-Gm-Message-State: AOAM532QEB5OHaADTgFcuaKAAIgnxL2oFahs06rgft3MLbNKuIrWrQQ7
        WzXkWUemBGFqmiSPDkZOcKUREZbPoiyoDw==
X-Google-Smtp-Source: ABdhPJwItRO13Zmdg22GpHB7UcEv7z6Bu3Fpv9z0M7Je/7kUN/eL5EEOyARaa4Hfk95Lg0KOTXag+Q==
X-Received: by 2002:a05:6214:184a:: with SMTP id d10mr24741280qvy.41.1608686726188;
        Tue, 22 Dec 2020 17:25:26 -0800 (PST)
Received: from [172.17.0.2] ([20.186.46.92])
        by smtp.gmail.com with ESMTPSA id z40sm9169355qtz.81.2020.12.22.17.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:25:25 -0800 (PST)
Message-ID: <5fe29c85.1c69fb81.c9750.b446@mx.google.com>
Date:   Tue, 22 Dec 2020 17:25:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0960001453487779475=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [1/3] tools/mgmt-tester: Update sample data for adv features
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201223002633.187612-1-tedd.an@intel.com>
References: <20201223002633.187612-1-tedd.an@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0960001453487779475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=405549

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


--===============0960001453487779475==--
