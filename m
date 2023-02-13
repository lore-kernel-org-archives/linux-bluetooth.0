Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678AFC636D4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Feb 2023 22:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjBMWf3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Feb 2023 17:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBMWf2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Feb 2023 17:35:28 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CB91E9DF
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 14:35:28 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id n2so5746074ili.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 14:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fYputjiwb95mqv5opX0xTg1jOUgAVltRdggivmJtlcg=;
        b=ZRJetM/dJU3n+5FV9typ4u6uYWe+Ct/OXpVO52cnQ3+eIY4KvOLAmw14KiAww1b//F
         5JsQ4fDlc70qL191f833l0TVaxpDL+Wx2n4aW6Q9q+/tStvUMh3jXpss1AbNnOckl64t
         /2DWk0G0ajjW9XcTeqNWLS48F5vt/uCP70jKqSNnuKl06zRUC8XTgWdwgHjw+vRacQfb
         3aPIOi5AY9o4OnCfl4JvThK/EmFaNY5CMMjl8HK7bsmFtU6igkGBxY0R2zmBKmp2IVuT
         ldMTDI5vn1VWHmm1030p2UeKwacEG24rfudOXK5LSm3kezzigvs8Y9l1vJcmgKNPdUqS
         2Byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYputjiwb95mqv5opX0xTg1jOUgAVltRdggivmJtlcg=;
        b=R2KtQlteBXJQufIuIvbp8huVtvRkJhdNIXVGgMo+jPcV94gFZFR2N6bTEVN2Bv7UgQ
         UjYg4T1PGnBD5f9SrhKOpgiJkZvTRUkjo5gGLKl6ATXCNZeNLZq5KSj0GxZCNw58pAfT
         QRT2t2sPjNgYLbNy7ben8CIlhSrSHi3bdUkgof0sb4w6ixtkkZDBPDqo61/W2OItuAVk
         5NAT47d9+QUyBNhpQ1O2rSUAwSNl9CxgtbOgHyoijeSjBYCUBaawERXzC6AnV9l2j2ix
         4zz6xLo3edvNclHnEvufSDpItWCN/xf9s52B9o8WhHK3K+DfZulZy6em+PsexiO2ZF50
         Ts+g==
X-Gm-Message-State: AO0yUKXuGELEepvRM4jZXX5PvXkAJaK7n3NLScdhi81V8LKZ3ur/xcJu
        fRXGIaqC4X+UsnEzmNu9zdEU1W0KOgY=
X-Google-Smtp-Source: AK7set/6bs/NNuiva7kANjFWovmxt7oKiFyBoLIng1KTYg77QVjUjjqMCVTOQMJkYoLdAd0A3TR2cw==
X-Received: by 2002:a05:6e02:152b:b0:315:498b:415a with SMTP id i11-20020a056e02152b00b00315498b415amr282286ilu.18.1676327727356;
        Mon, 13 Feb 2023 14:35:27 -0800 (PST)
Received: from [172.17.0.2] ([13.89.2.164])
        by smtp.gmail.com with ESMTPSA id h23-20020a02c4d7000000b003a96425c4c5sm4121066jaj.157.2023.02.13.14.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 14:35:26 -0800 (PST)
Message-ID: <63eabb2e.020a0220.de842.92b7@mx.google.com>
Date:   Mon, 13 Feb 2023 14:35:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1733539104158335790=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] media: fix crash when clearing BAP transport
In-Reply-To: <8355ef6eaf7bf6b1d82d03580de9a1d18ed4f152.1676323061.git.pav@iki.fi>
References: <8355ef6eaf7bf6b1d82d03580de9a1d18ed4f152.1676323061.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1733539104158335790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=721448

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      27.10 seconds
BluezMake                     PASS      868.57 seconds
MakeCheck                     PASS      11.43 seconds
MakeDistcheck                 PASS      148.31 seconds
CheckValgrind                 PASS      243.86 seconds
CheckSmatch                   PASS      325.37 seconds
bluezmakeextell               PASS      97.78 seconds
IncrementalBuild              PASS      713.08 seconds
ScanBuild                     PASS      1006.56 seconds



---
Regards,
Linux Bluetooth


--===============1733539104158335790==--
