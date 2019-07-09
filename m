Return-Path: <SRS0=Cqm8=VG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_TVD_FUZZY_SECURITIES autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85DFC004EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 11:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6205A216E3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 11:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eslLs9oW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfGILkU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:40:20 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:33570 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfGILkT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jul 2019 07:40:19 -0400
Received: by mail-qt1-f171.google.com with SMTP id h24so21313002qto.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2019 04:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xAgm/6tAV6Hs1+Muq358pFsoWmIR8i1rKIUTCo9qBlw=;
        b=eslLs9oWq67nB+HbVMNYfRp2HzcxLNL3PdmewrAc8IoLm21ENuj+mQUoGK6+55ysj2
         c8zAPPpivWqYEt+eak3oTG6jUJvc51bFSKDYl7WSO0RsxC0rX9Bs+wA9n3tOUKRho3/7
         lEMHjBKPuUBNfoZVgExVrt9OqPlF9eBfL1O+AA5UGW2sSTepiW/6KgE+lSHXJeIorrTi
         H7MseZhhMDat2dauSFoRyEjDqedfbBqwQRlCIoCpKPhB/1coBTSXMWTWbyqJLMTZMeVp
         huRTJME+wXZEMaFJofuhcnuvK6HYd4HTywK0r6VxevAvmvGpbD+uC4Ang12LD6AAoTv5
         4cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xAgm/6tAV6Hs1+Muq358pFsoWmIR8i1rKIUTCo9qBlw=;
        b=kDojqutxOjEHTEF5uhWi2k0lxP9uTtyAmB16u40z9CtFVdkHoAYlKYQ+ku3MY9Vx7k
         63TU6N2cwKSWK8IwqOWvI4c5Bnxj65enO81Bq21OHLDRzqUyh+1bFUP/up9rAFpGtXPy
         IMSetpEW02/mM0DmpUd3BZJjx1RzqLcNaQRfCpwYUmwBr5YGBTZqWFb7zrheNb/cyJU4
         H64fLJKMIzteyoNIR3uxYmXqTOSeTOE15ee03TSJN7hNEYlwxDyROnFvNNhvBu3QDF11
         LFqhlcPptb9XG1avujp/bYiFoqVthHTRhVWDPTjafhwULlAkkrvSMYu3WTqwMOdUy+CZ
         XtOw==
X-Gm-Message-State: APjAAAUHwNLaTQXjLuAe2V4mV0ucYxnig715nnHfiv5h2yM6xpuY+24f
        ez0eZ3rCdW/fj8IMwMhm0SWTT7KjiUorIAYaOLT9ZiXRbOM=
X-Google-Smtp-Source: APXvYqxqMxwPSeqRWXg2Wl7qn3QbaPBevZ+VQzDEbkK7qpQq4g5aeCHgNn2BqTrD1lRcCxVd8YWlpegPdHQuBlhZVLk=
X-Received: by 2002:ac8:180e:: with SMTP id q14mr15963593qtj.327.1562672418626;
 Tue, 09 Jul 2019 04:40:18 -0700 (PDT)
MIME-Version: 1.0
From:   Axelle <aafortinet@gmail.com>
Date:   Tue, 9 Jul 2019 13:40:51 +0200
Message-ID: <CANKzOHD7JyDDv_3=HWH3CxD-F5uc2p37Lh9Zp9hVgFeN1uDNTQ@mail.gmail.com>
Subject: Connecting with security mode 1 level 3
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi list,

How do I connect to a BLE device using security mode 1 level 3 please?

With bluetoothctl, I do not see any way to do this. Instead, I
connected and then paired. It said success in both cases, but then one
of my write requests is failing with "Error: Insufficient
authentication (5)" which I assume means that I did not get to level
3.

I tried also with btgatt-client provided in bluez/tools. I specified
"high" (-s high) level but I get the same issue: error 5. I had a look
at the security mode with "get-security" and it told me I was using
level 1 :( I set it back to level 3, but actually that does not seem
to do anything, it remains at level 1 !

sudo ./btgatt-client --t random -s high -v -d MAC-ADDRESS
[GATT client]# write-value 0x0014 0xFF 0xFF...

[GATT client]# att: ATT op 0x12
[GATT client]# att: < 12 14 00 ff ff ff ff ff ff ff ff
[GATT client]# att: > 01 12 14 00 05
[GATT client]# att: ATT response received: 0x01
[GATT client]# att: Retrying operation 0xb0d160
...
[GATT client]# get-security
Security level: 1
[GATT client]# set-security 3
Setting security level 3 success
[GATT client]# get-security
Security level: 1

I am using Bluez 5.50 on a Linux Mint host.

Thanks,
Axelle
