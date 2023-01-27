Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7310FC38142
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Jan 2023 13:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjA0N3u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 08:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjA0N3s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 08:29:48 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41FC77517
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 05:29:47 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j5so4620351pjn.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 05:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DOY9At67p67kR2ShFWKaU2Jb60HkMgJR48ajnIni/No=;
        b=Pe2Jf3mUhjNWZMigOuPorjncxOAs76EVXGsgRxCMdp1kKYseILIy3dBMDj3vSwLE1U
         Ihs/XHmuFm+z3sufss1MCWpjxaK3Trbk5Q+4lFk3TO7ObI/NTnd7ux2gmHksjRalo2xQ
         Gy624vomhRMRPXqiQEH9R9euUs3a5H1mamFnmHRW06PVWS5lNcKQ8pLwpAtZ/RJAT/gW
         FXhFZkKR6mTNTwJatqq4WPh43tmu+TL23r/3H7sbXU7LXnw7DMnKktlAJbiW0q3F+nqk
         vF64lObrnnoEXHUjF+ozp714roQ8HhYquGtCU7/5yth3YVxnjuKOA/1tqR7CK3ke6rR8
         k1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOY9At67p67kR2ShFWKaU2Jb60HkMgJR48ajnIni/No=;
        b=1Usx/6aisEraXsXLSfq1vwlkXAm33VWWE4CFfM8vdHftDvEPkJAzk4n2sbp68Mlsnk
         ullvcsevmKIwtfKfdSQ66LLITz+j00qjRrv+g81j075rT3jf/S4OwMXVkLrsGo0+kgxe
         A2F4GXjDgR5TDB4ow98A7YHkXteUAHIGt8f25j7qSUqodEzuxwPS7m8Jgtw+zD+UKJof
         W+Hav4QLc46uFQ5igNf9npYF47Gin0ooTjVmxu3HwQzG6vLSMREqfW36udF9rz+wVtcV
         yzyUPxHvm52N1MhOPg1tfwj+mGj5Fw3fJ1KMo2e4Pu0P9DkJIU0L5oZPL55641H/LUGX
         87Gg==
X-Gm-Message-State: AO0yUKW73FmOZZtLzxUZ+v2eTmavbvEeGCXjsgdr/aVEGjjc85hZz8KP
        okdMbHQmZK4y1MIzBI5vmaSIt2TMiLqz+w==
X-Google-Smtp-Source: AK7set/LW/Jnxw4OMUKQ0nk5KtqwRnhH8LTxvISa7Dad7XTD7a7jJNmN3ybd5pKIYBMN5FJ1wNtESg==
X-Received: by 2002:a17:90a:1a43:b0:22c:906:aea7 with SMTP id 3-20020a17090a1a4300b0022c0906aea7mr10325530pjl.36.1674826186707;
        Fri, 27 Jan 2023 05:29:46 -0800 (PST)
Received: from [172.17.0.2] ([4.227.9.19])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090a404300b0022b787fb08dsm5102118pjg.5.2023.01.27.05.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 05:29:46 -0800 (PST)
Message-ID: <63d3d1ca.170a0220.6b19a.884f@mx.google.com>
Date:   Fri, 27 Jan 2023 05:29:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5288312091572336714=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marcin.kraglak@telink-semi.com
Subject: RE: [1/2] shared/util: Add CAS, HAS, TMAS and PBAS UUIDs
In-Reply-To: <20230127113504.134109-1-marcin.kraglak@telink-semi.com>
References: <20230127113504.134109-1-marcin.kraglak@telink-semi.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5288312091572336714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=716204

---Test result---

Test Summary:
CheckPatch                    PASS      0.86 seconds
GitLint                       PASS      0.47 seconds
BuildEll                      PASS      27.10 seconds
BluezMake                     PASS      744.08 seconds
MakeCheck                     PASS      11.42 seconds
MakeDistcheck                 PASS      146.04 seconds
CheckValgrind                 PASS      237.78 seconds
CheckSmatch                   PASS      316.33 seconds
bluezmakeextell               PASS      95.14 seconds
IncrementalBuild              PASS      1217.19 seconds
ScanBuild                     PASS      985.60 seconds



---
Regards,
Linux Bluetooth


--===============5288312091572336714==--
