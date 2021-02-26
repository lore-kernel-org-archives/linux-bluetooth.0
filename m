Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB15CC433E9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 21:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E7664F13
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 21:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhBZVdW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 16:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhBZVdQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 16:33:16 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3EBC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 13:32:36 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id k7so2572579qvo.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 13:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=bKoCXyxrPXzY+6OOQHihJKT8Fmh+BzNz0gLj9l4O9Lg=;
        b=DcwdtpOYwzHU2pB5YnDTvoMj40hSrQMLhDQlrqRzNhfxsta+Hoqctybv0E8Xpy8cEE
         JVuHqD0vkhztx1ic2N/fVjbXWjaucWCO+osbN42w7Qx2fwUL1dZx7nDpxeorFtTqAGcy
         ser9Cb+OUfP+6odA9Ic55vewOH6x94TW7Jak35w8H8wEf61Z+BnrMhL8SLFpvkSYjSj2
         z02nc76vYjJr+tqPOi2/sTxBqwmQBUPI1/3gkXfCb0Dw/2mF+BkBXO2UElRusXPvrqXL
         3q4BC6UQM1yF4G4MRgLsPVU/NSxM+OU7VDmwXdvA328ox0MFaTPgsvDEngr2iobbqmPj
         80sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=bKoCXyxrPXzY+6OOQHihJKT8Fmh+BzNz0gLj9l4O9Lg=;
        b=V5W6m9ib1X0ie56h+cUnspraefD3vMNtDGP2UEQOUlAEpQ5ZKpu/iG9AqDSJ1KKTGb
         H7N0TlwCBbmI9scvObRbjY2jlxSrl7zhVdJBFMUC0JNC8U/Kk1gcHKIkKZaHI6l9IbVw
         zNzIyOGoA3J8sErGy6Xfy/+DUKIYEuy12ccrGJg5+QDORSA/tldjIAwR5ErSnsrMTS00
         p2zxR5jfjSizg0olH2BGVkGvKqnyV5P6MA104ryGR1LYg/v0VCpdQUX+PkXv2vZN9C+D
         lYX/iQpKkprLwPDvLjFxFhX2tF1Tx+m0GAoHx0ObdFgBEnYJs6hq8XjJ0XiJCiZ0AouA
         ELlQ==
X-Gm-Message-State: AOAM530pVjeB6YRfBsurE1AJSN/A8GDzf2Y888mSzf+zO1AplaBu6z+Q
        mcevs830uSe9dB/kUa51rWKYmuj47TDzHA==
X-Google-Smtp-Source: ABdhPJyJFUmvBI55bdECWsXTFFktbMGAJ/MpJuMKFym6zMKbr7Vm+f+/h5XUfduQCxiyhvVGGjZ69w==
X-Received: by 2002:a0c:8f09:: with SMTP id z9mr4375230qvd.25.1614375155155;
        Fri, 26 Feb 2021 13:32:35 -0800 (PST)
Received: from [172.17.0.2] ([52.167.116.104])
        by smtp.gmail.com with ESMTPSA id 136sm7237678qko.12.2021.02.26.13.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 13:32:34 -0800 (PST)
Message-ID: <603968f2.1c69fb81.2485d.d5a7@mx.google.com>
Date:   Fri, 26 Feb 2021 13:32:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0827261043384659189=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,v2] monitor: Add option to set fallback width
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210226204953.6738-1-sonnysasaka@chromium.org>
References: <20210226204953.6738-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0827261043384659189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=439193

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
monitor: Add option to set fallback width
WARNING:FUNCTION_ARGUMENTS: function definition argument 'int' should also have an identifier name
#95: FILE: monitor/display.h:78:
+void open_pager(int);

- total: 0 errors, 1 warnings, 107 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] monitor: Add option to set fallback width" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============0827261043384659189==--
