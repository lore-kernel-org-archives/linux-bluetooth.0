Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5147AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Mar 2021 13:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F49064EEC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Mar 2021 13:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241384AbhCCNOl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Mar 2021 08:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhCBX7a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Mar 2021 18:59:30 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51729C061756
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Mar 2021 15:58:39 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id g185so3005668qkf.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Mar 2021 15:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nAAho6zFDbFG0EV15ZZZwZ3wGrbi8Dft8jegCqjdDTk=;
        b=Qrwnpbk5SzU5PilMwyFCSibNr8GUASWTArDLJynpiWWKabnZX+AdRyPi456+EUVlH3
         6eZm/wd8ndeSOg+Qi5Or0E+GHjZojaQEF6/SRQko9rThxHFZLSqEuenKjUM4VJr2vRYw
         gF9/SrA+jmc9wH+5qmrenxvptmrpus+kXKW0+UyyCb1aPkLKS2MoBgki1o8vN/M4/Xw5
         SGTm90Jbd49NXv7+gWRJROHp86WlxxLjIlC368ouaOIVM4b1pYqU9kPFqURNLWvllgpZ
         ru0rkUiTQyyAPwkjpxSorNj2MG1ev6svOYn1840QZqIBiwp3qgxQXTyjg3rpS4QFikYq
         5+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nAAho6zFDbFG0EV15ZZZwZ3wGrbi8Dft8jegCqjdDTk=;
        b=CjH0o/TkEVcsyVTh0YBXiJ/4ZZ25BHlYV6p1DvdHUEaKZCVm0l5Wh0IJBSdRsKzUGQ
         r/JGJmcrJZgIu61D/sXZ52xhqz6T4+rMxUdFRgxcFMyys+QFkb2w9+r8V4O0cR6NbV5w
         qiv6uzgaIyVgnKN4fry80VmYIW3ja1XEXUxuqKaY5jqb/98BtaR2etE/Pf3qsFN4GD8A
         c/29x/zRCQFPy9JM3DS6xy1bB5oAGhXvHXVCcbXVHhZ8+6ECqXm9hQzGysxezPQuygdz
         QbEB3NJq7YleBsXqGfcn267D46Ju5XV71q3gx2qqsk7OEUbkqqsTGMnX1IKw4NmlI9Ki
         PyhA==
X-Gm-Message-State: AOAM532tu/AZpHsrCk1k1OKObdQZ9BH7GvhErINeApvJk7GpQ2+Rk1V9
        HWJZ7e1V4slILQsyE50wlul8XLLuoGY=
X-Google-Smtp-Source: ABdhPJxBLWI5T+K65q0butZZQ2vtrCVYij1TRKP+yyZotGTJfN3St9dcsdOaL4egHwaTOmb2Bqd2Aw==
X-Received: by 2002:a37:9f83:: with SMTP id i125mr20666461qke.36.1614729518194;
        Tue, 02 Mar 2021 15:58:38 -0800 (PST)
Received: from [172.17.0.2] ([20.190.241.247])
        by smtp.gmail.com with ESMTPSA id e20sm7752509qtc.61.2021.03.02.15.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 15:58:38 -0800 (PST)
Message-ID: <603ed12e.1c69fb81.b0c65.097d@mx.google.com>
Date:   Tue, 02 Mar 2021 15:58:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5845469636133737676=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez] core: fix a typo in dev_connect
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210302102506.Bluez.1.I4b5a2f5249af5dbb7234c6831943dbd8de7c271c@changeid>
References: <20210302102506.Bluez.1.I4b5a2f5249af5dbb7234c6831943dbd8de7c271c@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5845469636133737676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=440757

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


--===============5845469636133737676==--
