Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B201C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 07:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiKRHDa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 02:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiKRHD3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 02:03:29 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895B8B28
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:03:25 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id s4so2624998qtx.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CqaZxT1lsunvHIxrZbcHfyuYHd7+KerCSkjj1P3gg4E=;
        b=bhphLXnQeNLdizur5HRuGrtSY6usvv064hQEJ4h6eBJpY/8ZlbNwDjQqSrBAxpT071
         VapPrbTr4JyrBQ/f2p0lVWREhBposvtYp4TLw8wq3Fc+XyHRZAk7CbHiXy5ArqnmVoYH
         QsurQNs2pgYZbmnk2GmzyBSqlfTOtux1p6jO3B2NtE3xwFR68oo8gG9ahfj/KlumqhRq
         qTJp/cZmAbbSp4QabMFdl9FpWLUz4YjJVvzAvl6JxY8BN0v35TT5bTmxi9zn/sVrsgDY
         QNvt6OjCqyyt9ijlUpWbsQ/HWq3s1JkSfD3g4b7YxdIQ7r1Mho1GJaHYT9nkvoXXfn5G
         VRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqaZxT1lsunvHIxrZbcHfyuYHd7+KerCSkjj1P3gg4E=;
        b=BmM1hJF83rk7NlqF0h+KvzMzu/fLeJTmqlQWnSeEI8VovOv4X62YudMd7l4mZhjl/l
         OjN81T8w/8ya1F4aNsLLig52dMY2Jt+9YJ9GXUy+XoJg6TDwswW4/0Xw7aGjjGIendmC
         hFE+Gk9RB7kHKnbpwUAh5xAnxB6DsCIfywqr5NpS6xfzlNL2rgWZ3eaaOPqeVZidjhDi
         IkU6URpo2AZUOXZaOKhJV1wX6RhYZEgP5HT0uhcU6/8CSTBKvWpSPzNxbqrFlLIuMHoN
         smjXad7JsOZr1sAvhk4BeBepTm0YztOQuTycHJ1Pl+Asor9Co9BOJmhCINU/IxxeG53W
         meeA==
X-Gm-Message-State: ANoB5pkt2NoJKNtml1mRm1Hllhe1tNxMdyu7+1QslGxZMb97qGFJ1xRG
        Pgl0z8XylCK2uAKpYGT4PaDBgQDCDjHp4Q==
X-Google-Smtp-Source: AA0mqf7I/juzhH/vE3/96RccW6RhTfVgkt6zXAP7rC7/tYfyrIGY6aYRQKelXIKxLReYhkOkF7+Miw==
X-Received: by 2002:ac8:7303:0:b0:3a5:42f9:dddb with SMTP id x3-20020ac87303000000b003a542f9dddbmr5480988qto.212.1668755004575;
        Thu, 17 Nov 2022 23:03:24 -0800 (PST)
Received: from [172.17.0.2] ([20.15.121.228])
        by smtp.gmail.com with ESMTPSA id y12-20020a37f60c000000b006e8f8ca8287sm1822375qkj.120.2022.11.17.23.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:03:24 -0800 (PST)
Message-ID: <63772e3c.370a0220.5baa9.8a00@mx.google.com>
Date:   Thu, 17 Nov 2022 23:03:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3374515465815550632=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets.
In-Reply-To: <1668616931-21987-1-git-send-email-neeraj.sanjaykale@nxp.com>
References: <1668616931-21987-1-git-send-email-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3374515465815550632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695943

---Test result---

Test Summary:
CheckPatch                    PASS      2.53 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.99 seconds
BuildKernel32                 PASS      29.49 seconds
TestRunnerSetup               PASS      415.44 seconds
TestRunner_l2cap-tester       PASS      15.43 seconds
TestRunner_iso-tester         PASS      14.85 seconds
TestRunner_bnep-tester        PASS      5.24 seconds
TestRunner_mgmt-tester        PASS      103.18 seconds
TestRunner_rfcomm-tester      PASS      9.02 seconds
TestRunner_sco-tester         PASS      8.47 seconds
TestRunner_ioctl-tester       PASS      9.69 seconds
TestRunner_mesh-tester        PASS      6.75 seconds
TestRunner_smp-tester         PASS      8.36 seconds
TestRunner_userchan-tester    PASS      5.53 seconds
IncrementalBuild              PASS      30.63 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets.

1: T1 Title exceeds max length (96>80): "[v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets."
1: T3 Title has trailing punctuation (.): "[v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets."


---
Regards,
Linux Bluetooth


--===============3374515465815550632==--
