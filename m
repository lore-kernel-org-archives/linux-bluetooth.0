Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E3C27C7C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Feb 2023 19:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjBTTMu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Feb 2023 14:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjBTTMs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Feb 2023 14:12:48 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347832006E
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Feb 2023 11:12:17 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id bh1so2583448plb.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Feb 2023 11:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TFXZb3JayiLZRsLr4AVCBsXtEYue4+D21o1PClGiT24=;
        b=hGMmHU3iUEd0c7u544gjUNZyJfPU3DOqZQhhP3/K/sh36/qqrOV3Tj//4x2/qkgea2
         /rXt3l2i/UspwKoxn7RHc0LCsAhUuzlmP6vFjlm+pV25c69qRoXdpwRaHglu5Ym0d4+S
         Jmt1d1lkvETJj3b/sCCyCgFnXYBXGBjH3hE1IDxyGgzjHRrhcmQmwXOtd2v5Jk+DFa8K
         KACNVKofsCpoT2POwtvVKLq0GazvEKE47dvfj8M4GllHob+kE9HgAI/dtgZxX8JI1UZX
         /gD9wQjF2eLcLT45eeHeQdDLeaYzklf5hbmaJyoxtlNdnX7IZZWekyzfS9/ImilYLFEd
         qgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFXZb3JayiLZRsLr4AVCBsXtEYue4+D21o1PClGiT24=;
        b=UBuyeaPlF80m2NczsaXCp4Jxpiqr0da52KToIKqV4yoNwsjOo/40SUtBPQcKFHkkDs
         k9UxxwVZ6Je1XOtaqR1NCxSHmHQN6apunlLmNJvVlzMu3O8nLfrLFzokKmxOXYF7/V2v
         SovqnbFHwrUz9TiA74ywuZBSwKoQ8/ARRMZtu8uk8kOA8qToLM4wPs/ImCGNA0GtnuZ+
         QiEnuOrWaXiesqYV2Isrv/AXQl/crBEA0OmG4Hl0jzPmQoanqs7W9FucwHKEv6sj0bUp
         +qhQM1rqlPtS5UrP73eqn1C1wzoXI5afqgese+pYjZv9Jr/4mE/08Dv7+69z+kEQWV6L
         nbKg==
X-Gm-Message-State: AO0yUKWRGrlbm8e3kfSbQ5K/IevNAknxTOQPpAI1du6zPUUNLxMGnMUF
        aGzE1sKOeI3GqUAdnhbwTNPKp9hVeZI=
X-Google-Smtp-Source: AK7set8P7WMwE+1wkOg3W6axAQq9L1M26be47DYTOMAAJ7+5mvuYSQ3WTBRY1CeDaiZ7isZQ3rqFBA==
X-Received: by 2002:a05:6a20:6988:b0:bd:278:f68f with SMTP id t8-20020a056a20698800b000bd0278f68fmr1302268pzk.52.1676920275543;
        Mon, 20 Feb 2023 11:11:15 -0800 (PST)
Received: from [172.17.0.2] ([20.171.133.129])
        by smtp.gmail.com with ESMTPSA id i21-20020aa79095000000b0058ba2ebee1bsm2781050pfa.213.2023.02.20.11.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:11:15 -0800 (PST)
Message-ID: <63f3c5d3.a70a0220.e6202.4869@mx.google.com>
Date:   Mon, 20 Feb 2023 11:11:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5813781914056617509=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v2] configure: Check ell path
In-Reply-To: <20230220181205.1577283-1-hj.tedd.an@gmail.com>
References: <20230220181205.1577283-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5813781914056617509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=723518

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      26.81 seconds
BluezMake                     PASS      751.72 seconds
MakeCheck                     PASS      11.17 seconds
MakeDistcheck                 PASS      147.79 seconds
CheckValgrind                 PASS      240.71 seconds
CheckSmatch                   PASS      319.26 seconds
bluezmakeextell               PASS      95.72 seconds
IncrementalBuild              PASS      607.91 seconds
ScanBuild                     PASS      941.47 seconds



---
Regards,
Linux Bluetooth


--===============5813781914056617509==--
