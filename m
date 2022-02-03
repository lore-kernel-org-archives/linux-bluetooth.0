Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFE9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Feb 2022 05:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiBCFNC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 00:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbiBCFNB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 00:13:01 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EA8C061714
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Feb 2022 21:13:01 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id g13so1665410qvw.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Feb 2022 21:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3Gcpnj3GbjHG83moxpOUF3YSI8YycFSYS/SHKkgfDW0=;
        b=AMfWTD0CbA3hVYkGYj4yZAHGytP9fEiYJkbQ0cBXfFd9P1d21aJmnmXI3FdKqu4SHw
         ykRjFjARVFJLT8Xr6lznE2Jxp4lTdbi+FHYbr3wsuJmdyz9Y1N/U8JrhMrGXqKYQ5CbT
         7ysUfjETk7+ojn0mariugw1Qi5itmnRe2n08jvTlGRwfW/Al9MRINIV17pT92hdqta34
         INP3KllMvWWH6UfSZZcXZC++XnTZEsKvsuo4FkNL+pliIInX37mnUTnf9IpnjzeUyy+p
         pw4cIOGbeLISRBZUOOs/Kg7YLxhVn+7CdVujXoV+VaLhb5Z9B+V34U5e7XcXqnS3Ph5n
         goaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3Gcpnj3GbjHG83moxpOUF3YSI8YycFSYS/SHKkgfDW0=;
        b=D1RwvdXVZPdUZiAihipwnWNOMqK+pHH/g7Ake25gr1Hsz7UDF7nNiQxzQSkypDSItK
         QS9Df/PYwOnfi0elcftio29v7d4+ayfUeBqJd9bXdrv9tlwpwa6IqpooNqajRhgxpyEI
         TTT92FdXyPMObRD8/6pp9G4zlafBLaAnE4SZBHw6fLIB1bmmOqBb1aWZ/Cg7nc9lEo6C
         vcoESqTiBxgXJljEq/ofnVXMPFenywLE9SC6fqFaH9M4rZglNMUHLy3Fkh5o6sfZY8PY
         5tgLCa8mahzMeVopy2rSJRyOZrE/AFkBWgPvvWqnBP+IGZ+PR2btHCyuxxkmkgi9pKWK
         7hdg==
X-Gm-Message-State: AOAM533RfwQ+HIiD9Klhmda/GEHPDDlLAHEuxqCjN+5EkDg6Per0kXt8
        R5MQ8/ORztIxPw0iXdvMbIRfg7YEncY=
X-Google-Smtp-Source: ABdhPJxRVq0MyNWDewH3u3XMwbEKSeYrxrCD9oY2jsv/vCqmn+EXPjMkCRzeGp+X0e3UPcS0cnSlIQ==
X-Received: by 2002:ad4:5942:: with SMTP id eo2mr29503455qvb.29.1643865180731;
        Wed, 02 Feb 2022 21:13:00 -0800 (PST)
Received: from [172.17.0.2] ([20.62.111.27])
        by smtp.gmail.com with ESMTPSA id a14sm1278495qtb.92.2022.02.02.21.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 21:13:00 -0800 (PST)
Message-ID: <61fb645c.1c69fb81.374cb.75ca@mx.google.com>
Date:   Wed, 02 Feb 2022 21:13:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4591428739123163228=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kuba@kernel.org
Subject: RE: [net-next] net: don't include ndisc.h from ipv6.h
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220203043457.2222388-1-kuba@kernel.org>
References: <20220203043457.2222388-1-kuba@kernel.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4591428739123163228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=610900

---Test result---

Test Summary:
CheckPatch                    PASS      2.97 seconds
GitLint                       PASS      0.99 seconds
SubjectPrefix                 FAIL      0.88 seconds
BuildKernel                   PASS      34.97 seconds
BuildKernel32                 PASS      31.56 seconds
Incremental Build with patchesPASS      44.18 seconds
TestRunner: Setup             PASS      554.52 seconds
TestRunner: l2cap-tester      PASS      15.40 seconds
TestRunner: bnep-tester       PASS      6.96 seconds
TestRunner: mgmt-tester       PASS      116.67 seconds
TestRunner: rfcomm-tester     PASS      8.70 seconds
TestRunner: sco-tester        PASS      8.99 seconds
TestRunner: smp-tester        PASS      8.75 seconds
TestRunner: userchan-tester   PASS      7.12 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.88 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============4591428739123163228==--
