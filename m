Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF19C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 16:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243740AbiDAQaL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 12:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348478AbiDAQ16 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 12:27:58 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB64192A8
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 09:00:06 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t19so2525403qtc.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Apr 2022 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=AKXcF4teVwlDU5LgheGWUQHjwPclxbfbFlscmhjQvKo=;
        b=g3y11gE1LlpQsue7MDpndBttOXR+ybi1vxZX2LdQx4bvyopxd0nwmdrr+nU8YuUyJQ
         bluB+XRovMGmHGj9XylnHCEqA6+hFb11Q5MeQeae/NczhokRn05WcNly3lKcwre6vxTp
         ablozqMtFtXP+EVh2claAwW2fIU2LwQ9kYjYFQAJ+1S2b9vrKQNVqUI8yXeg2FAXHaJ7
         NaaGErJNYxPQIM/+mQpQAlCpmIHCVigX+je+274nxi6nd+Ns80DfPwgLmnGSX/PVRBQu
         nd8SiuQtiKobciSnDq3Eu5XvyFb/0SxCgdIFmM7HYk2CNgwXOd7gZcuqOaZ0C+EvTxzX
         v9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=AKXcF4teVwlDU5LgheGWUQHjwPclxbfbFlscmhjQvKo=;
        b=VXtNFmMcheMm8WUn0fpsAFnHxELBPSMUA0xIcz1RqzMV1M1TkWSX8+ihE140ELUo0C
         OFVr/2mMJ5S1BCd9TZSHDYfHP7PM8nHRw0ErlSmBJyPcbD2DQmqZxoA6xRd6VAIhycur
         ld4flu/ZQ6kSiz0oargGl1sFP0fU68cJU+ZJLkxPXEvyCkuhTeLZpRFJSaovOC+ZZlRc
         9jY1QH7IcqDQFD4Avo36whdOOauGcIWzdGNX1YxrW2Sb6mQLurXsTCLCLnXaSif0XxoK
         muD+7OTJciwURJwnXDxz3SEBjNVZknrCB18LhB1FPWrpIWMpAwXw65O8oTzHSMvvfQtP
         nL/g==
X-Gm-Message-State: AOAM530VrnHO71pUM2A8rSwPwTftoIVZnySoomNIWDcuK40VUHFEnBao
        ww9QANk5dFKLrySUpB0mlIGy2T30q0H7HA==
X-Google-Smtp-Source: ABdhPJxgza1VTSpX1NXA1/qe5GdNk4WnbuIGa1QocVCnlMSipcI5BS2ryhOdNQJK7YK8lJ+M7nMyfQ==
X-Received: by 2002:a05:622a:1c1:b0:2e1:b35c:2aa9 with SMTP id t1-20020a05622a01c100b002e1b35c2aa9mr9038147qtw.313.1648828804305;
        Fri, 01 Apr 2022 09:00:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.11.107])
        by smtp.gmail.com with ESMTPSA id b17-20020a05622a021100b002e1f86db385sm1962321qtx.68.2022.04.01.09.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 09:00:03 -0700 (PDT)
Message-ID: <62472183.1c69fb81.bfc3c.b910@mx.google.com>
Date:   Fri, 01 Apr 2022 09:00:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8746605423345953343=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, i.kamaletdinov@omp.ru
Subject: RE: Fix bugs found by SVACE static analisys tool
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220401121647.3985682-2-i.kamaletdinov@omp.ru>
References: <20220401121647.3985682-2-i.kamaletdinov@omp.ru>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8746605423345953343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=628188

---Test result---

Test Summary:
CheckPatch                    PASS      8.20 seconds
GitLint                       PASS      5.62 seconds
Prep - Setup ELL              PASS      39.64 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      7.87 seconds
Build - Make                  PASS      1330.57 seconds
Make Check                    PASS      11.64 seconds
Make Check w/Valgrind         PASS      404.30 seconds
Make Distcheck                PASS      209.94 seconds
Build w/ext ELL - Configure   PASS      7.88 seconds
Build w/ext ELL - Make        PASS      1278.53 seconds
Incremental Build with patchesPASS      8064.66 seconds



---
Regards,
Linux Bluetooth


--===============8746605423345953343==--
