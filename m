Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D78C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8794B2075B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbhA0LlP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 06:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbhA0LkP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 06:40:15 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C7C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 03:39:35 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id t17so1127080qtq.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 03:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pyCF32agDEAMlhGlMCOCdtbjTBDuH2jBQu/eKiTY6eI=;
        b=NDA9BzjMcdLZLFBqNbljsTCrOYXhGvfD5g8XAcQDMhWvD/lKPTm3qNTPliKHFiPTEc
         lKc/uU+gHUOyB5KBD9Me9oRLSlcuuNdyJpM7S8YX9ZSkOQchHRDio9AeVE2aRakAOELm
         7LQhk8YFX7TkEsBzGcIfn8R7AvhkpY0MYPtDktdcKIFg2fqjisEWaz8d6Ciphwwt3ei4
         4lll03wxOz3UPumkfL5s+G9WYfcxY5p/W4yWKuVInps35Yw5SNlojx12CkFeR+/Al9Lu
         0LUxbcvHhSHEXxfz7+/4fHe44oADOfgFZcxYDonqmAuckDrW4at2iGyoDKslCAgNxE8c
         BT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pyCF32agDEAMlhGlMCOCdtbjTBDuH2jBQu/eKiTY6eI=;
        b=KSTOUBrYJkwVll+S371Y7M9+0ual/iXwv164V+JShx3vQtADd6G49AMfO7lLzy0gVg
         L/tgYl3Q3YctCh2cD3QGfcrTBGBXopqxbtZwLPtr2I3xC15+AOlq1dKaJ/AGP5wpN4dP
         bQxfgvcOnfhjgl/uOFRuqz5CilZ/5WWDr2M1uhLd36mdcGQfrwhu4s1LU0Ip39pz0S28
         R/N/WiVJKUeUSbzT8GOLLCG6Qm3VVWocVS1CGFyNzqCmccMJCZwxjUoL2VouR2og/EAV
         +Ss//bvEZzj/VgeKemCsN5qCoKj5FOM+Vf7K3BVRz255laR9Fl9M57NgFF1CJtxwc59x
         Fzaw==
X-Gm-Message-State: AOAM5322P8EXZrQWEcZWOiVHGLML2lEPWuW6og63YNnd8ZQVyap04Vkt
        D+Gg+7YCCEgAgv0Dwyf8CW6DJ5sOLSipZSjV
X-Google-Smtp-Source: ABdhPJyU4rCjKE5z+fieDQhw1lermKex+MlTsv+J0xkrg6JWMOoK/89l4AjoyEXHO02MgL8TnCDxTA==
X-Received: by 2002:aed:2146:: with SMTP id 64mr9151666qtc.296.1611747574589;
        Wed, 27 Jan 2021 03:39:34 -0800 (PST)
Received: from [172.17.0.2] ([52.254.68.157])
        by smtp.gmail.com with ESMTPSA id k12sm975018qkj.72.2021.01.27.03.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:39:34 -0800 (PST)
Message-ID: <601150f6.1c69fb81.98300.5c59@mx.google.com>
Date:   Wed, 27 Jan 2021 03:39:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7809246336632472749=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v2] tools/bluemoon: Display FW version of firmware file
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210126174912.83822-1-tedd.an@intel.com>
References: <20210126174912.83822-1-tedd.an@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7809246336632472749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=422831

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


--===============7809246336632472749==--
