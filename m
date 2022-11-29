Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD1EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Nov 2022 23:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiK2XML (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Nov 2022 18:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiK2XMI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Nov 2022 18:12:08 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBED56DFF9
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 15:12:07 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id x18so11060005qki.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 15:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AllhpDwhkksbARcsqF1jTEQxMqiuMYm+r9gXbbxo6MQ=;
        b=pqe4oBeP2iZ3OmIPI1DMBsor+IcpiWRqGNYVQNyZoTqbmnYmR2H2y93IJzFH+3LpaX
         Cx5RoeJtBaZ0OGQp3DGAGRnlbvSIK9c1ukWPmzdo2WHmVfxfhtLZje2+B17DU5U6uN2w
         J4GQhsC35GftSrhW8c+VQMLzWvoteya+Gv7eQiQ9dAQFLDFF4s2E09SNHKVgmE+GpIBH
         JO293ihybS4j2kY5QSAVJ+3nPl6f2WAt7tRtK+OGnDyrSfucDw96yF2SsHka9JnrqRk6
         AASo+e8GO/EZLwEKPQ2YwBRDb8oYviZxGny26UOhac/b5uJ8pso/izd1j4b1NnGn0hw3
         2Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AllhpDwhkksbARcsqF1jTEQxMqiuMYm+r9gXbbxo6MQ=;
        b=PHUfH3qzgcNLgioEhqx82gFdLbwtnZ5ujeMv4ZJ07B8I0301f9ZI0meuab4yi9PH3I
         y8ajmm75eNaG/sLP0P/syHb/hSSXfPJG2BMRsOrKR9nZYPoWjct9QApqfC2DAkx5+i7F
         sPQ7ugeTtrjRdok0Hx1wtrWPhn4K/qSC2E3aXB0/lj4b8GlO1hcXW5FN1ul3NgEFjd7R
         wC6BXRmMo6aM7qgfwDXZybjftSItzyTv5mSKCk1TkCinOjqUa23LiER9MPI64nLi/nQG
         EtNAhFQpHPcEALfulABgTpYa1UtJWfSq99r3B1jK2USIO1cOqDwpgkV8IFQBrW/Sh+gI
         oY/g==
X-Gm-Message-State: ANoB5pnnjHNJf491s/J6NewFjzGF59imzJJ1iSS0uHvYDvSbJM7ecb0v
        rV0QQUb7FBKsE/nwzOurjHWbqnLjmIvEzA==
X-Google-Smtp-Source: AA0mqf7wO5IWbmvYv8ZZ5Omrnb+zFCKBIDXRI40d2Ghu92or9+c6caKyaUKM7X9Z9wd4u7CcPdGnQQ==
X-Received: by 2002:a05:620a:3710:b0:6fc:90de:af27 with SMTP id de16-20020a05620a371000b006fc90deaf27mr3954460qkb.330.1669763526764;
        Tue, 29 Nov 2022 15:12:06 -0800 (PST)
Received: from [172.17.0.2] ([52.188.207.116])
        by smtp.gmail.com with ESMTPSA id u3-20020a05620a0c4300b006fc8fc061f7sm2050332qki.129.2022.11.29.15.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 15:12:06 -0800 (PST)
Message-ID: <638691c6.050a0220.6ac65.79ea@mx.google.com>
Date:   Tue, 29 Nov 2022 15:12:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0641341986726689862=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/5] shared/bap: Fix not reading all instances of PAC Sinks/Sources
In-Reply-To: <20221129204556.1535821-1-luiz.dentz@gmail.com>
References: <20221129204556.1535821-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0641341986726689862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=700234

---Test result---

Test Summary:
CheckPatch                    PASS      2.95 seconds
GitLint                       PASS      1.87 seconds
BuildEll                      PASS      33.94 seconds
BluezMake                     PASS      1007.00 seconds
MakeCheck                     PASS      13.20 seconds
MakeDistcheck                 PASS      183.09 seconds
CheckValgrind                 PASS      297.60 seconds
bluezmakeextell               PASS      116.65 seconds
IncrementalBuild              PASS      4089.08 seconds
ScanBuild                     PASS      1243.14 seconds



---
Regards,
Linux Bluetooth


--===============0641341986726689862==--
