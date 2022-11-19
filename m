Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3878C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 18:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiKSSRY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 13:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiKSSRX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 13:17:23 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5FE13CD1
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Nov 2022 10:17:22 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l2so5079513qtq.11
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Nov 2022 10:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqSOXTkAAvVNeZW3+U7TJ8GZE6OFhdZAeFaA4kqX+8Q=;
        b=YBeQXjDFi9E0IW8WT8JbvjGPNSiunSB/nUuhpt3MVd1OOXt0CebTetKBTOcJDqZgpS
         j2gSu7+2SMErXG9r1fDHANnw7pP8FDeBqXb77LA812sYXaOX15X/zJMgWSyLreMPzExq
         QeCaqoQ4hpQi1W86/IUT7z+4Nodl3Rz6f7XV3uiCV5KWghun39RBPCvF6s9kI0TL8h6W
         SMTLmQK1yzHH1TSUKn1EdZVP/EmAfUSQLHvjKFRVVLU93VjX4EdJ8C9p4zrNc7aas3ZL
         m3m0S7EfWoneKXyHb3rbgdQnJjDFobhZ3bQl/h7Pob3qOk8jjbJa5YBy7i4an5UQt9CV
         DFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqSOXTkAAvVNeZW3+U7TJ8GZE6OFhdZAeFaA4kqX+8Q=;
        b=MRJMsSphNWT0hnWRCqF4WFBjeyL8Gz/4nkE5XXSDYBD5g7aXyE/vUfLMfmBTUkzRct
         SadOWAe023Pmr5w//7c0Eet38Wm2CYty44ApIavqz/eC9PBI9x2vY55brtGp2keE8Hfb
         iyt9L/2FcNcDq0UbqWfUb8GK827kSJrVFWVdpkOzDOLlKbhXrJpRCyN53S6G/YE2mj76
         PJrRutKSlt+To4vdbX0uqAn89XIUwoZE2Qd7x0J2hmL+w58RSsxlpCKETkHN1IMFMkxG
         +Qbw52BT4I6ESf2OKoZT7vzJLutWC3a9dDRYVjKBnVTBGzSr9T1wqk4BWNABH9KIAoyA
         EFRQ==
X-Gm-Message-State: ANoB5pk85+x1BICBvIm34Vj0Bsc0xUMIi27ZJ/dSniOdzGoXRmLDaemM
        uE2yr9vuKtq/V4bwQjyYEVtHQFtTmc8Gdw==
X-Google-Smtp-Source: AA0mqf7zB5a7QYEZZQUUUccvKwgGP1sAtbR3hmdjrrsgsKtyP0rb7OceNhkzrOtnzf1/q+KMZ5cnsQ==
X-Received: by 2002:a05:622a:590e:b0:3a4:fcde:733d with SMTP id ga14-20020a05622a590e00b003a4fcde733dmr11843467qtb.269.1668881841495;
        Sat, 19 Nov 2022 10:17:21 -0800 (PST)
Received: from [172.17.0.2] ([20.120.80.72])
        by smtp.gmail.com with ESMTPSA id m19-20020a05620a291300b006fa43e139b5sm4882411qkp.59.2022.11.19.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 10:17:21 -0800 (PST)
Message-ID: <63791db1.050a0220.990b5.4497@mx.google.com>
Date:   Sat, 19 Nov 2022 10:17:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6313457246720187537=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, MihirKhatri@proton.me
Subject: RE: Bluetooth: btusb HCI_QUIRK_NO_SUSPEND_NOTIFIER causes kernel panic on CSR 5.0 clones
In-Reply-To: <CecyZdAwliTFqNWeZYcBef--uL7SBwD_JGjv1i4pxjQPSDNpheMorDHT2dAiFVvcZbO2afBLIVjbE52fcUYLWtEroa68AkhM5GdJLHEsQ6c=@proton.me>
References: <CecyZdAwliTFqNWeZYcBef--uL7SBwD_JGjv1i4pxjQPSDNpheMorDHT2dAiFVvcZbO2afBLIVjbE52fcUYLWtEroa68AkhM5GdJLHEsQ6c=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6313457246720187537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:2267
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6313457246720187537==--
