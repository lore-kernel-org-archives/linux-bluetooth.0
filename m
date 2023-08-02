Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672DDC001DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 16:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjHBQPe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 12:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHBQPd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 12:15:33 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8F5F2
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 09:15:32 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-799a451ca9cso2635241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Aug 2023 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690992931; x=1691597731;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RO3amrJV2ha4O6kJcRR2uQSVWGAYghGluiVWFFVBiNw=;
        b=hFdzFrk46CVjYjCXVR/sKlJ8r5YRrWo+UaHGwaSX9U3VbsJ4Oq7CJQDPu2ioVex2EU
         Uugv5Mhn0AuboMwRCJfOPe8ygTdz6vahhYaliVdNV4wek4HY1G/8sdhGyR6C1d8+kkrj
         3pzZkQG4MpcgDKVsM0Pe/t8gXIwEOSF54AaF+hgexwbRoydC54IBwuwsqc0uJAnn4sYX
         aNPmCTNF/oUemRCB+JqDAX1a/4lQaXIF8FdYOUjhJmHcpdpF4vV/cDJaFGNWFqUcaPSV
         O//J1YI28mmqinbyd/aZ4t28UFCHoep6vhCDFWrP3f4k4/tk3TkUKH4zzDFpbETWLBvZ
         U36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690992931; x=1691597731;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RO3amrJV2ha4O6kJcRR2uQSVWGAYghGluiVWFFVBiNw=;
        b=TMXZPWAfo9+SVb4ECompbC1ml8y9B9Znxdc1CjAddwzFrVs3U++Kd+3MADzBWVpv0J
         WTZiNYO+exZY7IOcan6s/LKzBgUPOjehwYbbJ3YXJCtsnEjp+CaXcgLUE+vNz9D+8xfL
         agbeMG/uiLOQSQeRwlS+p7swvKQnzJqDGT/yPYUBR70kxKXhKbqsNnfBjIfcq0LU8w5e
         FrWCtKTUYwX3vU8cvobNM1Bfj3MzhpeCFVZ9oE2eVMH6x6Smxo0mgDrLVXREohsEwhfL
         MeQvYVcOTbfx97mifQxYd1VtjP4O/BqfjDK4ksVH+lsA1ChNWifhim5TRTMgtctAeIfi
         p2wg==
X-Gm-Message-State: ABy/qLYxMLaAI4DlRisUdrFcNUcgAhbTpGneEKbBhGRN4zLc64S8Z5bO
        f4XCfD+PGKJ60NlhsirgDC9ZGFNlci4=
X-Google-Smtp-Source: APBJJlFqzrXfDsC/hkJSrPygOVe9AT6uO29yRh99X/ejTzbztujURcVs8GMqS+muduUAHbwdIa/Nsw==
X-Received: by 2002:a1f:3dcf:0:b0:481:2c13:eabb with SMTP id k198-20020a1f3dcf000000b004812c13eabbmr5482941vka.12.1690992931507;
        Wed, 02 Aug 2023 09:15:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.255.6])
        by smtp.gmail.com with ESMTPSA id hf22-20020a05622a609600b003ef2db16e72sm5359720qtb.94.2023.08.02.09.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 09:15:31 -0700 (PDT)
Message-ID: <64ca8123.050a0220.81aeb.42dc@mx.google.com>
Date:   Wed, 02 Aug 2023 09:15:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8343481191118469215=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: isotest: Add defer setup support for Broadcast Receiver
In-Reply-To: <20230802144447.59985-2-iulia.tanasescu@nxp.com>
References: <20230802144447.59985-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8343481191118469215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=772206

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      28.22 seconds
BluezMake                     PASS      904.95 seconds
MakeCheck                     PASS      12.18 seconds
MakeDistcheck                 PASS      161.53 seconds
CheckValgrind                 PASS      264.43 seconds
CheckSmatch                   PASS      351.71 seconds
bluezmakeextell               PASS      107.06 seconds
IncrementalBuild              PASS      745.62 seconds
ScanBuild                     PASS      1121.18 seconds



---
Regards,
Linux Bluetooth


--===============8343481191118469215==--
