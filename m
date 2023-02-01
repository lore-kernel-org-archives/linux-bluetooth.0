Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4283EC05027
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 21:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBAVOK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Feb 2023 16:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBAVOJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Feb 2023 16:14:09 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D056E6D5FD
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 13:14:07 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z5so8956397qtn.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Feb 2023 13:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6BE23Ibgpd5SkYut9PJ2Ej04FkJvUgRkE+ESKntf7Hc=;
        b=PpwjU+sH1yU05Uyvt2Iyw7CTMdNpIuFxR4okKt6w6jHu5DV8jk5R6k7FVaCdMpPmgU
         0dhW1Go3s9dL6WN/KW6MQKs0xEmRX2ivNFRrqiLqZi/E6pyaegE7dan4ZIiOF7n93Kld
         xwg184ibp2DKS+RciJvfEMCU4QSvw6HfJs0zMiBM9J9tAlAtCW/q4x3KC3J6eCoIwfOe
         SH+yz1kq6GudDlnUoGniTtsiVR4EdgSrcWzyn3iSBVbG6eFNonm2+caGzxTruamRwwoS
         b1q7kuoFOKlKDxRwiJV0Z+Bw4a2/nf7ZeBOLOFlC3BTgx98nu9gNUpqISru50Rb64t6T
         LuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BE23Ibgpd5SkYut9PJ2Ej04FkJvUgRkE+ESKntf7Hc=;
        b=chPt3yckKIP+G+bK53ESKPgrYyCdIVIcYzWJo1NFHClU2cpCrjREtlL4D17OhJUiqh
         ulKfiTfuu3avKy5B7miIlB8vfD+gXGpbE508C2/jGQ74FBlp8mtyqUIevttlgn29nGH9
         31KbBxLP7EzQCXHKWXUAJeANR5vT+Nr0M86D1Q8VV1zVZJYtKWX7MjBS6JkGGWFCV2EZ
         Z0xTXDleM2H2/HhzfnHsZ+WojQRUgrcdbO2EOJ9GENCxiZA2ZsXdD2aWfhQgganmwTXu
         SIQ5Qw+vXZrldjwcPk9XykeV34w2oxF+m4etmgBt8fsfymiZDBquEw9lDg0aXhmTnLr4
         IKsw==
X-Gm-Message-State: AO0yUKWHoMvnumbqQ4MeZnKCpZh2g08b8ETVx8hh7B0hW1+8f49VwDhH
        GZJexF4uStvONX1ju7N3r9SX8Y/guCB3CA==
X-Google-Smtp-Source: AK7set9kd/g/FOwkQC+kUtb6z45fVplOFy9c5fF9CCCqaTqr/aJjt0SlePf49UNqEkOZQK6efw01gQ==
X-Received: by 2002:a05:622a:28a:b0:3b9:7051:255d with SMTP id z10-20020a05622a028a00b003b97051255dmr6685298qtw.63.1675286046854;
        Wed, 01 Feb 2023 13:14:06 -0800 (PST)
Received: from [172.17.0.2] ([52.179.102.210])
        by smtp.gmail.com with ESMTPSA id fu3-20020a05622a5d8300b003a7eb5baf3csm12356647qtb.69.2023.02.01.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 13:14:06 -0800 (PST)
Message-ID: <63dad61e.050a0220.3c3a7.9983@mx.google.com>
Date:   Wed, 01 Feb 2023 13:14:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4515315834808971046=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] media: set default value for BAP endpoint Vendor field
In-Reply-To: <26d36cc8d645773b6795a18355631134bf2bd074.1675281104.git.pav@iki.fi>
References: <26d36cc8d645773b6795a18355631134bf2bd074.1675281104.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4515315834808971046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=717874

---Test result---

Test Summary:
CheckPatch                    PASS      1.01 seconds
GitLint                       FAIL      0.67 seconds
BuildEll                      PASS      28.44 seconds
BluezMake                     PASS      860.68 seconds
MakeCheck                     PASS      11.86 seconds
MakeDistcheck                 PASS      148.18 seconds
CheckValgrind                 PASS      244.17 seconds
CheckSmatch                   PASS      325.68 seconds
bluezmakeextell               PASS      97.45 seconds
IncrementalBuild              PASS      703.79 seconds
ScanBuild                     PASS      1001.52 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] media: set default value for BAP endpoint Vendor field

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============4515315834808971046==--
