Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19757E748ED
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Oct 2023 09:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjJAJh2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Oct 2023 05:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjJAJh1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Oct 2023 05:37:27 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42094AC
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Oct 2023 02:37:23 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c61d955161so3126001a34.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Oct 2023 02:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696153042; x=1696757842; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g02F3TTnWY9E5Y/niflVubHg6vZpfugpUwqp4QT26H0=;
        b=bo9/El6RfAQHnW6Ezo9IBG2Jpx82ZTAgLjj/cc8zZkS5N8f2uOm50yNazGXuiIb5Ez
         AxfDkeXIrKUhY0LtUabmpT+tGuEVb5rCCLvtpuSB7nTqlZZ12z8k0H6A4KBUh+ytWZAC
         OrErOUNyafe2lI2TX9tgwcf+hx+73gFmsFnhqkOxRI23nCq4h+IIapXxCwioU/T/YKBY
         Vq26kHlfF5dM8gLImCfup6xQZtz6EMCOTfoe0Az2OfGPgEoI2DJnRNc99XKhiYPdM/AQ
         vzZ1Mx0XsDe6EPjSsKvBERYvGVYhJGBQpFl0WUsasTtFyqeJuIOO3ncVN8/jnkM7db+6
         /GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696153042; x=1696757842;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g02F3TTnWY9E5Y/niflVubHg6vZpfugpUwqp4QT26H0=;
        b=wRvzX6XWDQD4xbwpiAU2W3cxW6S3g+HJnk+np0YQhScSG+i1IgHNPKbW6X2h1W5NMY
         vIKAijpeThmi3gALbT0dyB3tZl4nKbf6HTobg20v9Okfn5lEm+DJ0VzIwbA5Vnde5WZH
         dhY4nhjGWjzhT1/7aAPp4njSCMHiJweuJ8+ypuZxCnKjJWfxarwm5PH/bykAspu7MXk5
         qQGhq4An+3sI8sqrIhVwg4fK1jl6uqVKPqgcuFdxvFHRtTOBio0OcGE+737jgWD7DigK
         vo4pR25Y8/WYIKxhjMB6geG7dn0IE8+hnO/skNYpgbIV7w8VnHr3nabwrSytY/14wkZO
         D0Kw==
X-Gm-Message-State: AOJu0YyhCvgAi/ctWcxZmrjzNgP8Ixgo2GevUS/AA54CuU9j3IC4IGDP
        2/jgDvuKaOPSUsjxvKnFEnGAYky+bIwPsQ==
X-Google-Smtp-Source: AGHT+IF3dfRpurEVoWEMSoWVZ+NFk7ibYCguhpqlbdcC3vyjqcf/41d3l73VyhdDN4JyTakgIy2AZQ==
X-Received: by 2002:a9d:6643:0:b0:6be:e447:dbd with SMTP id q3-20020a9d6643000000b006bee4470dbdmr7958249otm.22.1696153042199;
        Sun, 01 Oct 2023 02:37:22 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.179.183])
        by smtp.gmail.com with ESMTPSA id c21-20020a9d4815000000b006c637fbaca7sm923561otf.53.2023.10.01.02.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 02:37:21 -0700 (PDT)
Message-ID: <65193dd1.9d0a0220.4a9fe.9155@mx.google.com>
Date:   Sun, 01 Oct 2023 02:37:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1453303662535995396=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jlee@suse.com
Subject: RE: Bluetooth: ignore NULL link key and reject connection with the device which has same BD_ADDR
In-Reply-To: <20231001085931.GA17048@linux-691t>
References: <20231001085931.GA17048@linux-691t>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1453303662535995396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789101

---Test result---

Test Summary:
CheckPatch                    FAIL      2.89 seconds
GitLint                       PASS      0.61 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      35.46 seconds
CheckAllWarning               PASS      39.10 seconds
CheckSparse                   WARNING   44.54 seconds
CheckSmatch                   WARNING   118.36 seconds
BuildKernel32                 PASS      34.21 seconds
TestRunnerSetup               PASS      520.60 seconds
TestRunner_l2cap-tester       PASS      32.09 seconds
TestRunner_iso-tester         PASS      55.24 seconds
TestRunner_bnep-tester        PASS      10.58 seconds
TestRunner_mgmt-tester        PASS      234.69 seconds
TestRunner_rfcomm-tester      PASS      16.34 seconds
TestRunner_sco-tester         PASS      19.67 seconds
TestRunner_ioctl-tester       PASS      18.91 seconds
TestRunner_mesh-tester        PASS      13.78 seconds
TestRunner_smp-tester         PASS      14.59 seconds
TestRunner_userchan-tester    PASS      11.30 seconds
IncrementalBuild              PASS      39.54 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[2/2] Bluetooth: Reject connection with the device which has same BD_ADDR
ERROR: that open brace { should be on the previous line
#144: FILE: net/bluetooth/hci_conn.c:1631:
+	if (!bacmp(&hdev->bdaddr, dst))
+	{

ERROR: that open brace { should be on the previous line
#162: FILE: net/bluetooth/hci_event.c:3271:
+	if (!bacmp(&hdev->bdaddr, &ev->bdaddr))
+	{

WARNING: line length of 108 exceeds 100 columns
#164: FILE: net/bluetooth/hci_event.c:3273:
+		bt_dev_dbg(hdev, "Reject connection from the device with same BD_ADDR %pMR\n", &ev->bdaddr);

total: 2 errors, 1 warnings, 0 checks, 27 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13405332.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============1453303662535995396==--
