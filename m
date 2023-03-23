Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECF0C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 21:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjCWVNA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjCWVMw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 17:12:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DD225B8F
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 14:12:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so3368256pjl.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679605954;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w+d5wC9oxknSIhHIewZ8wc40sxEWTLaSTCpcHLTET/c=;
        b=MFLGtzIE32SQWo+r8nkXb6+zIyWPZzpihz+CwP7i2ZS/rr2JQlm+7KXnAQ56Tn3SIB
         YJyoz9esk3TGywl7+2LPaDtLzlNrelL91e7o0EJJVp1pkxSuACFvl8P2b+BqYwMLJ7ux
         CCUxzodtriUqraUUE+tn40NsVyDg7mSFi7Mcm75nSiAMNfTlqzqmS0bPRnZKzOYH95mf
         RDFl8NPF/GSQ6IttXNmqZYJBR46zzAHAisKxZZqueVJsZ6oGTCt2BLwe6Nxlj1cvYtet
         wLCjfkzH5J1Cr0RxhoMRwzJc5j2xQTscRmUtQa2POG8/1sc5Y1w1tGRTvCAJmSBmdE/F
         1MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679605954;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+d5wC9oxknSIhHIewZ8wc40sxEWTLaSTCpcHLTET/c=;
        b=4Fq7lPTB8ofYfCDpPW9EQf6HnBKVYXTyDCNH+lxDH7EeYM9dYmQZfQXfm5VUXklked
         DsMwUyB+mKKlse4GxQRiLt6nHz2fK7wRTzzC/BRQTPNu88vtYSJ3elIAfHBPOhYpuJGL
         qP3Ri9OiU5bB/gddHOrGwVpFq6jhhErhy5rUts06PeFNJAEVR/wXDpp4bBntYtMa1aHl
         0udm4SdINkn2HRusboHOIBHLGg5WTo55voX+5U7jape9RtGGFsREZ+XETkyrT5Uj22ou
         xQDcy0MDaANBBWg/DpVhUE7n6S8sDnS0mR9K5VndyKBJwtyIY2P5h1Ku9liBdZEzxgsb
         eFhw==
X-Gm-Message-State: AO0yUKWUBlcxRoSIAyiosuIahKOiDpET+oDq2dtWC12vUi945c6pOFZ9
        eRYB8s7OqfNImtA+nm2af8dDkhsUPjE=
X-Google-Smtp-Source: AK7set+pd2/TktUbq4GTwhBLQmMoeRXqjq3v9Mm46GEP0GY9qwH2d3IYfROEAEUlDioIF28bWEWXFA==
X-Received: by 2002:a05:6a20:9305:b0:d8:cfcc:555d with SMTP id r5-20020a056a20930500b000d8cfcc555dmr790772pzh.17.1679605954300;
        Thu, 23 Mar 2023 14:12:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.45.233])
        by smtp.gmail.com with ESMTPSA id i10-20020aa78d8a000000b006281bc04392sm4787074pfr.191.2023.03.23.14.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 14:12:33 -0700 (PDT)
Message-ID: <641cc0c1.a70a0220.1df3d.97e5@mx.google.com>
Date:   Thu, 23 Mar 2023 14:12:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0357253700048326638=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jay.foster@systech.com
Subject: RE: [BlueZ] btmgmt: Fix typo in command help text
In-Reply-To: <e74f4f62-ff59-b2a3-47d9-2b3edad9265f@systech.com>
References: <e74f4f62-ff59-b2a3-47d9-2b3edad9265f@systech.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0357253700048326638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: tools/btmgmt.c:5897
error: tools/btmgmt.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0357253700048326638==--
