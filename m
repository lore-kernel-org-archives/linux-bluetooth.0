Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20239ECAAA2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 00:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiHZAKs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Aug 2022 20:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244511AbiHZAK2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Aug 2022 20:10:28 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F60F62
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 17:09:55 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id i8so34230ilk.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 17:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=/cbzv6ScwuVaXoe+mmXD4WoQ+gVI2TLUa9H7dwRlE/I=;
        b=UwR50IS8vFaRz95S8XCObJd7azcBuuaUrbpXIv5gYKgkqm4GzqkTG+k4P0VQY+ubIN
         593vNEzffxCuTjxHM9TYezhXXTHKlEDZ8IbMJrLzICWYr1ymFi+7xa+JdQOLfwoU41Ci
         IZMt/lxoWzQfgdEad3G+Xu7FRonZTtjkFEII6On6hsB1MktprVwILQe4LTCgxgPx6sxi
         g3VLF3jCrNZLCu6I0iq0aS1rfYOluL14n0AAcmFFJZhZsHjWG4HmSgpi7Zde+7jy/7wp
         P94+LrrtZqiunUIgo8l1hMUUk7WZdPvvpeo9Gr3m2V1PR1xWuOORohLKGV4Z9nioReV6
         uSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=/cbzv6ScwuVaXoe+mmXD4WoQ+gVI2TLUa9H7dwRlE/I=;
        b=ezXGhUEJovObLy2zrONIE3YbnhrFDw7GteyJdcl4UiWIglaImdDjJX76LMXTNYKeDU
         huNqdeJjBd8XLAHaW2z7DQgjzJisJg0u/CwIX8KAZ6iYUpLviOXwrlG8fZ/vlKOKza5b
         MQBemWeA05AuU+co8CHxMxCNSYcync5AtizrQ2Ed7tWeDn/ZPPEDNldlAT21MGUf7xus
         SHh2qie04BFO4fyy657gWDApQyRQo94CRAsKePj121ph1al5V4k3qaKsj0gAsAdvJfV3
         Qwu73JJBjTHyROlm6rrX9fGMJAzJpiyhOkQvwS/7JAjf2yPItF3GrRlTxZY430S74Hba
         KKoQ==
X-Gm-Message-State: ACgBeo2myfY1b1murOvnudl4nfXkRpCP+y3vznbaqbyEKc8FHpijJ6Vv
        5BzRHcCKobmh268R577lU4tByNhAkPo=
X-Google-Smtp-Source: AA6agR5sFWhqevVHY+QMAijcJZeRTEKu26v6odarZbBI4md83MLBNe+Q8hyXgJffvv4lbFZv4/zGsA==
X-Received: by 2002:a05:6e02:198f:b0:2de:91f6:f70e with SMTP id g15-20020a056e02198f00b002de91f6f70emr2909792ilf.80.1661472594102;
        Thu, 25 Aug 2022 17:09:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.9.93.235])
        by smtp.gmail.com with ESMTPSA id o9-20020a92d4c9000000b002df244572dfsm386683ilm.25.2022.08.25.17.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 17:09:53 -0700 (PDT)
Message-ID: <63080f51.920a0220.a073a.0969@mx.google.com>
Date:   Thu, 25 Aug 2022 17:09:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3964388564007945783=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, labuwx@balfug.com
Subject: RE: [1/2] Bluetooth: btusb: RTL8761BUV consistent naming
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220825224208.343700-1-labuwx@balfug.com>
References: <20220825224208.343700-1-labuwx@balfug.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3964388564007945783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=671252

---Test result---

Test Summary:
CheckPatch                    PASS      2.52 seconds
GitLint                       PASS      1.60 seconds
SubjectPrefix                 PASS      1.22 seconds
BuildKernel                   PASS      33.74 seconds
BuildKernel32                 PASS      28.41 seconds
Incremental Build with patchesPASS      47.92 seconds
TestRunner: Setup             PASS      478.99 seconds
TestRunner: l2cap-tester      PASS      16.81 seconds
TestRunner: bnep-tester       PASS      6.24 seconds
TestRunner: mgmt-tester       PASS      99.16 seconds
TestRunner: rfcomm-tester     PASS      9.56 seconds
TestRunner: sco-tester        PASS      9.27 seconds
TestRunner: smp-tester        PASS      9.26 seconds
TestRunner: userchan-tester   PASS      6.41 seconds



---
Regards,
Linux Bluetooth


--===============3964388564007945783==--
