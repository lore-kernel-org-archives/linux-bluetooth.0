Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04352C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jun 2022 12:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242174AbiFIMAJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jun 2022 08:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbiFIMAI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jun 2022 08:00:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9239768F93
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jun 2022 05:00:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 15so20912732pfy.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jun 2022 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=mSzg/aL6DJHGzbMb1VDeZyZ7ThCOQswJWikvgG0ii/s=;
        b=bAWH/QU1CPm2s8jwv+AKBKsyfGeR+EYCXInpEWdzHzkg5bIeXmIeuy6cGnPFDfEKJS
         DnrghV9j6csMS2P3jaWZrtXn3mIKrsvxegWIsg3//jXr/beL9A1Wwl2oxV9ydq4LX6Ra
         D0lQGlVtljQOylaUukI+e2f1Pdr/o9GGqyLu6wHmVFJW2xI5ctNbyef+iOgI3rDkoqQe
         ujMdmONP9Hwl7+E9fAKIkNLdv2tL75OwVYrBCcyjItyFiEtb/qyr1hnq5kpaPp1s3w75
         o+7IgdyBtGJfe91jHYntNWxXpyOleKSNPQbAIV395spJVG/yPjElSaHARwUzabMjEl4O
         KcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=mSzg/aL6DJHGzbMb1VDeZyZ7ThCOQswJWikvgG0ii/s=;
        b=pvcb3yYtnyGuqn/ruXyrd+ovz7j0VlT+ixhlecPH0K+jkL1TzQ7qckRSy96Gf7UTuF
         z6eQoZDAd6t8ZIciT2h/Hy7VLq4RCmHzM4qsRbd6lhJziD0TxGxeByBOxOu48BsfEOW2
         IYvgDJPvz82XsQvos8B+lZ1XHCF58OIJccGc9I0GhIdZ+v8uUaGEMcLwrNNSMN4sBQrW
         8EwonWCtmM8aKdhhQuN+KdfblBIqRv0HLfaXrAtxZqnVfhaSX5ZjfZ3tdbGuzlqD0OUt
         FnRhWb3Alle8KReD6Eg29aDBdErMgISogiE2UlPbqgJbn4liYTV7k0S9nKcjDjmPupUQ
         vkQw==
X-Gm-Message-State: AOAM533VWuOc1FFXZNfYPlsQcFf5Uyl0EkFoiP/rCZ9wj0Hws4vhMgTY
        O/G0Oj58bueFTziFmVCd11gKLFCaVsQ=
X-Google-Smtp-Source: ABdhPJx5sPwmKrYOhQJcSYJLdPSdqo+CT6tiD0gdz+lD2BdK3OFNA+RgavSVaviYgWOPBY8Fk7p3/w==
X-Received: by 2002:a63:4f52:0:b0:3fe:4274:75e3 with SMTP id p18-20020a634f52000000b003fe427475e3mr5978004pgl.595.1654776006919;
        Thu, 09 Jun 2022 05:00:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.48.97])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b00161478027f5sm16627915pla.150.2022.06.09.05.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 05:00:05 -0700 (PDT)
Message-ID: <62a1e0c5.1c69fb81.81c47.15cc@mx.google.com>
Date:   Thu, 09 Jun 2022 05:00:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7430041051454425091=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: Fix CVSD SCO setup failure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1654772596-10019-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1654772596-10019-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7430041051454425091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=648803

---Test result---

Test Summary:
CheckPatch                    PASS      0.83 seconds
GitLint                       PASS      0.41 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      34.73 seconds
BuildKernel32                 PASS      33.51 seconds
Incremental Build with patchesPASS      43.15 seconds
TestRunner: Setup             PASS      543.61 seconds
TestRunner: l2cap-tester      PASS      19.00 seconds
TestRunner: bnep-tester       PASS      6.61 seconds
TestRunner: mgmt-tester       PASS      114.47 seconds
TestRunner: rfcomm-tester     PASS      10.30 seconds
TestRunner: sco-tester        PASS      10.04 seconds
TestRunner: smp-tester        PASS      10.00 seconds
TestRunner: userchan-tester   PASS      6.76 seconds



---
Regards,
Linux Bluetooth


--===============7430041051454425091==--
