Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A34C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jul 2022 00:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiGLAB2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jul 2022 20:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiGLAB2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jul 2022 20:01:28 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552AB2CCA3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 17:01:26 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id cf13so6518354qtb.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 17:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=PYic9/7wc+pvKwbW18Mp6ZQzyH+6FW6jSxL0ImN3Gk8=;
        b=GF4bphZhcWuZJOU3vWx88Sp+YjOqS/r2Cx3/FHDdTeSxvx2425Df9yvpEFJ9TQOQHg
         1A01OF5740GYt10j8QTtMgoxIt54QpHKBvs9iSJ0rhg7WO7a6+1Dvnc0fhvOvvyLotY5
         vL5TlACc3n1KPpgU/gy+FNE0svJKTEXC5Te4bbA8VrCNkCTYYf8YOAUmRKazoJrB3IeC
         WemLMLYrwy/aLlAMX11gYawA9SK+9UgdanWlXrIMol9LoX570Fu1uctLgdogGWYc6ufi
         sSv07+eyDo/eEz/fvCa/2JjehXEUoZ66A6APFp1qfrnoQxtyXSjN9WSMC0oKl4BSEcc9
         jwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=PYic9/7wc+pvKwbW18Mp6ZQzyH+6FW6jSxL0ImN3Gk8=;
        b=tuyfCzuVT4bIUjWjuwmRSvmUDqwcumbaZ5uKqeYCCt0NvyqOnKzobPuYujDsVJYa/j
         8DXVN9ucwxP2jX/xwJIYk04eGIBSNqP8foZgUeNpX9l1WIMfI+KQKjteF9512rrfl9/a
         SSH8KRF6eqo3QnTfk/5Oe6e861R2a4nnkAJcfPnV8LRYcXB2uGRmC8GM+q5un2FPBT0t
         omi9PYSdfwERffEaFulPsEG3dWnkwDXjGOcN7+CCt87Au+e07pzBd/AE6cyu1nJpJ/3J
         fpN0qfGz0h3Hec+NDMZdKyI56ssGnvQ2fYIcugfoOw23svyU2v4xTWab4u57QGk1BETq
         AmgQ==
X-Gm-Message-State: AJIora8FLgJprPoYl99FbTRxpSZJeGiKMMxepiuBhWGDjqTgBn2oc+wk
        7TjfhLgA3htUV9UrqJ73AIjdeLBVePY=
X-Google-Smtp-Source: AGRyM1sT0Ptmr0ZCz5OrPtj78yVQroE2KbCp7iaTNSS8F+UdLcjPqlNzmxc+5FaejRtDiGHE6zIcQg==
X-Received: by 2002:a05:622a:490:b0:31d:2a47:c221 with SMTP id p16-20020a05622a049000b0031d2a47c221mr16142173qtx.212.1657584084997;
        Mon, 11 Jul 2022 17:01:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.22.252.98])
        by smtp.gmail.com with ESMTPSA id s12-20020a05620a29cc00b006b28349678dsm8561126qkp.80.2022.07.11.17.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:01:24 -0700 (PDT)
Message-ID: <62ccb9d4.1c69fb81.17e34.dcc5@mx.google.com>
Date:   Mon, 11 Jul 2022 17:01:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8345476148555262707=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v7,1/7] Bluetooth: hci_core: Introduce hci_recv_event_data
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220711233535.3134546-1-luiz.dentz@gmail.com>
References: <20220711233535.3134546-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8345476148555262707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=658721

---Test result---

Test Summary:
CheckPatch                    FAIL      10.05 seconds
GitLint                       PASS      7.54 seconds
SubjectPrefix                 PASS      6.65 seconds
BuildKernel                   PASS      31.44 seconds
BuildKernel32                 PASS      28.64 seconds
Incremental Build with patchesPASS      164.47 seconds
TestRunner: Setup             PASS      460.91 seconds
TestRunner: l2cap-tester      PASS      16.46 seconds
TestRunner: bnep-tester       PASS      5.40 seconds
TestRunner: mgmt-tester       FAIL      95.53 seconds
TestRunner: rfcomm-tester     PASS      8.79 seconds
TestRunner: sco-tester        PASS      8.60 seconds
TestRunner: smp-tester        PASS      8.66 seconds
TestRunner: userchan-tester   PASS      5.60 seconds

Details
##############################
Test: CheckPatch - FAIL - 10.05 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v7,3/7] Bluetooth: Add BTPROTO_ISO socket type\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#176: 
new file mode 100644

total: 0 errors, 1 warnings, 0 checks, 1721 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12914365.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: mgmt-tester - FAIL - 95.53 seconds
Run test-runner with mgmt-tester
Total: 494, Passed: 492 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Read Exp Feature - Success                           Failed       0.091 seconds
Read Exp Feature - Success (Index None)              Failed       0.096 seconds



---
Regards,
Linux Bluetooth


--===============8345476148555262707==--
