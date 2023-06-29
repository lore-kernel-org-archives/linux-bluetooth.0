Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F8FEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 01:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjF2B05 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 21:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjF2B04 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 21:26:56 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B293E1FE7
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 18:26:55 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-560c617c820so102165eaf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 18:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688002015; x=1690594015;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zh73Jv4s9OmzMkQoBA4UzTQdUSwzcjVfNJwk28V/7VQ=;
        b=ky1XdFADgarxEHJr8mmGz6a3tvGU6uTqBDT5eRjGFins8vsZCqpo6vTbizCe5w23jx
         FJv+pEQIzKFP8vIcqUrUqkPE0+Q7YKxYVmiFJqYby3Imwc8Jn+WXxymFxBPVOnOyndVQ
         c98LTQaJLoP0MwsBNRJlj9N6M6M4iZTPCZgmL9HyA0hrvF+1Z472MQHnJXzPwUHHCNOU
         KgiHkPUFTNqhIO/DOzqCy6EE3zeT1c064Ks4KrIC06Ah5ZBOpE0km8BTvavCPL/sQHnO
         99EdDbJPrahx6xAmjNSUITPuyZR3Xzh0kB1IqeCBGjqf9OPtkl+XMms+5kPNQplOgPjl
         A0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688002015; x=1690594015;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zh73Jv4s9OmzMkQoBA4UzTQdUSwzcjVfNJwk28V/7VQ=;
        b=TpSssoxAE2w26nFrvC9zaJXFyk0/E3y/IVbAcRSYyiKUI1LZ/baHYDH01PsbTAQUdd
         WhAevTBoS+tnhBNo5zjNw33Nvt9AHQaE2NPX88h9BNIk9cvxP/siIfF9Lt+ICQWywU5t
         GLF9ocp3xMQkPpLoyzVCjMIJBXFEzX/FFYYzJ0KykJCrrzdK5nksi+Olj3R0iwA5G+l7
         THrhNMXMpQ20PHj5ko7zAUQsTFTx8mCzSrclnScFLiA3Wu4BtAyeMnEsiH7TZPDQu60/
         qRj/jM/f1ZD+ShWEyutlLpDy2UpJQQQrkjDKlMfsq4++WY5MIlk2pi2OHhkNBsnv6wEX
         PN9A==
X-Gm-Message-State: AC+VfDw4E+AMfYI7HtQ2RSrpgQkf9EF6eBxoR3/b8OJY0g7qTEPlPUdN
        ACmornsDNMgD0YiaHiZi1pQIVfDjsZ8=
X-Google-Smtp-Source: ACHHUZ4E632nFco3YDWIEBelJGTFYmcjKTMPUGRr0f4/8J5ld0cu3vRp+sZJdSc39VsDS2daDh8xGw==
X-Received: by 2002:a05:6808:14c:b0:3a2:1b3d:2384 with SMTP id h12-20020a056808014c00b003a21b3d2384mr6032258oie.7.1688002014816;
        Wed, 28 Jun 2023 18:26:54 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.2])
        by smtp.gmail.com with ESMTPSA id 15-20020aca280f000000b003a1ed9482d4sm2902616oix.4.2023.06.28.18.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 18:26:54 -0700 (PDT)
Message-ID: <649cddde.ca0a0220.d4438.2512@mx.google.com>
Date:   Wed, 28 Jun 2023 18:26:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5155670580397464338=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4,1/3] Bluetooth: hci_conn: Consolidate code for aborting connections
In-Reply-To: <20230629001310.2946122-1-luiz.dentz@gmail.com>
References: <20230629001310.2946122-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5155670580397464338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761073

---Test result---

Test Summary:
CheckPatch                    PASS      3.47 seconds
GitLint                       PASS      0.89 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      37.83 seconds
CheckAllWarning               PASS      42.13 seconds
CheckSparse                   WARNING   47.23 seconds
CheckSmatch                   WARNING   127.59 seconds
BuildKernel32                 PASS      37.05 seconds
TestRunnerSetup               PASS      525.20 seconds
TestRunner_l2cap-tester       PASS      15.19 seconds
TestRunner_iso-tester         PASS      27.81 seconds
TestRunner_bnep-tester        PASS      6.49 seconds
TestRunner_mgmt-tester        PASS      147.80 seconds
TestRunner_rfcomm-tester      PASS      10.38 seconds
TestRunner_sco-tester         PASS      11.59 seconds
TestRunner_ioctl-tester       PASS      11.01 seconds
TestRunner_mesh-tester        PASS      8.37 seconds
TestRunner_smp-tester         PASS      9.48 seconds
TestRunner_userchan-tester    PASS      6.79 seconds
IncrementalBuild              PASS      72.87 seconds

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


--===============5155670580397464338==--
