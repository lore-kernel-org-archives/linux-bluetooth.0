Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD423C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Mar 2022 07:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiCZHM7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Mar 2022 03:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiCZHM6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Mar 2022 03:12:58 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36241F611
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Mar 2022 00:11:22 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id a5so7925106qvx.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Mar 2022 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rnXTElMxBif/HfIMD5Aec7uqqt/QG+aZwtxUHNzWu4c=;
        b=NCWBalIdGJfat2/Vtnw+jSnLlcbC4GBpNnP+pTv6+bdQ3Qg54clUo3g0VPajN6MSqp
         52CY7uydTYSgb6PJ7zq2ouQ6v2LNRZzwBmwU6MC88f8pk1koTQxZLxF4BH2sLf9FphVj
         nfb9iDr0QGLYB+OEhIo8eogdjU2/8L7t2/aO/oqowzgWt7G6Lj/1lc7axC3L+VWz8vCV
         Dhpt9N7GyvBd2y6zKaPtVhp0KAyVScC0aJap6yDPAfZ1U3MSWP+mHlQ9fabyKoytOZqZ
         vxbZofpfGbamsmBtgUaTldkvZbKp7GT3KXgESNm+1I+nrmubY6yQGzTneww3SvhaEvNi
         yLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rnXTElMxBif/HfIMD5Aec7uqqt/QG+aZwtxUHNzWu4c=;
        b=MAGer8frAoa9ktTT84fr/qtV6d1zbVKdnopHKKt2o+nvJdTABDh5AjdldmuQVT2Syk
         I3eHiksQ/mWilXb43jSDIqIk7xsDFtgfWmDY4+gxf4SW0rqkphRDYVwxq+yMOrjGuqRy
         ppsjb1w5B/OesCuA56wPM7+FmNJ2+Fc0k1bssHr2VgGsIFcrwkpDWZwEKkfmPJ7VWUD/
         4o0LTEnDvdEC+8gSVT5gHxMU6/EdR99j1RaWsaFLUDT5aQEFHdJlBtkh93MNK7P7fmf8
         pDLHteoBTfHOFItyOUOunpzZmqs+btbdaWUmtzFKMAHLi+Xpi4ufYwVQ2PWKPWRkj4Au
         gpyA==
X-Gm-Message-State: AOAM532hSNowZRctpkxOvfmx6eqqIjEB7830hElMFHxR98gFw/MsiGfM
        GFFAKJbX6Y98hQ0lUY60IygbIZCiqiru2Q==
X-Google-Smtp-Source: ABdhPJwDT6F4eKEV2cQoMv6DHPLUUVOE0ObgAPrIiXVF1aockubJrfIujbXByytnUVFqA9ErFG1WRQ==
X-Received: by 2002:ad4:5c6c:0:b0:441:65:4b9d with SMTP id i12-20020ad45c6c000000b0044100654b9dmr12450296qvh.11.1648278681774;
        Sat, 26 Mar 2022 00:11:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.231.39.157])
        by smtp.gmail.com with ESMTPSA id r64-20020a37a843000000b0067b0cf40b18sm4709156qke.69.2022.03.26.00.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 00:11:21 -0700 (PDT)
Message-ID: <623ebc99.1c69fb81.ea0ab.9c35@mx.google.com>
Date:   Sat, 26 Mar 2022 00:11:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2482292701540438169=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: Bluetooth: fix dangling sco_conn and use-after-free in sco_sock_timeout
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220326063415.1.I67f8ad854ac2f48701902bfb34d6e2070011b779@changeid>
References: <20220326063415.1.I67f8ad854ac2f48701902bfb34d6e2070011b779@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2482292701540438169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=626494

---Test result---

Test Summary:
CheckPatch                    PASS      1.77 seconds
GitLint                       PASS      1.06 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      43.89 seconds
BuildKernel32                 PASS      39.92 seconds
Incremental Build with patchesPASS      52.73 seconds
TestRunner: Setup             PASS      686.83 seconds
TestRunner: l2cap-tester      PASS      20.11 seconds
TestRunner: bnep-tester       PASS      8.56 seconds
TestRunner: mgmt-tester       PASS      135.33 seconds
TestRunner: rfcomm-tester     PASS      11.01 seconds
TestRunner: sco-tester        PASS      10.73 seconds
TestRunner: smp-tester        PASS      10.60 seconds
TestRunner: userchan-tester   PASS      8.91 seconds



---
Regards,
Linux Bluetooth


--===============2482292701540438169==--
