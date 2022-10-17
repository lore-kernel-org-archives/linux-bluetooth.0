Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27110C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Oct 2022 23:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJQXQF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Oct 2022 19:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJQXPz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Oct 2022 19:15:55 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCBB7284E
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 16:15:53 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d142so10423288iof.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 16:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xvvn3KyAnfdU/U5AwtDtUIaViTj9NHzWDl3vVXTAFEk=;
        b=oBQIW2WgqJcWVq9KNqOYkdJO/Fp7JioU31GS+ibVPPlh2RUIsn8C8QDX2G/UWXHMpf
         eI1XYaGUNheK2AEMqV3v3B/TccNi6njnobvn/wRofT8yrikcYee+X1SEQ6vvOHcz0BsD
         JduJnLzq/w1G0tDSJn2ngdr7huZuonsVeeJHeFelIIxg/oOtu5Qo5DlCsxUqcdBipU+g
         ge+lA+1OThj57ZDSeXwckNTNpVSs9J3wEPhbuqT0Ck9A93RGd2J15qNYCNGDd8xrcBh/
         xHKntQ6oL/caHznkROg3JKRzFlBeT2WtpJaRZxe5qkpGdF5+YCoRyXRI0lf0quzx7r2u
         7mMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvvn3KyAnfdU/U5AwtDtUIaViTj9NHzWDl3vVXTAFEk=;
        b=1Dg/2VCNQwYt6jTuejKmWo09TcGc6ngWRSe/oO/zVLRdAgkwkiCngffS1Ry5W2DeSP
         K322Yrq48BkqL3cte2h0A5gYW4QdRsPq1c1LjqhpjgkaT8dPaDsW99Vnss9Gj6/2mrmz
         iwyMDvptkNp3qp9Jwfjw8PkY8RckxjdNzkRaF9hm9ywBlc5M3To12g/0Mj91z4Rlh80u
         REbnNhSJL8ijKb81WlaT8iVuYdcfNSz/7McbnnhGPCAfTxYxMdeTNYmE9+mln0jbs7iQ
         sQCo2dFDc8wgjNpOiFYc/kAvHr13Wk/qPciKlosxUgQaLMjiBBjE40Nc94FFCqygmLKR
         lfmA==
X-Gm-Message-State: ACrzQf2TsBB+ozRss1RU30GOaAU5uYBrzhf/uWDP1wCi306cVyvWRuz/
        CpdN15zxe8R57mnxHJDwjZ78wrvL68ytjg==
X-Google-Smtp-Source: AMsMyM4C3HzEcSp5AbEdo2lkvFs9huIgqW8WqI8/56VozhL1oDSV4zIlwySm4qNnBlepBD1vMAk1iQ==
X-Received: by 2002:a6b:189:0:b0:6bb:ce8b:e947 with SMTP id 131-20020a6b0189000000b006bbce8be947mr217020iob.78.1666048552883;
        Mon, 17 Oct 2022 16:15:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.91.90])
        by smtp.gmail.com with ESMTPSA id g11-20020a02b70b000000b00363362cd476sm439545jam.101.2022.10.17.16.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 16:15:52 -0700 (PDT)
Message-ID: <634de228.020a0220.12608.155b@mx.google.com>
Date:   Mon, 17 Oct 2022 16:15:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0151547129941995889=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_conn: Fix not restoring ISO buffer count on disconnect
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221017224147.3629459-1-luiz.dentz@gmail.com>
References: <20221017224147.3629459-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0151547129941995889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=686004

---Test result---

Test Summary:
CheckPatch                    PASS      1.36 seconds
GitLint                       PASS      0.79 seconds
SubjectPrefix                 PASS      0.65 seconds
BuildKernel                   PASS      34.19 seconds
BuildKernel32                 PASS      30.08 seconds
Incremental Build with patchesPASS      42.19 seconds
TestRunner: Setup             PASS      507.77 seconds
TestRunner: l2cap-tester      PASS      17.15 seconds
TestRunner: iso-tester        PASS      15.95 seconds
TestRunner: bnep-tester       PASS      6.26 seconds
TestRunner: mgmt-tester       PASS      103.35 seconds
TestRunner: rfcomm-tester     PASS      10.05 seconds
TestRunner: sco-tester        PASS      9.43 seconds
TestRunner: ioctl-tester      PASS      10.72 seconds
TestRunner: mesh-tester       PASS      7.76 seconds
TestRunner: smp-tester        PASS      9.41 seconds
TestRunner: userchan-tester   PASS      6.51 seconds



---
Regards,
Linux Bluetooth


--===============0151547129941995889==--
