Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652CEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Jan 2022 07:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiAWHEh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Jan 2022 02:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiAWHEh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Jan 2022 02:04:37 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD5CC06173B
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Jan 2022 23:04:36 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id w6so15576756qtk.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Jan 2022 23:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=v8SH5J2jm+/GF9WG2tawKaEAWL1OJQz10CpRSObX8qs=;
        b=UaRrd+ZB31NHmGYTpbmFkQJ5zkKuIZ6CWKx8M7GqOqqi8uYWgNrcHLGpMB3IZNz26f
         mhqy/4GTHTusRDumE2Xyl+d+CirSJ4aUh/5UxrAOvGgu9Ze7h4ym0RxvSJZpDO1MF96H
         cjRODrSC2eEYEKuxXnfD91dVB8tLD8D5Wy/0TgpyChFj4SplMQPmwmQiS0u7ssfcOYU+
         nvoyZj6n0IeOwR70Fct7qHOIeqMEx9X82BDszZIwl9uqD9T47N7ki8kOmC461IAfqVXn
         epsXK/7ob81SY1XIxfbPF/qk8RxelfZPyfsp5qshdPmusAYib4gix523lQq2LprCXN5R
         fl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=v8SH5J2jm+/GF9WG2tawKaEAWL1OJQz10CpRSObX8qs=;
        b=Gz9GKP720Jz0hn8VuwZAwQBy8Otsm6m0SCfAbf9s4lUxdNqyYXeB6BGA1v7TgW4k5u
         hBb3UEK+6+B+pgmfSMLB/lQqINtogWahv0nHbMY8mkEg61ETvo4Wo3OwXAOXYhdv1A1f
         drt0xXTa+QiKRpwOjSVH7IAMA9SI1ABlGd7J91uWgD/yvIehYkm3HGacJ3qWfVqdCu7v
         GWVRIGHca0G6Wv4AUZe2pp82+kVYw4lYRWXwfJ9Ff+rDS/zJgsZFxqH1hp4AffCyHATF
         CL7z9RLCXdd2EjbJMZQ7WHVZG/+5xnHR+js5VyQ/cw1kNyNXLfy7SiUgmCs19A6523Id
         fa9w==
X-Gm-Message-State: AOAM532sKOslJvxrhw3ML8Lnr7rghFTvnXzvFkOX4j6h4Yv7HMDjcPcA
        Evq546gJ6+OBceEH60yqgJtVDBwyCYw=
X-Google-Smtp-Source: ABdhPJyLRrr0e1cv1LdyvSACU+riSYrWU90XeUVvOhboUh68YZT8SMVeuAvfvmnSm54QebjRWMp3dw==
X-Received: by 2002:a05:622a:10:: with SMTP id x16mr7982694qtw.502.1642921475755;
        Sat, 22 Jan 2022 23:04:35 -0800 (PST)
Received: from [172.17.0.2] ([20.62.69.108])
        by smtp.gmail.com with ESMTPSA id m14sm5347010qtx.44.2022.01.22.23.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 23:04:35 -0800 (PST)
Message-ID: <61ecfe03.1c69fb81.885b6.080c@mx.google.com>
Date:   Sat, 22 Jan 2022 23:04:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8349547478229973936=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, soenke.huster@eknoes.de
Subject: RE: [v2] Bluetooth: msft: fix null pointer deref on msft_monitor_device_evt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220123055709.7925-1-soenke.huster@eknoes.de>
References: <20220123055709.7925-1-soenke.huster@eknoes.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8349547478229973936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=607542

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
GitLint                       PASS      1.03 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      29.25 seconds
BuildKernel32                 PASS      25.92 seconds
Incremental Build with patchesPASS      35.97 seconds
TestRunner: Setup             PASS      464.06 seconds
TestRunner: l2cap-tester      PASS      13.32 seconds
TestRunner: bnep-tester       PASS      6.07 seconds
TestRunner: mgmt-tester       PASS      102.13 seconds
TestRunner: rfcomm-tester     PASS      7.36 seconds
TestRunner: sco-tester        PASS      7.57 seconds
TestRunner: smp-tester        PASS      7.42 seconds
TestRunner: userchan-tester   PASS      6.28 seconds



---
Regards,
Linux Bluetooth


--===============8349547478229973936==--
