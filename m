Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757E4CD68ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 06:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442286AbjJJGoD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 02:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442277AbjJJGoC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 02:44:02 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3507197
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 23:44:00 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3ae5ee80c0dso3666996b6e.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 23:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696920239; x=1697525039; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ADu43iqAxgWCGQoWay232KiF4mHTKPSjpTOb9DmMVRo=;
        b=kNMjotEdcOKIj+b/VqtMDl9AH50u+cevMPtgPfh68rl76rgsr7vWnk5ZnP0mGH+eg1
         R4PNrUysh2jyI5NPcBa4NPQK1NUlhueFP4JTB/1/FyNB3Ga9cUyR1nJIu5zkXR88QlQv
         g7gWAoXIQUReitzTbyLpAufvvQTIYbvXnOt1rOwlbFmwBmcLyTBbpC/GQCWwcVygztxU
         KYoojHZ4iRPcp+4/EoWVYBXQ14hkIojabvdDNz95pA6FWqi6Ppvk95UXxc+i3p1edBvk
         G3WAI4/eSw8c4r9+WrAGW0JKmx78rPDm18kpil3QgpZNs1gBB4Oph79E7pPxx2Npc+M1
         +x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696920239; x=1697525039;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADu43iqAxgWCGQoWay232KiF4mHTKPSjpTOb9DmMVRo=;
        b=I0hLmpK4GUCLxASiPt+XdZ7SSsUP3KTR2qzp065BXDLyTxrugYDKOZ/Xy36n0Juiy+
         V4AaSI/QTrBSUu8W46TiDWSoJI9ba7w2vZxS+MBLnQdWjbSd0A5NM7uiqkVyPxvwv7gN
         Pn9Gzw8raqnxn9ILLXXSX/BMOGlLGp1mcTBqKYQsW7px1m35H7XKL7SJxgU5BveGD+Br
         t2QhEAdWoLGXELlTCZ+fbGfKXzDhiGI2GsJqzrTpRGMV63YbQ0aQ+IaIRnvA/yajD+Q+
         nqOd/nhvvR8ruDJK6SrPl0+ojiCJ3VImrMIPTRY9by3yMSXec9gRHC8ILBaTYuf4671T
         yY7g==
X-Gm-Message-State: AOJu0YxU5XlNCXnDH29VArOukXkcZ4Bf2p5mE6BiCqMEMwoQuSaqTHIX
        rnmEYWhSnHKqZuwbuKO8VOK17bQoWBk=
X-Google-Smtp-Source: AGHT+IG2WC1lXQpkxMKqDGe+sOyoDAj0TDNa0teRthU7LnwB2w7uRlHUx+oWukU7tKoxKVitFbRAoQ==
X-Received: by 2002:a54:4113:0:b0:3ab:88a0:78f8 with SMTP id l19-20020a544113000000b003ab88a078f8mr18725399oic.23.1696920239313;
        Mon, 09 Oct 2023 23:43:59 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.171.119])
        by smtp.gmail.com with ESMTPSA id s27-20020a0568080b1b00b003ae31900048sm1873851oij.44.2023.10.09.23.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 23:43:59 -0700 (PDT)
Message-ID: <6524f2af.050a0220.a4b3a.9bb6@mx.google.com>
Date:   Mon, 09 Oct 2023 23:43:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4858556910984955092=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, twuufnxlz@gmail.com
Subject: RE: Bluetooth: hci_sock: fix slab oob read in create_monitor_event
In-Reply-To: <20231010053656.2034368-2-twuufnxlz@gmail.com>
References: <20231010053656.2034368-2-twuufnxlz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4858556910984955092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=791644

---Test result---

Test Summary:
CheckPatch                    FAIL      1.00 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      39.81 seconds
CheckAllWarning               PASS      43.46 seconds
CheckSparse                   PASS      49.12 seconds
CheckSmatch                   PASS      132.50 seconds
BuildKernel32                 PASS      38.56 seconds
TestRunnerSetup               PASS      589.07 seconds
TestRunner_l2cap-tester       PASS      35.77 seconds
TestRunner_iso-tester         PASS      79.65 seconds
TestRunner_bnep-tester        PASS      12.49 seconds
TestRunner_mgmt-tester        FAIL      256.84 seconds
TestRunner_rfcomm-tester      PASS      19.08 seconds
TestRunner_sco-tester         PASS      22.05 seconds
TestRunner_ioctl-tester       PASS      21.62 seconds
TestRunner_mesh-tester        PASS      16.19 seconds
TestRunner_smp-tester         PASS      16.90 seconds
TestRunner_userchan-tester    PASS      13.17 seconds
IncrementalBuild              PASS      36.19 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_sock: fix slab oob read in create_monitor_event
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#89: 
Reported-by: syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com
Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13414808.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.512 seconds


---
Regards,
Linux Bluetooth


--===============4858556910984955092==--
