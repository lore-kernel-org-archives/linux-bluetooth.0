Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3102C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Nov 2022 12:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbiKHMAc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Nov 2022 07:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiKHMAa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Nov 2022 07:00:30 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79591E701
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Nov 2022 04:00:29 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id mi9so10052153qvb.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Nov 2022 04:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YDCWn530jVhC93+NHzsDVE6RW/pM4nXDlcbnpHb97W0=;
        b=RnJa4EKUUN0lnfbcz/iPYxUDZhsWNUIXkwJWbGuWlMGip9G6k6ioamTcwfbgGJbjCq
         HGhBnmVMQyX04+fc2iDf4/aRbY9TzhIJR02y5fpLflb11ZK29kYaAzS1+MUrPF1RjU+z
         gUBf+HlDn1rzrh7kuoUgluokZn/UvjfeCVJfxNXB2ix6iEtNwpqiHHdKacyIn6ghh+hD
         HTk5jq0uPxnvhC3jU6+Y+itf1V1L0MSwuBK2IDm8xRrCZ/xJJ4PDc2IaULPylwAIK7Sl
         JU9csrC42L0SWahaiu+AFe3KIdLvHhtpmuxdtos9A2PSXJnlZwRGZ0mmNQ7TIqHbuB1/
         8l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDCWn530jVhC93+NHzsDVE6RW/pM4nXDlcbnpHb97W0=;
        b=4ymI75zKo5qk42+qIDq78pcWH9ZMsxLD4kt5KRmaY3557jUrAbqzql6uHta3J0Lfw5
         vRrUIKgpYTBwIQXlhggFkchwWLdXuI0g1NrHdIfKhlv7yZhexa5x9knHfNYeiPRkzxFH
         qwtTnxpZaqREqiz9TttZE7yKsO7X3MjCtbnFO/SwRqTDWCAQBJOyJtTQBrSeaZ2GI2Dy
         HyeA4Ca6PAxga1esFzY18T3Tr47IPhk3mIBX5EE7d97zlUeU4jqPM0OoJgEol6JVqw6r
         mHgC6U93yRcr7+MHBPaR3nl69D1GFn8BKH49Vt21LMl4sEtYFaQDNCAe/Bv/0PspbQMf
         PQvA==
X-Gm-Message-State: ACrzQf1ir4Vkl2Jij8LD/kYHexo+MycIgVvbz43aZlCr6fWrYp8J2haf
        0IRInQ74AziAJpnWvm89bd0daMh3bkYk4g==
X-Google-Smtp-Source: AMsMyM5vHGBHJJTGlUPjj7nEyGc6v03Vez/8YGUTI+1eUSQ1aTMntjqn7ZlGVGA7eVfoeWYJvVM26A==
X-Received: by 2002:a05:6214:27c3:b0:4bb:6d7d:982a with SMTP id ge3-20020a05621427c300b004bb6d7d982amr48617031qvb.98.1667908828351;
        Tue, 08 Nov 2022 04:00:28 -0800 (PST)
Received: from [172.17.0.2] ([20.163.137.178])
        by smtp.gmail.com with ESMTPSA id ge17-20020a05622a5c9100b0039cc64bcb53sm8048854qtb.27.2022.11.08.04.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 04:00:27 -0800 (PST)
Message-ID: <636a44db.050a0220.1d8f7.155a@mx.google.com>
Date:   Tue, 08 Nov 2022 04:00:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2454171863961073369=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bobo.shaobowang@huawei.com
Subject: RE: Bluetooth: hci_conn: Fix potential memleak in iso_listen_bis()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221108112308.3910185-1-bobo.shaobowang@huawei.com>
References: <20221108112308.3910185-1-bobo.shaobowang@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2454171863961073369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=693186

---Test result---

Test Summary:
CheckPatch                    PASS      1.66 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.84 seconds
BuildKernel                   PASS      34.49 seconds
BuildKernel32                 PASS      30.67 seconds
Incremental Build with patchesPASS      47.81 seconds
TestRunner: Setup             PASS      510.78 seconds
TestRunner: l2cap-tester      PASS      17.73 seconds
TestRunner: iso-tester        PASS      16.71 seconds
TestRunner: bnep-tester       PASS      6.66 seconds
TestRunner: mgmt-tester       PASS      107.48 seconds
TestRunner: rfcomm-tester     PASS      10.88 seconds
TestRunner: sco-tester        PASS      9.90 seconds
TestRunner: ioctl-tester      PASS      11.26 seconds
TestRunner: mesh-tester       PASS      8.20 seconds
TestRunner: smp-tester        PASS      9.91 seconds
TestRunner: userchan-tester   PASS      6.89 seconds



---
Regards,
Linux Bluetooth


--===============2454171863961073369==--
