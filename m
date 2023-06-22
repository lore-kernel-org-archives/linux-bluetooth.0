Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CF7EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jun 2023 20:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjFVURu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jun 2023 16:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjFVURp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jun 2023 16:17:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9531BFE
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jun 2023 13:17:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-25e83a63143so5590937a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jun 2023 13:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687465064; x=1690057064;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KiIMIlvZlFHp9wO2VnIaRQCJ3voV/y3dGSr5dRXlUYk=;
        b=ZMKyYfiz4hdOgpITliVbBmDwyrD5wY/cBmRz4ldK+t9e4W0lbStWflpSnLfGTdOF1r
         Qw30x71yjihxBLnFHA/W3/sEmbg3ZYAEEX215IUKLZim4hLmxR1Jpqs70oMEvrKQGbUt
         SAaUQ4mXm8lfDNxZeQ0XkOaGbIyEnVoMk7b1CTh3qa5hvrmZNTK/LUq31q54opOJ4KoS
         kWnSlPFX9ju4fggTi1tpIVNqRDyL7UR5TlWIDo9stAT83O5lXHmU70sklj7k2yuLWKpO
         vDSFy+gYWpoJDQpjSr71PUISH4O70ki2AuR06SO1b3jhqabd2/zXBFio6OmErhV4fJyu
         23fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687465064; x=1690057064;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiIMIlvZlFHp9wO2VnIaRQCJ3voV/y3dGSr5dRXlUYk=;
        b=WG4462Zg4cq0VIN9aPS1Ni4gDxPEixAU31gH7yC5PZId+NzwW1CNE9kES+BoFWCbuN
         VPD339jiwVvQPZve3NS5WS2kok7eGKuwmsX95WxhXFMvyEwQiqH7OupbIr4agEBcRPXQ
         mIwXi3q32Qv5+psxrGlFIh0XpVt65ir+LfoyEJ+PAzRZElECi1hIHNW4o0yKJuQ+yd3f
         cLXUssGI3nATsrPWtjANsgtIKAuvJdGEJA20iAfE+E5M2bijcw+BbMSpTvrQz4dSbmm3
         dJWxD63VL1AH7qIwNSyg+Lpg+86Dfpq/D7PdPARoyO+1PYpH8R9Krn6uWCKugPtqjyjF
         /1CA==
X-Gm-Message-State: AC+VfDzBNAoGQw3qhbz6Ou9IcAyFa/rtnR/jy3b1DSmfxBKlGoSqEyjL
        C6xxmiByNS7BiWcu12tt2uIkKC4eNIs=
X-Google-Smtp-Source: ACHHUZ43gizZzsQj1Nzf8NrDiC8nscMleDbAtfuNIZHgPh3ZViFPIp/EEca/9rrdEzFmg2EUiRtfxA==
X-Received: by 2002:a17:90a:8a0b:b0:256:2cb7:406e with SMTP id w11-20020a17090a8a0b00b002562cb7406emr19860276pjn.45.1687465063811;
        Thu, 22 Jun 2023 13:17:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.70.70])
        by smtp.gmail.com with ESMTPSA id ei16-20020a17090ae55000b0024de39e8746sm142838pjb.11.2023.06.22.13.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:17:43 -0700 (PDT)
Message-ID: <6494ac67.170a0220.d159f.0be0@mx.google.com>
Date:   Thu, 22 Jun 2023 13:17:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7680451226833803878=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] btdev: Fix LE CIS Established Event
In-Reply-To: <20230622190843.1242967-1-luiz.dentz@gmail.com>
References: <20230622190843.1242967-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7680451226833803878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=759611

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      27.25 seconds
BluezMake                     PASS      1008.24 seconds
MakeCheck                     PASS      12.06 seconds
MakeDistcheck                 PASS      155.83 seconds
CheckValgrind                 PASS      254.00 seconds
CheckSmatch                   WARNING   343.13 seconds
bluezmakeextell               PASS      103.98 seconds
IncrementalBuild              PASS      869.61 seconds
ScanBuild                     PASS      1090.43 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:417:29: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============7680451226833803878==--
