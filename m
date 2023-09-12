Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390D3CA0ECA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 08:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjILIMi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 04:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjILIMi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 04:12:38 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C43BE73
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 01:12:34 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-410af8f75d9so35301791cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694506353; x=1695111153; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lnPfoXBB33bu+wdSipXbVQ1LOEujy5Ur19YozdimHtY=;
        b=Ww2jR16wRSKo9+Vjn1cvHdKaz1jpaJc9ryE5xlWpNKxQekGeb3ZANkXPHRruYmAjv0
         /+dfuKQ8Nm5WC8OkRvLCbSfgY8oh545FBEI+D2RjU7cPo+JWWw2gqswM6PwIeJxUKrvK
         0MiSoeE2hn6P4czjodvj9jC+y7LAuI/XpwmlgZ3RPz8O4wvNoHS4ir3r+bNbV1QICFEE
         HfYnFWZLC6GRtQrWcG81SXpcnUp4DqVWzFKJFj4jaNl507AsWNJLs8ow3Z3i3RxztExH
         PbtfC7HkDA/SMX7Qsp6isYaaTFHjfCCC1EpxwIgOepW3MvDHu7OicF7/ce7VlN9nM8Q6
         SdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506353; x=1695111153;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnPfoXBB33bu+wdSipXbVQ1LOEujy5Ur19YozdimHtY=;
        b=I3N/jTb6cxBm6o9o72BtEl3zFI9tlO+xNQMCMr9QUdWPJa8JEp9q0TDMhIM35aJpA4
         jOy5XsRiqs2qn9/r0O3/j+wOhO5de77aqY1hX7syR4GAoXa/ThUVXVACUS7C2KHpJgCx
         MNUL67s6Xaext6h0y998pQn7Zztx3cJsz9K9qlwmCTKKXVkxm+G/jwXEaT44jvk7/I5l
         tKqr2kWTNkF8fT1dw4stjUzAIdR1AwzcB0B3OtNN4tI19CQyDO1m5egirmqeesBL9gGe
         D7QiFIs3qREexUim74FCYl40W6B1k9Lj3+3BUCO9SqRqmCEqlMEhH6i+sgliDfNuMI5j
         cf5A==
X-Gm-Message-State: AOJu0YySDClaNixKaL0Cee4WKcFdR+j0nmedwIY7FmpHBcXW4gmtIznR
        G43nX0J58SwPgutuyHemloyP9t14pzo=
X-Google-Smtp-Source: AGHT+IFrHfi8OBhFPP9J4ZoICtKtVR/DfoUSEIWKdZH1GKXuoaaDLdJF7nNVNngaEQanoZ63Mo1Lpg==
X-Received: by 2002:a05:622a:164d:b0:410:87a:be98 with SMTP id y13-20020a05622a164d00b00410087abe98mr14202064qtj.20.1694506353313;
        Tue, 12 Sep 2023 01:12:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.15.94])
        by smtp.gmail.com with ESMTPSA id g16-20020ac84b70000000b00401217aa51dsm3154367qts.76.2023.09.12.01.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:12:33 -0700 (PDT)
Message-ID: <65001d71.c80a0220.5a1ac.c39d@mx.google.com>
Date:   Tue, 12 Sep 2023 01:12:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2216226629804028033=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: client/player: Add command for control of BIS encryption
In-Reply-To: <20230912064026.1203509-2-vlad.pruteanu@nxp.com>
References: <20230912064026.1203509-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2216226629804028033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=783275

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       FAIL      0.53 seconds
BuildEll                      PASS      27.76 seconds
BluezMake                     PASS      870.88 seconds
MakeCheck                     PASS      12.28 seconds
MakeDistcheck                 PASS      157.48 seconds
CheckValgrind                 PASS      259.41 seconds
CheckSmatch                   PASS      346.27 seconds
bluezmakeextell               PASS      105.12 seconds
IncrementalBuild              PASS      705.32 seconds
ScanBuild                     PASS      1078.20 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/1] client/player: Add command for control of BIS encryption

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B3 Line contains hard tab characters (\t): "	encryption [on/off]"


---
Regards,
Linux Bluetooth


--===============2216226629804028033==--
