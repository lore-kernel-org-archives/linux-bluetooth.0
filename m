Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2C1C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 03:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiJRDmU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Oct 2022 23:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiJRDmA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Oct 2022 23:42:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDE35F7D
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 20:38:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 204so12892855pfx.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 20:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hsHn14SvVu3n5RW+wVCKi+A1WyZ8hJwk8/88MIiQa2s=;
        b=qKi4rMzWQIMfk50SJmIdFux39wYIgh7x3pqQp5Y0kVoPrvo8Nf0/nYjtYXh/Tl64Wg
         gs67R1n3HlbVceYLz97i/3jGg7z9PmSoh5OZqB5kiG/IBnH4tt5tCFo3BQ9H4rsZAuxf
         yAZxBvs+sb3cSrj8t17ffDzeLWO5B/kJkjtq2e6KvxLq5TDcrrzQTjquZI4REvLkwp3G
         6vEaAPhFwxsDQthxq+ACEUe3Cm77H92slLNcCrV867UjVPcXd6KdeKtKc+emlkIn8Bl9
         GfzOANT/qg0b/sTnHKXkTKcOLZIDSbi43zwtfDtibMsKrvXs74+MobyBzp6ljsmqz6wI
         yKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsHn14SvVu3n5RW+wVCKi+A1WyZ8hJwk8/88MIiQa2s=;
        b=0Aapxna9/VtVaJqdEmx42dN6nyqXQkkHaaHTe2PI4sw82KeeiUwGMe4usT75rQfBCm
         pJtcl+7eiXYcFdjsQPoIPjhGcwDr49LjzO3ZR3CJc4pBZOsvQWOAZUnew5gvPFsy1pKP
         VlFta3GfcLc/IzCr2BWi11PTdLt5BX6EZxsNEFeV3qzhE+z5gkl6jC3Tt/qFpwIwIUq9
         NFGYh2Lqbze1vNa12vWjoeWZPC/GIn2GAUa/RflePKQYKCTSpkimZ8jwvBaf1BxsC0uu
         dxRyf6NWa8//5qPx0ZWGF2MEnJcawg3EivIN1bHn9vxlh8mfMEDK6HkybcAomQnbqKvt
         ClRQ==
X-Gm-Message-State: ACrzQf2mjebhuc0CnUZgE+ZFbmtg9V4yWKGfcgBSoRHs3aV9V0FqvopQ
        sI/UJJYpm6CQvf06IN5x+w9/Nj7aKSI=
X-Google-Smtp-Source: AMsMyM7BLQuPVV0a9Jh0LNWwtYf6vDJvAtp0nI9dHz5La7hx+VMhXHUa96W+yCBfLcCt83NWxszpMw==
X-Received: by 2002:a63:5b05:0:b0:460:a6a:ec38 with SMTP id p5-20020a635b05000000b004600a6aec38mr885774pgb.485.1666064284590;
        Mon, 17 Oct 2022 20:38:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.70.207])
        by smtp.gmail.com with ESMTPSA id q29-20020aa7983d000000b005625d5ae760sm8143348pfl.11.2022.10.17.20.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 20:38:04 -0700 (PDT)
Message-ID: <634e1f9c.a70a0220.19636.ea53@mx.google.com>
Date:   Mon, 17 Oct 2022 20:38:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6337841691629528948=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v2] doc: test patch - DO NOT MERGE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220928045439.210967-1-hj.tedd.an@gmail.com>
References: <20220928045439.210967-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6337841691629528948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=681301

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.45 seconds
Prep - Setup ELL              PASS      30.93 seconds
Build - Prep                  PASS      0.76 seconds
Build - Configure             PASS      9.55 seconds
Build - Make                  PASS      1153.33 seconds
Make Check                    PASS      12.66 seconds
Make Check w/Valgrind         PASS      346.53 seconds
Make Distcheck                PASS      276.50 seconds
Build w/ext ELL - Configure   PASS      9.70 seconds
Build w/ext ELL - Make        PASS      99.18 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      638.59 seconds



---
Regards,
Linux Bluetooth


--===============6337841691629528948==--
