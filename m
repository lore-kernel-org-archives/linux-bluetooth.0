Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96052C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 23:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiGUXsV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 19:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGUXsU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 19:48:20 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0AF1EC7E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 16:48:19 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id e16so2566009qka.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 16:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=nMmtxKpmmmkKrDGM0NO4C66FYYwIyTNkD6q+j/Nhp9c=;
        b=ayd2xb3oymY0vDbvcajsTqVrVpCkc6CaTPsZJYxh4EL0iYfLSqr6pXKaNTtfIrS7bJ
         ur+oefhH3obzweOlBcOBMFwR1VZ9xI2x3VyOqSBKExmMSa1Frv1aiJVcgO6D/j6w+zMr
         g+OxsdeBMgiqx1RNvK5bu8Y7z/bDg+v6s9avzZr6GUNR/gsjt3C+VN1bsPMcFKgkPTpI
         qPySbPtpWePot7ALWWNcp9xo7RHBsr3VANan7xuw7RiIutJmFGuF/cuf7s5af34IDaEz
         pgLJ/yt4998fYSknzA3z4r0y0NgsJBwQQdh2qxVo+kVFFH8LvMgPv5VADEpnG3V6dnBC
         6ABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=nMmtxKpmmmkKrDGM0NO4C66FYYwIyTNkD6q+j/Nhp9c=;
        b=ACac8SxjUhph9MP3pt9cHa00spuSoeGAKvBLUHAPHkUmMbd1mJVMsMlQ9QDBEZdtsu
         X5eB8pt1eSqfkDPdLI1LjdFY5vDzaZN32vQRWVQ6JxbRyBBmSXzcGJyp+D+BAj0HthVd
         LBVRuc8vUmenDQ7r0kMRws2JKYkxT05oai/Emt2+B4Oi5OZfG8XsNL1tc8C/yT7LtydB
         DKfE8KT0vXtCmY+/suR/agHBrZtmJdIIYqwVbJzdFM7Zg2LXCAc/Qi5ukAwDzUKHkAcj
         4PWQ+shl/gisUksu/F3URoxVRgFQSCSGkYwlnx/S7XvHbELO2vsdAKRpfSggxK3SmetE
         iRYg==
X-Gm-Message-State: AJIora+VhE9bexFbpO6CIJK5IjUNH3oZ33H2l5BrcQKUsKiOPzJhb+ZZ
        fFT6t0eDiy3afMb5Kzwot6o2qCeliVc=
X-Google-Smtp-Source: AGRyM1sZ8iG18lRyTKoPqRygD0hyN8HQgU6CUIv0tDQeqPpBdcuySX+oFM7RfHbt6vpwChbYUedLhw==
X-Received: by 2002:a37:dc05:0:b0:6b6:27a8:e045 with SMTP id v5-20020a37dc05000000b006b627a8e045mr722916qki.402.1658447298640;
        Thu, 21 Jul 2022 16:48:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.164.141])
        by smtp.gmail.com with ESMTPSA id cd12-20020a05622a418c00b0031eaea83fc1sm2074065qtb.47.2022.07.21.16.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 16:48:17 -0700 (PDT)
Message-ID: <62d9e5c1.1c69fb81.7a290.6c21@mx.google.com>
Date:   Thu, 21 Jul 2022 16:48:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9123342703979613277=="
MIME-Version: 1.0
Subject: RE: Clean-up stale/unused hci_request.c code
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
In-Reply-To: <20220721225705.602002-2-brian.gix@intel.com>
References: <20220721225705.602002-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9123342703979613277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/bluetooth/hci_request.c:2269
error: net/bluetooth/hci_request.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============9123342703979613277==--
