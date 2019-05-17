Return-Path: <SRS0=oIVb=TR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4004EC04AB4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 May 2019 10:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065A6204EC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 May 2019 10:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCyushfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfEQKNt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 May 2019 06:13:49 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38838 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfEQKNt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 May 2019 06:13:49 -0400
Received: by mail-wr1-f45.google.com with SMTP id d18so6510950wrs.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2019 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=p6W5323R5Qtutz7aBvuUQgMu1YBdN8N2j0dn/NzXtps=;
        b=SCyushfAdRtgxjJe7Lz3uOSk4AvOSYLMt5Ee0v+TpA1lT/6D0xew6CZ8LXzAeX9ll6
         TUO/Tpvu4TlOkUtoeu+eMx8j4dXRmhkKyqkS01a/tH2b2vtGXrEQwgQPwTtcQzACecX6
         ahOiyspUbCqjKZH4jXSnWzGEO513iHkBjaQIMv3o0D72rRnqnsct0d3K9/Ugqq9uQzsJ
         cZnaM84hmIVVTRVFOwtYRCcp4WjIx08aEGCCBe1j6M4n3N4qmnYuovGO1pDrFtZtLejq
         74zGa8WFPqQqvXgYzbkdkUfmg6Xf1cdfBA3O/Z5TfUDJWbLg/3uo2qpvSyz0EEo5RiGH
         ouCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=p6W5323R5Qtutz7aBvuUQgMu1YBdN8N2j0dn/NzXtps=;
        b=JKpj9eZSbG6eiVSgbxXc6euOgBjtnzZ4dNdT1s+z6XnVttm5oFxu0pb7+S/7rxwxDP
         rVBmZWBec9o5+7jfLa6uHHCt96n3UzSWBwX/QgU7hXg08lARpfw8PWNOCgBOZFQML3+F
         sE/oPuEjDwuwQmFN9yAJvfpgVKpUTGTNQtu2LDwMbPhzNfpuWBhOnjQPriR2mrsh8dHk
         Clla8WmCGTY4M9147bFrscSuWxLrLVVIelkWbv1/hZpp/ptDuk113FSaj30mDz70abUz
         lEOs6BahSFFGas0/rd+zP04aoMDIQn8etXmB0pDohXlKDknAcZ0OXZEtZQz1aHO+FM5U
         8NRA==
X-Gm-Message-State: APjAAAXdJRXf5Lwyvz7hYdZwVg7hWBYlWGYbIo2kYV3RCJGybyaeCzKU
        LeexJ46odu6HQq9qKauVaP5SlKrB
X-Google-Smtp-Source: APXvYqzP70uA0dBS0kxzmjy/9rvLgBbfgLJ+tqPfZNz2rxn7bvkFyHXiYLE8mKnz26UPTk4c9TPKJg==
X-Received: by 2002:a5d:45c1:: with SMTP id b1mr23429955wrs.252.1558088027614;
        Fri, 17 May 2019 03:13:47 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id l8sm10405441wrw.56.2019.05.17.03.13.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 03:13:47 -0700 (PDT)
Date:   Fri, 17 May 2019 12:13:46 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Kernel 5.1.1 broke bluez/pulseaudio audio
Message-ID: <20190517101346.ffhzjdtg5kwvjreo@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

FYI, linux kernel 5.1.1 somehow broke support for audio via bluez and
pulseaudio. See more details in pulseaudio ticket:
https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/674
