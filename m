Return-Path: <SRS0=4/QO=6J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04435C2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Apr 2020 02:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C334A208E4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Apr 2020 02:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG/dnp7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgDYCfO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgDYCfN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Apr 2020 22:35:13 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98028C09B049
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 19:35:13 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 59so3621023qva.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 19:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:in-reply-to:references;
        bh=pFFmqybnz4DXK7VzqS0BSsTAjfaxu6Zvl3akQKMCYJs=;
        b=SG/dnp7Jas5bgJQgJgh89msu0i5JQkFxs62G6p3B+o9dVrxLIXdFzjjAVbh0Sgj2oI
         AhWZb4AZrZHMOe9pwr8gSENu94hHjkM0S63VsG/JOSsZnIxgFv99jjUrQp2rMqncO75a
         u7chlTO9dzaTPeiiurkZrMYc2JpcS5WeHycPBDau0uVFJgc5I5S1fMDfAZi9wX1WwHNg
         RPnl2mSXPYUnyd5nlmW1SoaWmUTLiBfOMwRMCwG+yJHW113GRbUN7WBMFRNrCO0U4AoF
         +Jl+JvrB6h2mtamPzwxeOZl8b/fYl0P7giXTF5PBnHMYicBXkphA3SM5t+gsIQcUNbfc
         nhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :in-reply-to:references;
        bh=pFFmqybnz4DXK7VzqS0BSsTAjfaxu6Zvl3akQKMCYJs=;
        b=UmZNombUw6vn4U9NTqtwD8SAOOMy/9OgNazpb77vbKxdQqCOJlTkPcJ1Mrpaa7Nr4b
         TvMYuWVi2kAcOhqKyLh25GjWmHu2n1sDDTAJrzBMciywoNA0pL1pAtzzc8im37p5Bo2s
         k0qtdQ+v1mqnl+VkHZHtGpgQnUIed0z4jKQru5NVFHsQzkSoLTFGnVNIR5HRUKj0AqAf
         ndCVoMY01thp81GOP70ZMI2TqOVAU7ENixEXlKX65uf76918BHw9PqCLrlTlPn331N9Y
         X7Sd2SDG36efdbVxoi9aAtnUX9z8+SvGuoCus6m5tbDXajSlYAGmvC9R/c7v10JLYpOe
         kgBg==
X-Gm-Message-State: AGi0PuYjnMjAVj/DGBGsHWSlzfcvdYSH3r6DkHoSYzVIWK5P6bJaEslj
        i3YwSmYXmKia59jNTuVmnREfkNnZp9M=
X-Google-Smtp-Source: APiQypKHLnYpi5qt2osbOf8SB5vwnJqpjJubkQmHsh7cjZl31BqQmv79DjrnO0LlVuvpyduFnneb+g==
X-Received: by 2002:a0c:ef05:: with SMTP id t5mr11880750qvr.113.1587782112566;
        Fri, 24 Apr 2020 19:35:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.99.182])
        by smtp.gmail.com with ESMTPSA id m11sm4817072qkg.130.2020.04.24.19.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 19:35:12 -0700 (PDT)
Message-ID: <5ea3a1e0.1c69fb81.747dc.019c@mx.google.com>
Date:   Fri, 24 Apr 2020 19:35:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1854484666968621217=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: [1/3] Test patch #1: LONG_LINE_COMMENT
In-Reply-To: <20200424231026.127164-1-tedd.an@linux.intel.com>
References: <20200424231026.127164-1-tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1854484666968621217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not replay to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.


Test Result:
Checkpatch Failed

Patch Title:
[1/3] Test patch #1: LONG_LINE_COMMENT

Output:
WARNING:LONG_LINE_COMMENT: line over 80 characters
#18: FILE: tools/btpclient.c:3163:
+	/* This is a test comment to test checkpatch.pl for long line over 80 column line */

- total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



For more details about BlueZ coding style guide, please find it
in doc/coding-style.txt

---
Regards,
Linux Bluetooth

--===============1854484666968621217==--
