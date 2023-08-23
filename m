Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA177C27C40
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 20:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjHWUhe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 16:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236832AbjHWUhV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 16:37:21 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0008C10E9
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 13:37:13 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76ef03f76c7so1676685a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 13:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692823033; x=1693427833;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eBn8tgWhYGI6Tk/eUezWCYxqsU+lw8gXjZs9ToRb3Ak=;
        b=bY0iQx4SCQ77GzERJA5GoGe4GRLjNe93v5Gjl9ry2n5a3/PzrsaPM5fOd2AobCSctb
         DU/Clg7aJ8yh5W4ZT0xAsVszN7+d0+KQrmwNlQlusFEwHtJZN3zDZfRtRoyl96GtkYJQ
         iwyKdtcD7UqanZfAt+8hD9ZBqQXMSmc9/mwWJNKX0mMhWYeVTf8BspyaQqDKYemkOigr
         /rPjD6xSW0+BI+q8S1VSQ3m70gP5Ew0pS1eTqnoTE5n1QEEMNsNPiaE8Np4rdmMPj1hq
         3xJFvkM7Yx9ZE7DRp9b5kvfp3OdiQdlAaXCE8Sdbpk/9GykDlsXMpLHIFQndNNE0Z72F
         QeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692823033; x=1693427833;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBn8tgWhYGI6Tk/eUezWCYxqsU+lw8gXjZs9ToRb3Ak=;
        b=RfDzLDRCJ79y4kEYvuuoa90h5QKhqNzRNRAcxU6kin0Fan0E0cL2HYAQ4NkOrIK6lS
         x1AnqNv4SbUel3lSF6aTr1uqDuwaNP+B79rXW0C3eVtSyZjcnmLeOxO+ndigAReJMjh4
         0PlBehbZmaZ/gIo9IkocQiLqRMKM369y1Y23eKPKFNTpNb6dzOQeLu5sNuw7Jt3YwoZb
         55Ngt2WS81odJX0DFg+2b9JerpnfBGUoBLOdEOo63cGZSKNRkFaa2yZ68DQy0W+xyINv
         ulRi+Td9Y1PislIDEuIQOyKIIXsmQqBXeYSRbfyBt0mCX932tD8/alUT2DMTZJZJDEP+
         pqvw==
X-Gm-Message-State: AOJu0YxptyJNyJPtBLWktsWbUxUvuda76vh/PHvwduW0mbvttIBchZVb
        8ukeUNDeileMRbcgxW6L/Ggcf0zUrsA=
X-Google-Smtp-Source: AGHT+IH9E6cz6OC3gAza85FcH6JXY92NMEpNGLaHK6aa1AjCmMx4IKTdv6nVmpTArADDzK6tck02hg==
X-Received: by 2002:a05:620a:4493:b0:75e:bf7e:e17e with SMTP id x19-20020a05620a449300b0075ebf7ee17emr19847098qkp.6.1692823032922;
        Wed, 23 Aug 2023 13:37:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.37.22])
        by smtp.gmail.com with ESMTPSA id t2-20020a05620a004200b00765ab6d3e81sm4181208qkt.122.2023.08.23.13.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 13:37:12 -0700 (PDT)
Message-ID: <64e66df8.050a0220.eab07.2308@mx.google.com>
Date:   Wed, 23 Aug 2023 13:37:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2142375016414428515=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
In-Reply-To: <20230823194128.3893244-1-luiz.dentz@gmail.com>
References: <20230823194128.3893244-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2142375016414428515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=778730

---Test result---

Test Summary:
CheckPatch                    FAIL      1.58 seconds
GitLint                       FAIL      0.57 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      34.33 seconds
CheckAllWarning               PASS      38.12 seconds
CheckSparse                   PASS      43.27 seconds
CheckSmatch                   PASS      114.92 seconds
BuildKernel32                 PASS      33.57 seconds
TestRunnerSetup               PASS      499.15 seconds
TestRunner_l2cap-tester       PASS      29.11 seconds
TestRunner_iso-tester         PASS      52.60 seconds
TestRunner_bnep-tester        PASS      11.65 seconds
TestRunner_mgmt-tester        PASS      229.14 seconds
TestRunner_rfcomm-tester      PASS      17.24 seconds
TestRunner_sco-tester         PASS      20.59 seconds
TestRunner_ioctl-tester       PASS      19.43 seconds
TestRunner_mesh-tester        PASS      14.61 seconds
TestRunner_smp-tester         PASS      15.51 seconds
TestRunner_userchan-tester    PASS      12.19 seconds
IncrementalBuild              PASS      31.26 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
WARNING: quoted string split across lines
#167: FILE: net/bluetooth/hci_sync.c:4671:
 			 "HCI LE Set Random Private Address Timeout command is "
+			 "advertised, but not supported."),

WARNING: quoted string split across lines
#170: FILE: net/bluetooth/hci_sync.c:4674:
+			 "HCI LE Coded PHY feature bit is set, "
+			 "but its usage is not supported.")

total: 0 errors, 2 warnings, 0 checks, 55 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13363067.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B1 Line exceeds max length (116>80): "Link: https://lore.kernel.org/linux-bluetooth/CABBYNZKco-v7wkjHHexxQbgwwSz-S=GZ=dZKbRE1qxT1h4fFbQ@mail.gmail.com/T/#"


---
Regards,
Linux Bluetooth


--===============2142375016414428515==--
