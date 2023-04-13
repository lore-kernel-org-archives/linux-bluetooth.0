Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D04DC77B71
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 18:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDMS7a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Apr 2023 14:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjDMS73 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Apr 2023 14:59:29 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6967D3C39
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 11:59:28 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3282f36b9fbso611735ab.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 11:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681412367; x=1684004367;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rLTSnCCuK/E8HFMqP28ZCJCkFPkG19p5YPuX2v08uP0=;
        b=pYHIUfKqPttwB14U3tLsTdGENms5wzDOV3p38QvngdsY94tW/ws84L9Jr+pw5roWG6
         zXTVscYx6EP+byjH2HrbMoIHbL9nLOnV9Kh5OpvZMr+i/DHA+Z4BbHz656+HUEjB50cv
         zkHnw2VgxAMOxUga9l0dEbldiIQT33qFx1+IN/iXcub8KUqXJ7uFXjLkv69grIPuA36y
         IqJRFAfBmIxkejXONUemqOCE6ixJzzEYVvbiBWuBaWkpI7/vdLp7100C4Oe/B4XIk9Ni
         9xWxgzjTh4EvIZvaYiD0U4jkdn7CbBAsq5qZIOIt2n7kzlXM4KoN/YR7XVCw2BbzKhtM
         GWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681412367; x=1684004367;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLTSnCCuK/E8HFMqP28ZCJCkFPkG19p5YPuX2v08uP0=;
        b=YE3FKmq3Eu1H+2YRcjE9QB0m02Mt352nvKvsE7ax9q4a2j/2drWcI0LJoqNAjmS9c+
         46qQPO9SNOf88RpHbhy4+3BJT7q2tszf+qvSSykq2b0QArEk2TWsskPJrWs4sDJGUquq
         m5Y9rLBrcDeeSmHJAP61viw8mLJTX3inHE4GrQDyDAdVvLpG/PV2CSwiZthDYKq92geB
         2VqvWVIwMxlRoL6Nq6bzeXD0nVlfNPmUrTHzz0eVGZpTivbTrDFGV8zSNOicgkqWCmai
         s5Xnn0b5R1YR2eAKbCDH3Rl+tCfoSS04o/9i57ZlMJ/av6AyIA505orz+I5niusjQSyk
         0+sA==
X-Gm-Message-State: AAQBX9eJeLQGRcSvBkcS2UiqMA9/9wmvg1kCLidFg3KVNaM57G9vvzon
        G9SiK7oXyHi/TFoQS1Bb5aimRjje3k8=
X-Google-Smtp-Source: AKy350aCoxq4CYYp3HHpX/bDWOdwO1SfgFAlZzGxnkw35iUXWrSSsUCdVdy4Fu6r6KeK+VhNn8AS0g==
X-Received: by 2002:a92:d746:0:b0:326:3a39:89bd with SMTP id e6-20020a92d746000000b003263a3989bdmr2033126ilq.21.1681412367653;
        Thu, 13 Apr 2023 11:59:27 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.244.107])
        by smtp.gmail.com with ESMTPSA id b8-20020a923408000000b00313ca4be5e1sm534688ila.12.2023.04.13.11.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 11:59:27 -0700 (PDT)
Message-ID: <6438510f.920a0220.b927.0981@mx.google.com>
Date:   Thu, 13 Apr 2023 11:59:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2475272395626242617=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/3] Bluetooth: hci_conn: Add support for linking multiple hcon
In-Reply-To: <20230413183113.896669-1-luiz.dentz@gmail.com>
References: <20230413183113.896669-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2475272395626242617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=739574

---Test result---

Test Summary:
CheckPatch                    PASS      3.03 seconds
GitLint                       PASS      0.83 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      32.27 seconds
CheckAllWarning               PASS      35.41 seconds
CheckSparse                   WARNING   40.34 seconds
CheckSmatch                   WARNING   110.67 seconds
BuildKernel32                 PASS      31.57 seconds
TestRunnerSetup               PASS      448.56 seconds
TestRunner_l2cap-tester       PASS      17.25 seconds
TestRunner_iso-tester         PASS      17.84 seconds
TestRunner_bnep-tester        PASS      5.62 seconds
TestRunner_mgmt-tester        PASS      116.98 seconds
TestRunner_rfcomm-tester      PASS      8.96 seconds
TestRunner_sco-tester         PASS      8.31 seconds
TestRunner_ioctl-tester       PASS      9.59 seconds
TestRunner_mesh-tester        PASS      7.06 seconds
TestRunner_smp-tester         PASS      8.13 seconds
TestRunner_userchan-tester    PASS      5.81 seconds
IncrementalBuild              PASS      82.75 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============2475272395626242617==--
