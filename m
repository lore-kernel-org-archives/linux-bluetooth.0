Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96DDC00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 11:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiHALQB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 07:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiHALP7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 07:15:59 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE471D6F
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 04:15:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e132so9392263pgc.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Aug 2022 04:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=zMWxdCHxU4fyKwlUgVZ3tF8l5sebiecbRJWmzn/l1oI=;
        b=B8UvWcbnnTCYPQG6bCd/Vh7L5ilkPN81XIf+bxPdCI16GEZVc2VvuiDhL6VpvBI7L5
         Bvi6PJrmG2JGD/CkgEWffwOB+v4BkKyrLVSpkpOtN6KWQq0pAHbqv69UBiUL9Nru/ac1
         0jJRNZQlsFTktJU6/2YG+ey/zeeALGn4YAzwdixBco7aaeAD6n3kngeSaFlN6gUwcKlx
         /xjUtF7ME+X4AEWAsAv/G6ywdahxU471mfH1IPQnZ5B+MSGx+B5ggcXO1IhE6YeuOheN
         H/bRBWn0/h77F5qh5iEWYeMJD3OJj3FfltUA8pb6Qew9NaxfNRCWZFOnQHf7WvL3Us4p
         yJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=zMWxdCHxU4fyKwlUgVZ3tF8l5sebiecbRJWmzn/l1oI=;
        b=3VKrZ2gKQ0dR7mUJcGec40ysKQfUjIOBbqbvPRqpJyKiQgOgdjcUpeOO5XHyPQT08i
         cstWWfVAEjPFxlqCTrdsVbPlL+sTqHLPcMDemef5NPV73mUa64U4YNfrx6rUBbLMW5uV
         aLkj3fH4WGasTTAARoBIHZjxRiispN5YTi3SGbqYMpiEMTm8+Uf/ncWiW1TGBiqtWHQA
         J+DSMmhusOmc9aXbg7A8U0ZstVNTHl8EG5VHg/3m9Ent+JKPStOOrBFAYbzjM2mXTP6M
         yzNXo1rdEXO/d9GVGZvOvhAaRek4PEH3Mt+Q8pibZpfZAmcHycugE3Hj2cnoqiGu5VS4
         0Kpw==
X-Gm-Message-State: ACgBeo1d5YCHvf87f0j++cpkyoHxpb5xLHtztdoFpCliO6yLryBtoD5j
        5HwVnRn5+bGokP3PS0hdaxKEIDWuFOc=
X-Google-Smtp-Source: AA6agR7W7HCs7j/I8hsOV/4LnYAZ6B/M/l+djXHtJSqW3KQ10KsnMPZ52ahW81Ml4OIIw02oB8tOdA==
X-Received: by 2002:a05:6a00:181f:b0:52d:87ef:f9bb with SMTP id y31-20020a056a00181f00b0052d87eff9bbmr3532477pfa.70.1659352557693;
        Mon, 01 Aug 2022 04:15:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.222.153])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b0016ed8af2ec0sm4186354pls.29.2022.08.01.04.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 04:15:57 -0700 (PDT)
Message-ID: <62e7b5ed.170a0220.b1f88.5ac6@mx.google.com>
Date:   Mon, 01 Aug 2022 04:15:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6426890542215481478=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sven@svenpeter.dev
Subject: RE: Broadcom/Apple Bluetooth driver for Apple Silicon
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220801103633.27772-2-sven@svenpeter.dev>
References: <20220801103633.27772-2-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6426890542215481478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=664458

---Test result---

Test Summary:
CheckPatch                    FAIL      4.23 seconds
GitLint                       FAIL      1.36 seconds
SubjectPrefix                 FAIL      0.58 seconds
BuildKernel                   PASS      44.19 seconds
BuildKernel32                 PASS      38.19 seconds
Incremental Build with patchesPASS      136.13 seconds
TestRunner: Setup             PASS      638.46 seconds
TestRunner: l2cap-tester      PASS      20.84 seconds
TestRunner: bnep-tester       PASS      8.28 seconds
TestRunner: mgmt-tester       PASS      130.01 seconds
TestRunner: rfcomm-tester     PASS      12.10 seconds
TestRunner: sco-tester        PASS      12.07 seconds
TestRunner: smp-tester        PASS      11.87 seconds
TestRunner: userchan-tester   PASS      8.45 seconds

Details
##############################
Test: CheckPatch - FAIL - 4.23 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[1/5] dt-bindings: net: Add generic Bluetooth controller\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#118: 
new file mode 100644

total: 0 errors, 1 warnings, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12933676.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[3/5] Bluetooth: hci_event: Add quirk to ignore byte in LE Extended Adv Report\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#113: 
> HCI Event: LE Meta Event (0x3e) plen 55                    #1 [hci0] 0.912271

ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: unsaf ("ace/src' is owned by someone else)")'
#142: 
          Data: 311f013c86ab

total: 1 errors, 1 warnings, 0 checks, 27 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12933678.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[4/5] Bluetooth: Add quirk to disable extended scanning\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#106: 
< HCI Command: LE Read Supported St.. (0x08|0x001c) plen 0  #27 [hci0] 2.971839

total: 0 errors, 1 warnings, 26 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12933679.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 1.36 seconds
Run gitlint with rule in .gitlint
[1/5] dt-bindings: net: Add generic Bluetooth controller
14: B1 Line exceeds max length (83>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth-controller.yaml"

[2/5] dt-bindings: net: Add Broadcom BCM4377 family PCI Bluetooth
13: B1 Line exceeds max length (85>80): " create mode 100644 Documentation/devicetree/bindings/net/brcm,bcm4377-bluetooth.yaml"

[3/5] Bluetooth: hci_event: Add quirk to ignore byte in LE Extended Adv Report
25: B1 Line exceeds max length (101>80): "          Address: XX:XX:XX:XX:XX:XX (Shenzhen Jingxun Software Telecommunication Technology Co.,Ltd)"


##############################
Test: SubjectPrefix - FAIL - 0.58 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============6426890542215481478==--
