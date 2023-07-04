Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4442EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jul 2023 18:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGDSLP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jul 2023 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjGDSLP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jul 2023 14:11:15 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9099910C9
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jul 2023 11:11:14 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7658430eb5dso620531085a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jul 2023 11:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688494273; x=1691086273;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxkkB1wf+A5t0FCJ9CJDxKHS3s8U3rGbD35Hz69vCIU=;
        b=ZeZsZ/rFgDO6cA2dfya5kyzp9dunNDkccLdCivcuq7uRLq4a1Ejvo4+RErVf19d9Yx
         0IuJL7W/HeqJ0R3HPMNccUiEtJoS/VpxxmZQ50RkwP5K2VN3T2+gUmX/qr8ALykBypte
         JX/lEHherbarCNRXYM7JYA9+Tbsy0/v8Xz4vqgcpGRUTzJVlM42DN/MCgozrw+vGfH5l
         uLHpvAWLcOaJCw0CiQ7dRtwcWaClOlb6ts0QrMNLWFfjhlPDFjnlE2iG56v4hSwMgDGW
         SOrBs8t9ucZJ6uI5AdfbPw9tUeUUygweW6peNwcWXQ5AW9Whp3C/5DmTDKYwELyJab9x
         y1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688494273; x=1691086273;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxkkB1wf+A5t0FCJ9CJDxKHS3s8U3rGbD35Hz69vCIU=;
        b=iWs4SWJzeP+KZ5JqAyHkoXG4ClfEXqWaGosEfMjEKslxHswczbXICuDdSj7ndh99Cz
         lLN/PsBwAsEbV5zpaquDuqU0uwsLJRSkkdxR1Pa4fb2k1/pg7xid9cbxVgHiksa1tRoQ
         JQYejh/6wA/MY5oJDcxlqt+xtXE5tPKY+vm2KYcwfL3oqZdZkSEbD2JBW2jT0Av9Z1hm
         nvp3VuUWcbXAficrJbirAhZtZr8Bo93Owbimv6bKNcxilT26Dyx7kuhNhp3OYVIVPayO
         oREBAJAtsbpjhVLSMzgUAkT0mH6iiin/l7KEpombTJgIlOdHFSN8GJI0ngec+Gn0WemQ
         9P7Q==
X-Gm-Message-State: ABy/qLbUlNdVFjaPyeiqXIrEC4mbidE2ZaWwtGM43k5gTFhSc6BZw7DU
        6TVHMhRv6RvUqv7miRRm8PomUxVh9NY=
X-Google-Smtp-Source: APBJJlGRIjTevDhnMfkAn0+0RcwHaZorC/a2JLV3fUK8/IPe8/R8j5nLQUHhIL8rca8wCXIHMjuX5A==
X-Received: by 2002:a37:8681:0:b0:767:464e:c529 with SMTP id i123-20020a378681000000b00767464ec529mr15209494qkd.2.1688494273576;
        Tue, 04 Jul 2023 11:11:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.73.11])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a030800b00765a676b75csm10098448qkm.21.2023.07.04.11.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 11:11:13 -0700 (PDT)
Message-ID: <64a460c1.050a0220.13904.8bf7@mx.google.com>
Date:   Tue, 04 Jul 2023 11:11:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4714757957846510888=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] doc/tester-config: enable DEBUG_KERNEL, PROVE_RCU, DEBUG_ATOMIC_SLEEP
In-Reply-To: <fdec6ddf8eacfb37cbd34d9049fcadf29041c103.1688490237.git.pav@iki.fi>
References: <fdec6ddf8eacfb37cbd34d9049fcadf29041c103.1688490237.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4714757957846510888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=762441

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      26.77 seconds
BluezMake                     PASS      789.58 seconds
MakeCheck                     PASS      11.67 seconds
MakeDistcheck                 PASS      156.73 seconds
CheckValgrind                 PASS      249.52 seconds
CheckSmatch                   PASS      335.72 seconds
bluezmakeextell               PASS      101.89 seconds
IncrementalBuild              PASS      665.74 seconds
ScanBuild                     PASS      1035.97 seconds



---
Regards,
Linux Bluetooth


--===============4714757957846510888==--
