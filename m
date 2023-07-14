Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BC4EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jul 2023 19:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjGNTmA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jul 2023 15:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbjGNTmA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jul 2023 15:42:00 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F9C1BD
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 12:41:59 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a1ebb85f99so1911973b6e.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 12:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689363718; x=1691955718;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eq6lnUF4cfTXfb6Nvqacg/wnfAEpPEUIa83x2tSt58U=;
        b=FCkFGOReyM+f4P4r2VhgHSPraRZ7oH/JHw/quFdupmp2/P3opwcSWsoR5YiEIzriBM
         lZO11JZ3DdVffy0oVcN2UFMPrDwWvz/weZ++sS+Hy9Bm4C0iKUlliBfJrBQHi/+yjl0n
         6eR/Ga/HGFDca1fHvLZPs4aq5efioxiD7Sf2xwqxb1eHDKKZbSjmZd2o735Hyw6GIogX
         42q8abXKHOTDnyGe0+zwX8RjKEl63q1VH5tqy1SQU1U5sOaTT1fRNpaXWyoN801OVa1w
         CiTZuwTy5EjKUD3EyijsngPrXphIU5+8wlHDcaYw6NJPQHQqVthGBSyDLitD9MCQdPCG
         iuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689363718; x=1691955718;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eq6lnUF4cfTXfb6Nvqacg/wnfAEpPEUIa83x2tSt58U=;
        b=FMDf5PcITZaBJheI/lXuFBH573LtjCFhj0uFFhuj1N/D/lTJWDIPZlNjOi9LjJFb9U
         EfGop1x28Zln3oK6Yj+ejtNs6Rba1m6biIlYNtgyuVuhpjzejHTcVSJqtAQ0PgBKBd0H
         7dPU9yVSS+OP0L/90oFfpFwTGMmYySMtFaENVt5PzAIl82qB7RtYxfKaIoR3GHyRzwwm
         cfXR89FurfTjxkInUDrJMXHmL78EgdJ0mLtfJAq48/2KNTkxx7KMWjbV8mmbGzoUaHSR
         vD6MlsriMkf/l0qbKuEZvytoPzZCZbMiERlCTkuQJE9bXjeLFPPsL3LUsasl/vhMrVgr
         EeJg==
X-Gm-Message-State: ABy/qLbU0a1/mlauDFZy98BxeSCkIrkF4vpc4BPWOBDFppFQC6pPkmv6
        nVVoRCh3R1IZYpbQW6VMwJaSo2jFtC0=
X-Google-Smtp-Source: APBJJlEj2R8XLd1u3FzLgod6w/OOO+p4PO7MSoZNqluLlO1ypSTkWiNKC222ceQsHOfhB22CKYpiMA==
X-Received: by 2002:a05:6808:200e:b0:3a4:2a13:71ca with SMTP id q14-20020a056808200e00b003a42a1371camr8669736oiw.16.1689363718343;
        Fri, 14 Jul 2023 12:41:58 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.140.144])
        by smtp.gmail.com with ESMTPSA id q17-20020a056808201100b003a36f73a8e3sm4214795oiw.53.2023.07.14.12.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 12:41:57 -0700 (PDT)
Message-ID: <64b1a505.050a0220.286e2.c2b0@mx.google.com>
Date:   Fri, 14 Jul 2023 12:41:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7245615270238572394=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] bthost: Add support to set ISO Packet Status
In-Reply-To: <20230714181500.2371014-1-luiz.dentz@gmail.com>
References: <20230714181500.2371014-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7245615270238572394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=766033

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
GitLint                       PASS      0.57 seconds
BuildEll                      PASS      29.02 seconds
BluezMake                     PASS      1076.95 seconds
MakeCheck                     PASS      12.90 seconds
MakeDistcheck                 PASS      164.95 seconds
CheckValgrind                 PASS      269.70 seconds
CheckSmatch                   WARNING   360.33 seconds
bluezmakeextell               PASS      109.60 seconds
IncrementalBuild              PASS      1840.93 seconds
ScanBuild                     PASS      1159.86 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:584:28: warning: Variable length array is used.emulator/bthost.c:741:28: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============7245615270238572394==--
