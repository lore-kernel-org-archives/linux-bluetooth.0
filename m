Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6110DC001DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 22:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjHHWWA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 18:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHHWWA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 18:22:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF269E51
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 15:21:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8b2b60731so39256415ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Aug 2023 15:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691533319; x=1692138119;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6y+SoeoSfJqGase0QsUYuyLvyl9cNXlZBY8YEZFEbNM=;
        b=dgzhE1dQvm03IySsqQtA3c/+UvtTHytsxARytoTuXXYLhfRRIAYMeHU68vyB4xp+Pg
         MJ8NSsx8aTJyM6oj5H5LmGje7EHXQVjIHYQpdSeilePjW4rW/BE0dgjSA4NU4yj/4KfM
         3M1Bs4lvQnw1d2D9O+sGRJ4qz7UJRvvCTdqEgE6386rGtI/+mvK1qWeA9zpu5wBvoh1P
         qWacDj5K7CUwvt0TE+Vw0x/bV/CBJ5FsDZCVX3VeamM8wIsc3QkZZDIbTi2swKk+BQ+h
         hNZccDQD77s2xFbdRL6NTylb/ZDJ95HypKXy54ZCm9LarTQy1JPUmAnFoOl5H7j/DBEi
         dOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691533319; x=1692138119;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6y+SoeoSfJqGase0QsUYuyLvyl9cNXlZBY8YEZFEbNM=;
        b=JK8V3t4AS+BNjjydDIDrKUkZgJ1l0YEcFCk+vZ9nbSwOozaTpWtUjyKOnta4rJqaOZ
         dF/sTuYJZV0KKausYif4vTireQD3BN4kGtvQHfJF1OZ+nW+1YhrwZ5wCEbnx5fwwESz8
         ZwkNTks+L5Q0zx1jBkqZS2r2FJ//fT8oRoWUe0tkD868VGmnomAkuMssnYRGttZgW3hB
         PFmPo26s98Pkwods+YNLFh/1bbd/b7IOHUE3GjqeyBgbsA9lKAb7ajUtP9cmu93Dz0Fi
         RetizMma+EtdJZ77T5MIc1KzGHQOY+FaXotXR9jadVl6ptYfeW7yYiDJO+02XvH+iiuu
         C5IA==
X-Gm-Message-State: AOJu0YyqkT02GyyWMsgDUmYJ5k/CHdc6tLpNjHB3T9VBPM+boAugSFG4
        5n7ayYFEdcxr3GdKrBIhgH4gFU6hzUo=
X-Google-Smtp-Source: AGHT+IE/ktyAnt57CqlegMe0Zi2DXcs2RdIEv3o0R6K84Hzq8pg0k+mTPcqyTCUMjx7KIEd7y1TEqw==
X-Received: by 2002:a17:902:7003:b0:1b1:9272:55f3 with SMTP id y3-20020a170902700300b001b1927255f3mr837842plk.66.1691533319036;
        Tue, 08 Aug 2023 15:21:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.158.178])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001b06c106844sm9524584plk.151.2023.08.08.15.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 15:21:58 -0700 (PDT)
Message-ID: <64d2c006.170a0220.c6204.1bab@mx.google.com>
Date:   Tue, 08 Aug 2023 15:21:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3036319278977378109=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gioele@svario.it
Subject: RE: [BlueZ,v2] configure.ac: Install D-Bus policy in /usr/share, not /etc
In-Reply-To: <20230808200022.2001329-1-gioele@svario.it>
References: <20230808200022.2001329-1-gioele@svario.it>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3036319278977378109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774263

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      32.73 seconds
BluezMake                     PASS      998.03 seconds
MakeCheck                     PASS      13.17 seconds
MakeDistcheck                 PASS      187.49 seconds
CheckValgrind                 PASS      306.13 seconds
CheckSmatch                   PASS      405.81 seconds
bluezmakeextell               PASS      124.90 seconds
IncrementalBuild              PASS      817.38 seconds
ScanBuild                     PASS      1262.49 seconds



---
Regards,
Linux Bluetooth


--===============3036319278977378109==--
