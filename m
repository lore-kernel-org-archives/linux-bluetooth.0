Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EB2C64EC7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Feb 2023 05:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjB1F6C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 00:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjB1F6B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 00:58:01 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74965FD3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 21:57:59 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d7so9316907qtr.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 21:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677563879;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B/uK34moIbKHLmByHk+vIm/U/o+uKrgEd2iQXW7y1Z8=;
        b=Gymz2KqIJwu+O7JjHsktQffwFB+DHSt8PN2mh5+RBSSZzfQ48IMamvs5zE0bHjEZua
         tXHE4p6nnD2du8qqi3kX/AQ2aVUrtJFERn6JgbYnCZW04fBADqYl9Z17fdwsfaxuSH/D
         oFGRCv6z0K7BnegaB9KZC/NkWcU0xpw7VIcPgFuBvzLAjS3QXy91hFbaLaO+BqwpGE8b
         FTJ4NtqG6QTlatEBVtLtShu34G27mYXfrrqBe9droaY8wXRLrqH8wqm5TYWyCnHUqd41
         +zEDHPVHSJMaDjsfQ5R4y3U4SxnO33nVP7gw43gcL9hwdzqrHQEp+z9hyCi7HcATeL9c
         BPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677563879;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/uK34moIbKHLmByHk+vIm/U/o+uKrgEd2iQXW7y1Z8=;
        b=c6PhrWjXr4h2+urPlDDVe3p+m90fTsDaV9oetQAEA4iwCvaws2XjEFQkC6OMoZlvdX
         zJIZs4ubiaTp64n5KUkMEvrCvmMaNBJWQFFXaNAGQBTnUobjsWBFJLIZcmsGxFYSWGks
         aDkRYXiDTlH4041jAdH6xbZv5I3EcndEr9oB6CCFwt5Qi1X7RAeVBaTv1hUXswtdnERx
         RnJ0/GZW6wyS3dL4ZfSn/Tg00QOoH/KpX1KzWAeqhWxAqizTsPQ3ULFPwAwa9nQV5iNI
         GBvy49O/p+ZmeFBmdI952WucdFDK0uqTwiOkkuIHLeeebffKVJfwiJtKJCEsz1sPB457
         /xMw==
X-Gm-Message-State: AO0yUKVi9N62RI8xl+9y9bzZoZQbBN4fQuOjCFgglq+94Mv9ygHvvscB
        37PnuFM/tnl3Xc2gy7uU/QXdkCo4dIA=
X-Google-Smtp-Source: AK7set88OLTO+SogPOg3Lnfe3KTO500G/6GGUrEF6NbY36+H9dWXb5isKhwDEeuUcdI3VN2g7wcI0g==
X-Received: by 2002:a05:622a:1756:b0:3b9:b6e3:c78e with SMTP id l22-20020a05622a175600b003b9b6e3c78emr3584250qtk.8.1677563878700;
        Mon, 27 Feb 2023 21:57:58 -0800 (PST)
Received: from [172.17.0.2] ([104.45.204.177])
        by smtp.gmail.com with ESMTPSA id a3-20020ac844a3000000b003bfc335f124sm5970080qto.79.2023.02.27.21.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 21:57:58 -0800 (PST)
Message-ID: <63fd97e6.c80a0220.89c81.172c@mx.google.com>
Date:   Mon, 27 Feb 2023 21:57:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9010746262805398413=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tangmeng@uniontech.com
Subject: RE: [1/2] Bluetooth: btusb: Add new PID/VID 04ca:3801 for MT7633
In-Reply-To: <20230228051554.13501-1-tangmeng@uniontech.com>
References: <20230228051554.13501-1-tangmeng@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9010746262805398413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=725395

---Test result---

Test Summary:
CheckPatch                    PASS      1.38 seconds
GitLint                       PASS      0.67 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      31.73 seconds
CheckAllWarning               PASS      34.60 seconds
CheckSparse                   PASS      39.68 seconds
CheckSmatch                   PASS      107.12 seconds
BuildKernel32                 PASS      30.49 seconds
TestRunnerSetup               PASS      442.58 seconds
TestRunner_l2cap-tester       PASS      16.65 seconds
TestRunner_iso-tester         PASS      17.51 seconds
TestRunner_bnep-tester        PASS      5.70 seconds
TestRunner_mgmt-tester        PASS      112.63 seconds
TestRunner_rfcomm-tester      PASS      9.20 seconds
TestRunner_sco-tester         PASS      8.37 seconds
TestRunner_ioctl-tester       PASS      9.92 seconds
TestRunner_mesh-tester        PASS      7.31 seconds
TestRunner_smp-tester         PASS      8.36 seconds
TestRunner_userchan-tester    PASS      6.06 seconds
IncrementalBuild              PASS      34.41 seconds



---
Regards,
Linux Bluetooth


--===============9010746262805398413==--
