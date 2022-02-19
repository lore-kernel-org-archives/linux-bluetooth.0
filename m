Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EB2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Feb 2022 00:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbiBSAoT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 19:44:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiBSAoR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 19:44:17 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C8F1ED1FA
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 16:43:59 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id f19so18036969qvb.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 16:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=U32FJeb8+42CETWtuEfYAP9dhnE9+5odFUiXYtNdmUk=;
        b=PadWXzDN83tL9raL7dIZEexWzweIhA/T42pMxatr9xsheeTqAkv26dBzPMfzSRvLOc
         8vFdzCLKLSs3U8tH3ObqM5mk5dGfDBJfUwbnZKz8nvZXgiXu8sZhfxDsnqkVvSJa7OSq
         FYe9KdzSWNIcLiupAZvv/L2fCY4EYAyPovZaHp8a5ezQ2F7oHtz2QbC63J1nZNoGalhy
         zUqrFA8sIvVttJeT/IG/tPwoOWUZkCN4+M95PadlV0ChpnZwq7gVAuiRsCvmqi+8Mt6h
         X6iq5bzufDhC0kch8m0ZGTUe+mqjGTBFut3LavhfanwWgXHapYE4BwY06ydBg9ktx1cj
         z08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=U32FJeb8+42CETWtuEfYAP9dhnE9+5odFUiXYtNdmUk=;
        b=xCnzTfyi/Svl3/z7zi6487E4oQKe1uLcBmw0O6NSDk+T0v7tx5frgkWFXS3wqSFxkm
         C3i9eaRUCXVWpZTSRonygEnKHKQ4xk0U3oUeRl+YPq0gm0Kes4g4ImoU8zbNtnTVov/N
         zwm+psa90FCqO9XR0bhIpCIyl+H+0J4NYKUvlj7Ym3TVqx6B6fxFjjjh8Q+9bCqMFdJA
         5aCRkBEzMEHAi1gXzx3YZc9qEJBICTmGa1u2IkG9bHTi8CpA3mstYkwyG8nNnV+JBEpj
         CPLXtFBzzQ16HggcaXrzCXM704FTH1Op/eyBgmx0V/6rgkR1ls3zOnp0p9pZ96/HDLsP
         yF1A==
X-Gm-Message-State: AOAM530S9Ctg4yTtwoBsKZFpVpDAUCNZyKR4M+aWtsnu/4zVx070gPsZ
        qxpPi8nSsM58QU2hj+zv0PKs1xYWfCw=
X-Google-Smtp-Source: ABdhPJycFWVpaGTLJu+k0yFQbyIjIHTF2AMOdmjlZmW0Afh+QD/xfFXMeOd2VvSg1llaEWcIZO5jYQ==
X-Received: by 2002:ac8:5a82:0:b0:2dd:2ddf:ff69 with SMTP id c2-20020ac85a82000000b002dd2ddfff69mr9208602qtc.236.1645231438680;
        Fri, 18 Feb 2022 16:43:58 -0800 (PST)
Received: from [172.17.0.2] ([52.252.106.32])
        by smtp.gmail.com with ESMTPSA id d13sm3367122qkg.38.2022.02.18.16.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:43:58 -0800 (PST)
Message-ID: <62103d4e.1c69fb81.8c0c7.7cb9@mx.google.com>
Date:   Fri, 18 Feb 2022 16:43:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0569304562949777359=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] player: Fix Track being emitted with empty metadata
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220218231846.3455223-1-luiz.dentz@gmail.com>
References: <20220218231846.3455223-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0569304562949777359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=615908

---Test result---

Test Summary:
CheckPatch                    PASS      1.60 seconds
GitLint                       PASS      1.02 seconds
Prep - Setup ELL              PASS      48.44 seconds
Build - Prep                  PASS      0.80 seconds
Build - Configure             PASS      10.08 seconds
Build - Make                  PASS      1417.81 seconds
Make Check                    PASS      12.11 seconds
Make Check w/Valgrind         PASS      506.93 seconds
Make Distcheck                PASS      263.33 seconds
Build w/ext ELL - Configure   PASS      9.92 seconds
Build w/ext ELL - Make        PASS      1392.75 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============0569304562949777359==--
