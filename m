Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051D5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 09:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiBIJuF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiBIJuC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 04:50:02 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0023E03A99D
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 01:49:57 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y18so1714181plb.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 01:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=3COxJiEr68Vbg+fNVna2gWtxxXK+XhdEjJrlpyELaZI=;
        b=dbfTC2Nqm/tTtdyceCln9lzvW0JnJxVt+zYUbLKpysRdpIZ0LmDnpZY5JDC/Gfrz8i
         qi1A14hjW0mlHj3XujTG6PHzEV2aSs3a8MmsGgTPLUnjG0Awb8xGX8JTasoQgfzKPyHx
         03aebT2HcCs+5a7PJ9+1cx6DW0siJANT/+gZ3aaM0wKhrotG6I2QJn2elZhiBczESY2l
         Lohj0n18ez0OQgkBZdCcF1B1LZKaHMR5Q+1d0Tgk839CktUVsq3+v4E2Dvoe3VJBLnkU
         LkA6avPg0SoJkGkyT5tuj/o8M3AtOfhXvM7H12yxK1ReubdHLRQrVC+jANBxBNEmnh9s
         m4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=3COxJiEr68Vbg+fNVna2gWtxxXK+XhdEjJrlpyELaZI=;
        b=FK+YFZTnEeKbOBQMBV78gFeyPIKKEfiJia4RsrbHAhhMMRv8l0ddCVmmPsMqLAtU9g
         Vf/rOmMQvCmUzrqDzxDpKCwziPNMdQTGMhpHuAvV2s6yvlJwCMqe4HS2jdFObYLLucbq
         225fLMqBncYe0A94OTrbZTK7GLeM4tk0LBr38hUE1+5oyeipbX+M8/RoWTWlf4PAh+12
         FAtWWAWuvfpkZa5YbsMUgRC07raSwn1OjwmsMX2JwgGHIrg/T39xnpqnCU8RyORnHLD7
         1Efzf7x/FS1HwvMOp+Q4lyb/UPJ95TYMuR5Pd9QNSPZhdZ+sKfD01RqmaZEev6ME1leJ
         tt/A==
X-Gm-Message-State: AOAM533GPznGL0fIx9K1TYArXzoP8vvbvOAraIRlsjeyNIHGIPqi9hzB
        hK+WNndLrzfFMhpyPS/pbdXkrnGGeqc=
X-Google-Smtp-Source: ABdhPJzCy2ubI5024XHILxov1RU5nacPGHIdqvH/kGLiIsFZGhB76hS26PpWyyCW/OlSbk0t7wGvHw==
X-Received: by 2002:a17:902:900b:: with SMTP id a11mr1283724plp.13.1644399921144;
        Wed, 09 Feb 2022 01:45:21 -0800 (PST)
Received: from [172.17.0.2] ([20.69.156.224])
        by smtp.gmail.com with ESMTPSA id x23sm19145679pfh.216.2022.02.09.01.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 01:45:20 -0800 (PST)
Message-ID: <62038d30.1c69fb81.bc073.fcd2@mx.google.com>
Date:   Wed, 09 Feb 2022 01:45:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6909562259939276655=="
MIME-Version: 1.0
Subject: RE: [v3,1/3] Bluetooth: aosp: surface AOSP quality report through mgmt
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
In-Reply-To: <20220209172233.v3.1.I2015b42d2d0a502334c9c3a2983438b89716d4f0@changeid>
References: <20220209172233.v3.1.I2015b42d2d0a502334c9c3a2983438b89716d4f0@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6909562259939276655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/bluetooth/mgmt.c:8656
error: net/bluetooth/mgmt.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6909562259939276655==--
