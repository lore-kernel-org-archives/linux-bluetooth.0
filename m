Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB56C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Feb 2022 02:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbiBSCgF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 21:36:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiBSCgE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 21:36:04 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADED01732E8
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 18:35:46 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id qe15so10095543pjb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 18:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pgWpgB6xhMvFcr7Y/z0QJzPTF/iK2v3RRXAlUqB1HAE=;
        b=czVi+31Dk/wBblnyBxLxJmKwp9CEi3fDxR+athTgVVrFzN+hQ1PfUVO65AQWJ+u1Mu
         gZDtSYVvplV8YejwDNynedduepawC4CfiJ4DDLtbe0jTIGqMq38G5CNaRPV8HU77AzVO
         VGOZzp6Mvcy4AcSQfLS1ybEvBTsgkLS5d2bEuOQwi+ZUvqvl9GeICwRffYd7NGB1NxJF
         snnDXpsFo2ezrm1BSETYzkFtiJ5gr6iPvq2fr4UlCSbN5c6x7GtlypGCPm/70NyiUZP9
         98h5QZuyuurUNNUNSxEonLzCz4aIr7ZmkLYVmZyEc/oB282A6BZufeg5GB2ATvhMfWFV
         ddAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pgWpgB6xhMvFcr7Y/z0QJzPTF/iK2v3RRXAlUqB1HAE=;
        b=1xVFVwCkWoQuHGky3HhTS3dclQWRnMZleqA/lkM/vcbp2xY8FKNBPU9e2ILbDdTLrc
         3KIgEZJC4WPCkbX0hetmXJU/TZHV1BZ4g2QnwbZgVWB2QVA3/rUjp0p6P5bw7W+KN/aA
         izO6LxsERHr7ra7cAn8tKZKKRjfg1xFDuQsG0TCLnVl0R6L/eHULN+S8REGxrKVhdIQ/
         OBHc6/nvWaxfW8MWk09ptyC6BNcNamJVyQK/QmWGm4cGBZLKfDD6kSJj7nVLnS31eO2a
         g6pz6FmoDNJDWUgmcMUe/NvdhFLhuumkPfutrxONaOKsQQ+xidoXxcjwke+4DFwLJ130
         m4Pg==
X-Gm-Message-State: AOAM532ax+0Z8ZfAWoLSmpuUhvyZnPzSbSYFeSg7BcpZpQWJc0MtLWaX
        i7RhPyL+SIuLX2JWOL8uYHyNcI2EWYI=
X-Google-Smtp-Source: ABdhPJywbDpfrTlQuadW/hZPpFPLCTwAgytoTiwHBzIes/PdSKaY/A/VE0bogMN1yfm9fXI0+w2lHw==
X-Received: by 2002:a17:903:40cd:b0:14e:dd7f:f3d5 with SMTP id t13-20020a17090340cd00b0014edd7ff3d5mr10056413pld.88.1645238145827;
        Fri, 18 Feb 2022 18:35:45 -0800 (PST)
Received: from [172.17.0.2] ([20.114.45.163])
        by smtp.gmail.com with ESMTPSA id c15sm3045238pfv.6.2022.02.18.18.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 18:35:45 -0800 (PST)
Message-ID: <62105781.1c69fb81.f63bb.7f22@mx.google.com>
Date:   Fri, 18 Feb 2022 18:35:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4004629082252637146=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] player: Fix Track being emitted with empty metadata
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220218234041.3460546-1-luiz.dentz@gmail.com>
References: <20220218234041.3460546-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4004629082252637146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=615912

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.39 seconds
Prep - Setup ELL              PASS      41.47 seconds
Build - Prep                  PASS      0.51 seconds
Build - Configure             PASS      8.02 seconds
Build - Make                  PASS      1696.97 seconds
Make Check                    PASS      12.56 seconds
Make Check w/Valgrind         PASS      539.33 seconds
Make Distcheck                PASS      285.54 seconds
Build w/ext ELL - Configure   PASS      10.33 seconds
Build w/ext ELL - Make        PASS      1768.07 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4004629082252637146==--
