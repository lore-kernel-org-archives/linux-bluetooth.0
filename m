Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60631EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 03:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjGGDZv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 23:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjGGDZu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 23:25:50 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A6D1FC3
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jul 2023 20:25:49 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-635e107642fso7151406d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jul 2023 20:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688700348; x=1691292348;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i/APkEFfA0PsFu8x3lxUG6CVNTB9XI5MZJsEBzCz9wM=;
        b=Po0esm8at2GiutbHpdwwiEV74kV2a/tv2Z3aFESoPP2KHbuAsayIFUdOO1pgD6794Q
         Mka/uqENfv+KTv4n+wYbQpzfbyO3uDyBRP67km2ioJU/km9u9WpX3xC9Ly9dvu/tD283
         /IYVgbhR+1zUwrYsZb5AH4cRIkIzb9tUKWc38/hCSYKMoyyzJ8VULNYlV4skvvydRyzS
         sx0s9sQwzuDVsXNY06D1PPGQDsw37xbZZB87h5Xg1fZAXJ3zizKX6PDUEsbaSgakR5HQ
         zMj47TegZa8MRCR1V+LyPz45DhVCEdWfN3jHCrVQ11/KMLoUIF5gK/84z1Vp+D5fbVps
         o22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688700348; x=1691292348;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/APkEFfA0PsFu8x3lxUG6CVNTB9XI5MZJsEBzCz9wM=;
        b=UFMH8UAj+4RyM/YD0Xx/rU/LusC8VX3zT7rxba9DRNTpNjH1MSw5eLFLnXQsCuFhRC
         IefPtWHfhhO58J/XGc/m4JovTsstqvOrt4YujIGcSMAPv6WSlNkedIn13tGXa+Fxd0v5
         BluF5dvZ3vhbGovyhkRyO0ORThn3i4YfrE2EbtVnNaOS5KKK7/LOnZmy92hZTHr/lk83
         +QcxFvbmGRIwJG8tknh26QIQwpzH2YyozOP3PKpZ3KsG6BFHBRwwPoOmrSjFGs1HAGrk
         16O1QTe+QQFcAC2OpqNpAmrrWCvmD+h+og/mi+KmZLpbNEBigA/ITwRn2q6Qe41Q6hb+
         naDQ==
X-Gm-Message-State: ABy/qLaR6XazWbabRF+Angtxu+immirWZxMUrNqEsjmSzkcnOTRK+AU6
        eV9lNydqGTDEiPWGjibSuCvgVehjgVw=
X-Google-Smtp-Source: APBJJlEOnqzxdmJdE0B+TFCKsGL5w5XBQPRp2M/2EMFl4y4ge8Rc7o8usRhvQ7qCuzd5VUMcIHD1ZQ==
X-Received: by 2002:a05:6214:d6a:b0:636:695:c84c with SMTP id 10-20020a0562140d6a00b006360695c84cmr9911736qvs.20.1688700348230;
        Thu, 06 Jul 2023 20:25:48 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.206.80])
        by smtp.gmail.com with ESMTPSA id i15-20020a0cf38f000000b0062635bd22aesm1582217qvk.109.2023.07.06.20.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 20:25:48 -0700 (PDT)
Message-ID: <64a785bc.0c0a0220.2cd61.4e61@mx.google.com>
Date:   Thu, 06 Jul 2023 20:25:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3150128919488862759=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [1/2] Bluetooth: btusb: Add VID 0489 & PID e102 for MediaTek MT7922 USB Bluetooth chip
In-Reply-To: <20230707025932.25083-2-chris.lu@mediatek.com>
References: <20230707025932.25083-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3150128919488862759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:638
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3150128919488862759==--
