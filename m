Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3373FEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jul 2023 00:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjGSAdU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jul 2023 20:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSAdT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jul 2023 20:33:19 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92F513D
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jul 2023 17:33:17 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-401e23045beso48559981cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jul 2023 17:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689726796; x=1692318796;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hNTwlrbF1UAW4uORFUhb25mdctWk1Q140VTVf9oMcIA=;
        b=nD3a6cOIfUHuWd4uR23DLXSPJgF/q/dZSQo4GAI1tTiYwGhvWOhcUeHC5CR17yyvtx
         4k4swKIN36JQo5SlBrgpQUR9uKCdhQSMRwhbgrgPEhi/cG4P0mHJ2quPMZrcDzOrEmgX
         YzJdPlLHxj4l/JIBS9P67TaCuPAe16sPjiKfYVbXHb6dGVCTctPuGLlBPD603InVOyqt
         VD9iTWqZbTM1eMH3TKoht4lxZehq/J2fPVx5C87zSa0+CBZ1EU9rT7FnqU9c87feaX5Z
         d2y/rLpjTBdpe2QGeHDpDT6lhDdx/LaE58kzlAN4OkCu6aucggvtqasFLPyl3oetgGxM
         JfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689726796; x=1692318796;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNTwlrbF1UAW4uORFUhb25mdctWk1Q140VTVf9oMcIA=;
        b=i67RP1R3wxeYNf4dd2S1mXM529XwtWOmNdrACQMPPYxWITNQgrnu1/eXM/w+8xwyyx
         HS7Gtx8MZT6h+Z8gMKlCiM3bGPbbZ09sxN6oknfFcYjdY7jw5Gr4QQ3D1V6U/LXZiJej
         83ZMJBLiIHgmegWzhI3EM2+J6AiX4xljkqbWrwFbJXB5tgmOY2Mv9zCMw8vc6H399inw
         GAxuCb4FFLp4JZvPya5FAw6ySZXws3g9+2eAkvuPMnUfELjbCh9CojLcro7NZp7MeHZ4
         vKbwmjFP+ddnPfFkD35dn0LBICzHk7Sq0WjNb8EMVflJ+Txjoc13i4v2QJesVy4LUd0n
         rTOg==
X-Gm-Message-State: ABy/qLbjqswIC4SmFt0cp4/bxzPzi9YMtTeKTzQUorPRCciViYd5bTAR
        qcBRn2453NEne0Mu8lXpuHzuzB1XO5s=
X-Google-Smtp-Source: APBJJlEiFwAjgqZXZ24Rht7oNFoqcxhYtxVviFCwPb6OIiEqlTzmHCpENsVWntHWMAFVwV9mxPuUAw==
X-Received: by 2002:a05:622a:1053:b0:403:f772:50dd with SMTP id f19-20020a05622a105300b00403f77250ddmr4756108qte.35.1689726796654;
        Tue, 18 Jul 2023 17:33:16 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.229.31])
        by smtp.gmail.com with ESMTPSA id y25-20020ac87099000000b004009f6e7e7csm998975qto.31.2023.07.18.17.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 17:33:16 -0700 (PDT)
Message-ID: <64b72f4c.c80a0220.f0d37.52ff@mx.google.com>
Date:   Tue, 18 Jul 2023 17:33:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4348080559361143058=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] btmgmt: Add man page
In-Reply-To: <20230718231802.217170-1-luiz.dentz@gmail.com>
References: <20230718231802.217170-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4348080559361143058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=767076

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      26.77 seconds
BluezMake                     PASS      785.14 seconds
MakeCheck                     PASS      12.19 seconds
MakeDistcheck                 PASS      156.16 seconds
CheckValgrind                 PASS      250.32 seconds
CheckSmatch                   PASS      337.08 seconds
bluezmakeextell               PASS      101.62 seconds
IncrementalBuild              PASS      649.53 seconds
ScanBuild                     PASS      1024.22 seconds



---
Regards,
Linux Bluetooth


--===============4348080559361143058==--
