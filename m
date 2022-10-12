Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9409DC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Oct 2022 08:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJLIWL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Oct 2022 04:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJLIV6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Oct 2022 04:21:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBFD6347
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Oct 2022 01:21:55 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q1so6617051pgl.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Oct 2022 01:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CWbmULRyUou7+WQyIkDi8xA0H+vT3AkVahOi+jAi7gk=;
        b=dMWJTeQTzUXStwT1Mq56KQONI0ByTtDAfl2bApQmcyOjhHKbULAMcvLNRp9p6OM8CB
         J6ZmqZfc4MQV2dk+Qc7ncVN5qMvnQqgMgWnCkP0Dr6FnJ4S5CM7rFyqqv3yD1q0vZvtu
         Tmqu5+L0XOg/XzrA20wJ4RGLnCUKG1T/pfRKXjSsPcZ2ES5U6yO/3+NENm8v5j3ITD/V
         twbCKTvfAjjEkuzWcvT2fFeBHj2mwEcRxMN0fLPSToX6+oy01vBoePwNNyzua5r6lQS9
         viEBztSS17ameW58zCu8DBgQKrRM/zm6FRNAR83VlqcnD2lS6aR1qOBv5+LIRfPXvgEV
         eYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWbmULRyUou7+WQyIkDi8xA0H+vT3AkVahOi+jAi7gk=;
        b=z/+m0zn0hOLsdJMZ5pVL8bKuJOWf+F5ImYGD6EMVfVg16+VyvShvxZThj0oG6TFDDR
         sM+zVNRXwD8g6xPJMXKxTA/vXmTLQ/3THYB/ZlRL2kA+q8MXnXlk1TAUO5RxDN9PcEOA
         k8+s8Bc7nrFE8uqjt+1uR8Lm/BJ3kd3NtHXVRy71yIwQ+EbxP+EFLX563W0qslNjFmLO
         oSLm77GYPiYbAJLk67yZqN8bR+gkU/a28V/qdIA+4qssWB5NPE9PWQ1QtnlAfu8h1stz
         V++CypOpdllYn9EQ2s5d0z2sWXo7jnc+2Q3ofnHQLabv/TWudF4YFzj/NDo3UhdXYxZo
         RBoA==
X-Gm-Message-State: ACrzQf1jetzEHGVRWaKp6yWhJxLCphIKe3NDKlCWbMjvPmUlNfQotsrh
        z29aSCMvAs1BoQ3GsOTzsUDrSyv12mY=
X-Google-Smtp-Source: AMsMyM5orcalSaFPUK2KYLl4Wb0IrzhgiyPb1BPYkdkgLGXuaUMDXJjfx3Y/pf1KphzKbbu0B9P8DA==
X-Received: by 2002:a63:9043:0:b0:458:6003:30ee with SMTP id a64-20020a639043000000b00458600330eemr25339898pge.231.1665562914333;
        Wed, 12 Oct 2022 01:21:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.188.117])
        by smtp.gmail.com with ESMTPSA id q31-20020a17090a752200b001fd76f7a0d1sm876662pjk.54.2022.10.12.01.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 01:21:54 -0700 (PDT)
Message-ID: <63467922.170a0220.4746f.1820@mx.google.com>
Date:   Wed, 12 Oct 2022 01:21:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8974137047333288130=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, soenke.huster@eknoes.de
Subject: RE: [v2,RESEND] Bluetooth: virtio_bt: Use skb_put to set length
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221012074507.8157-1-soenke.huster@eknoes.de>
References: <20221012074507.8157-1-soenke.huster@eknoes.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8974137047333288130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=684698

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.50 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      47.90 seconds
BuildKernel32                 PASS      42.79 seconds
Incremental Build with patchesPASS      62.39 seconds
TestRunner: Setup             PASS      702.33 seconds
TestRunner: l2cap-tester      PASS      21.62 seconds
TestRunner: iso-tester        PASS      22.65 seconds
TestRunner: bnep-tester       PASS      8.55 seconds
TestRunner: mgmt-tester       PASS      137.07 seconds
TestRunner: rfcomm-tester     PASS      13.42 seconds
TestRunner: sco-tester        PASS      12.48 seconds
TestRunner: ioctl-tester      PASS      14.80 seconds
TestRunner: mesh-tester       PASS      10.57 seconds
TestRunner: smp-tester        PASS      12.28 seconds
TestRunner: userchan-tester   PASS      8.83 seconds



---
Regards,
Linux Bluetooth


--===============8974137047333288130==--
