Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB1DC43334
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jul 2022 00:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiGBAGm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 20:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiGBAGm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 20:06:42 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A428369CB
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 17:06:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso6168358pjz.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Jul 2022 17:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=qWAM4+rLKCtQSsn1uBT4BU+m4NYPjqmFyr9vi3HpRBU=;
        b=SmVAmcsW6vIjmLTBVLIBGgIBf/GP4V0U3vKVXexN8Vq98UbCEwd6AnF7QSEhOS4LGm
         uArjlmsIWrb6oAYxhDuUZqGuYFzCHiBrofH0oitZYDXwr+vebpXJ1N70yzOYkiBWdJBT
         V4wA3ONGnpJp+M+iLRW6XdPk9rTtTdwKnM8qrNduDlvHi/AKmYsCdKdRGVOvNu/fvaL2
         ulhE9PEIJcQe4o+gSU9RIc9s/SLrKdoXugP4tlYAL58pX/CINRtvdi9zUg879TSlXM8v
         znq+fdjdTx/nUh3Ma+bnn5MVXwZic0Kh4mzaiiK6InzyNO4Acu8ZVdZfe7Xee2ah131Z
         zI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=qWAM4+rLKCtQSsn1uBT4BU+m4NYPjqmFyr9vi3HpRBU=;
        b=bihbkChx3wwN6qoXTEvx/zaiPFUIDCrhp4rrZM9loj5Brm/3JEbZtU7xA4EVzjFsw7
         m0FvFn8fpXuww+lp0HWNyYXpA4kPB6ckOhGoZZKxz/cvtMBt7QUnKXGDHZbG0OlAxN/c
         W4rg2pH7AuY3GR03AYm24JGNZqLRgj/lwy6IG7hTZNzkt5t8dZkbwqZZVCddKq9F9twx
         dfzjo9DHhvC7dX3WrWQNejQtK59WS3LURJcbTAmuGJWDhlFS3zjQ5k6GnFpu1DpU66H4
         eVWLy4TptHNptYFOsK4LfrPAQ+PW3A96bbEmAqNnQkwkoXZtHT2v51NDvxTbMg4aujy/
         wJEQ==
X-Gm-Message-State: AJIora8ozdFY9s7dJ+HRYuEaNeX1j6On+UWdngl5cWQR4M+RaAa9ViW3
        G0QqwARRMGos6Ojf0vfcApusi7smoi8=
X-Google-Smtp-Source: AGRyM1sKJOdCDy1Mvd1ZuGO0j8XbtvdwxnnSwhRocVFMrJUdX+ggr/Dexi0OYYCksJJND8ewrEzcdA==
X-Received: by 2002:a17:90a:8b81:b0:1ef:3b32:8fa6 with SMTP id z1-20020a17090a8b8100b001ef3b328fa6mr12685571pjn.165.1656720397640;
        Fri, 01 Jul 2022 17:06:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.221.156])
        by smtp.gmail.com with ESMTPSA id v7-20020a17090a4ec700b001ecaa74f8dasm7276715pjl.11.2022.07.01.17.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 17:06:37 -0700 (PDT)
Message-ID: <62bf8c0d.1c69fb81.76780.b4a5@mx.google.com>
Date:   Fri, 01 Jul 2022 17:06:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7779264272177947240=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v5,1/7] Bluetooth: hci_core: Introduce hci_recv_event_data
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220701233658.966972-1-luiz.dentz@gmail.com>
References: <20220701233658.966972-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7779264272177947240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=655961

---Test result---

Test Summary:
CheckPatch                    FAIL      12.27 seconds
GitLint                       PASS      3.08 seconds
SubjectPrefix                 PASS      2.14 seconds
BuildKernel                   PASS      38.92 seconds
BuildKernel32                 PASS      34.65 seconds
Incremental Build with patchesPASS      192.84 seconds
TestRunner: Setup             PASS      566.86 seconds
TestRunner: l2cap-tester      PASS      18.75 seconds
TestRunner: bnep-tester       PASS      6.52 seconds
TestRunner: mgmt-tester       FAIL      115.33 seconds
TestRunner: rfcomm-tester     PASS      10.37 seconds
TestRunner: sco-tester        PASS      10.34 seconds
TestRunner: smp-tester        PASS      10.34 seconds
TestRunner: userchan-tester   PASS      6.83 seconds

Details
##############################
Test: CheckPatch - FAIL - 12.27 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v5,3/7] Bluetooth: Add BTPROTO_ISO socket type\Traceback (most recent call last):
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

total: 0 errors, 1 warnings, 0 checks, 1718 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12903848.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v5,4/7] Bluetooth: Add initial implementation of BIS connections\WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#848: FILE: net/bluetooth/hci_conn.c:817:
+ * */

WARNING:LINE_SPACING: Missing a blank line after declarations
#1878: FILE: net/bluetooth/hci_sync.c:1031:
+		struct adv_info *adv = hci_find_adv_instance(hdev, instance);
+		if (!adv || !adv->periodic)

total: 0 errors, 2 warnings, 0 checks, 1874 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12903852.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: mgmt-tester - FAIL - 115.33 seconds
Run test-runner with mgmt-tester
Total: 494, Passed: 492 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
Read Exp Feature - Success (Index None)              Failed       0.118 seconds



---
Regards,
Linux Bluetooth


--===============7779264272177947240==--
