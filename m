Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7D0C5DF9D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B41207CD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG7MNk85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbgJ1XnH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgJ1Xd3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 19:33:29 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AF9C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:33:29 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k6so1416293ior.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=LDi5xnUDIfDvwvCaody/BlX3k7LdPP30Au5+3qgahoU=;
        b=KG7MNk85okXJsBeKJYtMo8jp4rXA2nc8ZzchSqjIW5AE2kI4N0tsSgcW3IIDIWCPuZ
         c//K8EQ7dpC5JRyAMhYU0QqcAgG9AAYBTRarhDQuL+6ehJhlZUSfag8UY0CIqT2715v0
         SrnIGetyMV7mI3jjaL0rzO1VVNxzm8OHf+uqQFGDkKZ0S/jlTTKkxitY+68iFUD8SXO/
         fQi4PRAKtywNLjsIlA6uGiVrimcwlsHYHvd16EWDSAd83aqygpV6mgXAPzjXJjJZZPIY
         bvr7gErwUpkPjHC47jRk7j8rLSVRhs+rjYAR/yNwrMOhJgJyVJ7CUVPedvbbfdcYGmqP
         aAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=LDi5xnUDIfDvwvCaody/BlX3k7LdPP30Au5+3qgahoU=;
        b=Adrf/3tmH7Y+LxKBwDfAubYUayThvGFqCRYwtqMJlffq4qjsavb3t9bjg/rx75IZEz
         7hFBuTZ8R3ahC0yF9Cghr4g2yY/mgw3CrY2NZRZEm8mjVdADHRRpwAqzaHpg626QDVlE
         OyxPxME3dZUYv6w+SwH7ss0tq35G7bdfdUt3BhBZQ9+h4jmGWyL6Q8TjxtdtRw+VQxqN
         PnXJlRyKzV/0AA6jTm7luOXSyqOCbAR+QPfTIL2gyZw5qU9ndkSKqZXtat23h4yVl4i2
         DKoxMvTgk+rycLQRJ2P9QwoWOLm9eiqgCoPEvV0COXUsilEwMuOfpvCa2Qw5f+tdR1bj
         z6zQ==
X-Gm-Message-State: AOAM533GCn1BwLlueSQChp/iXlZhQWgXTkOIDdl2MEoH3pj0HO8/6v8/
        8HVoOni7sl/gjjaEbxVAV9rVdT03x3E=
X-Google-Smtp-Source: ABdhPJwuXqH3PFp8QRujsu1z4VFsTu671ofREK25opSL+gsphUbALV0I1sNtlB8TdxzUufzGHnXbBg==
X-Received: by 2002:a5e:da45:: with SMTP id o5mr1491339iop.62.1603928009060;
        Wed, 28 Oct 2020 16:33:29 -0700 (PDT)
Received: from [172.17.0.2] ([104.208.243.174])
        by smtp.gmail.com with ESMTPSA id k18sm691833ioj.21.2020.10.28.16.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 16:33:28 -0700 (PDT)
Message-ID: <5f99ffc8.1c69fb81.8d6b8.3e16@mx.google.com>
Date:   Wed, 28 Oct 2020 16:33:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7084044108655641264=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, danielwinkler@google.com
Subject: RE: [Bluez] adapter: Use initial temporary status to decide device removal
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201028154914.Bluez.1.I8216fab388e34d8a1373efc71a252c2c5a085564@changeid>
References: <20201028154914.Bluez.1.I8216fab388e34d8a1373efc71a252c2c5a085564@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7084044108655641264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=372435

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


--===============7084044108655641264==--
