Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F3BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Apr 2022 00:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiDWAtE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 20:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiDWAtC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 20:49:02 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D046ECA
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 17:46:07 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d9so6658148qty.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 17:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1vAUus2GZ6U8EJUG5M94yxP4aVTHozRDPahkyASnDXg=;
        b=N1056/nMfqSmo23LCG9P58iboe7mT2NDAC9hYdPd6LnE7DiMnhG98y39H7soyVWGIT
         AqGd6e/YOh3sDCCDLh7CnBJWWCRt2M2Wc7HVqIQuyxbGPmeUt3JrLuHY7A0+zrW9/Mdo
         rOoD3dYpDvd33PNcnbHOQxaq8ShjLHoRsP2XMcKOJK6SuUL8IfEAe04wZxekrXRTLWLe
         /Zg5dhTP4NNidWmDqPBzfjkyaI9brP6JOdu9wO3BcIqXkGd4+grYARoCzyl3OdAZOEj5
         RCllqq5HDd1Lh0VdUBG2VTUtaGIQ20CTYPej4t5386GzV0gOW/xnONTe+eJ3r86oEGX+
         dROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1vAUus2GZ6U8EJUG5M94yxP4aVTHozRDPahkyASnDXg=;
        b=BTbr11dKEjCUpr4OQZB+6OCxfiYMRGR+vgYxx8q9W6+DDMLVaxBKfDC+FikIjNfETA
         dvJnMrFOh+l02NjS+GcP1P4mT1tOa3ygaZNS1W6t3ooOxiuotAam+F4OfQfk8zo0SN9F
         RNZfQFrcBkVP4B3C97TXav3aQkRlsYfXukds2tTzREEdrj611qljZiQNxPR7TNLhcuCA
         HhkaJ+egzlyDEh9VoRl6+5UfkLsN4FBptXkduSvLTgDUh728odCMMe11V9TS/WCjGoIx
         e79x1oHZu/OYqUM6rkIyo9ywHTSPA+CUA+qvOfC43LSDAOYAISTGAcutuRm7lIaatEzi
         l9Tw==
X-Gm-Message-State: AOAM531I2CtTCgMG1wFWnBNgBtAbJdkLupiJoJXhWpTbGCs9Ry3YzPuT
        S0c4VHrvpIsx0M0Jqus9HTcz4FCdVVhtEg==
X-Google-Smtp-Source: ABdhPJwK759PyVWYJLX0tbch25wV69y+UA2g2pTG36Y31cbghNgwgraLff4eZgRhrIqFWGa6xdpy4A==
X-Received: by 2002:ac8:5c4d:0:b0:2e0:71b7:2829 with SMTP id j13-20020ac85c4d000000b002e071b72829mr5353497qtj.323.1650674766808;
        Fri, 22 Apr 2022 17:46:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.38.234])
        by smtp.gmail.com with ESMTPSA id p144-20020a37a696000000b0069f02b93b36sm1594425qke.133.2022.04.22.17.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 17:46:06 -0700 (PDT)
Message-ID: <62634c4e.1c69fb81.4f5f2.a780@mx.google.com>
Date:   Fri, 22 Apr 2022 17:46:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2978888135214839122=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client/player: Add transport.volume command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220422230238.3836087-1-luiz.dentz@gmail.com>
References: <20220422230238.3836087-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2978888135214839122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=634837

---Test result---

Test Summary:
CheckPatch                    PASS      1.51 seconds
GitLint                       FAIL      1.02 seconds
Prep - Setup ELL              PASS      42.85 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      8.50 seconds
Build - Make                  PASS      1414.72 seconds
Make Check                    PASS      12.05 seconds
Make Check w/Valgrind         PASS      448.90 seconds
Make Distcheck                PASS      240.44 seconds
Build w/ext ELL - Configure   PASS      8.64 seconds
Build w/ext ELL - Make        PASS      1436.65 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] client/player: Add transport.volume command
9: B3 Line contains hard tab characters (\t): "	 volume <transport> [value]"




---
Regards,
Linux Bluetooth


--===============2978888135214839122==--
