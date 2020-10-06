Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A04C4363D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 20:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2C9208B6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 20:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf8tT1zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgJFUwW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 16:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgJFUwV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 16:52:21 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DA8C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 13:52:21 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w12so81186qki.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 13:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3kSBW4TWTNEYG3hjBkv2hebNoLPLQubvj7f21RxCF/I=;
        b=jf8tT1zvqh+KGTIqlVm70fp7MWJAwbMZNy+KWNxq8rEoYQSRkKqqeRAhI+QZ+Kwa6g
         rxqpgxts3Epn77h1izkG9IWq/HmDaaPXdEJa4ZuQRQ+Hx2vTZi79o5eaVruzAYDLk0dG
         KjD0xLHDKfTHCdgfyoLQzX7nJgTCb0NEJo1TROpRJ9JwLXrRkJIN43apQsUNdd1baGbE
         dbL0fVbcpW2ftcbSl1ADUJnutl9PiMn4CTpIrebx6DJb91Xrd82fxTRFJqX6tE49CaiD
         6ZgQuuGgkGm+bCvsGh8Vaz39FyxVLIOKoWwYwI+j+WP+V72+ny01vd1dc4jwDvGIKMxD
         RC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3kSBW4TWTNEYG3hjBkv2hebNoLPLQubvj7f21RxCF/I=;
        b=gMEhsqxaDswktUT3S4dbbR+gWEjNbS4hJf7tJy2Jl4vXVoP8pZFsTQKzngzZAZybGb
         7XCv0QhzDpIgABkaW5hmOA7WiXGy/mNmTo7vAtoy2p2wfuvr9MjcaQI1xxGC8JBxr+J5
         0PLxCuoJTkJRpIjh6xv6JM9MnBPx2UvoY0RwI9DiA6OqPW4hePWW11h5FV0KhGFu6DHw
         UIwBnGVYJKOa3eA4pN80Bdr/Y27Xsb0F4XhkANzts6VIXxI2RMaEQGU9Wnj5J+7YNEsk
         T01i/uKj+V/6RgxK5FWIYJZiD0xKDMBP2pP5Wb1s6T3UBZMtJKq6mOfVT+4pes1x0WdG
         mu2Q==
X-Gm-Message-State: AOAM530yL+lKiLkVUV4hHKfnQxEydyXzdSoMLzeJb2lr4THwF2n4i0z6
        KlIzXzKjU2vErB8l0s41CR+dIPrzyz0tfA==
X-Google-Smtp-Source: ABdhPJxXwkMECPhPZ7Fs6FvQn603/k/GYYkWHeavg0p5Z2ueCzK4/xtmlpm1TSzQ7J1gv7GYW/qEkA==
X-Received: by 2002:a05:620a:134f:: with SMTP id c15mr6988378qkl.316.1602017540421;
        Tue, 06 Oct 2020 13:52:20 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.18.159])
        by smtp.gmail.com with ESMTPSA id 185sm2553946qke.16.2020.10.06.13.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:52:20 -0700 (PDT)
Message-ID: <5f7cd904.1c69fb81.b9019.0475@mx.google.com>
Date:   Tue, 06 Oct 2020 13:52:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1495010758604200329=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] mesh: Re-arrange Join/Create/Import/Attach page saving
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201006203529.424897-1-brian.gix@intel.com>
References: <20201006203529.424897-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1495010758604200329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=360483

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


--===============1495010758604200329==--
