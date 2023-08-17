Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D983CC678DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 22:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345812AbjHQWov (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 18:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355954AbjHQWoT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 18:44:19 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1592A3AB7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 15:43:59 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40ff82320a7so2355271cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692312238; x=1692917038;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uuHv7Ld2A18t/BwjTM0AHiKIfqUwBqRKGYI4KDvfuQE=;
        b=fhsG2CrtY0zMWsKpU5ixlKY+jO8ZNJh5p+2DQWbIl9KkEB6QfIUeicYI4iGm7Xp2Cp
         KTOVHgztfyZ/n5coPCyCG+756Ox28Jsu9NezsNI9CUc/wU4L5AkLzGF8ofbnZe6KHliF
         kITjxU/bRePayomkwQx/zOE7zNvdJ7v6eBl6/4coj0S97xGYPWPMMaTWmVSebmTuu1pv
         MsvFkpR8PD9Df86BWDsI/O0awejMumglFTqqoMhx8nImBuCaleg71PaOy0moFx1v5JMK
         XhZH/34zFG2RH12gg2EKIsw4xQDBpva/Xoa/A3niSzUVg7tG6ehRaVG5nGWlIEWwqNmW
         4DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312238; x=1692917038;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuHv7Ld2A18t/BwjTM0AHiKIfqUwBqRKGYI4KDvfuQE=;
        b=Xo5/FXTA5Aen1GlUgmr3pWrslAHMOlVJ0Bxm94irO/ogjMapzZdDW4ru6l1XO/nR3y
         wzwyIgbumG6qVtLUWujaVtFO1rrPVaPyqy+vHEjeer6MRyojT5ArqKMPsV6OSM1yRU+g
         nWKkIhJaBVzbEtQdIESZZ197QHXnSd/8OWTYbWPNY78eVb8DTAQMJX0QPmCn1cZL+2le
         wpvmVKa7mcQhu/1dux5+4HVV1MIdvF0RPzCqcLTyU03doJRGCF7g3XMkiMxhe3NOvcmx
         gV+sP+Ac1iqy+3VG3WzNV068QR8HXgZzEoBdHHPETLiuKqP8yQ0lhkSF9zK30vuBFAbK
         S0qw==
X-Gm-Message-State: AOJu0YymXMTxXSrtphhEpdchzI8SBa35m+Ba4y//hkKiFZ8/ywrESCvc
        1mHHGmyQYm8NCgq/7NoPx51lMngUovM=
X-Google-Smtp-Source: AGHT+IHQKkYWuBIEucx7J+p8qPdSY7DT40d5HVD5C/JaBf6wJ4Ibi7iYcVryUvh3n/Njl2wRxvkDSA==
X-Received: by 2002:ac8:5916:0:b0:40f:df95:213e with SMTP id 22-20020ac85916000000b0040fdf95213emr947618qty.58.1692312237882;
        Thu, 17 Aug 2023 15:43:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.155.212])
        by smtp.gmail.com with ESMTPSA id z4-20020a05622a124400b00403c82c609asm161140qtx.14.2023.08.17.15.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:43:57 -0700 (PDT)
Message-ID: <64dea2ad.050a0220.7cf5b.1149@mx.google.com>
Date:   Thu, 17 Aug 2023 15:43:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2116366490416949468=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] profile: Remove probe_on_discover
In-Reply-To: <20230817212606.3024276-1-luiz.dentz@gmail.com>
References: <20230817212606.3024276-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2116366490416949468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=777179

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      28.31 seconds
BluezMake                     PASS      1050.01 seconds
MakeCheck                     PASS      12.08 seconds
MakeDistcheck                 PASS      164.09 seconds
CheckValgrind                 PASS      266.26 seconds
CheckSmatch                   PASS      356.41 seconds
bluezmakeextell               PASS      108.54 seconds
IncrementalBuild              PASS      882.73 seconds
ScanBuild                     PASS      1119.15 seconds



---
Regards,
Linux Bluetooth


--===============2116366490416949468==--
