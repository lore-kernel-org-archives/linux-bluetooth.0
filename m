Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC882EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 20:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjF3Upu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 16:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjF3Upt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 16:45:49 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2103C32
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 13:45:46 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a36b309524so1758181b6e.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 13:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688157945; x=1690749945;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gog4rPBg8oxHju71rhfnuwwszvXiQrjQ0OoWk0AFgRU=;
        b=GY00NI05+8/477J8atUd3gPabrnDnhPTfw9Bi1RBv3fRYdUU63S8JVj04cqWp1YhuP
         tlds3487HOoljNT1WfCkMC/jv6AzIrK3g8+qEjQHowxG4NAy6B9pudnhQXbbcRv/PXt0
         snkS0UApzj9Ov5QKmb/tBovfn8OQvUsTOyO6oJZe5tdqs5nWs2kGdRcnZAT6glw4EYCx
         9xYV/h3f2P1aZlrQYsNUQvtd9S85dbH3DSYNWBQc2Ix+6vwZJIPMEppGeFGCg4z3y+hl
         Qc0ZTTGKUDOp/DKSbPtsfKA1jTyUifoki5GF7U9KpnQ6KLffpo/mxpyBS/9Z7HaVOEe9
         x1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688157945; x=1690749945;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gog4rPBg8oxHju71rhfnuwwszvXiQrjQ0OoWk0AFgRU=;
        b=kjwzV09NzU3LZziGLyV98f4IVo+Xfa4YEkPoLhJQ0hUwm1DirSeiruSu6bbvTvVkz8
         BuWjQQqtnwKCbPtu/hHDMP5xWZ4W1ILvPAHpis7YIaG/3UeeaUigdIwGs5Yv30k/Ml//
         gzFJEguO3ZXATc7Glx+GKASueRFxX5IGJ0lnrnwud16FCatcZ24G59JaCG1udMboSrQM
         d7dx8irSVGZD2z1BlTO4Pkwc4+BEjqnORn0FXPq+V6ddDUgc954MG+axnB7nMVvM88+W
         WqXIaPmfUxPNxr01XUFLNLGeouxAcl9FDDCndTYBefjNN//2Owi0dvA/qyiTdFoL2pNU
         UJxA==
X-Gm-Message-State: AC+VfDxP8MditujRe4uCQBrCNXQxvFMUBCereUxM7bIRi/vldzmmcups
        PoVDCWq/cLT18WC55IOO5u9/ER6ZPp0=
X-Google-Smtp-Source: ACHHUZ7eMqz1yj/1gr6rTedWHWtQlhSYFnNzGpVkmDInjb39gpsRPWi91XK01gjCbqfkkFfvXDtIZg==
X-Received: by 2002:a05:6808:2214:b0:3a2:a96d:19c3 with SMTP id bd20-20020a056808221400b003a2a96d19c3mr5780409oib.41.1688157945076;
        Fri, 30 Jun 2023 13:45:45 -0700 (PDT)
Received: from [172.17.0.2] ([104.44.128.240])
        by smtp.gmail.com with ESMTPSA id k24-20020a544718000000b003896e31867esm1034402oik.49.2023.06.30.13.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 13:45:44 -0700 (PDT)
Message-ID: <649f3ef8.540a0220.14645.636c@mx.google.com>
Date:   Fri, 30 Jun 2023 13:45:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2905136736175623951=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] transport: Fix crash on Transport.Acquire
In-Reply-To: <20230630192642.3591626-1-luiz.dentz@gmail.com>
References: <20230630192642.3591626-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2905136736175623951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761667

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      32.05 seconds
BluezMake                     PASS      990.62 seconds
MakeCheck                     PASS      13.77 seconds
MakeDistcheck                 PASS      182.82 seconds
CheckValgrind                 PASS      303.36 seconds
CheckSmatch                   PASS      399.63 seconds
bluezmakeextell               PASS      122.17 seconds
IncrementalBuild              PASS      806.29 seconds
ScanBuild                     PASS      1232.68 seconds



---
Regards,
Linux Bluetooth


--===============2905136736175623951==--
