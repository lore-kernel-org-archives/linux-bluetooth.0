Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE8CEE49A5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 00:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjHWAFp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 20:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjHWAFo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 20:05:44 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBD5133
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 17:05:42 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4108974d60aso17570811cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 17:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692749142; x=1693353942;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qygBRis/ojKWaq6YYsZPDyAwrqPzJ8IQfPbR7XdGaB8=;
        b=FHcFyg4RsZPLQxul93Yph4BdS0sdQX603olC+MHXGZJwgGx3dSqyQgivqwWGc37o4L
         dsH6SrVJp3cWCSVpW/ENI0NrskOndRn+X/nNIYf/glnhvqAQNtpjLf96zXtoEc6soY1B
         pIYt2R/vhtAGk+7OeqHNqdOqTWj3O/3JJc9axXFIc0ligzAiSyy5lBJzVohF4yknhdPf
         csDXv9zKQXUJtoWwEk5wDs2DLHMhajyib3pAMyvfSnSa7aF0hPpiQy7vzQEnN4Gduhg/
         Sky8EE8cWyNT5kbEZa/+BS1c8Jy/msjJheh+r+bAF8m7wim5CNh5ktCOtpCy1ifj/M2W
         xvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692749142; x=1693353942;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qygBRis/ojKWaq6YYsZPDyAwrqPzJ8IQfPbR7XdGaB8=;
        b=XpFXxOE3kmUCzdiys9o5MdMAvs52ruPq1PEeLJEuJp6C5ceeuW7Wm4MUoNi58GKUH6
         x+z6xuQqKXHliyz454weEE3MuRWdZ64yc2Aj1c5q+orXLRmS3AjwB8gct4F/o+QxmHds
         izJF5kY92cW2J8C+mdgiORnCBMyLdpJXzb2vCfAU+uxN30t4HJgk586KRoncaIq1Cjpi
         s5+7pnK/bQzlTOgK/lGlAhaN6EULtmuvPYGVVMVH5s5GhuNmdIzpGnSV1MyZ3yOu1f+k
         Fq7rl1vkY4Gkhi/in1oMNcbsT9zEAXIlE/8nPqy11nCGRNkm0k+G4sJXAAvmoH/4KaWe
         ok1A==
X-Gm-Message-State: AOJu0Yzh0tZuCWgH/84W9QMBqN420WteNa9K12Hg2pENjZP/vKJWK0ty
        e788kTpIjNLIqdMOeR42SxhfEpdKt1o=
X-Google-Smtp-Source: AGHT+IFJXsrIqRtVC8dQp8aWwpNxhjAyQBQM0aetinXs1ik3y8tByL4tdIsepZ297mxZ9s+nwjTIrQ==
X-Received: by 2002:ac8:7f95:0:b0:403:a662:a3c1 with SMTP id z21-20020ac87f95000000b00403a662a3c1mr14716471qtj.29.1692749141745;
        Tue, 22 Aug 2023 17:05:41 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.66])
        by smtp.gmail.com with ESMTPSA id hz6-20020a05622a678600b0040f8ac751a5sm3317577qtb.96.2023.08.22.17.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 17:05:41 -0700 (PDT)
Message-ID: <64e54d55.050a0220.31b08.e540@mx.google.com>
Date:   Tue, 22 Aug 2023 17:05:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4977407545143399890=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
In-Reply-To: <20230822232340.3780478-1-luiz.dentz@gmail.com>
References: <20230822232340.3780478-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4977407545143399890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=778385

---Test result---

Test Summary:
CheckPatch                    FAIL      1.59 seconds
GitLint                       FAIL      0.58 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      42.38 seconds
CheckAllWarning               PASS      43.33 seconds
CheckSparse                   PASS      47.76 seconds
CheckSmatch                   PASS      132.12 seconds
BuildKernel32                 PASS      37.90 seconds
TestRunnerSetup               PASS      588.26 seconds
TestRunner_l2cap-tester       PASS      34.75 seconds
TestRunner_iso-tester         PASS      73.94 seconds
TestRunner_bnep-tester        PASS      14.30 seconds
TestRunner_mgmt-tester        PASS      271.92 seconds
TestRunner_rfcomm-tester      PASS      20.80 seconds
TestRunner_sco-tester         PASS      24.33 seconds
TestRunner_ioctl-tester       PASS      23.27 seconds
TestRunner_mesh-tester        PASS      17.40 seconds
TestRunner_smp-tester         PASS      18.49 seconds
TestRunner_userchan-tester    PASS      14.45 seconds
IncrementalBuild              PASS      36.60 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
WARNING: quoted string split across lines
#166: FILE: net/bluetooth/hci_sync.c:4671:
 			 "HCI LE Set Random Private Address Timeout command is "
+			 "advertised, but not supported."),

WARNING: quoted string split across lines
#169: FILE: net/bluetooth/hci_sync.c:4674:
+			 "HCI LE Coded PHY feature bit is set, "
+			 "but its usage is not supported.")

total: 0 errors, 2 warnings, 0 checks, 55 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13361520.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (116>80): "Link: https://lore.kernel.org/linux-bluetooth/CABBYNZKco-v7wkjHHexxQbgwwSz-S=GZ=dZKbRE1qxT1h4fFbQ@mail.gmail.com/T/#"


---
Regards,
Linux Bluetooth


--===============4977407545143399890==--
