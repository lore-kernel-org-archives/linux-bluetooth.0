Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84626EE4993
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Aug 2023 14:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjHSOEB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Aug 2023 10:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjHSOEA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Aug 2023 10:04:00 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EBB1FD3F
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Aug 2023 07:01:02 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-34bbb4b580eso4415195ab.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Aug 2023 07:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692453662; x=1693058462;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=COFgzixuOJIuy68/Rg4P175rZi0v69cR3YnIJKdv1s4=;
        b=fuHA+wE8zYUnYNEpPdSpnMDq08oc2PwADdsejt8fbV7fIrIvbKm23+GpMjg2Wblr3M
         VSorZuQw7kJY2kf0yAdMTXT7ahdyYADZl5XQWvR8dR/Em4t3N7i9SWXbqikdJs+XiSF5
         Y5HVVHq7fWgqT+yFXRdUNUKK1/wkQdyv9wwd5Y7rA0D8ywGil7+nV/jyJ/2pArwKjXqf
         miqxD07PvGYEjcI00hAgi1UtXbBOstCmOWhN1R20pUdqXjjyox1VfttBYDxOi/X1ibbs
         noaNNV+2V1FYtVmGc9P1JTcU/c1I2D3mmNkXYDAIe9ajjLR4N4FZeYCK5ycP7JxkJ9Xh
         6ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692453662; x=1693058462;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COFgzixuOJIuy68/Rg4P175rZi0v69cR3YnIJKdv1s4=;
        b=c2gkeCTmA60vlEX+XW8VFzA5QSAYzN2UWnxP4lAb6i53XpQ1WiGx4L8+ODJ57OJFvC
         G+r3pjkNbyS08gu9cHA5sY1748s4mOdQyMcTBeURhY6RaJLN130ztvFfjAW8DKezd4M7
         NOWJjrbEt+HYF0NNrDQWfkDJPVA1D3Xk7p+cvO6uXURN/ndyErHWyUU3esMX+TfBTc7s
         7RucUpvKGoaD/69QLUc4GUPnxAOJekkygxGaUPbz6BMFaQeYRPNEr6zS5bPObJ1LM0sR
         GcyymFVFvge0ntRr9AdsNsMIwYeLRX0KN57oIXJ+bqgAJBN/++lqhALNhr4DnToLPfXI
         htGg==
X-Gm-Message-State: AOJu0Yxq/2LZe2tmNwHNJQpObEOMtPSxhBuCG07BmphRQ9ooOJuFegZt
        d/Zb5dswZd2UBU/KVpp9CrrSaqR7zz8=
X-Google-Smtp-Source: AGHT+IHrCiU2uinGoE8KOq5CZCptHlnv2EdhVOPm3t5BgPoPqrOPNPniAyr7C3R2U+DhvmjBmDJR0w==
X-Received: by 2002:a05:6e02:1d0d:b0:34b:b024:a07c with SMTP id i13-20020a056e021d0d00b0034bb024a07cmr3634973ila.5.1692453661762;
        Sat, 19 Aug 2023 07:01:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.134.161])
        by smtp.gmail.com with ESMTPSA id m25-20020a638c19000000b00565d46c5ca2sm3369153pgd.27.2023.08.19.07.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 07:01:01 -0700 (PDT)
Message-ID: <64e0cb1d.630a0220.82761.6336@mx.google.com>
Date:   Sat, 19 Aug 2023 07:01:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5637768382296996348=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_conn: fail SCO/ISO via hci_conn_failed if ACL gone early
In-Reply-To: <d5aebbd4337291708c970380fa947a0fe1767cd5.1692451565.git.pav@iki.fi>
References: <d5aebbd4337291708c970380fa947a0fe1767cd5.1692451565.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5637768382296996348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=777636

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       FAIL      0.55 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.33 seconds
CheckAllWarning               PASS      35.45 seconds
CheckSparse                   PASS      42.21 seconds
CheckSmatch                   PASS      113.36 seconds
BuildKernel32                 PASS      31.27 seconds
TestRunnerSetup               PASS      478.83 seconds
TestRunner_l2cap-tester       PASS      27.54 seconds
TestRunner_iso-tester         PASS      48.19 seconds
TestRunner_bnep-tester        PASS      10.63 seconds
TestRunner_mgmt-tester        PASS      216.22 seconds
TestRunner_rfcomm-tester      PASS      16.10 seconds
TestRunner_sco-tester         PASS      19.05 seconds
TestRunner_ioctl-tester       PASS      17.97 seconds
TestRunner_mesh-tester        PASS      13.37 seconds
TestRunner_smp-tester         PASS      14.33 seconds
TestRunner_userchan-tester    PASS      11.15 seconds
IncrementalBuild              PASS      29.72 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_conn: fail SCO/ISO via hci_conn_failed if ACL gone early

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
14: B1 Line exceeds max length (88>80): "Closes: https://lore.kernel.org/linux-bluetooth/00000000000013b93805fbbadc50@google.com/"
21: B1 Line exceeds max length (83>80): "    ISO Connect ACL Disconnect - Failure                 Passed       1.004 seconds"
22: B1 Line exceeds max length (83>80): "    eSCO ACL Disconnect - Failure                        Passed       0.987 seconds"


---
Regards,
Linux Bluetooth


--===============5637768382296996348==--
