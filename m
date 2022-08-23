Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D804C25B08
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 05:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiHWFZb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 01:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239821AbiHWFZX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 01:25:23 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585635C9C3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 22:25:23 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 62so10088309iov.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 22:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=WzCa4+/h6cF+trJaQBDKPZrQuNjqqy2blLDRkod9AHw=;
        b=ZnrwQ6YFw95CvTciOx2ReXg1EYAno/OS1AJgP+N+XmnLAgDfsPdv2WLo1pjCbWvc6I
         tPkGYIvH9aPJuNKLoqW/+FDbBKHGx3FQSYYMWTRLpCtrlhrLK4T6HE8t5g+HJ7fKKzm1
         F2HBPVUULOF2XHF+f/UbNAMP1TEy0amoR2Wt0Wa6CWnb6T3xoS4dftX0xQMpe/RIyinJ
         0VXNRk9wBP+kvhBOZgzptymgLIzVmvmlX2MwofX2C7szW9ppp3wAPxPkhhemKfzqTi1o
         oQaoDR392luLAkS5CI12Nk36mOp8ZC9cUEbgLLa+PbMQTX/dHgJxORcIrQyxs+iK087N
         To0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=WzCa4+/h6cF+trJaQBDKPZrQuNjqqy2blLDRkod9AHw=;
        b=A3XwTjLucvHmBFALnhdp/Ay5havjwvxqr5eWNx7TK5+UhDSx7+WotSWWPwuKQpLxac
         oc3qAWdjQ5PR5dCEXDiIrpkMAGXjsJisRyEWibSJnHnMsStLdIQcu8uawaRiWoZRJpW8
         DPgqkqVZdtFtmJBlLQDdtCxRz6zTogTfAto95VYeL64mwGmf5ZUFNTWOcP8wIu82vnDV
         /pESEGUd8rEs173T1QD8vP1NfrA4L1o+VHwf7Rg4P/tKvbIURAcnrKLFHKoXGS713SuP
         2nm3igi/25asSZM8LCeKpIbRDKSmA0tgUAr20H1NmeG2j5JIw0jCS/N+J9qJRvZBevQi
         2oAg==
X-Gm-Message-State: ACgBeo1uXlR6zIoUpsrhalZ4lzuqHk+PrkbzdsM/h9WsXySqSouZBuC7
        Sb5rBfyGD6tn97I1VyfPtJl3JrBSsKA=
X-Google-Smtp-Source: AA6agR4ClgqZj5yYtqiL+tmd0iUIiYv5IwN+gmRX0bOR9vTewwfH7HRH2SPfqiLS0I3TPozl10DbWA==
X-Received: by 2002:a05:6602:2ac2:b0:689:f825:803a with SMTP id m2-20020a0566022ac200b00689f825803amr3992083iov.131.1661232322593;
        Mon, 22 Aug 2022 22:25:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.89.122])
        by smtp.gmail.com with ESMTPSA id z6-20020a056638214600b003429ee6ca96sm2535657jaj.1.2022.08.22.22.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 22:25:22 -0700 (PDT)
Message-ID: <630464c2.050a0220.fc866.2fbb@mx.google.com>
Date:   Mon, 22 Aug 2022 22:25:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6913580398856215449=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: Bluetooth: hci_sync: hold hdev->lock when cleanup hci_conn
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220822214430.kernel.v2.1.I1d10fc551cadae988dcf2fc66ad8c9eec2d7026b@changeid>
References: <20220822214430.kernel.v2.1.I1d10fc551cadae988dcf2fc66ad8c9eec2d7026b@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6913580398856215449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=670006

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 PASS      0.64 seconds
BuildKernel                   PASS      34.08 seconds
BuildKernel32                 PASS      28.82 seconds
Incremental Build with patchesPASS      41.42 seconds
TestRunner: Setup             PASS      479.01 seconds
TestRunner: l2cap-tester      PASS      16.64 seconds
TestRunner: bnep-tester       PASS      6.27 seconds
TestRunner: mgmt-tester       PASS      99.95 seconds
TestRunner: rfcomm-tester     PASS      9.53 seconds
TestRunner: sco-tester        PASS      9.30 seconds
TestRunner: smp-tester        PASS      9.30 seconds
TestRunner: userchan-tester   PASS      6.39 seconds



---
Regards,
Linux Bluetooth


--===============6913580398856215449==--
