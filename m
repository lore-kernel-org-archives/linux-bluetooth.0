Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56E8EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jul 2023 19:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjGFTMF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 15:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjGFTME (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 15:12:04 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92BA1BDB
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jul 2023 12:12:03 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-19fa4346498so1047156fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jul 2023 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688670722; x=1691262722;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6klDRDhVzKCep/QNcx/ikXH4k40cQSQpb4kWhWrmhyw=;
        b=Yy7Vcs4MbfL/rgwksgxvqu1uQqVvCfqOLyZONTZ5Wd/P2QDbwHz4iTN1HKgjW6+q5Z
         fIH2HlnMIHW7E7drIbVBaF4Hq2YaySo9GrFgV+lNp9iNZ/otHpEDcoLjb9NvY5jxN0BX
         x9Bx4A1pvc7hS84HjS/VB1M1+rWBesEFfOrFsM6F2ebT5PJHkeRdp8QdmjV6bRCh0soQ
         S/gwNtNZjPNSPppkFaNBvlrB7j5o2AMyDSpFRxPT3k+QGrvpHHgR3XdYMqalgBUoil81
         wJp4MkmZHHa8w1mP2qnCGH/c9anrrLuMMbd/DFo7JDrRN6AundMq4dBYMkpCoppZu7/E
         gJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688670722; x=1691262722;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6klDRDhVzKCep/QNcx/ikXH4k40cQSQpb4kWhWrmhyw=;
        b=eWOr6vMG6tK1sPQNfL7kFyGn8jYXOdpD0dzAXo3acTJcgDi/rww3EmlKtTZpP6FkYY
         pyVE8/T9x8SMbyf5fiBpkpCiH6fxXKN/ot3xK+pECdhHybiBwPS12CWnhftJnQJgVjFK
         r0+R6aKxTWoG2R5Nc47OxAjysIlq3tIwGWBv7oXqCioyRqVFiLWYvBzIo/D44VyXbOR/
         IOzhDgn7w0WqEeAtEQo8U2nz4VQBP5o0aa17G5WBd0FRi04vYOJ5zMkiGXBEMlC+ud1/
         g6ZBIU18O663eOvrx/5kGwK6CXnrnY4FyJR+0BChHNPaXMNaKPDiGJM3lB4gp1hPT9zR
         UoEA==
X-Gm-Message-State: ABy/qLZS384ntCv9VCWXcOlfVtxnzcca+ZSIwn0g1j8lJSC00yy8d6ri
        n+Yx0igPU0wzxxaS13VAVrspq5VQCDg=
X-Google-Smtp-Source: APBJJlEAiIiqYZOXKrIVslnHLwcHkA2vo3abhLKicWNx0VlTAujXiMTqK/mBJDubQrZGtgn+W/G21w==
X-Received: by 2002:a05:6871:825:b0:1b4:4931:d579 with SMTP id q37-20020a056871082500b001b44931d579mr725469oap.8.1688670722144;
        Thu, 06 Jul 2023 12:12:02 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.14])
        by smtp.gmail.com with ESMTPSA id q26-20020a9d655a000000b006b8af3a2599sm958353otl.73.2023.07.06.12.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 12:12:01 -0700 (PDT)
Message-ID: <64a71201.9d0a0220.1048e.5bbd@mx.google.com>
Date:   Thu, 06 Jul 2023 12:12:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4700002211429714709=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, valentin.david@gmail.com
Subject: RE: [v2] Bluetooth: btusb: Add device 0489:e0f5 as MT7922 device
In-Reply-To: <20230706191035.736632-1-valentin.david@gmail.com>
References: <20230706191035.736632-1-valentin.david@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4700002211429714709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:625
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4700002211429714709==--
