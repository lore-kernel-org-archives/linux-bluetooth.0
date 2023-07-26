Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98746C001DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 06:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjGZGAK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 02:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjGZGAJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 02:00:09 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92133170D
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 23:00:07 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7672073e7b9so446328085a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 23:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690351206; x=1690956006;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IcPMgcwR+w/DTCG5EMV5LuLFh/kEpmG7JkI76l/RYJQ=;
        b=YeXE2wOExbO6T84bx5NVOlesb3H2+aEZVyxASBft0BSJROHml8MC8y7Pwd1AuoP93+
         f3+hxxhHZdHfwTDPvm5qBP8kDzNwH28Ii3R+akwug0615cZGI6Y+dAzVDerVlpblAPyc
         CfT/uNlvohx+SqQyrYdUL52atR/Qilwyfub34YRCFgJBa57adnEvS0MWRFPB/UYdy4cx
         Vnuq+Ep5Zi+YBaDDWUbBB3CeggUO8p7j96QSrZ1qcXh1WpECE/jiU/1xc8At2vBre0YU
         /fBSgMRL5hUQ7z5P3nC1w0gVRJ+KO7+viDcOFflNWXTNiqPoyg9TGo0c8mcQ4e+k6++E
         4VsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690351206; x=1690956006;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcPMgcwR+w/DTCG5EMV5LuLFh/kEpmG7JkI76l/RYJQ=;
        b=ToTI5UkM/jH/rxtaeSYvuAE1q9Hax1D5KxInXCrYf+RrJYbCha0ZMTS5bGKYGom9QT
         PQto1SLrGMjVOMMXheGMqkbnHxU9XniBXzmiTlXgMUQ0jZ9GeWzlzGoG1izpzAoBdgvC
         Gu6lAtJaegkiCS8mInle0dNfUVtyqYU8DlS13LyeKPKuTlXLHDpWLMvGs4FKVkIj4Co2
         QCh/5Z+34cj1uKTc0mpCpP2RLre/asUY8P6/ewpZXt6nknPNZGW0SebgwsyEp/9lM4yR
         Y1VRuCp4YCYTO4DSUJ9lDlr5QkAh5wHpx3LR6mzKDAvmlwiJlqQp9T7xwIhxYlnDK0YV
         yTWQ==
X-Gm-Message-State: ABy/qLbU8Y59o5JLUkp7K/ABgZbuchJKwptZKxPQ+7wI8LlHzGigSt+0
        hibdL24jNnkQ6jI9dsu3GT0BH/mczSY=
X-Google-Smtp-Source: APBJJlHQ3vqCPdKJ6UMr3OqbcDVlBszu9jTGnEJtvOu4GnCDWxlkB9IYkFpHUuo7iKaESjWLpYcWlw==
X-Received: by 2002:a0c:ee63:0:b0:63d:1f89:7697 with SMTP id n3-20020a0cee63000000b0063d1f897697mr841095qvs.54.1690351206463;
        Tue, 25 Jul 2023 23:00:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.188.91])
        by smtp.gmail.com with ESMTPSA id t10-20020a0cde0a000000b00636064e3d2bsm373606qvk.106.2023.07.25.23.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 23:00:06 -0700 (PDT)
Message-ID: <64c0b666.0c0a0220.34fe1.1d04@mx.google.com>
Date:   Tue, 25 Jul 2023 23:00:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5350366956852322404=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
In-Reply-To: <20230726052245.609987-2-quic_tjiang@quicinc.com>
References: <20230726052245.609987-2-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5350366956852322404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=769552

---Test result---

Test Summary:
CheckPatch                    PASS      1.95 seconds
GitLint                       PASS      0.67 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      32.64 seconds
CheckAllWarning               PASS      35.17 seconds
CheckSparse                   PASS      39.99 seconds
CheckSmatch                   PASS      112.03 seconds
BuildKernel32                 PASS      31.03 seconds
TestRunnerSetup               PASS      472.71 seconds
TestRunner_l2cap-tester       PASS      22.10 seconds
TestRunner_iso-tester         PASS      41.97 seconds
TestRunner_bnep-tester        PASS      10.03 seconds
TestRunner_mgmt-tester        PASS      212.34 seconds
TestRunner_rfcomm-tester      PASS      15.17 seconds
TestRunner_sco-tester         PASS      16.02 seconds
TestRunner_ioctl-tester       PASS      16.94 seconds
TestRunner_mesh-tester        PASS      12.66 seconds
TestRunner_smp-tester         PASS      13.54 seconds
TestRunner_userchan-tester    PASS      10.46 seconds
IncrementalBuild              PASS      34.50 seconds



---
Regards,
Linux Bluetooth


--===============5350366956852322404==--
