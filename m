Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9232C77B7F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 May 2023 22:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbjELWGZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 May 2023 18:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjELWGU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 May 2023 18:06:20 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC45210C9
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 15:06:19 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f4fc2a4622so7379261cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 15:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683929178; x=1686521178;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r/WZ/zXlepoEAyX8+gzrh0s65Bb91saAdL3DWaZWfeQ=;
        b=aRyAdeixB71xjSaseuNyTqj4OZFhoNMollztuYEuu18ToMNdA0XIi1eX1JMoZ25fFF
         hsRPCpN4Ly8jrUuwvyNQ6SrYkgYrvzKp9gWMLfWDfx8IVE6PC/NMPuVWDRwNlJNnQmwY
         SsCpXbYK0wQdz9aDC7yxzxvrauFfmqDLhORvfhGgDKEOLGI2+GhvdaHiWR2310AOo9p6
         uf624Sztp4EK1fwR2RqNAFcostQ66DwKvqr0IBpB3caveBYyiPQ54CyFNXxTW7I+6sOT
         y349un1lk0iS83M2utHtdqVnzSpYI2Zno2Kp+b/kqjITmhP9A3E/f8kePdOsJo8pl3eb
         3iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683929178; x=1686521178;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/WZ/zXlepoEAyX8+gzrh0s65Bb91saAdL3DWaZWfeQ=;
        b=YpNLnYqC/UrH99u5oCjk1upLcUe3kINAQ15lwdiwNSRB1H9/FTeZsM4Rz2TkoFiXv0
         LW3NLc+vLO6X0jXsh8p4y1Do0HGNfkHAZ0gkru+Gmn/XK8Ns1klmn4BGrMHt3POw0Hkm
         2YaCTG4Geez6b1w6vY4pXHPMXRs+WFuBv77+lmzkNWY87Oeh5WEaSV3aeTWantIEbjh2
         vTf0mArXIAV1T2MYrNN1HR7fEunkED8lmrybQQTVGrHRHmw4n4jrogABM7bBt7Wm2TbE
         3rELlLpGokKu8wt95K+Et4kKCm/xtsJPZIswTeolfWRdF3cdj0y1R4D9g22JE5a9M5c2
         2+Lw==
X-Gm-Message-State: AC+VfDwvb9I9okjXjFyCLF8lm2Ad7ik4Y2TI0ybBepBoJ748igxRGySf
        vwd3k4H6hxP4lzCvFTeFKPIV2CW7Bwo=
X-Google-Smtp-Source: ACHHUZ40vTqAGbQY00VBgnMAqyh7i+N2VGOTBpfk1wm0Eg7qlRGF5/faoceqcmQEGlFNfqCqHiCpaA==
X-Received: by 2002:a05:622a:1650:b0:3f0:b026:3991 with SMTP id y16-20020a05622a165000b003f0b0263991mr44731542qtj.32.1683929178590;
        Fri, 12 May 2023 15:06:18 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.106.82])
        by smtp.gmail.com with ESMTPSA id a10-20020a05620a102a00b0074acdb873a7sm5627083qkk.86.2023.05.12.15.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 15:06:18 -0700 (PDT)
Message-ID: <645eb85a.050a0220.f3217.abca@mx.google.com>
Date:   Fri, 12 May 2023 15:06:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7259966113881005360=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client/player: Add codec as parameter to endpoint.presets
In-Reply-To: <20230512203507.4146233-1-luiz.dentz@gmail.com>
References: <20230512203507.4146233-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7259966113881005360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=747185

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      26.35 seconds
BluezMake                     PASS      756.71 seconds
MakeCheck                     PASS      11.61 seconds
MakeDistcheck                 PASS      152.87 seconds
CheckValgrind                 PASS      245.82 seconds
CheckSmatch                   PASS      329.72 seconds
bluezmakeextell               PASS      99.86 seconds
IncrementalBuild              PASS      637.77 seconds
ScanBuild                     PASS      990.47 seconds



---
Regards,
Linux Bluetooth


--===============7259966113881005360==--
