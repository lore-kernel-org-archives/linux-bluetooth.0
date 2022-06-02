Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D46C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 17:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiFBR0N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 13:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbiFBR0M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 13:26:12 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFA5270F3D
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 10:26:10 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id el14so3982293qvb.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jun 2022 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=2aYrLKVYdpDSbu+rFxBf5fwRjb8QcnIJuwEjnmxYoDI=;
        b=j+k4TLfk4+7pkwXOvVKTCKfFVAkHR8jz+0bnfZu3ss8g2Mqm3PlnJi0cmrShoY3385
         GQEo7kxPeoxSUAdC77r8ezgB0cV9RXbzrGUqdTVbb7vOmP29S3CCU5ZOXbKm4RRbQ7nS
         tTf4BK612pXoLokdMjevCw/bExXHCTwjxW1yAJDQ8AdHBgAdpyPz9rH+QX6I2yMxdBha
         tylxHaMjNtedkoymY9WmSDzM8vDNFR8C3Z/4o82RrRlrOxN/fnA3CASTh7FQecjL0uGN
         ESNNPiaA/a381uDpdzrYigGpFRxTD/ygvKsVqgnPNRtFKMXo/G5y7vUV5BoyzjKhIjWF
         gdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=2aYrLKVYdpDSbu+rFxBf5fwRjb8QcnIJuwEjnmxYoDI=;
        b=FYLuJ7H/ErA8hH/i7vGJ24h8JyesXHoXhFaD0Hk0zg6BFugd8TkpWlDp/A+SrWa82l
         dB6exbGIv3UU7t/VS+W475hw2V1RCygLDj5otYN0J7VS3tgjMvc8dM+z+iYRmli8R91P
         K94p6YSWDU01IIKYypaMgtdzrZbZVSp711/H6iHu2DbdfskzpokdRDmRI3CeRVgsaQpA
         0pY5hegY0hgQAblk8sVSOdKFKTCqZnc6UDD03/1S33MlWPA+LsjX4/CIEVfq/1eVarMW
         RgAugsWZO8y39Jfj8V9z2zTMXX8j11IveEerxReb7KCmT9WcXG+Xh8Shm+9h/165a4IV
         BIIQ==
X-Gm-Message-State: AOAM531x788wHQX/ILVnEta4CQXNOHAWJ9O72Ov9/6kKCPGdmJ4+Owh/
        4RK/cK9JeN9I0/xJyfNlk+UzdWKA/qgPMA==
X-Google-Smtp-Source: ABdhPJzzfO0NrFY9goN2lzZtIU8FOEDigcbHVKuhzt90cboJ1daZG55WaQi0DSuMhPAoRMzFPowATg==
X-Received: by 2002:a05:6214:224f:b0:43f:d536:d014 with SMTP id c15-20020a056214224f00b0043fd536d014mr59921042qvc.50.1654190769913;
        Thu, 02 Jun 2022 10:26:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.79.134])
        by smtp.gmail.com with ESMTPSA id fb11-20020a05622a480b00b002fbf0114477sm3289775qtb.3.2022.06.02.10.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 10:26:09 -0700 (PDT)
Message-ID: <6298f2b1.1c69fb81.cf74d.e5fd@mx.google.com>
Date:   Thu, 02 Jun 2022 10:26:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6689649105319084393=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@google.com
Subject: RE: [1/2] Bluetooth: Fix index added after unregister
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220602094645.1.I7d191480c15b45a237b927e26aa26ba806409efb@changeid>
References: <20220602094645.1.I7d191480c15b45a237b927e26aa26ba806409efb@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6689649105319084393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=646945

---Test result---

Test Summary:
CheckPatch                    PASS      3.66 seconds
GitLint                       FAIL      1.03 seconds
SubjectPrefix                 PASS      1.74 seconds
BuildKernel                   PASS      31.77 seconds
BuildKernel32                 PASS      28.08 seconds
Incremental Build with patchesPASS      65.60 seconds
TestRunner: Setup             PASS      475.78 seconds
TestRunner: l2cap-tester      PASS      17.44 seconds
TestRunner: bnep-tester       PASS      6.11 seconds
TestRunner: mgmt-tester       PASS      101.81 seconds
TestRunner: rfcomm-tester     PASS      9.61 seconds
TestRunner: sco-tester        PASS      9.37 seconds
TestRunner: smp-tester        PASS      9.40 seconds
TestRunner: userchan-tester   PASS      6.41 seconds

Details
##############################
Test: GitLint - FAIL - 1.03 seconds
Run gitlint with rule in .gitlint
[1/2] Bluetooth: Fix index added after unregister
24: B1 Line exceeds max length (82>80): "    @ MGMT Open: bt_stack_manage (privileged) version 1.14     {0x0003} 682.437223"
25: B1 Line exceeds max length (82>80): "    @ MGMT Command: Read Controller Index List (0x0003) plen 0 {0x0003} 682.437230"
26: B1 Line exceeds max length (82>80): "    @ MGMT Event: Command Complete (0x0001) plen 5             {0x0003} 682.437232"




---
Regards,
Linux Bluetooth


--===============6689649105319084393==--
