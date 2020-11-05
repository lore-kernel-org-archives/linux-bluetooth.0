Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63479C00A89
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E892B2087D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orcB8k+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgKEGr5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 01:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEGr4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 01:47:56 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7EEC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 22:47:56 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id s24so692992ioj.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 22:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=kM1G/smUGEA/A3kiMHw/wyrvQPCvTUypk9xfWXglcPY=;
        b=orcB8k+IJzlsCK9/CKtplBpB5btd0MZvPLnS3Zckbuxqrt0zp1IhSBbF+GgU7c70AU
         hqwjGl5bxBtqhQv0Cw3tZ91Na20UlL9pBWnt4qKzj7E3h3v0MYXmv/CiOiyjLopXsCFM
         q970M18yeRCppW9ZAzy1c3BIN53tHszRc9gE6X4lV6S3wQCTBam5k/+YdO0S979eU819
         6ZYPWycAPrt5olZ17gS5J8qLMzXxDLgvzHx07+uCu+kkmB2coQez+LpVksRMcot/CisJ
         tBd8QV2CYH7VmlAIoZHnGK7gGxpZAYBJt8pLVmSBcubjXmM2WXO8ETTXqbS5wDcwn6fE
         PWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=kM1G/smUGEA/A3kiMHw/wyrvQPCvTUypk9xfWXglcPY=;
        b=Kl5P0a7CG1ZnyzNFvAVGrcOj/VZIER5CZxameZSd8pvUKyemg052JaWOmDZyfgTRjR
         Uc/2FnhARbfX4k8G5sEjjqLibS7chX72wS6ozJStJ5xGHWL3W2SXgofAX7xBtT2GTzhd
         3RzOaNeNmV3VXXe3Y3X0sarOG/rSH8WGapgVCKSV4zOjrFo/8AWxAMQXhytTuEBsN/ms
         JGuvJJ0nVXG1UEPUIwa9JGqtBaJYjXfxTdeh49Dm5q7DVHiANCGXB51aP1aSkQI2QX29
         gQTMsWZCWqGi3Y1e0jtCrmoVDk67O7hKw2D8PsqDKD9aucuI1DtVB2Imh7/pqLmyO5mR
         fEXA==
X-Gm-Message-State: AOAM532GTUjIpZRZHRrZ+fSqzpyaWnpAv00T5FZ5sF/VuPiLb4024apv
        nLUeVISp9dxQoAKKGpxZY+spMuMGMs923g==
X-Google-Smtp-Source: ABdhPJxcizt3UCx7uHUdVykSnLh7vXVEn+5j3vp3IkKBP7nv0hc3IsvGnqCVPdzMzaIP+pRzL5Dyfw==
X-Received: by 2002:a05:6638:24cc:: with SMTP id y12mr960327jat.144.1604558875648;
        Wed, 04 Nov 2020 22:47:55 -0800 (PST)
Received: from [172.17.0.2] ([52.251.32.30])
        by smtp.gmail.com with ESMTPSA id 9sm486524ila.61.2020.11.04.22.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 22:47:55 -0800 (PST)
Message-ID: <5fa3a01b.1c69fb81.6a162.1904@mx.google.com>
Date:   Wed, 04 Nov 2020 22:47:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8218745407138465572=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v3,1/3] service: add adapter powered check before connecting
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201105144005.Bluez.v3.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
References: <20201105144005.Bluez.v3.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8218745407138465572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=377913

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============8218745407138465572==--
