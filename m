Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D88C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 13:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiDFNyu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiDFNyn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 09:54:43 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EBF23192B
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Apr 2022 19:18:16 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s7so2262421qtk.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Apr 2022 19:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=FDA+Xrsqiz1X8jKOU7E9Jb0Y96EP0h4alI/vRHBD7Jg=;
        b=hFdqZx5XevfaHUvujF5HrhSjAKUwpOP0l4ahI1glKz5uUpFXAI4DDRbwteq5RZBtjT
         HZCLGaow43xM94a5gylomIpdULoLE/8i8bURgcdzFhLvO7WAaq6P8Jj4YrW7kDrJB9b7
         wrDP6nIr1JdzdK/1YkBWt2SlcQ7m/54Oh6W+/OLPZTYTfPsj4oyBmDEbRmtRp7x2vkx1
         v3wR6mcqH08nVgudfO/wdKG2Fcrynyc/OVsfY2MbDa2shmFjLVedF5tN4OOffuNCW8GB
         KowknezUidMOflZnKKA14Pvo0HDVO9j8UJxvECAyBn0Nkf2sXp/sbSBy9s8dnH5EBM2d
         3Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=FDA+Xrsqiz1X8jKOU7E9Jb0Y96EP0h4alI/vRHBD7Jg=;
        b=nyUsfBpu6h2BfvTR26oBTYdntBhbGpAsPveviNQ+9jt5V5lao5JvPx3Y+il8NEfYBf
         EejLtF04nPGw3Izu0UbCnM+iqvkWY8sFoel4ywSZ8+XE8z/AQ6DyuAwLvcTkaFMB9EUB
         vPkM/R/hTKnJ/CUUHgSAuuXuSd1FefzMIn8+dmaB5yur6tXT1FpI2qX1tacbfXSgL11j
         Jjom6SAIcVHzfsypbKcUIC+lUion4TKX+MksoEU7Yv327POCeSKvsrJDdBmLzxjQZaYM
         dvxMvJonawH3VkGhm3Qb1Et67FTk5ljC+TfjrB6o+2HMC3Mb2Pi+L7T84mD41UsxA5z7
         PS9g==
X-Gm-Message-State: AOAM532JWDlaZ8LQHVeTHbQwplo3WmbpurRSXJgs32ZT+yBMuwQ+HDGi
        Uy8A0ILBVQJ1hT7OZE2yshJUomtqMkTSUw==
X-Google-Smtp-Source: ABdhPJzSSOXrpk+40vuzMBTfohbvGnUDP0RWUcYVcIV/E4eBeXZ3A0pIRFfk02h/k3Ix9tQX2kWo/w==
X-Received: by 2002:a05:622a:610:b0:2e2:694:38c6 with SMTP id z16-20020a05622a061000b002e2069438c6mr5691032qta.458.1649211495828;
        Tue, 05 Apr 2022 19:18:15 -0700 (PDT)
Received: from [172.17.0.2] ([13.92.45.38])
        by smtp.gmail.com with ESMTPSA id s5-20020a37a905000000b0067d35f2fdb1sm8875684qke.37.2022.04.05.19.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 19:18:15 -0700 (PDT)
Message-ID: <624cf867.1c69fb81.f46e4.be63@mx.google.com>
Date:   Tue, 05 Apr 2022 19:18:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3017401543747661994=="
MIME-Version: 1.0
Subject: RE: [v2] Bluetooth: hci_qca: Use del_timer_sync() before freeing
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rostedt@goodmis.org
In-Reply-To: <20220405100200.64f56e50@gandalf.local.home>
References: <20220405100200.64f56e50@gandalf.local.home>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3017401543747661994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: drivers/bluetooth/hci_qca.c:696
error: drivers/bluetooth/hci_qca.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3017401543747661994==--
