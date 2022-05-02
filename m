Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA562C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 May 2022 11:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiEBLLI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 May 2022 07:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384672AbiEBLK7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 May 2022 07:10:59 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0703D1EC53
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 May 2022 04:07:28 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 126so10111536qkm.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 May 2022 04:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CWQDniP/f7Ql7RrcXP1P1hi8YGgZSLwWc8r5PyE/O2c=;
        b=TCoSm+w+9zj0iNMdiZFXt3d5LsG0nkuis6iAMczo2qsPZwRcP6h+HkX1ImSeQwrVYA
         Fd5YIMMMHivB714jxDcIkFYZAZzuh7bSqE1O49dSvOHnwlJtUY2oTb4xEVP4keKysjWZ
         uWPfz3rimNGnGUkR4PX55KYSaV2iZCSYiBpc0jyxpu3D83ajhUxawb1cP0t6JIN5bxIH
         5swoACtB8vcinqEkhE370Mzt2+Su0AEqY7l+NG/rCqFGJSp/ocIGMjDOAYRCIj77aXNe
         hqlOg4FSXoVNv3wd5zrgZJsa3DzPukOI5OS0MfeOos1nnsPYAWtNo1ndhLyiPVrKgyrO
         xj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CWQDniP/f7Ql7RrcXP1P1hi8YGgZSLwWc8r5PyE/O2c=;
        b=Bozz5XXJjcngNT+yFSOnc+KCjlhYpnlEN/qnl59Q9y28HMj4nTH1I4iPMzKxCzO7Eg
         STuxjGu+A1lC22c3tv/rz5nXq6lOxEx7FItIooTKwvdElT9sPW/uaSPFYAntyBFO7cmE
         cn3lEJjB4hp1ymtn0WVf3zypufNbILXv74XhfHjM0bhHzZqbfVkVvEMHe6deDurDqil1
         kI5RwAkeQRhlmtcFHgTY+luUCPXNdTRswoohu3nZm7jZze+UCN5bNUBb0VQhlFqqA+47
         hVojRMkQjW2N9z2jqsJfhjQY2MEtV79vJbcTZNyawlHCG1Lrnfv0wQvkrXBODtHhPg7y
         xP9g==
X-Gm-Message-State: AOAM533fFS9c6TByv0fWalXHhs8u8ie3Q8E++HnhysdHfEHo/OZYeTSu
        qhbcHN8ZQa/9LGlTsQNMcWxQLoXxVKWMrg==
X-Google-Smtp-Source: ABdhPJw8Jk5pogusa5LCjX43jDTOmXkOLTVaT7i6+ptpdh9my0LLAjwGgCL2/DxPlWOkIewLDgxwYw==
X-Received: by 2002:a37:68d4:0:b0:60d:f4eb:fc12 with SMTP id d203-20020a3768d4000000b0060df4ebfc12mr7848276qkc.413.1651489646910;
        Mon, 02 May 2022 04:07:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.17.195])
        by smtp.gmail.com with ESMTPSA id a7-20020a05620a124700b0069fc13ce211sm4020527qkl.66.2022.05.02.04.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 04:07:26 -0700 (PDT)
Message-ID: <626fbb6e.1c69fb81.bb318.168c@mx.google.com>
Date:   Mon, 02 May 2022 04:07:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1040842405078567746=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_saluvala@quicinc.com
Subject: RE: [v1] Bluetooth: hci_qca: Return wakeup for qca_wakeup
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1651487048-30298-1-git-send-email-quic_saluvala@quicinc.com>
References: <1651487048-30298-1-git-send-email-quic_saluvala@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1040842405078567746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=637536

---Test result---

Test Summary:
CheckPatch                    PASS      1.69 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      35.22 seconds
BuildKernel32                 PASS      30.54 seconds
Incremental Build with patchesPASS      42.68 seconds
TestRunner: Setup             PASS      517.97 seconds
TestRunner: l2cap-tester      PASS      17.84 seconds
TestRunner: bnep-tester       PASS      6.46 seconds
TestRunner: mgmt-tester       PASS      104.54 seconds
TestRunner: rfcomm-tester     PASS      10.14 seconds
TestRunner: sco-tester        PASS      9.74 seconds
TestRunner: smp-tester        PASS      10.04 seconds
TestRunner: userchan-tester   PASS      6.65 seconds



---
Regards,
Linux Bluetooth


--===============1040842405078567746==--
