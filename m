Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B354C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FB820780
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhA0LG4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 06:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbhA0LEY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 06:04:24 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B7AC0613ED
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 03:03:22 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id t63so1286090qkc.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 03:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wXiDTLyj4S0MUmMBooUh4jyCwpz5teawhXIybCE9ZWo=;
        b=reO4zpUT+aOupKQ146ctMdHOrMoC6tDl+6Kl9ZR9LF9gNmGLtB04/kx/js491nGVs7
         EtBWjNs+KfQhlN8XlzDhgEnivmWihHE1WZ79dOMTBlDQzVhxIeZ8x1zqdRRBNac2SQxc
         poa6GDxSYFqC53VckFCgr3Ade+ptJ6r87esCJknQwTA64775QVfYAucIQ7QFiFZFs4pS
         6KxdDunb+G0qRhc8qBPrN+pg3CdYnaLl2086RT6rRLFW8r42LMUD4YJutUHat3IspTEt
         SbKdqfoavxV6+Wdll+aRy8t9G3eb2BH3RFzdEbA3auz8hwEeVdWFZPHLsRvZlJHbMoc+
         xXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wXiDTLyj4S0MUmMBooUh4jyCwpz5teawhXIybCE9ZWo=;
        b=jHK+Vd9tVFhTXNGI06C07Tli+toydaUTIVG9Pae/OZqwboi5vG5kT1jMhA950/VnoV
         70m5e5g8zU4nlQ+t9cFzmlC6wpTaa7ypamHZamL09Gh+iA7wCzNm0HfIJiQwmKYEi/wW
         /WI+x3+JdXCyCxJCEfzVL1J3WKtopW7b9Mj+rylaSfenCEpbwmDio2JpJW1jerfDGjhk
         GL+P3nxx6+MJheJr+E3widSqQeOGAUbuI8rp5jbyD/cApT48VMalJBIu532kXJFfsVqp
         9/DnPaRXJkmwewwJvTF0+3ndfgjZ9kF/kKrwPAPez8JAZW2AxJpqZj57QZiFp+xqSH8t
         nvAg==
X-Gm-Message-State: AOAM530tklbN+UaZXMkSY/sPFH7pZT8wI+PSzcpbpbOmlnqKWP5UtL+w
        tIdkFx4tQqx3Qr8Fz1XMZh4UMQH1tTLVGg==
X-Google-Smtp-Source: ABdhPJxaSO6mu+sjuHaja1hvrrsGjKBfWrUBMHzIm/14kPFC8tEhrZD8xyeb6dLs+wRxi+8b4tLQDA==
X-Received: by 2002:a05:620a:3cf:: with SMTP id r15mr9790270qkm.292.1611745401033;
        Wed, 27 Jan 2021 03:03:21 -0800 (PST)
Received: from [172.17.0.2] ([52.167.162.107])
        by smtp.gmail.com with ESMTPSA id v145sm945682qka.27.2021.01.27.03.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:03:20 -0800 (PST)
Message-ID: <60114878.1c69fb81.fa04d.5a6e@mx.google.com>
Date:   Wed, 27 Jan 2021 03:03:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3092122805707348714=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@intel.com
Subject: RE: tools/bluemoon: Display FW version of firmware file
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <c4043018c34d56aa5aa3222c6544ae21de706253.camel@intel.com>
References: <c4043018c34d56aa5aa3222c6544ae21de706253.camel@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3092122805707348714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=422795

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


--===============3092122805707348714==--
