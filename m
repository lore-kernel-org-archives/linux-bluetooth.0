Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6774DC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 01:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCWBLb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 21:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCWBL3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 21:11:29 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E03E35AA
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 18:11:28 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so417463pjl.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 18:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679533887;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sG3deX9mcFL/ZJhfF3phQ1ubNpRD7jPNCl9oOnV0kB8=;
        b=iciSykKh0R4VPfjxqhAZqG+3nMHx5wp6J1LS4ZYnfknlqxz2V18W3CVGjhdekCFRDP
         cIMERer1Of3MI8leKYZRGNkqOtwbpC2ULxDgY0/y+1ccj7vZbIdjfF8M440xmyPpm3ow
         zCMpBPHVqX2/xUEiAVJKgiNWLeAP2oSyp84oeezhKhvbIfwRZGXUS4tG7Bva7bRhvH6r
         55Jjto+fH5pxLCQ7R/ISTvB994jTuX+OkZQaBAzT0TnlTpEI1wIT+u3U9axJlPdVLEEi
         qtCQhBsrYiMvVuRaRAhANPwNy2Y63qcDVjN9Qe+FQxI+RtpQT3neLwIfy7r69e0u8khA
         4G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679533887;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sG3deX9mcFL/ZJhfF3phQ1ubNpRD7jPNCl9oOnV0kB8=;
        b=h8rhMEvFQ/PgdLTwKrslIwSj9viO2fUNFI8LGgnL3oLcJ0wViLuafcvyHGD0DiBeVo
         heSXvThiNb2faDB88YS0dc+4Cu47oiYUdk/mvVuFL/JDJ6oOqyxYrNvuYkk+HHNWpOlE
         AtwkdpqACbhqQQYu1yt48YBXazk/3tK/b/C3djuqhXJtJnodNAU65a0YIfCyYaI4MUm/
         qCTxPHZzSebBr1WaBrI/4TzsDoxZ455dAEnjA7WGY4UVzX/S+i5kaBJd8CYr/gOQLjas
         OsmHzRoIYzYNP0Kmapn/whK8OyRpV3VrkTSsUdEyCQD14oRA6lOO9poTNVhwzcqn9iHz
         9kKw==
X-Gm-Message-State: AO0yUKWqnA2TNF0gMPDp5hwPnm53wnri7uESduy2WXU73ERzbSudkVKP
        7IvGgoUvgv0HScNikPk7ZzifEVbSpJc=
X-Google-Smtp-Source: AK7set89IzvPfhs65a/JOmhuOCSDzunk97rPAtYkJbrJEN1qRaPZ60rVrJ6SmN71OW4lNYGOLbIzpw==
X-Received: by 2002:a17:902:e2d3:b0:1a1:b238:d1a5 with SMTP id l19-20020a170902e2d300b001a1b238d1a5mr3486239plc.4.1679533887469;
        Wed, 22 Mar 2023 18:11:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.48.2])
        by smtp.gmail.com with ESMTPSA id y6-20020a170902b48600b001a1ea1d6d6esm3001308plr.290.2023.03.22.18.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 18:11:27 -0700 (PDT)
Message-ID: <641ba73f.170a0220.ebdc2.62e2@mx.google.com>
Date:   Wed, 22 Mar 2023 18:11:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3423123535607556674=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dhowells@redhat.com
Subject: RE: [RFC,1/3] net: Drop the size argument from ->sendmsg()
In-Reply-To: <20230322135612.3265850-2-dhowells@redhat.com>
References: <20230322135612.3265850-2-dhowells@redhat.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3423123535607556674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=732753

---Test result---

Test Summary:
CheckPatch                    FAIL      18.11 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 FAIL      0.40 seconds
BuildKernel                   PASS      31.50 seconds
CheckAllWarning               PASS      34.46 seconds
CheckSparse                   WARNING   39.28 seconds
CheckSmatch                   WARNING   108.13 seconds
BuildKernel32                 PASS      30.32 seconds
TestRunnerSetup               PASS      433.80 seconds
TestRunner_l2cap-tester       PASS      15.85 seconds
TestRunner_iso-tester         PASS      15.61 seconds
TestRunner_bnep-tester        PASS      5.07 seconds
TestRunner_mgmt-tester        PASS      103.41 seconds
TestRunner_rfcomm-tester      PASS      8.14 seconds
TestRunner_sco-tester         PASS      7.43 seconds
TestRunner_ioctl-tester       PASS      8.59 seconds
TestRunner_mesh-tester        PASS      6.36 seconds
TestRunner_smp-tester         PASS      7.37 seconds
TestRunner_userchan-tester    PASS      5.26 seconds
IncrementalBuild              PASS      28.86 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,1/3] net: Drop the size argument from ->sendmsg()
WARNING: Unnecessary space before function pointer arguments
#729: FILE: include/linux/net.h:195:
+	int		(*sendmsg)   (struct socket *sock, struct msghdr *m);

WARNING: function definition argument 'struct rxrpc_sock *' should also have an identifier name
#2195: FILE: net/rxrpc/ar-internal.h:1224:
+int rxrpc_do_sendmsg(struct rxrpc_sock *, struct msghdr *);

WARNING: function definition argument 'struct msghdr *' should also have an identifier name
#2195: FILE: net/rxrpc/ar-internal.h:1224:
+int rxrpc_do_sendmsg(struct rxrpc_sock *, struct msghdr *);

total: 0 errors, 3 warnings, 2169 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13184097.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:148:35: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:148:35: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============3423123535607556674==--
