Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A61C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 18:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E55160F0F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 18:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhJRSDT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 14:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhJRSDP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 14:03:15 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD57C06161C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 11:01:04 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x123so2321048qke.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Xojc9ERYvv7UyxJJVPBfD+/Zf5TQV6sIXoZDgH8tNbc=;
        b=mUYOWwTbJAc+SExGykJMtkekFzb/K/rLdPTuMavVla8gghARy4XJrNnFFka1kPvGNQ
         /BHeUOl880e7FU/qeWq6rNsQ0TI+q7w1tXV3+oRhpPCzocLq8ibemRbNYDCV/KAad0Pn
         fkcX2DDyYTD9UGozwbobB6UrEsA15vuIA7TXknjiqzSqvTLW6ngKbrwNNItUp1uAGxHq
         dP33FmG0Aq2JpJB/yh1lztxJPgPvPQcFU26Oamx/TDeApdxNKwnkouajnC+qZexv768u
         iwuyqdzRpDtbKI6cYmkLiAcHltPhxRnH1SbTtblXk8M+Bu6zfi6tR0wzcKpbQeVscZUE
         43TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Xojc9ERYvv7UyxJJVPBfD+/Zf5TQV6sIXoZDgH8tNbc=;
        b=eClKPc/AhwLzaaBSwOEdTJRjt0jCRMVS3op8K04meB+FSdsiFf+LvmPeJGX5LnX6dQ
         O9zKglYN9sYalOApFOUgKR+X0lhrUo1cdOdJZrCEhdfdBowUgwnaxJuPj8YU4OzVxwYI
         mfHgbADBhwSkC5j9a1e0+q1tLAcB9kF2IMe2HF18BA4YSm3qtace8BjuIqOHZTlVnL2T
         DTJdxk5rJlB0CXvbtbR1kZ9YFqpFsX4cvj/fz5uBajytVBXMEjxykxULlXGZzgoSq8t9
         Hbm6OqikWlb86ci7rn68sQ/ssnF4QdpV/cQdUHluhooIw2uoYChyF0F9mnRYDluElWYy
         jucA==
X-Gm-Message-State: AOAM532CfoNG+dcYe5f88J76Fe2uMw0IYGOS5xCKpQjDeGquWI5TlC1r
        3fpNXf/4J1pZaiCUSpAsDviobUHzxgrMhg==
X-Google-Smtp-Source: ABdhPJzAZ8SetfIsJdYJuasxfeyP3qbugLi6tKWyIpz9FjwFug33NW965lUQzWiwqG3BlbVuWxyQaA==
X-Received: by 2002:a05:620a:228c:: with SMTP id o12mr23291428qkh.367.1634580063306;
        Mon, 18 Oct 2021 11:01:03 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.209.190])
        by smtp.gmail.com with ESMTPSA id m16sm2528322qkn.15.2021.10.18.11.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 11:01:03 -0700 (PDT)
Message-ID: <616db65f.1c69fb81.c4a83.fe17@mx.google.com>
Date:   Mon, 18 Oct 2021 11:01:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1043535176271591406=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: Fix unchecked return value
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211018172833.534191-2-hj.tedd.an@gmail.com>
References: <20211018172833.534191-2-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1043535176271591406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=565705

---Test result---

Test Summary:
CheckPatch                    PASS      14.20 seconds
GitLint                       PASS      8.79 seconds
Prep - Setup ELL              PASS      50.33 seconds
Build - Prep                  PASS      0.53 seconds
Build - Configure             PASS      9.44 seconds
Build - Make                  PASS      219.25 seconds
Make Check                    PASS      9.97 seconds
Make Distcheck                PASS      282.41 seconds
Build w/ext ELL - Configure   PASS      10.45 seconds
Build w/ext ELL - Make        PASS      223.90 seconds



---
Regards,
Linux Bluetooth


--===============1043535176271591406==--
