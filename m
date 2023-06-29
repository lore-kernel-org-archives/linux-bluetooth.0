Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98628C0015E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 10:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjF2KjG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 06:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjF2KjE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 06:39:04 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0669D1BE8
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 03:39:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-263036d4bc3so372461a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 03:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688035142; x=1690627142;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ICiHLX2fJM6/x6V4ZyJYWinU+HGjoRNx+ZqkSEpLV7w=;
        b=YCR/afe9Er2+/erzXodzUuiTDHxyjbrFOurcYXbLxnmNs6kI8OR2YlfZ8tnfEdrWk+
         Li+fASoXm2KWBriZPdsMXanXGCn4bc+c0Id3Iiky9sg23Ov+Uf3L8D5AWklagfDTiUI/
         F0QdId2kCiHvRfhzS8/FuhXhBWKvQgti3xe/kXEa2cvxl8KjyrYFH+zXeyqF0cOSEhQW
         xn7hDZjOxl7JMugF1CXIF81eJnt4HY0a+mmJkAY4vTzHL9J0tRmMmWsu09kEmCfA/bzF
         jO3HjZCkKa9VuD4juVxa2XvXK+Qw3ICxZF6MjpbYAuR+sXvKeDgEzqsOVWBIQoCY3/EW
         eMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035142; x=1690627142;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICiHLX2fJM6/x6V4ZyJYWinU+HGjoRNx+ZqkSEpLV7w=;
        b=E8M8sDDGc8KHm+vRBguFVs2Jww9c05iq10/URUTRgCrZE8LYXvTDpIajVFe+tQg2Xn
         vN59s4hmTQDQ/gtp8o4QzUoT/RNDTF9inHFbXxhfuHi00EUVDiLOy8U+G9uK1cb3YuwC
         zaJAwwyhM9AqK+0plNdn9lJdEG2/HoLpbkIT4AQwJbBqlPgVyP4n3KUcWCrrAV6fNdiL
         DOGp/EI8QJbVJO8MpmWA6Jep9RYur5pjhGgfNGi7VrVuz9TyhB7J5y7zF5sdkXnpdRDF
         dbcPLcxtwqyOWBsL4N7QNZAdJu5f5aEi8Gxyz3s1kKzeX8nx5r6wJrndB9WdKvxiIK6u
         /uBg==
X-Gm-Message-State: AC+VfDxp8P1O/exWG+FT4c71hvXunA+Axw92unkh78TLDP01JNhXFcV+
        q46wVIp+zSsk04UQ5+Jyf0Gzsh7F8FY=
X-Google-Smtp-Source: ACHHUZ5dvVPm5SFAkVsGdr1vDQOImnMF49NEjZLvk4gWp+hvq+cNXBYd2lZKBiHMPAzM500hEwYhOQ==
X-Received: by 2002:a17:90a:dac5:b0:25e:9aa6:2dfc with SMTP id g5-20020a17090adac500b0025e9aa62dfcmr34976095pjx.40.1688035142142;
        Thu, 29 Jun 2023 03:39:02 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.61.179])
        by smtp.gmail.com with ESMTPSA id w2-20020a17090a380200b00256353eb8f2sm11922339pjb.5.2023.06.29.03.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:39:01 -0700 (PDT)
Message-ID: <649d5f45.170a0220.9168b.84cb@mx.google.com>
Date:   Thu, 29 Jun 2023 03:39:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5788083198673971152=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Bluetooth: ISO: Add support for periodic adv reports processing
In-Reply-To: <20230629093224.5135-2-claudia.rosu@nxp.com>
References: <20230629093224.5135-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5788083198673971152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761178

---Test result---

Test Summary:
CheckPatch                    FAIL      1.53 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      40.11 seconds
CheckAllWarning               PASS      43.90 seconds
CheckSparse                   WARNING   49.12 seconds
CheckSmatch                   WARNING   133.50 seconds
BuildKernel32                 PASS      38.56 seconds
TestRunnerSetup               PASS      546.64 seconds
TestRunner_l2cap-tester       PASS      20.03 seconds
TestRunner_iso-tester         PASS      32.96 seconds
TestRunner_bnep-tester        PASS      7.94 seconds
TestRunner_mgmt-tester        PASS      159.62 seconds
TestRunner_rfcomm-tester      PASS      10.78 seconds
TestRunner_sco-tester         PASS      9.93 seconds
TestRunner_ioctl-tester       PASS      11.87 seconds
TestRunner_mesh-tester        PASS      8.66 seconds
TestRunner_smp-tester         PASS      9.79 seconds
TestRunner_userchan-tester    PASS      7.12 seconds
IncrementalBuild              PASS      36.37 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: ISO: Add support for periodic adv reports processing
WARNING: Missing commit description - Add an appropriate one

CHECK: Alignment should match open parenthesis
#157: FILE: net/bluetooth/hci_event.c:7176:
+	HCI_LE_EV_VL(HCI_EV_LE_PER_ADV_REPORT,
+		  hci_le_per_adv_report_evt,

CHECK: Unnecessary parentheses around 'sk->sk_state == BT_CONNECTED'
#172: FILE: net/bluetooth/iso.c:1395:
+		if ((sk->sk_state == BT_CONNECTED)
+				&& (!bacmp(&iso_pi(sk)->dst, BDADDR_ANY))) {

CHECK: Logical continuations should be on the previous line
#173: FILE: net/bluetooth/iso.c:1396:
+		if ((sk->sk_state == BT_CONNECTED)
+				&& (!bacmp(&iso_pi(sk)->dst, BDADDR_ANY))) {

CHECK: Alignment should match open parenthesis
#227: FILE: net/bluetooth/iso.c:1671:
+		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
+				iso_match_sync_handle_pa_report, ev3);

total: 0 errors, 1 warnings, 4 checks, 116 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13296825.patch has style problems, please review.

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


--===============5788083198673971152==--
