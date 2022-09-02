Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748C5C38145
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Sep 2022 12:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiIBMAl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Sep 2022 08:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbiIBMAj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Sep 2022 08:00:39 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2FA32BAF
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 05:00:36 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id i77so1386524ioa.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Sep 2022 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=vXcjmPedjKxC+K4yzsczN/WeYOaKh1ODmXnyPZe6mYU=;
        b=SSxqFbp/Be5VGlx7rD1AX1UbmW9mf4Bos87cTP6jiSFZzcgy0/7EGFntUtKA+DW9SE
         gvkR3wk04fxj3Y3iBflJW1B8JHY2rWw4S0CJcVpSEZObkPZD4mS7Jt8zMFPcwkqvG2yg
         KUKuLPXv/SB9c/pTpQKSpigyKu8fda7mpMsDZBdMAY2K1pjD1i/04VK2QRonAUx0ySFr
         RTo+wDo/kRLe95vZtxmn43JE+Ack80BHsIwIgVvG42mW/lL0NsXl+cezzJXBTfX+xV5u
         MQ6XoDgrV9IHJ9JB0qYUxB2erA3AHOrl/4pZ0a0sPZpBKb64QOCtGT+lm77hYfAhm1Ax
         v6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=vXcjmPedjKxC+K4yzsczN/WeYOaKh1ODmXnyPZe6mYU=;
        b=klZARW7Tc0oXqobKvZ3yu9MrGuKJDod8qXlcGqFjl2Un2c33IjMkcM22aXmbOvRXqd
         QZPFpcB7srTnJLlyz/zLYS8fhWIRJr7KtHzgOrfdz2N4jm6/e/BNafKGVuoZpAo+GHkw
         /qbViq/MB/0rogoav3dJRiBe/XEdyYP7rPc+pSUodc3k4rxmvNZgNvXhphieMa9D6r+L
         cRt+cKihBcOsBAxx2Wco7Pj080pNvIuU1+xWuznSqte9TQKKd+4Gpt/raiIAYXQkHFmz
         Wg//vpL07HrFeaunKD2cn2xJmq+Qsl8sEISSxlbKzaaoCJxjJm9n2aglzXVx1guQH3x4
         hOYg==
X-Gm-Message-State: ACgBeo2UrJ29MJqIdkqpaxsUEog6h2NM0VoeR8v7Out+w5KVXpXdphHa
        +4yg6XxK63E4Mv6Jx1qWK9LM4pf/xGc=
X-Google-Smtp-Source: AA6agR7dKaoTHjMKgfia0BVzhfQAx/PQx98GX6BHOgU6voQQtF6plU6ueg7v4Rda4/JRSig9F5RtDQ==
X-Received: by 2002:a05:6638:3728:b0:346:a6ee:8673 with SMTP id k40-20020a056638372800b00346a6ee8673mr19526548jav.226.1662120035351;
        Fri, 02 Sep 2022 05:00:35 -0700 (PDT)
Received: from [172.17.0.2] ([13.89.40.122])
        by smtp.gmail.com with ESMTPSA id g7-20020a05663810e700b0034286654d38sm782818jae.82.2022.09.02.05.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 05:00:35 -0700 (PDT)
Message-ID: <6311f063.050a0220.67686.0d16@mx.google.com>
Date:   Fri, 02 Sep 2022 05:00:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2271445172743246931=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
Subject: RE: Bluetooth: use hdev->workqueue when queuing hdev->{cmd,ncmd}_timer works
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <733e6931-aa66-5295-d8a8-49063b7347f1@I-love.SAKURA.ne.jp>
References: <733e6931-aa66-5295-d8a8-49063b7347f1@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2271445172743246931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=673604

---Test result---

Test Summary:
CheckPatch                    FAIL      1.66 seconds
GitLint                       PASS      0.82 seconds
SubjectPrefix                 PASS      0.67 seconds
BuildKernel                   PASS      34.07 seconds
BuildKernel32                 PASS      30.21 seconds
Incremental Build with patchesPASS      44.33 seconds
TestRunner: Setup             PASS      512.05 seconds
TestRunner: l2cap-tester      PASS      16.75 seconds
TestRunner: iso-tester        PASS      15.58 seconds
TestRunner: bnep-tester       PASS      6.27 seconds
TestRunner: mgmt-tester       PASS      100.77 seconds
TestRunner: rfcomm-tester     PASS      9.46 seconds
TestRunner: sco-tester        PASS      9.39 seconds
TestRunner: smp-tester        PASS      9.49 seconds
TestRunner: userchan-tester   PASS      6.46 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.66 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: use hdev->workqueue when queuing hdev->{cmd,ncmd}_timer works\ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: unsaf ("ace/src' is owned by someone else)")'
#66: 
commit c8efcc2589464ac7 ("workqueue: allow chained queueing during
destruction") does not allow such operation.

ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: unsaf ("ace/src' is owned by someone else)")'
#69: 
The check introduced by commit 877afadad2dce8aa ("Bluetooth: When HCI work
queue is drained, only queue chained work") was incomplete.

total: 2 errors, 0 warnings, 0 checks, 51 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12964073.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2271445172743246931==--
