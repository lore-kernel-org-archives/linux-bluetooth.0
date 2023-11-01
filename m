Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F99C4167D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Nov 2023 16:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjKAQB5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKAQB4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Nov 2023 12:01:56 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6379E4
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Nov 2023 09:01:53 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66fbcaf03c6so36300756d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Nov 2023 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698854513; x=1699459313; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j/rucV7eaJuwFE2eoPuoj0WH7pFQNH4MygAmFajA0K8=;
        b=CkPekcGXp8MVVxN1OIidWK6cJaOn8BknoTHN7HPSOpEyM2W61ad6Irl+ugIk1PtTqL
         0kFUHvC//YOjlGwblf1kQJsS6BkgrK6XORhtFmLu4hfW3EetRXRIAmBhFDKK3wOKz+sm
         NXtB8EgKqYdFVXbGWqaUiuEtkp2YdxpsGNg32VQ4KakWW7zqINl8/s8ZAZpw7Q00HfEW
         JdkKP1Q+xxcfxybEn2rN4nilnfxByLu8iPmXICRY1csOvA4YZCUJZZ/7h4JP6sO01Ysv
         86E3EMlAkapMrJThOAo83QA1mOj3ebp3/uG/NSZu1ZM2teQtvjzzBh5nFKNjJGrNtgBa
         5ymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698854513; x=1699459313;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/rucV7eaJuwFE2eoPuoj0WH7pFQNH4MygAmFajA0K8=;
        b=hPRhOrMlXirdDXMVh59YAfJUwLQ4NUDn2xMryLdJmQMBDl/3t/TPQKruTYBDCg7H/E
         l0XuRRhDlKgyNFbXWDO1gSel2SFZGzgPEQk5DOuKuWE//FW3Xz2gaALtzCJYvdppvGhQ
         MZsaYrOLcpSGRjlIOCK1lW9Q1T4hgUr/INlEZiMW7FiwJcjugBPJFToyndP5mbieE30X
         MAkVzn9RB2Hh9eSRiyuCKujO/x2v1gb8LxcyX8Q0akoSWiIlPLScY+7TUU+zwf/lKzBH
         wM8j+aDyad6cS5cLkMtTxj9ODd/APyVTN5SbMTwslXr2sHNeaj0w/uco+AxhMx3vgT90
         wWXQ==
X-Gm-Message-State: AOJu0YwwQ8Aw7V4PyOmXaSM50pmLbVkKD6oVV1OBqTHJlolXMZ20Ev8g
        SZ8yC3Fl1vIdynhTky/RgAFQjMqwR88=
X-Google-Smtp-Source: AGHT+IE1qKAi47bdUVZ+pIlJanlxTsoIJdHe+25r9oCWNof/iSyLhOz/Md8ZbC8BXdiUWftPRtjEiQ==
X-Received: by 2002:a05:6214:130b:b0:66d:ba80:2324 with SMTP id pn11-20020a056214130b00b0066dba802324mr27454850qvb.41.1698854512708;
        Wed, 01 Nov 2023 09:01:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.217.79])
        by smtp.gmail.com with ESMTPSA id w1-20020a0cef81000000b00670a8921170sm1579404qvr.112.2023.11.01.09.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:01:52 -0700 (PDT)
Message-ID: <65427670.0c0a0220.a332f.86f6@mx.google.com>
Date:   Wed, 01 Nov 2023 09:01:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2595561407297477283=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Reassociate a socket with an active BIS
In-Reply-To: <20231101153015.5541-2-iulia.tanasescu@nxp.com>
References: <20231101153015.5541-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2595561407297477283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=798193

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      34.10 seconds
CheckAllWarning               PASS      36.53 seconds
CheckSparse                   PASS      41.65 seconds
CheckSmatch                   PASS      118.76 seconds
BuildKernel32                 PASS      32.44 seconds
TestRunnerSetup               PASS      507.02 seconds
TestRunner_l2cap-tester       PASS      29.84 seconds
TestRunner_iso-tester         PASS      56.25 seconds
TestRunner_bnep-tester        PASS      11.78 seconds
TestRunner_mgmt-tester        PASS      209.83 seconds
TestRunner_rfcomm-tester      PASS      15.09 seconds
TestRunner_sco-tester         PASS      18.35 seconds
TestRunner_ioctl-tester       PASS      16.80 seconds
TestRunner_mesh-tester        PASS      12.37 seconds
TestRunner_smp-tester         PASS      13.52 seconds
TestRunner_userchan-tester    PASS      10.33 seconds
IncrementalBuild              PASS      30.85 seconds



---
Regards,
Linux Bluetooth


--===============2595561407297477283==--
