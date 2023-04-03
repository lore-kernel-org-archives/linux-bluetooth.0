Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA84C76196
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Apr 2023 13:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjDCNN6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 09:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjDCNNz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 09:13:55 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5A03A82
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 06:13:42 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id cn12so24858812qtb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Apr 2023 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680527622;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cXfyGVRe7Weu9tUpWx+iwcP8hh7jwFwYSvNN8389mrg=;
        b=j73BUWEH/u5DWVq35WJexvtxdOP69WhiQK39LIdShWJXuMytnpO3fV+5UdY+jG5JNh
         c9ERbe7zydnZzOeYDqgajIpJeCYBuec8/mLPSD5PG0kmEoKa0tiVShxcRPdJkyNfhyyg
         HrVmlsFf308Te0aLcBeONkAcrVGoCz1s26n/WDaJTnusGbQq3F3CTJJ210d5S2Vy+VHl
         XQlUnNAXdR9L52Qu9G6hffYfjys46wmur4fkpiChjZXZuB6ji0TovFztGBjv7ZA4Mn7P
         GEPCMNlPo+C8TGPIXYMH2Idjnj7jIf0oxQlzHNkjlSOXNzE2pbzyZDvfczlayq7Ve6Ad
         tmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680527622;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXfyGVRe7Weu9tUpWx+iwcP8hh7jwFwYSvNN8389mrg=;
        b=ZM44oT2xHKo52VSsehP/OSBJvvJ3hbcEpEDJj8BT1J9v3S3aekwABoaCoWZZSgszOM
         4igXP37mw8PBoq8Vk/1dndyTKIq+NnOdxflahHIrt0bKCqs0MYnr6FKssjhbmDNc1l02
         CalmW37sPf5L6zOD6fm/MYFtMhQPupFMk7+JR7uTlCbbEyhqDuA99ea1uqmT1bwl9L7O
         Y33MArPu8kmW54mgGVnDrS12nbMLfhsHIhjnlKtMEH6JHQfUmatNPOVTrGF/vC8jF6ip
         eHLRNl0Y8WaMi0QBbLCjXgapbtMJzhC7/b5zT1+v8djYVHjN4bq2ccXd4ZHLzp6eDrsU
         /CCQ==
X-Gm-Message-State: AAQBX9fj5d0Y5z/bldhhA36+ymQrfHpxmr7XsbmO+L44RvydpCuvIbtO
        EOpveDnUH2OH1ZupTSR6VY3voabBz9g=
X-Google-Smtp-Source: AKy350ZtBqeEJogUYGlGtn46PJoUjwcBoWdupMW8OvY/GlZsT8pOMot8C2/ORe6sUqlKj6P7Pgx8hA==
X-Received: by 2002:ac8:570c:0:b0:3e4:e66e:44d1 with SMTP id 12-20020ac8570c000000b003e4e66e44d1mr44692102qtw.62.1680527621698;
        Mon, 03 Apr 2023 06:13:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.13.58])
        by smtp.gmail.com with ESMTPSA id k19-20020ac84753000000b003dffd3d3df5sm2534592qtp.2.2023.04.03.06.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:13:41 -0700 (PDT)
Message-ID: <642ad105.c80a0220.21214.94c1@mx.google.com>
Date:   Mon, 03 Apr 2023 06:13:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7317048510052419403=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: No need to check the received bootloader signature
In-Reply-To: <20230403122430.1024235-4-neeraj.sanjaykale@nxp.com>
References: <20230403122430.1024235-4-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7317048510052419403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=736377

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.81 seconds
CheckAllWarning               PASS      34.70 seconds
CheckSparse                   PASS      39.50 seconds
CheckSmatch                   PASS      109.03 seconds
BuildKernel32                 PASS      30.76 seconds
TestRunnerSetup               PASS      441.63 seconds
TestRunner_l2cap-tester       PASS      16.19 seconds
TestRunner_iso-tester         PASS      16.28 seconds
TestRunner_bnep-tester        PASS      5.38 seconds
TestRunner_mgmt-tester        PASS      110.72 seconds
TestRunner_rfcomm-tester      PASS      8.58 seconds
TestRunner_sco-tester         PASS      7.85 seconds
TestRunner_ioctl-tester       PASS      9.13 seconds
TestRunner_mesh-tester        PASS      6.73 seconds
TestRunner_smp-tester         PASS      7.77 seconds
TestRunner_userchan-tester    PASS      5.68 seconds
IncrementalBuild              PASS      29.60 seconds



---
Regards,
Linux Bluetooth


--===============7317048510052419403==--
