Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B9DC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 01:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjEYBMD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 May 2023 21:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjEYBMC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 May 2023 21:12:02 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30019E6
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 18:12:01 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-75b0830e2eeso20506385a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 18:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684977120; x=1687569120;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qC3LFGwrGeDlX7D40M6z+e+ZsJ4iyFoBmQ6Y6rXrinM=;
        b=nVaTsSXFSUc7lXRmGzrgYOgLECkb8CxDPJ6BKnKbt7EdbmG0mv2+ci9ELkTVu7bkHx
         ZnnJU3TVDVMmk/oa3iHjKurlxEv///ujGrCVVls0eD4/CyzxHYsRtP5SyztMGcwdCEwa
         3CS0x1kxP+4hmjFnAGEiL8Bvw21+DJtMSL0DWLawFiunHwAl719ChugLhfFQIU5JgK+p
         k+Lgeb4i4hI92xqCgaODFlH3ThGb37mfPdlIvLmN68trDJxFTHSXIDZ2iEpCqU3VYAYL
         saHoOIs5ttI71IdMt58PWtLo6y0CI7UG8gyIQel9ZT8ZgK0JRYz+joPukcJwQ0S2Es41
         fZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684977120; x=1687569120;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qC3LFGwrGeDlX7D40M6z+e+ZsJ4iyFoBmQ6Y6rXrinM=;
        b=SZiDQisIr+xwyCvQKljxO5wcAbbe7/BthasafrRNgeYr8auCozy2LDI7AyPbES3PW4
         lK8iwoa912p4EQrCsRVcw68Mj280ygtVcvhmoXSTj6IqT4btpbvbGmlb7lpPDJmB5fjb
         0iHBGFIO6jp9Tjz0uaPSQdvvO+ZTX1pu/ch16sAUOKxkoQN8blFhyHMhppXu+hUsYP8D
         lne6NO/irQdl5PXFzykXmfIYqD978JPUCths/sfwyKVzFbVynjTITIJ4tyBYtPZ6znyF
         QFpcVFeejWxrs6g6KsbxLUtPFFGhHQj5hUwui2jsYEbM1diVl8CLb7VGhsDsfs3tJCYt
         EbFw==
X-Gm-Message-State: AC+VfDwXLZOTRk+stSR0AVOB3PQREo3RiD9TN1cp0KA+qiXiFuyOFjKX
        GmyCATyXm+h432/5nZCHcnmMT+zTt3c=
X-Google-Smtp-Source: ACHHUZ4eWMkPP8aLgN1gA5XaFeHr5dI0rmn3gZQkyJSWpF/ZTZrgdCzcKsAIrcXAeqV/gueZzgAMqg==
X-Received: by 2002:a05:620a:4806:b0:75b:23a1:d849 with SMTP id eb6-20020a05620a480600b0075b23a1d849mr1360429qkb.11.1684977120190;
        Wed, 24 May 2023 18:12:00 -0700 (PDT)
Received: from [172.17.0.2] ([52.184.138.39])
        by smtp.gmail.com with ESMTPSA id k25-20020a05620a139900b0074def53eca5sm20657qki.53.2023.05.24.18.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 18:12:00 -0700 (PDT)
Message-ID: <646eb5e0.050a0220.8baf5.00dc@mx.google.com>
Date:   Wed, 24 May 2023 18:12:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6347565569703387435=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: [kernel,v1] Bluetooth: hci_sync: add lock to protect HCI_UNREGISTER
In-Reply-To: <20230524171158.kernel.v1.1.Ie9c81a5f8bbdb4f9a2007c56f05001d7e674dbe0@changeid>
References: <20230524171158.kernel.v1.1.Ie9c81a5f8bbdb4f9a2007c56f05001d7e674dbe0@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6347565569703387435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=750829

---Test result---

Test Summary:
CheckPatch                    PASS      1.07 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      33.07 seconds
CheckAllWarning               PASS      34.78 seconds
CheckSparse                   PASS      39.17 seconds
CheckSmatch                   PASS      110.97 seconds
BuildKernel32                 PASS      31.36 seconds
TestRunnerSetup               PASS      442.40 seconds
TestRunner_l2cap-tester       PASS      16.63 seconds
TestRunner_iso-tester         PASS      21.83 seconds
TestRunner_bnep-tester        PASS      5.45 seconds
TestRunner_mgmt-tester        PASS      112.10 seconds
TestRunner_rfcomm-tester      PASS      8.59 seconds
TestRunner_sco-tester         PASS      7.94 seconds
TestRunner_ioctl-tester       PASS      9.20 seconds
TestRunner_mesh-tester        PASS      6.81 seconds
TestRunner_smp-tester         PASS      7.90 seconds
TestRunner_userchan-tester    PASS      5.70 seconds
IncrementalBuild              PASS      29.21 seconds



---
Regards,
Linux Bluetooth


--===============6347565569703387435==--
