Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945A1C43217
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiKREeo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiKREel (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:34:41 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A9931F87
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:34:39 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id z9so2003032ilu.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+qkfNG2MsTZiycq3CYnym54BlGQeUFMnG2azRivUU3E=;
        b=l7X8Lh4zBidYjiGi8j93LFlvWNBpzcjMKOTvQCRnkd+3k/Jc8ZvDs8bHfEu0Vm62Hn
         kOiQggAoUF2rGLyJ5kD73Xp/FwcfY/MhPIAT8vp+X4w30LhdKH11nKUBrXPO/dbnNDuV
         aPf0FXXF3Wz4mHYaT+yqyU8iFEJOgCQioqLlbboGtqHEzZzQCwA90YQxdjjV/6FnJUi4
         qUEBl3O5YpgAt6VvQx0iUME6VoAAK6/nz2fhs0tw5KJOc/Nf0xiN1NApAYr5lNW+1vFT
         rb8kOeZbqfY8/RSJRClunYI/8oJzjQ4+m/Q5P/3UaVEdOtN2GhseVeeFCKn/KPA+SSsC
         bnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qkfNG2MsTZiycq3CYnym54BlGQeUFMnG2azRivUU3E=;
        b=rNm1ZrioIB3faBrRj12RvLQYKAEkb9KL3yTlGyNbB35bmPYu/Mgc0t5Q60G/PNlNu5
         OwazgjmciIJujrdAo++qaya8MkzdY3grwfbkZqWO8h7EK783gG2Vt5v2FqsiIwqcLKKW
         k1q0uTVC4yuN7IoauzwEvfMq5enQnIIx9GuvzH71xoorQiD6cnbjKGpBtE1EqyeI4OFo
         P0+dBRRZq+0wEJ1oe3zjUGyQz7rDKkJ5IQMfYY949T/kJ9saqiShNwtXE80z4QZzcnKK
         oP2HSC6JipeFJBrk5dEzMITxhuu4b2Ci/g95I5ziD5cw41sW74y6tWogecYQJczj7Kih
         /MdQ==
X-Gm-Message-State: ANoB5plV3WtOubRCqR69iJUmiI0TxikXfJXJJvFESHYWMJ46TimV9RVk
        90QXvLmZcMrJ+/lkq5+NrcUgY8D6SBg=
X-Google-Smtp-Source: AA0mqf5ipr92apds+LE1uxDRnvu9vZ+VnAJ7ggC5734i/y0tRRNL/99RlXQsC9+Jt789Z2LH/uy/qA==
X-Received: by 2002:a05:6e02:88e:b0:2ff:c490:cf9a with SMTP id z14-20020a056e02088e00b002ffc490cf9amr2586236ils.169.1668746078530;
        Thu, 17 Nov 2022 20:34:38 -0800 (PST)
Received: from [172.17.0.2] ([13.89.230.166])
        by smtp.gmail.com with ESMTPSA id a22-20020a027a16000000b00375664a365esm898704jac.1.2022.11.17.20.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:34:38 -0800 (PST)
Message-ID: <63770b5e.020a0220.62548.2056@mx.google.com>
Date:   Thu, 17 Nov 2022 20:34:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2700916522778024456=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Fix MSFT filter enable
In-Reply-To: <20221102175927.401091-2-brian.gix@intel.com>
References: <20221102175927.401091-2-brian.gix@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2700916522778024456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691340

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      33.44 seconds
BuildKernel32                 PASS      30.61 seconds
TestRunnerSetup               PASS      423.63 seconds
TestRunner_l2cap-tester       PASS      16.03 seconds
TestRunner_iso-tester         PASS      15.63 seconds
TestRunner_bnep-tester        PASS      5.53 seconds
TestRunner_mgmt-tester        PASS      107.12 seconds
TestRunner_rfcomm-tester      PASS      9.43 seconds
TestRunner_sco-tester         PASS      8.83 seconds
TestRunner_ioctl-tester       PASS      10.07 seconds
TestRunner_mesh-tester        PASS      6.99 seconds
TestRunner_smp-tester         PASS      8.69 seconds
TestRunner_userchan-tester    PASS      5.90 seconds
IncrementalBuild              PASS      31.78 seconds



---
Regards,
Linux Bluetooth


--===============2700916522778024456==--
