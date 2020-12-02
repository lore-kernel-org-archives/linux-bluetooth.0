Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF725C64E7C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 21:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962A8208FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 21:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgLBV0p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Dec 2020 16:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbgLBV0o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Dec 2020 16:26:44 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED4DC0617A6
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Dec 2020 13:26:04 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id p12so1435914qvj.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 13:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xqbdljtxPTIqdweRardCHI+fVb2SfpbVEOU4wLKVfxM=;
        b=hTWJN59nXsRBPSwdN6hHft0AYCDwPBQhQVRNlBo63RAcNZ+MSZ5tz3ab/ZyLWhhr61
         AVxGwYyAFv19io1a5GfVU9390mAH4NNXf/fHOe1cYV3UEOJXXfMi7Twu47gt3A02A6Is
         OowdRT5XepqXnY1Y7xNhLtGwIkkfDoXmVsonz6midgw8FX7Pi8M0jiC+bRB+2G+d3k6r
         j6R9HjZSabCX5QDfGHO7RcrQGILqT/uCANmD4tEgygGFR34H4m7cvY5XZfZ0m0QgVwVf
         qzbpHad7EcXL3cfgYYcp5JPGtUp7LyDMDqznwrSPCXeYAt9K51XG3sdQK3RxgT6VFEkl
         QMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xqbdljtxPTIqdweRardCHI+fVb2SfpbVEOU4wLKVfxM=;
        b=HGmpjse2x06sdDMIKIlNNg/GxS9zjthVHZcjUVxzNbytahRK+dhVe/pi65dfG4mBa2
         wq/7lzSY4nWyP2MR5y3h0h80dK+b2M3V8cG42Vj8G3TlevO9mk3QeyvmfpKdf/JH4eVs
         qa/xH2mreTsbSJqWpK3FdOKqz+U7T2IGrQMiW4fvapEZLAnU34VThEC2fKudiP88Jenx
         G/xuiFH8uR5IeaLUh0ukN7UI5ykJNa48oSpFodgr5D3j1wXLwfiwqv85gueA2Wmtk/0Q
         lIjWnxBbTzqEYjxmpHJ6OPuK/gbUqsxBztOsDt3aLrk/fgqCRw9ONic8jsi1UwxYTfpT
         tHbA==
X-Gm-Message-State: AOAM533L2fRKwDNleh+zpdIxCzGK5O11Iy6EtPTPpIneetDxwz3NWXdU
        7Ov6MukSEFLB0VYv/A5L4Be6B8iTmhiJaQ==
X-Google-Smtp-Source: ABdhPJwxfGNRxo4YqWmJf9WmKID85v6oaYlCsujjofZ0H8GZwX3qH4mQZFo/oHvNgl8STWTfp1z/1w==
X-Received: by 2002:ad4:4743:: with SMTP id c3mr4512369qvx.31.1606944363560;
        Wed, 02 Dec 2020 13:26:03 -0800 (PST)
Received: from [172.17.0.2] ([52.167.170.114])
        by smtp.gmail.com with ESMTPSA id q32sm94023qtb.71.2020.12.02.13.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 13:26:03 -0800 (PST)
Message-ID: <5fc8066b.1c69fb81.4445a.0691@mx.google.com>
Date:   Wed, 02 Dec 2020 13:26:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0535454757287420478=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] mesh: Zero out config node struct before initializing
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201202211151.148651-1-inga.stotland@intel.com>
References: <20201202211151.148651-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0535454757287420478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=394959

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


--===============0535454757287420478==--
