Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99813C00A89
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 07:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C5820936
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 07:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKCnw4BN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgKEHuR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 02:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEHuR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 02:50:17 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1615EC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 23:50:17 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id x7so561040ili.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 23:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=dvx5KbytcH/FaRbW5w/9c4Ax9j91Ffo45qyj945Od3k=;
        b=vKCnw4BNOgV1kRMcCkOwrW2jfr6uLfVASQfzZZ0CQBQ2x9b5c9uAULGsw/qAdUmju3
         SUqBwC+XOeQv/9NWeqMUTJOoFtcbHdTvSRTU8bQ+mYyY13dvGpXpGUTgVp7Y46GAQ9j+
         XyLJm1tgHMQmlobhjnNM9xL2a8Cni2/Asy6EBiS2qK2DkMHxvyMf8dwiVvXlHT8KnM4u
         EHwcW3Cwfxb6mHlioxSixgymTs5a1A/SSCg0+x2UiasjpWeclFimIoKCLFPnlzDpM81N
         rMAWYJIaSmkzUkfoZywiKYSWgebo4bXq1MTmyMvrSQrzaG+vn+V4IAkY2I2APse+qYcP
         DkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=dvx5KbytcH/FaRbW5w/9c4Ax9j91Ffo45qyj945Od3k=;
        b=ZWHnX3qAHv5XcsOyBlBxt9I6SY2GPGDxOtk10zzZO1bd3hTFiBs708LjJ0h6pqlLbq
         pNUDp0Y8WfRrx1ohaSjyc0ojopvZd3EBDw2cWFTS+8tKf7T8Yw7NWBTlHs/Apzs2Yvn4
         LvaLgt/nFt2z3S/LBdSTVQ+lNKNI26v4qm1I9ULab9DvQ4TcFaco6zFTk64YodwQfARb
         Hvs0yH72ndP3HjNji6DEdJhS4tGXECv26v9aYxwvamyzM4OFgu7rNnmeYQxCwPXRx7Wu
         Ub8xGxhdH5iiX799pZwt4RSzq29BkSZIJUa+SLGMJYjLRwjcwd33EuAcTyY3vgynfO3p
         0/ug==
X-Gm-Message-State: AOAM531stqpC5cQltrYz9mxPCmkhZNzWk43M0dwbXqiWbdCG0NBok1Fq
        kUfA6vC+jdmb3ErsmZnvnRBjnkGbySZYzw==
X-Google-Smtp-Source: ABdhPJxRLWr2fswg4aETNugsLMz+SrFNWMhKRD0DcS76sVsKws7eCKC/fMFTN88wnIRnyLOSA+CtRQ==
X-Received: by 2002:a05:6e02:bcb:: with SMTP id c11mr914520ilu.285.1604562616346;
        Wed, 04 Nov 2020 23:50:16 -0800 (PST)
Received: from [172.17.0.2] ([52.251.88.182])
        by smtp.gmail.com with ESMTPSA id n15sm607910ilt.58.2020.11.04.23.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 23:50:15 -0800 (PST)
Message-ID: <5fa3aeb7.1c69fb81.8b966.1f4f@mx.google.com>
Date:   Wed, 04 Nov 2020 23:50:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1918154604466767329=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [v2] Bluetooth: btusb: Add more IDs to usb_device_id table for Realtek RTL8822CE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201029123649.1220-1-max.chou@realtek.com>
References: <20201029123649.1220-1-max.chou@realtek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1918154604466767329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=373083

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
Bluetooth: btusb: Add more IDs to usb_device_id table for Realtek RTL8822CE
1: T1 Title exceeds max length (75>72): "Bluetooth: btusb: Add more IDs to usb_device_id table for Realtek RTL8822CE"


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============1918154604466767329==--
