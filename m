Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0BDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Mar 2022 19:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiCMTFz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Mar 2022 15:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiCMTFy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Mar 2022 15:05:54 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6BD44761
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Mar 2022 12:04:46 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id j21so5198094qta.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Mar 2022 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Y7Gwa8Mq8oPw2eYDU7jqnqK1k1a2ZA7Dx0QDgI8Gi4c=;
        b=m0xmMD09DTeMGxEhhPl+h5dwLsuILEedYJouwu2mYi+sZ0EqYpKgM+EomzHWG/kE0O
         Me45TdIc9ddYL/LAs46PcgzMTnycilcl5JhSxUoIAZRRBuXqSNFw1ekh05FfPRb/xXMG
         mgYnQKClLZ389XhXhuJr1osVDttNnj4WAdpZwQfrSweVFkuF7yo5N/tM4RWfxk2Z6ocU
         2RngD5UGIWu1Rv4ikoCpd9+HeYTIY+5xphlJZEJH3p2zNDNC8EbZH+YUb7oExTz5GkMU
         l3YPu18avX5bVsHCsrL3Dzgk0RYAC1Ndcrvd8BjwGL23fRhRvspXqFSjjLshCNQAXddc
         6kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Y7Gwa8Mq8oPw2eYDU7jqnqK1k1a2ZA7Dx0QDgI8Gi4c=;
        b=K4wzCTNT226aYKh3MlaiLGFYXoaRexzp1mQQShDtcN82XY2o//eoa8iRV0kfO+R4y4
         s1dxTgNttjnCX6aMV3FmERl4PicAYoXSzQXr0g8g7Zm8wPakrjLzE7DKXb8zynLNeEWB
         BJMkss1i5jURVh9ler75AIK4j7NVSXxQuSsBzEM2rVNeWn6I/02LLZAgpR/Dtrn30af2
         qbi0G5OMvxrTRH4aT4QZ0mbDkjh2AkBwYcea33fz8VKzGPMG3BZxd+KQBHWIXsPe51JM
         r75q9URiFIW1LkN7FlewY2Re7Lqa/FdS9mTuKfjyg/wWox2BK1Hjn1/J1Twgp7ps+rGH
         jGbA==
X-Gm-Message-State: AOAM531rPwmqDG2TB5FxSPOf21Ak5yGmoFjNJCDVFKIdTi/fqqNSSknP
        v2RTrYPW9XPcP/GcybjyDVoMVjwhTcZ9Cg==
X-Google-Smtp-Source: ABdhPJw1hFJZWw9Aboe0oTRTBYSgHE14C6Sc98puMR8Lf3PsiuRhj5XkTwBKpfcXv0ntviWlHjcXJQ==
X-Received: by 2002:a05:622a:553:b0:2e1:d474:4459 with SMTP id m19-20020a05622a055300b002e1d4744459mr1170632qtx.169.1647198285425;
        Sun, 13 Mar 2022 12:04:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.231.36.45])
        by smtp.gmail.com with ESMTPSA id r64-20020a37a843000000b0067b0cf40b18sm6873383qke.69.2022.03.13.12.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:04:45 -0700 (PDT)
Message-ID: <622e404d.1c69fb81.39de1.6813@mx.google.com>
Date:   Sun, 13 Mar 2022 12:04:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0512250373759367643=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, paskripkin@gmail.com
Subject: RE: Bluetooth: hci_uart: add missing NULL check in h5_enqueue
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220313174936.1299-1-paskripkin@gmail.com>
References: <20220313174936.1299-1-paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0512250373759367643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=622982

---Test result---

Test Summary:
CheckPatch                    PASS      1.70 seconds
GitLint                       PASS      1.03 seconds
SubjectPrefix                 PASS      0.89 seconds
BuildKernel                   PASS      35.65 seconds
BuildKernel32                 PASS      31.37 seconds
Incremental Build with patchesPASS      42.73 seconds
TestRunner: Setup             PASS      550.01 seconds
TestRunner: l2cap-tester      PASS      17.10 seconds
TestRunner: bnep-tester       PASS      7.11 seconds
TestRunner: mgmt-tester       PASS      112.17 seconds
TestRunner: rfcomm-tester     PASS      9.00 seconds
TestRunner: sco-tester        PASS      8.81 seconds
TestRunner: smp-tester        PASS      8.80 seconds
TestRunner: userchan-tester   PASS      7.39 seconds



---
Regards,
Linux Bluetooth


--===============0512250373759367643==--
