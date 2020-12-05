Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBACC4361B
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Dec 2020 19:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC48122B2A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Dec 2020 19:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgLETJf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgLETJe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Dec 2020 14:09:34 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A61FC0613D1
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Dec 2020 11:08:54 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id q5so8802400qkc.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Dec 2020 11:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=VYFQXO2nK+rg7GQafAmFaGVYGxKNE5ho0Eeq9zsOR98=;
        b=LS8pXwrhu7615btVPzF1ON1pmd0+yrl1vmjATCpsNnyWsy8QGE01mKGt9zi7zbzKK9
         i3as729hHZkqtJKNRtIRM4UINYqU6Jj6UB5KlWEeRzqzyY5+2Z2x1s9TnEaEeAXXhuLq
         C9h33/tka3nOW68Bu99cRcT8Gf3DDJppxlQXQotJS10Bbv7kh5Ti5jFxUFqnedjNaMV3
         qyK3UlLtUrQxDKltogK/fHWfjRQ3XymS4/ti68/WcdwCk2IQ49EZ3nPX1QO2z7SUcMyF
         XtZ0NHN2es8BO3lczyWe71pVn+jh+BaTphNSvaxmJVWCCAknOsMKVoCn6LHDVPtgb4SD
         0WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=VYFQXO2nK+rg7GQafAmFaGVYGxKNE5ho0Eeq9zsOR98=;
        b=oBJm0ywitPpz3Z+WntzJretV+PWTI+TrrUs2fRhHJIh9csKX/I2bR0gC3BVqc7C1s5
         MPDLZncB19rBB5YXQHZRdd2mox+YotDF8vsDN5F+gv351vv2D3gTTvjyb1mrhAVhoRNj
         c9SLIKI8kYbxXPvdhgzNS9ikFkL+ZMfpk1rh55KmYT7T6ONPHVFKRec7h6QxeQ1EQxEn
         0q2JMbIgrsFWo6QEFDAz9ghlwUMfn1MjmWYQV16l3laqIBxR8MpjhiOEIb4faaU03VV/
         nw0M0vteOeEQfK1Fu2de44FJFycLdRiihDVpkchcmYoIX2bk116zRfSEUoSygSoW5Tix
         TYSg==
X-Gm-Message-State: AOAM533k+xPbhTz+RX4gtighI1LjqhxVi417arTy6oxNqDGXZyPri3mq
        gRLNANGNS4eRqPrYjKqXKqb0S0qiV23BeQ==
X-Google-Smtp-Source: ABdhPJybCLUkkuj8ATffcRXHvPqMg9WWoHCQZZFT+WGbPoz5ZvXxm0QRE6+kMunhJa+ylKPdHWNP4Q==
X-Received: by 2002:ae9:f44b:: with SMTP id z11mr16620803qkl.244.1607195333334;
        Sat, 05 Dec 2020 11:08:53 -0800 (PST)
Received: from [172.17.0.2] ([52.251.43.171])
        by smtp.gmail.com with ESMTPSA id j13sm10052207qtc.81.2020.12.05.11.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:08:52 -0800 (PST)
Message-ID: <5fcbdac4.1c69fb81.f7210.1338@mx.google.com>
Date:   Sat, 05 Dec 2020 11:08:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8676573841041848617=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: Bluetooth: btusb: Fake CSR dongle fixes
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201205150201.5631-2-hdegoede@redhat.com>
References: <20201205150201.5631-2-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8676573841041848617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=396867

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134
1: T1 Title exceeds max length (91>72): "Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134"
17: B1 Line exceeds max length (98>80): "Fixes: cde1a8a99287 ("Bluetooth: btusb: Fix and detect most of the Chinese Bluetooth controllers")"

Bluetooth: btusb: Add workaround for remote-wakeup issues with Barrot 8041a02 fake CSR controllers
1: T1 Title exceeds max length (98>72): "Bluetooth: btusb: Add workaround for remote-wakeup issues with Barrot 8041a02 fake CSR controllers"


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============8676573841041848617==--
