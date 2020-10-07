Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D8FC41604
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 21:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540B820872
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 21:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw/bZFAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgJGVcm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Oct 2020 17:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgJGVch (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Oct 2020 17:32:37 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171ADC061755
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2020 14:32:37 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id ev17so2040990qvb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2020 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aLR1v8x/wux1CVSVkt5hbYRIRlbTniT+Q3YsX+g7q4Y=;
        b=gw/bZFAxGFuhZakjXCsWZhNIsX0jZCXGfqG+MVRhBZbHCeTSpWDRJ7ZXG4bTpN+oFj
         th4qRQ7aB/KdMxYG3nqpMhcbCNYHdX19PP4n4HF5W7qpKkymSyx2+kHD1CAP4E3yqX94
         iJ4Z7S1nYGNqafZaIxiDTzTPq5RNpKlwVjpvRr8dDUoOElS/xErwVtd/bOBpLowIwL0e
         m1sPMoclwnXPffiUlvlk1A6P6FWNIfuCqgkZPj7VdnQ6uU0XDH0WohJI1tRys8H8YLXI
         6fD2uMdpRFWbkrSmzVkBBDEDjd0h10AHqfzPQRu/GWwFYcHuzUpVCoLqOvrt1wrwmwt0
         nixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aLR1v8x/wux1CVSVkt5hbYRIRlbTniT+Q3YsX+g7q4Y=;
        b=cer6/pzHKLgxslhNlrj0W20UuBIS0ZlzVeoj+5BGdNUi4ReXRX/x5dTXn3oSlqqugx
         ZPN8EODJQeXTC7JNdTo7A+nJ2KLzyUt5YTTwWZ2+QM7MeKOpM3zE7BOFg1wZ1EN/HhCR
         mEnA7fAMxS6jxrhZGhLTPUxH7WO2uf6ituY4qVpA5f8Mt2T6DOy1YghUlUIiYr69FCDO
         hmgzyfcYCgIwPknilZQmd0KxtS5MctjtoWwqoCpMiSCoth5pKLouD45WoXuUj+H0r+wy
         kXYPBsedIcN46uxwlw9whMuEzAeyPKB+H8az3AOfCDfH2/c9wSMNAJ8ZMGWZFTzfC6Yn
         J3Zw==
X-Gm-Message-State: AOAM530bb/fbZUpP5nG2hcpAx7ZFk+p97zFYCXeUmlrLxxbHK+HaVX7U
        gTc1eed1YN5FQxDX7wzFh4hNamG9WaO4HA==
X-Google-Smtp-Source: ABdhPJx8gqfKP6Cv215jIX0i0HzddYxodXXPo86Ws84Rav+Y6MAVXfgIymyTKId78EXMqyudY87yrA==
X-Received: by 2002:a0c:b9a0:: with SMTP id v32mr5296186qvf.58.1602106355951;
        Wed, 07 Oct 2020 14:32:35 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.20.5])
        by smtp.gmail.com with ESMTPSA id s15sm2419934qkj.21.2020.10.07.14.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 14:32:35 -0700 (PDT)
Message-ID: <5f7e33f3.1c69fb81.72360.bbc0@mx.google.com>
Date:   Wed, 07 Oct 2020 14:32:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4227453346580075888=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,v3] mesh: Re-arrange Join/Create/Import/Attach page saving
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201007210959.37565-1-brian.gix@intel.com>
References: <20201007210959.37565-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4227453346580075888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=361153

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


--===============4227453346580075888==--
