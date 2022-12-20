Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E08C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Dec 2022 19:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiLTTMV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Dec 2022 14:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLTTMT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Dec 2022 14:12:19 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED554E006
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Dec 2022 11:12:17 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id e141so14046037ybh.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Dec 2022 11:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/dikXC3VzUPMiGL/vlx5RCXT3VoOrYftAEigSAjqRCQ=;
        b=Q00Qkgqe22J1XwfiGxcn3G3L/zXFHTnPcliz9DCONGQl9DsDGu+HngaVNTcSciZ1gj
         X0goDy9lx6k+kBzUWWA5+8ZDlJ9291eiQ9B4OXeum7ajpt0t0YR7OM1v/TvWYBKytAu3
         Q3YDxU/ZMxLd6lJxqWJFi2Uo8wdFWO7mdNDi/cpYMiThUWzKNHbE/paWJD41MQunG8S/
         O4XAbptrOm+r1/ddyPq9pt8zput/er25TJ/OwijgDmw1aK8yagU0yokg9mF+3ve27hEo
         SH6L5eH1ekKX8D455twgnSM1C1WaqYVunVYSl8+lUVN3WzTh+mff7RAau/bAslutYE8z
         TKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dikXC3VzUPMiGL/vlx5RCXT3VoOrYftAEigSAjqRCQ=;
        b=xVPvuP98Z7Lj+r6v/nAaZe7BFITKbB+JNGtaWPPH5WWkNDljzNATb/6k32fuZILkUq
         huDFSagJEfbihwm2CeveMPjkoWnil74ozi8owED1sZdcEcYcvOY2X9MtRhgsUgNepk5W
         ALAAWl4SuQMBw06HThGw0OhqoWXAVlkZntMCkrTEied7f3BpfDvQwd7wsT4DZUtNh283
         n5gOWo7FGeg3TRu6j61mf1bUunQNPemZhdF3klJGHqPpHpLTIgxScn+olNLzsgJErM51
         zVSU4+gvv84o+CTxJq5dsGBLOpmFqoKZL9e7R1+JMWS8wpvft8EJdcBB7iG+GGw7t68i
         lERw==
X-Gm-Message-State: AFqh2koMw54JdvCQNVD0XOKgVSWc/3b/8l4eAX564oDUdHNNUEA+co8x
        hhRycPzvz0rMDus+bBFbPBLzlmZXpWudTg==
X-Google-Smtp-Source: AMrXdXviAqXaLidhb5bI91zP6FNhlls8m/wjqvoJt1IPBKK1GE/HAXGprsU07quQzdKLitPhNqdgrg==
X-Received: by 2002:a25:c0cf:0:b0:728:9ff8:ac4e with SMTP id c198-20020a25c0cf000000b007289ff8ac4emr16917824ybf.13.1671563536984;
        Tue, 20 Dec 2022 11:12:16 -0800 (PST)
Received: from [172.17.0.2] ([172.176.115.111])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a148800b00704a9942708sm374053qkj.73.2022.12.20.11.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 11:12:16 -0800 (PST)
Message-ID: <63a20910.050a0220.d38e1.30df@mx.google.com>
Date:   Tue, 20 Dec 2022 11:12:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2975426288318362878=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rostedt@goodmis.org
Subject: RE: treewide: Convert del_timer*() to timer_shutdown*()
In-Reply-To: <20221220134519.3dd1318b@gandalf.local.home>
References: <20221220134519.3dd1318b@gandalf.local.home>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2975426288318362878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/staging/wlan-ng/prism2usb.c:170
error: drivers/staging/wlan-ng/prism2usb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2975426288318362878==--
