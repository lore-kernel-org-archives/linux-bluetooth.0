Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6956C5519F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 23:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D6A2078B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 23:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKv5VmqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgKVXAh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Nov 2020 18:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKVXAg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Nov 2020 18:00:36 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1F0C0613CF
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2020 15:00:36 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d5so2844380qtn.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2020 15:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lEtl5+u0F+PQxkZ9RY/Tq0DUzbkHNVBXeErIHSHPIHM=;
        b=VKv5VmqKWpiA2muZahFxPCx3J37BI2zu9ENaTR5vKID2Zd3nrw9T76x1Yd2LweKuhE
         dILCTwjphXHEpyU8PkEdkTvDPkgo1F8WqlddhRDT33amm4A6kI061EJD4Kn4P5+1XDRl
         GS1BlRmJe+rrZgmjFLnrwyqa2MWBwBWesaxpI/hdCWpCWEqbQ/RZ+khKaE41vROY2vnQ
         giFbW9EAN9VSSD2ERCQnekEV/WTApRAJssDjlF5PobMOuCTCbLq/kf4eSHKu+lknUMm7
         tDnGRkS2PO7uFiD0lTT8Z0c9fRjD59BVfltGQKFFokgoyWJ9Zqwcq8X9TyRoM/95pAzm
         LNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lEtl5+u0F+PQxkZ9RY/Tq0DUzbkHNVBXeErIHSHPIHM=;
        b=gYBLHXce2M6nfMcT1RSYVOWMKuiaaIK+LJ8X+tvUvcagekI617esQTFaRj7H5Xb4pT
         eve9qsF4Y75l2vJ49ZTmhaj4ft22dRjkmmklrMG6Io7RP74cPyQEFHqVyF/MmW9/pd9F
         BMXmqy/7b6wVc8Zbd4qHt/1KODrb+GaVu4jrOerV35bWXJZm9deQpJtGgIz1B2oaktBV
         nXIRmNLqk6gwDjVbLPqXiumqbWBPy0G3X9RoRQge9oHL7gUqUIzZBKEbHvoMaCA3fCGr
         4mW2DSp8qNlhPU3SO6hWkEEsmx3gGYS7YFVtCRK/KPRegEy1dIFsVn3oTggD+bfNLhNB
         r1+w==
X-Gm-Message-State: AOAM532Ipe2NWgLKCk7HNNOCTO9mvuSKFVMXo4hkAN2b5ITFs6geSVWT
        bhjNBNWVXnhz7Tu1QWpZoiWPcOb7ogmABw==
X-Google-Smtp-Source: ABdhPJw6Wpo7st+vurSh+flfQkOVJ6g9TpT9iVpCGc8UV7qQr6zgi8DuEULXzTky+wqlKS6QRw0vvA==
X-Received: by 2002:aed:3865:: with SMTP id j92mr25475359qte.318.1606086035553;
        Sun, 22 Nov 2020 15:00:35 -0800 (PST)
Received: from [172.17.0.2] ([52.249.183.134])
        by smtp.gmail.com with ESMTPSA id n9sm2638925qti.75.2020.11.22.15.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 15:00:35 -0800 (PST)
Message-ID: <5fbaed93.1c69fb81.17678.8349@mx.google.com>
Date:   Sun, 22 Nov 2020 15:00:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8179540502770927202=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: [1/2] Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201122221731.441864-1-hdegoede@redhat.com>
References: <20201122221731.441864-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8179540502770927202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=389145

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134
1: T1 Title exceeds max length (91>72): "Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134"
15: B1 Line exceeds max length (98>80): "Fixes: cde1a8a99287 ("Bluetooth: btusb: Fix and detect most of the Chinese Bluetooth controllers")"

Bluetooth: btusb: Add workaround for remote-wakeup issues with some fake CSR controllers
1: T1 Title exceeds max length (88>72): "Bluetooth: btusb: Add workaround for remote-wakeup issues with some fake CSR controllers"


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============8179540502770927202==--
