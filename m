Return-Path: <SRS0=4/QO=6J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C41C55191
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Apr 2020 02:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC45208E4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Apr 2020 02:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="po7WQy+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgDYCfP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgDYCfP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Apr 2020 22:35:15 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46344C09B049
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 19:35:15 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c23so9132825qtp.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 19:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:in-reply-to:references;
        bh=Q2o7ZMLlkQRfzRhlfJp1sNabPYuZVnsCh+T9Oe5IaHI=;
        b=po7WQy+IMECWLQ5bTHcfuJOa3u0VAcZ7PPtgf1cWnjMBG8BFL30IsWf4qm0OVjz2X0
         p0Gj9Qh37XARo8xlOwxyxZTpDLw/rJos5ypn0M5KYZUeJsuwkO7Jnec0M1M00ri/KUN8
         ekOxN+h4+GKaTB570Yj8OZMHFus/+M/FqzGLkUrqOvLOfV8FXPIIZZfJc32/5F8BGjjH
         gEKFtbQ13rxXayogmTGWvmvNkQB5DdjfdlnIH8O67giplrCo31LxwiRR8PdxdUIVflRe
         lognRIEf0qqNv6AqqppfhXU30/8fCruvJXwWFgav4EvtL22rwkKblucheVjRF3FROa78
         jOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :in-reply-to:references;
        bh=Q2o7ZMLlkQRfzRhlfJp1sNabPYuZVnsCh+T9Oe5IaHI=;
        b=cOt2xTfaHxVy5hSRPpbmwpXnKLWw2B4+fsvVIwXY/XBl/FEAAcOUfMfEIXHTA3jqny
         uQUTg1bjGYQMDfXHcZLtP7SReI5uLFDmF7f2Q8xb3oHwjCHvI9YS8ChysACq7QUQYbMw
         8XuaKO6eqlT6X2944P315tyGdzKuO3Er7cscDsn0LrHQ0buTxEeSAQJe5Unrr6B38il/
         TBXOT6quqVQmW1ADOWNaXIWfYHg9hW8DJKA0csxhvGEslFGfxtPbb6Jgnl3HisLAjCTF
         x4PXdpRPM+3PWoHyzPDV8Eg6YTPCJd7LDynnGpaxEZTjNPZy1WrwVOvAp2tLG5B38Kuw
         8ySw==
X-Gm-Message-State: AGi0PubELBQnA9jBDwuMfWMiQ2qSfJga3JRx/2VuaZNKFbZhHG0+EUYs
        U7i+2pVnRwda05EM+3HjEbP8o1hPCm0=
X-Google-Smtp-Source: APiQypJGgawMTbhoG1W7vQ60dOPU33fkzoyNbxhI85ZJu7YykLOKWhN5W40Hi8NrvMKbsn+9Kes8Sw==
X-Received: by 2002:aed:31c7:: with SMTP id 65mr13116285qth.150.1587782114258;
        Fri, 24 Apr 2020 19:35:14 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.99.182])
        by smtp.gmail.com with ESMTPSA id l8sm5365259qtl.86.2020.04.24.19.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 19:35:13 -0700 (PDT)
Message-ID: <5ea3a1e1.1c69fb81.ca350.3189@mx.google.com>
Date:   Fri, 24 Apr 2020 19:35:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7964464292591789048=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: [2/3] Test patch #2: CODE_INDENT, LEADING_SPACE
In-Reply-To: <20200424231026.127164-2-tedd.an@linux.intel.com>
References: <20200424231026.127164-2-tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7964464292591789048==
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
[2/3] Test patch #2: CODE_INDENT, LEADING_SPACE

Output:
ERROR:CODE_INDENT: code indent should use tabs where possible
#19: FILE: tools/btpclient.c:65:
+        struct l_queue *devices;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#19: FILE: tools/btpclient.c:65:
+        struct l_queue *devices;$

- total: 1 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



For more details about BlueZ coding style guide, please find it
in doc/coding-style.txt

---
Regards,
Linux Bluetooth

--===============7964464292591789048==--
