Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D63EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 07:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjGMHFm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 03:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjGMHFk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 03:05:40 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C3B119
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 00:05:39 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4009ea1597bso3659851cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 00:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689231938; x=1691823938;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OMdfoFuprUvOZ2X0a44YUTCir37PKJbm9EGskLT7k0s=;
        b=nefFQwxgqC9Gh3WmeZb+9ZOQcwItCzMy/vNspJ4xSHY1TLcyw2n4SADXMRbr7D1cUF
         9wxcEnNhzIZXmNp/ifH3Y+pJxMHAtlVYkF5Ha+GXlXUwsMoKHkWXkxTqfgheK4oNYBYQ
         1CIMK3+85F35hRq76sVuYCdRa/87grgmTYuG6N0jP6OyEJjwbTBxYnc/DYxl8DozPFBG
         rxqY7jlLcJ1eG/Sjlff6cZF7Lnw+NwbA5YS3tx5JHoDG6/bXKjiHGsdbv8OX+QwZROlM
         DfMXDCKPF0iym4iUwlqG+PhL9fDImtoS/iMh2rPvp5TK5oLpN8yGeXi44G/3DInY+mQg
         tQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689231938; x=1691823938;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMdfoFuprUvOZ2X0a44YUTCir37PKJbm9EGskLT7k0s=;
        b=JknvrW7LAF9N6q1C1oDtDq2sfGHTe9QnlNtANxzrdJuExuVJU0TgC7VSqPNkkxICNc
         Ongiz6TJvH387O+9Tbx7HtqdGwTb0f3a5TwB6cvOsbfuOi9m3xWdnUQMP3XRh2ZTUAAA
         o5YvY6evf4aH58H9EotDf+KFT2fF9434HdwZZ4Kvug3H9d7Ob3KRSivaul+UCagJA3Uk
         fgRsKfbxWAX6ucREDZmcf7BPAAf3D2np8tdrfGL1ouQISsRKdsD07Bhz5Zqy0dPIiarv
         nm78maF+1JWex0gzcqeTtnHilhYhF+21yg8nB+5JBzw2lhey67crP29c7ykyqh8GOI4n
         IH5Q==
X-Gm-Message-State: ABy/qLYJr843nA/y/NGQYd2v8LOkacvZUZvJh3X5B+ggg8m98K3dJyVW
        xPQgP9lrCX0wQN4tRorfyTOL7/KeVXM=
X-Google-Smtp-Source: APBJJlGHNzKLU5f936aKrlTPOGGAp6w5pSVIupqQS8PBBHs9dfpfNwImzUWgf9h8NFNdZuhQk4St9w==
X-Received: by 2002:a05:622a:1a1e:b0:400:9d1a:a8eb with SMTP id f30-20020a05622a1a1e00b004009d1aa8ebmr1146017qtb.15.1689231938198;
        Thu, 13 Jul 2023 00:05:38 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.122.113])
        by smtp.gmail.com with ESMTPSA id v26-20020ac8729a000000b004039a43ddbasm2870810qto.53.2023.07.13.00.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 00:05:37 -0700 (PDT)
Message-ID: <64afa241.c80a0220.e5142.ae16@mx.google.com>
Date:   Thu, 13 Jul 2023 00:05:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7725037105771066802=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v5] Bluetooth: btmtk: Fix kernel crash when processing coredump
In-Reply-To: <20230713061111.25232-1-chris.lu@mediatek.com>
References: <20230713061111.25232-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7725037105771066802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=765133

---Test result---

Test Summary:
CheckPatch                    FAIL      1.13 seconds
GitLint                       FAIL      0.56 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.89 seconds
CheckAllWarning               PASS      36.39 seconds
CheckSparse                   PASS      41.52 seconds
CheckSmatch                   PASS      111.85 seconds
BuildKernel32                 PASS      31.90 seconds
TestRunnerSetup               PASS      487.08 seconds
TestRunner_l2cap-tester       PASS      23.09 seconds
TestRunner_iso-tester         PASS      42.28 seconds
TestRunner_bnep-tester        PASS      10.73 seconds
TestRunner_mgmt-tester        PASS      216.56 seconds
TestRunner_rfcomm-tester      PASS      16.11 seconds
TestRunner_sco-tester         PASS      17.09 seconds
TestRunner_ioctl-tester       PASS      18.18 seconds
TestRunner_mesh-tester        PASS      13.56 seconds
TestRunner_smp-tester         PASS      14.35 seconds
TestRunner_userchan-tester    PASS      11.25 seconds
IncrementalBuild              PASS      30.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v5] Bluetooth: btmtk: Fix kernel crash when processing coredump
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#77: 
There may be a potential kernel crash risk if 'skb->len - MTK_COREDUMP_END_LEN'

total: 0 errors, 1 warnings, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13311347.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5] Bluetooth: btmtk: Fix kernel crash when processing coredump

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B1 Line exceeds max length (89>80): "[  215.021695] Unable to handle kernel paging request at virtual address ffffff939fffd3c5"
17: B1 Line exceeds max length (98>80): "[  215.021943] [ffffff939fffd3c5] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000"
19: B1 Line exceeds max length (82>80): "[  215.022496] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.186 #3 (HASH:ad23 4)"


---
Regards,
Linux Bluetooth


--===============7725037105771066802==--
