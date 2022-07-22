Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45460C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 00:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiGVAJX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 20:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiGVAJR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 20:09:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C10E4C
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 17:09:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bk6-20020a17090b080600b001f2138a2a7bso5330502pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 17:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ks33HmF9cXS6Q/4HzrY/6Zx6IX4XAvTYfIkzgm2KCcM=;
        b=MbKcvW0M1KMgCIdfWlwNO74O+fLO1huoMDr0pflqI6/b8zS3T8JPBNh2UZA+MvvtT/
         +2pSWlFNmwt8DNjR2Vm9yDy/U/U/JtBcBbhGTQyMHFU3zKBLJN6oVd120JZ2n7AyiBhZ
         9J5j+IZaHr2kKuAL/DCfsFfwtcHKhJt6hKV/vXpQlv5zzjTl96skNe3UpChWNz8QglrG
         eXgSrepktdjhw87mqkjJzZWCiXSWTT14SXaW2tzH0ORv6Pkbr4LiIRYoxt7yvwdajf/l
         k2ko8jFeCOvw/CmwjlTq0k9veiI5lgw7XFHAXk1gcFDntjICJlK19E7tWPnQXYPc6pf7
         4arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ks33HmF9cXS6Q/4HzrY/6Zx6IX4XAvTYfIkzgm2KCcM=;
        b=aoJzTlyBnsWFTDfGqtDZW7HHdZ+LC755AOrFmjw3T7fu80yYJtk77RKBWMhWRzqI91
         LB7rlefTWSbntwP/W35sLUmFZGU7tuStjDTd+t2bRYiEkA9YzkvyNt84N+GdF8dza//r
         +QrdhbvZ2i4BEvp7kSOGWnG9u1lXYokgXLpjRZsOBYcYtDeJ3D06gAl6kuGthkrZREHD
         uyFTtqFjJL2kh02nPrDobbXnBw1ch0zoji1ud82TrWBwRG4iCuAtCbo8ghu72hHqhKsq
         LXD3zYhXlwcfMg8pzd/Dg7qzovw21OtBzVyKj3l68Y7Hiiv63d/MWfCU8baYNiabouDK
         9dxQ==
X-Gm-Message-State: AJIora9IU6bkvQG+/Ov4zua3IiQ0bMm4D/+vuD1oNyKQd0m2c5rvUkBV
        BCzLpQPyU3q4YQYSfllI9totXyWNKk0=
X-Google-Smtp-Source: AGRyM1vTFL2C9xCwRS8+Mhc3OvRJBidIw+Jll+nwrn67vU4I0RNvrBTbhOofjTO3UX284/C/eYvJpw==
X-Received: by 2002:a17:90a:b383:b0:1f2:24d8:71f5 with SMTP id e3-20020a17090ab38300b001f224d871f5mr9788311pjr.206.1658448553421;
        Thu, 21 Jul 2022 17:09:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.237.170.255])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b0016d2f0b67e0sm2255512plg.309.2022.07.21.17.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 17:09:12 -0700 (PDT)
Message-ID: <62d9eaa8.1c69fb81.7fef5.3d49@mx.google.com>
Date:   Thu, 21 Jul 2022 17:09:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8033333941306817543=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Clean-up stale/unused hci_request.c code
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220721232225.624426-2-brian.gix@intel.com>
References: <20220721232225.624426-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8033333941306817543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662029

---Test result---

Test Summary:
CheckPatch                    FAIL      3.22 seconds
GitLint                       PASS      1.50 seconds
SubjectPrefix                 PASS      0.89 seconds
BuildKernel                   PASS      46.46 seconds
BuildKernel32                 PASS      39.94 seconds
Incremental Build with patchesPASS      113.11 seconds
TestRunner: Setup             PASS      687.76 seconds
TestRunner: l2cap-tester      PASS      19.44 seconds
TestRunner: bnep-tester       PASS      6.84 seconds
TestRunner: mgmt-tester       PASS      113.22 seconds
TestRunner: rfcomm-tester     PASS      10.62 seconds
TestRunner: sco-tester        PASS      10.30 seconds
TestRunner: smp-tester        PASS      10.40 seconds
TestRunner: userchan-tester   PASS      7.21 seconds

Details
##############################
Test: CheckPatch - FAIL - 3.22 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2,2/3] Bluetooth: Remove update_scan hci_request dependancy\WARNING:TYPO_SPELLING: 'dependancy' may be misspelled - perhaps 'dependency'?
#55: 
Subject: [PATCH v2 2/3] Bluetooth: Remove update_scan hci_request dependancy
                                                                  ^^^^^^^^^^

total: 0 errors, 1 warnings, 0 checks, 124 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12925849.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8033333941306817543==--
