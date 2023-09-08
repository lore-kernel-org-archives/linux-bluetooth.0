Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9EEEE57EE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 10:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjIHKF4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 06:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjIHKFz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 06:05:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8521FC0
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 03:05:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68e26165676so2180226b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Sep 2023 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694167507; x=1694772307; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zeoJfvcercxCVzt+01uziUXw/tPzv2WaQSjQtN3ELV8=;
        b=XD4oui09sRfStaB2BANOTH/NlGMhqzvzcyKa0qN7dNcKqLVr4aAdjEPOvnOu7gFXGQ
         7uTHYZZYBxmIJRUi1QWyCF39JmwVvW0hebc9V7auiF0YafOQupIup/Kg9456KrwAErdc
         P00pQIldrJhK2s2glU4SsKvUiGy6oEqzvwuQ5/biZlyOVq3g2pn3ZC1Dr9WpeIMU7VGO
         hgZsPr57cVsoSsYe/CSmnBKGyz0qCdBlqTJLw/6bmzUxGpkom0lzzMa4/jfUh5JXROdW
         heAUe2OzLTblU6GRfjh56rEhyuaEkv58MZcPj3yD2Kl5QO6g5J8Zj5GiHRNLv4itv1RO
         t3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694167507; x=1694772307;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeoJfvcercxCVzt+01uziUXw/tPzv2WaQSjQtN3ELV8=;
        b=IKNRcUs1D1GUscARxBKzEI93ALXNn+4jqZ7kM8KEgNzHcH42huqLgiD+prD6PkPwB4
         G6NfnixfMePqTPnwJuqonJq0Bs2+8vh7ndYs7cGeEnXnou6GuxrSYoyeggJKWbnp4zjs
         zWlWjDtLzJ3XCJ/zQQRjjb8qmASytLmemayu3nbsWlZUwsOwu6vbMIKZJ4YIuGYYH6vZ
         ZRnAdAsAEj4HbkE/xl1bDyki3m+DaAjGcC7OdwBPAhvHjzpTqXPtQnNqxzIlhEWLWLnP
         M3npDJw//wzwLfZcmf0DTkHnX9OHZLiPAKrykdF96DzTrNZfX2MM/Pq/E4EKsaZgZUoe
         B5cw==
X-Gm-Message-State: AOJu0Yzs7oyJwyHgApL0uiR1IK2pcqB5DGX2XHhmCCwTMJtuvonL6TRG
        Wdx7p1s9ZvYaCH7zngEGMpiIYSDP3Qg=
X-Google-Smtp-Source: AGHT+IEJjRx7xhFt48opDXeRuSK55jMqMfY+rWhwpKDFUeAfc2I4i3voIxNrkGGKQYWsn3HLVvYUCQ==
X-Received: by 2002:a05:6a21:6811:b0:140:61f8:53f6 with SMTP id wr17-20020a056a21681100b0014061f853f6mr1724122pzb.29.1694167506818;
        Fri, 08 Sep 2023 03:05:06 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.11.216])
        by smtp.gmail.com with ESMTPSA id d5-20020a63a705000000b005633311c70dsm860342pgf.32.2023.09.08.03.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 03:05:06 -0700 (PDT)
Message-ID: <64faf1d2.630a0220.96f2.180e@mx.google.com>
Date:   Fri, 08 Sep 2023 03:05:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1571818038762400268=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: Bluetooth: ISO: Set CIS bit only for devices with CIS support
In-Reply-To: <20230908091624.20040-2-vlad.pruteanu@nxp.com>
References: <20230908091624.20040-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1571818038762400268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782458

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      38.24 seconds
CheckAllWarning               PASS      42.30 seconds
CheckSparse                   PASS      47.58 seconds
CheckSmatch                   PASS      130.78 seconds
BuildKernel32                 PASS      37.53 seconds
TestRunnerSetup               PASS      572.71 seconds
TestRunner_l2cap-tester       PASS      32.25 seconds
TestRunner_iso-tester         PASS      68.79 seconds
TestRunner_bnep-tester        PASS      12.89 seconds
TestRunner_mgmt-tester        PASS      242.18 seconds
TestRunner_rfcomm-tester      PASS      19.26 seconds
TestRunner_sco-tester         PASS      22.68 seconds
TestRunner_ioctl-tester       PASS      21.84 seconds
TestRunner_mesh-tester        PASS      16.31 seconds
TestRunner_smp-tester         PASS      17.33 seconds
TestRunner_userchan-tester    PASS      13.54 seconds
IncrementalBuild              PASS      35.35 seconds



---
Regards,
Linux Bluetooth


--===============1571818038762400268==--
