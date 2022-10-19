Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17206C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 00:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJSAvt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 20:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJSAvn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 20:51:43 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123D0C96F0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 17:51:35 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id j188so17560305oih.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 17:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=61OOgXrtpX965FTbS9r+OT2a55TPQ1Uu6d7nG7BIhTQ=;
        b=HaB4udL9llpMIZ/AhyoJLHBo9/0bhKo4269CsiU2eP+lTxONKujsSpfRcTN9VCBg9H
         1pJKUTeZ4ORk/dagFXwgeqkx/7oaPmplv1rIzSbq55jxF8PVBv9CM4BZs/YowQ8Hombg
         +Fow28ufBgFePlatO5lcQYAoiueD+6smQ9bWKfibGF6p1bIEJVe3AagdYL7RjImKTmBf
         NlK8yvDmT8z4IlfWRuA0KRUirnOyNJrgswX0r3wFYZDQWfXnMSgKPvjzctQ9XbjWpaNp
         J5ssVJJH6NPSsEIDpGgdYJZs6MrpXKVLHY7ituI1o6s90u2Hw4Ph+FEYfmMDluy40lmE
         DlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61OOgXrtpX965FTbS9r+OT2a55TPQ1Uu6d7nG7BIhTQ=;
        b=bJc96aBP+tX3wUzNFar3UszzH6NeIfgy1VcMg416+KECOarVALlaUCxeYxV8CiWfns
         qz/7V7qUEtPVHtxhnR/fmp9xkVk25qjBMxSRSL0PqfrzvGiPx9z4kj8OiCvI+SK0VSAf
         a+fkmGjuOTL3qvt/doE1IDaGGN5NQOXkAu0KeHUX1Z9Mr8x7W11x4ZlPLRIuSKmo2bF/
         EKjPGa3jFeTEcsdN8xLre6YAljB+mUrEbxdzkK4s8BhGnPjFlxA0dxbbYdbT5LAfp3Jg
         F5LJ29P4s+nig69/S70qye8tWARoNGiXPNHkLTDsYlUyUBfiwJ756fzgaa3S5tks6OUf
         ng7w==
X-Gm-Message-State: ACrzQf3mxJhLlSOr8RDFMjsl5mEm/PUmmqH8jHyk9lxdg8Sru2ICkEly
        xX/4MXikifU0KuSSrsRy6A1BAaAwPiI=
X-Google-Smtp-Source: AMsMyM5x9Sw5exAYx7FJUlKd+stfWVvVZIY1oZWUtfqOwuAzhZOG0UeSjgoyUu9mEzzW/N/AnKpjMg==
X-Received: by 2002:a05:6808:e8c:b0:354:2751:69ae with SMTP id k12-20020a0568080e8c00b00354275169aemr16702809oil.228.1666140694272;
        Tue, 18 Oct 2022 17:51:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.165.69.64])
        by smtp.gmail.com with ESMTPSA id y3-20020a056870418300b0011f400edb17sm7003229oac.4.2022.10.18.17.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 17:51:33 -0700 (PDT)
Message-ID: <634f4a15.050a0220.55d0e.be44@mx.google.com>
Date:   Tue, 18 Oct 2022 17:51:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2174703043462435175=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/3] settings: Fix scan-build warning
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221018234600.3990980-1-luiz.dentz@gmail.com>
References: <20221018234600.3990980-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2174703043462435175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=686498

---Test result---

Test Summary:
CheckPatch                    PASS      3.39 seconds
GitLint                       PASS      2.35 seconds
Prep - Setup ELL              PASS      34.58 seconds
Build - Prep                  PASS      1.00 seconds
Build - Configure             PASS      11.02 seconds
Build - Make                  PASS      1177.12 seconds
Make Check                    PASS      13.47 seconds
Make Check w/Valgrind         PASS      370.82 seconds
Make Distcheck                PASS      311.71 seconds
Build w/ext ELL - Configure   PASS      11.27 seconds
Build w/ext ELL - Make        PASS      112.47 seconds
Incremental Build w/ patches  PASS      397.01 seconds
Scan Build                    PASS      702.70 seconds



---
Regards,
Linux Bluetooth


--===============2174703043462435175==--
