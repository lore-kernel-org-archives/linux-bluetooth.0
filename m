Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7F9C388F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 13:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD212068D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 13:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8npqLCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgKJNPy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 08:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJNPy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 08:15:54 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F21C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 05:15:52 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id y197so11291436qkb.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 05:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=LV7AYw6Lx7SNh06UMfSADV0gSaeuGYBljw35gZoI3bs=;
        b=D8npqLCsqCzb7TUcB6FybDvFRnhTmN9pOZpzu+Cylsy751lnTokfFucGy9ppz9X4dp
         x4rgAttQn6I8V4SB3hWrvBGwPmal4FrC/fDVM3pyblm4iDgcHH5vCD+8ENPGBxP50Q6M
         Mx/ZHCXFaIDbFNWyE1MMaRGehpMpvq4yE9G/U7elfGKVwFz5E1qP/L0XDJdfy59Wlftv
         qyCNekvJYRbkScFsgd/FqOkP9DUcnA8EyDt1Te6VxLl8amQQkdc/mdcsyPJ9IV3FbS8v
         2iSLD/CCuIl4t0r9Fsh1liQ8i63YsP6xnWcTA2IawaegPb4qGtWqwRxUmBHLirDSbOZn
         e0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=LV7AYw6Lx7SNh06UMfSADV0gSaeuGYBljw35gZoI3bs=;
        b=WD6glk7gOFjsxr6mZVyiOoEoDWVsIg89zMzRQTJylZo8cDBSucXc/CERFc9k3m4Sim
         2MK2ws0R+0QU29SF1aldbWCZC6pkFMggEbPochVPDvw4RON2wcUD0wkXUNb0DXmvzBPv
         FhGDxQEuIyiANQDy7YDMGuj+No/ad4alXQcIksfqgFqESfq3DbTv/B/PpApNUMwt7yrB
         y9Yfe3dxvaGIwMrREeByMDkWIWrlE28MrXVMha8HQtCVhXUhO8QRviEGS/eUbxI67qHV
         oDP3ClU3FEAIjOiWW5/xI8n2cB1L7paQuSbmKDWLUHNYYUrTHpLq+n883quSbc0ZABVi
         BmKQ==
X-Gm-Message-State: AOAM5310luWqCz5IIgM0HZ1R2f4f/X0NJE8DDc09kI9o1c9nAkPxQcq3
        KLrcwx0w5l+mf7RcQvFoB1D0CZwoaX87Ew==
X-Google-Smtp-Source: ABdhPJxhK3Kh8XXDTCy6HKfguz550dGHPRP070nkqt64tT7cxkjdHJlN+l2AailF6AHFZfHfxHfqCg==
X-Received: by 2002:a37:6143:: with SMTP id v64mr9480255qkb.490.1605014151933;
        Tue, 10 Nov 2020 05:15:51 -0800 (PST)
Received: from [172.17.0.2] ([20.49.18.223])
        by smtp.gmail.com with ESMTPSA id m25sm2685478qka.107.2020.11.10.05.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 05:15:51 -0800 (PST)
Message-ID: <5faa9287.1c69fb81.ece52.1def@mx.google.com>
Date:   Tue, 10 Nov 2020 05:15:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6527893043892557350=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, colin.king@canonical.com
Subject: RE: [next] Bluetooth: btrtl: fix incorrect skb allocation failure check
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201110123915.3356601-1-colin.king@canonical.com>
References: <20201110123915.3356601-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6527893043892557350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=381173

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============6527893043892557350==--
