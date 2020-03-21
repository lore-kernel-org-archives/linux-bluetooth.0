Return-Path: <SRS0=gowC=5G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8B5C4332B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Mar 2020 16:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC97820739
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Mar 2020 16:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/5jFwyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCUQz5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:55:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40365 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgCUQz5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 21 Mar 2020 12:55:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id f3so11302380wrw.7
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Mar 2020 09:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Z9C2aPYvbuORVExRgoCw7kkRywT67u5qzBQLpOjpHo=;
        b=N/5jFwyRB5MTQzbrJOLNdC2NqzISVpKXk3jztZdKE1iM3Oe6yYewt24y6EVrYH1ftu
         sjmrxfAoHtgX1c6GbjII21bo23RpRJkTtZMUDqdcQRTkKA/CzUE5/hh5Ve+K5zoi3HiB
         SHn58SBNMNZcalefIlY/dqzSFn0JyynxC8YCKaGHQfA8tgifsOIlfj7/+WYj3prcs4OZ
         GTYv3UuUXXAU7ftzT5HY1SHG8hya09bLGFYg1iDi7YSasS58iRf7TApXBs8MsSfJTxVl
         gE771zZ57w6CfiBLUChiWxAeA+vxl/5K1s2tpJ0vTwAO+R+GNMxzX3MGk8vMyRDjzsbF
         s1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+Z9C2aPYvbuORVExRgoCw7kkRywT67u5qzBQLpOjpHo=;
        b=XVec9EqobcM4RDYCM5K1ipTKmgRMZ1A4xmgOBHJCEvn7/fKHSb7/7/3NJ1wijqN42U
         2aoZ8a7QiAgtv2JlSyp6Ie/zzZZGFkSHpD0fqM+QJNWjrFXbiJ63FOXrr1s6jDi/8su3
         98GwPf74r/njznvNi1i5duOEgudeBTC3jbuuVXsIx4Qy0kdAe+mFISiEhN+jHMw3NCOg
         1yypnVvHY2xJkMlE+RoCpupiWXyF47rFgF53VWbLVTL4zQcxbEYdjnCxMhkkV0BR7EgQ
         SDPowz07nrf/uTYWTvRoAOSU4FrT4CKymrvpMll2G6lazCzTI6e8C/yVDBMCGPoow26c
         j0dw==
X-Gm-Message-State: ANhLgQ0aDzycBplo7D/kVBnVZsZiyUghrfdwQahnSN6Hn562NUZoVNhH
        G17adC04NovLqMTyoAkpKWk=
X-Google-Smtp-Source: ADFU+vvdqT+DW1ZLl+RIxludvHWVbi2gbKm34sRtJCm9Ooo2deSkAkDaUQPZ6CAANLjcldvWwCS+pg==
X-Received: by 2002:adf:c587:: with SMTP id m7mr18995749wrg.64.1584809753372;
        Sat, 21 Mar 2020 09:55:53 -0700 (PDT)
Received: from heartofgold.home ([90.114.80.84])
        by smtp.gmail.com with ESMTPSA id o4sm14074462wrp.84.2020.03.21.09.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 09:55:52 -0700 (PDT)
From:   Guillaume Martres <smarter@ubuntu.com>
To:     sathish.narasimman@intel.com, marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v6 2/2] bluetooth:btusb: handle msbc audio over USB Endpoints
Date:   Sat, 21 Mar 2020 17:55:51 +0100
Message-Id: <20200321165551.11928-1-smarter@ubuntu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <F7B49142-FD11-4512-B2D4-0840556FC0D3@holtmann.org>
References: <F7B49142-FD11-4512-B2D4-0840556FC0D3@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Guillaume Martres <smarter3@gmail.com>

Hi Sathish, Marcel,

> I would really prefer to have some Tested-by lines from people that can verify that this patch works.

Here's my experience: a recent pulseaudio MR [1] added support for mSBC. When I
tried it using my laptop (Intel AX200) and headphones (Bose Headphone 700), the
voice quality was extremely bad. I eventually realized that this could be fixed
by ignoring all zero-filled packets sent by the headphones when decoding
mSBC [2], after that everything worked fine.

Since then, I was made aware of the existence of this patchset, after applying
this patch (and [3] which apparently only exists as v5 and not v6), my
headphones stopped sending zero-filled packets, but:
- the recorded audio quality is again extremely bad and robotic.
- when audio is being played, the headphones do not emit any sound.

Note that I applied this patchset on top of the current Ubuntu 20.04 kernel [4],
let me know if it's worth retesting on top of the mainline kernel, or if there
is something else I could try.

Hope this helps,
Guillaume


[1]: https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/254
[2]: https://gitlab.freedesktop.org/smarter/pulseaudio/-/commit/bb716b03002841e1092b4200935566d5c1a951fe
[3]: https://www.spinics.net/lists/linux-bluetooth/msg82149.html
[4]: https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/focal/commit/?h=Ubuntu-5.4.0-18.22&id=93dfa5b8e12fed29933f3451db44d88c0e4b5aed
