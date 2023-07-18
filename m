Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A30EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jul 2023 04:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGREhn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jul 2023 00:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGREhl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jul 2023 00:37:41 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604A7E52
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jul 2023 21:37:39 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a3a8d21208so4139838b6e.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jul 2023 21:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689655058; x=1692247058;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FAKdnMKzfFrh7mnGSOZxNCvccE5O9LjfBnQ7iOImGAg=;
        b=ZDrRBc25KT8KMvYqsp/Hhl2JWuc9Y98gKGizTlBectA2ZDiB1aSNmipog7QvMDAm6p
         fmipj6r7zYBemQFk6N9nvOVkCCReY+JCe92iNBJreMc3MXLX4XgdI8rBKAI6vgrY/g6S
         4eu9tJrSDaevgro6Tuy17Hqoyd5HHI0OxLFIKlVkcFGXg6d3nRNegep03cmiil0DY9u6
         HE+trAbTEPx+E4mlG/JnJWk286560uCpycdvtNNE66yAyKTU2xYBV6PxKGg+xQXbaNhs
         nOpbFflnBf7pLkAuupMRXPzHODNJ6k8YgD5DZgVK+b+1JbRWuvfaR8Hx3EXYDBNxT2jh
         pPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689655058; x=1692247058;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAKdnMKzfFrh7mnGSOZxNCvccE5O9LjfBnQ7iOImGAg=;
        b=cGA84qSubpAbyFtV3LIoB6AyhgManONc58UwabJ7lDbUO+zzAbZ0a1UpNJeN/yGQCf
         sLli3wdh6Fhd7FfAQ2Gdc8IMtE4A/untibmYxis4eCzVh1kcn9ewChYAcFxEdMnz+9XY
         C4QM4wUJvD+Iz5RAkX4nQHrksAWE88jllJP2Pp1eyHywUo0/U4mWsRGBl9snraZ1PBQn
         NN8bQ9ZpCeAcTlNQyBnOAJR9xjShgILNrmZNYf7XUUSdfsRJBZIMvukeMF+mBbqNhT+k
         C+2tvmMwobJeBhEqHFCir1YCrL9jO5wZ1JAzUjVcmH1AZXnAKA30LtzemaI+rACveet+
         JieA==
X-Gm-Message-State: ABy/qLbm2dvPGVp9zDtfiLdGC2M4ApLwEuyIyGE74h5MF3ZVerl8DZ6I
        FAXuHXD28OohoBvssL2E+2MYxJpnZXY=
X-Google-Smtp-Source: APBJJlHRTQvZiMm30WmdON0tIcxgJE1atAgjiD2DZgswaqK2/+vx2mhckarLVJto2/vl+BDP8Zy6jg==
X-Received: by 2002:a05:6808:220d:b0:3a4:30fb:58e9 with SMTP id bd13-20020a056808220d00b003a430fb58e9mr17142790oib.56.1689655058501;
        Mon, 17 Jul 2023 21:37:38 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.177.2])
        by smtp.gmail.com with ESMTPSA id 16-20020aca2110000000b003a43759b9cdsm410697oiz.29.2023.07.17.21.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 21:37:38 -0700 (PDT)
Message-ID: <64b61712.ca0a0220.c14da.2944@mx.google.com>
Date:   Mon, 17 Jul 2023 21:37:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7152757112264966062=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, joeyli.kernel@gmail.com
Subject: RE: [v2] Bluetooth: hci_event: Ignore NULL link key
In-Reply-To: <20230718034337.23502-1-jlee@suse.com>
References: <20230718034337.23502-1-jlee@suse.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7152757112264966062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=766763

---Test result---

Test Summary:
CheckPatch                    FAIL      0.81 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      32.47 seconds
CheckAllWarning               PASS      35.57 seconds
CheckSparse                   WARNING   40.49 seconds
CheckSmatch                   WARNING   111.98 seconds
BuildKernel32                 PASS      31.15 seconds
TestRunnerSetup               PASS      476.51 seconds
TestRunner_l2cap-tester       PASS      22.02 seconds
TestRunner_iso-tester         PASS      40.00 seconds
TestRunner_bnep-tester        PASS      10.08 seconds
TestRunner_mgmt-tester        PASS      211.97 seconds
TestRunner_rfcomm-tester      PASS      15.18 seconds
TestRunner_sco-tester         PASS      16.01 seconds
TestRunner_ioctl-tester       PASS      16.96 seconds
TestRunner_mesh-tester        PASS      12.81 seconds
TestRunner_smp-tester         PASS      13.44 seconds
TestRunner_userchan-tester    PASS      10.61 seconds
IncrementalBuild              PASS      29.63 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: hci_event: Ignore NULL link key
WARNING: From:/Signed-off-by: email address mismatch: 'From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>' != 'Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>'

total: 0 errors, 1 warnings, 0 checks, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13316718.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============7152757112264966062==--
