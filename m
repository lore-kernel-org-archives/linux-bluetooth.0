Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04CDC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 11:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbiGNLzz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jul 2022 07:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGNLzx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jul 2022 07:55:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23495A2F3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 04:55:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so8437259pjm.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 04:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=es82VCqe5109I8TWoT6aJL+CwuMRLGOEosyVTz1Nlk4=;
        b=cuF44sQRWckxNROI43+gZYEaN1NujT8N+jR8si34oMywv0hkEMTRbXcP0r3Y7KvGTJ
         233cQFV9IfbpsDypRI9SfapYYyoda++HJULWhO7YN+2JN1eHvAWSu7HQ/MSKsUyBmtH+
         oAyz+2cu67GbvKGqnRi5u2hKrHT6aGVl4ocDh1NYmU6LvBdaf/1Vkf8G2Gbrytq1i6eP
         JReDLQXngvwGK9nhEm3d1N7UYZc4JLLT8ieElyjSKqPKwgcryCcFpwoEniqdCZ2oL+Yp
         UqndRcPDs6EueivvSeKOjoMlEiEiVQH+mkd7l/kp0YZcTtm1pw2v+5vUFJZNngAATFqG
         5bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=es82VCqe5109I8TWoT6aJL+CwuMRLGOEosyVTz1Nlk4=;
        b=xXx6LUtq+qZ9dOK5eWgVcWhAU+8qlFIJzKRNZx0MEh3MGEFJqXE5PctOG73iF5HRiA
         iJFYIOhTT99fw0WJ6U0AtB5yIVkNKR1gAQkB0Ho8TdCeyEY77J8dsBLWUc3YoMFTTHU8
         saSktiArmnqqBBlF31FjXHAJtwHhp/ddzYJk544+jzRwxSN5d+NE+l0wfis4vyg7EOhk
         Zkrhz10Z1Z4G2StsZTJwOdySkpLZrX5bIFT3eprry6FQHoAlXZUulmGcik6dA68YK+uz
         OrSx36L1ItkeJxlML8z/I40AuIOv/j28rvCGcukb2C6LO3HlNfU2Ln5P8X/qOKMGYKNn
         dpAw==
X-Gm-Message-State: AJIora/l+pdLfi9YK4bipUYSn4Cmcu8Q912wUL4wMvrbOUWf4xU3qsFL
        YNkSYnwDyxlg86xhXhPq7Nz4oQg0hGE=
X-Google-Smtp-Source: AGRyM1ssEsg5Fzsj3kVW5nzUzPya4BVx1JYp6TwOaRI7KIlUWWZ4NATR0xeLYxH9+JK7F2jpRmIjRw==
X-Received: by 2002:a17:90a:cf17:b0:1ef:bd2b:1a59 with SMTP id h23-20020a17090acf1700b001efbd2b1a59mr9669807pju.144.1657799752027;
        Thu, 14 Jul 2022 04:55:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.154.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a622506000000b0052b2bf4cc42sm343104pfl.111.2022.07.14.04.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 04:55:51 -0700 (PDT)
Message-ID: <62d00447.1c69fb81.d74df.0795@mx.google.com>
Date:   Thu, 14 Jul 2022 04:55:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1530653385445203649=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, poprdi@google.com
Subject: RE: [v2] Bluetooth: Collect kcov coverage from hci_rx_work
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220714104814.1296858-1-poprdi@google.com>
References: <20220714104814.1296858-1-poprdi@google.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1530653385445203649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659660

---Test result---

Test Summary:
CheckPatch                    PASS      1.26 seconds
GitLint                       FAIL      0.56 seconds
SubjectPrefix                 PASS      0.39 seconds
BuildKernel                   PASS      31.70 seconds
BuildKernel32                 PASS      27.34 seconds
Incremental Build with patchesPASS      37.80 seconds
TestRunner: Setup             PASS      468.97 seconds
TestRunner: l2cap-tester      PASS      16.30 seconds
TestRunner: bnep-tester       PASS      5.46 seconds
TestRunner: mgmt-tester       PASS      95.42 seconds
TestRunner: rfcomm-tester     PASS      8.90 seconds
TestRunner: sco-tester        PASS      8.60 seconds
TestRunner: smp-tester        PASS      8.65 seconds
TestRunner: userchan-tester   PASS      5.65 seconds

Details
##############################
Test: GitLint - FAIL - 0.56 seconds
Run gitlint with rule in .gitlint
[v2] Bluetooth: Collect kcov coverage from hci_rx_work
24: B1 Line exceeds max length (132>80): "Note: this is a resubmission of https://lore.kernel.org/netdev/CAPUC6bJbVMPn1FMLYnXg2GUX4ikesMSRjj=oPOOrS5H2DOx_bA@mail.gmail.com/T/"




---
Regards,
Linux Bluetooth


--===============1530653385445203649==--
