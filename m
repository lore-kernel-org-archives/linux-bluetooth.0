Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF94C77B60
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Apr 2023 00:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347134AbjD2AM5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Apr 2023 20:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjD2AMz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Apr 2023 20:12:55 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A49BB1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 17:12:55 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-5ef6e0f9d5aso6478496d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 17:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682727174; x=1685319174;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SGB5uaKJ5np+pMJs4Q66qMGccex2SeIOndzfR85Yds4=;
        b=RVhLZT7B9cfjACJJLhcctOvJWvJq0HaBJSqCHZSAe3m3XXRo+7jd8rvouxb6t6AyFk
         KONAz3e4EQyfGoqtawFtdo+AQhH0diH+yCxle/mJ1Ij6Q+2kDkw2ZVKnyOku/wZOyeCd
         zwZ3MNrZk0dqKQTigOWAxw+rqeNPRIcwMytAJObjATRJv99AKproYR/TarbnTWSiCUsU
         J7D4OUyy/IOcz84fVvEQcPD7PMPk7DlfiHwKhJmZuiET05fe1KOJqEQt6SFPbzBZIeOE
         MxKfWTMyXrQfjGASavvF7IO+jVP9PkcCUTbFNQrB3SLtAJhBPM6PGgDdb8QlkwYrd3Id
         ZGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682727174; x=1685319174;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGB5uaKJ5np+pMJs4Q66qMGccex2SeIOndzfR85Yds4=;
        b=kjmkXNBX816nfBqBx+MUDQot0rf+RT32/2uw5FMPwi0q1/j1AIltujlmoLfL4GgWOS
         U4VTHDvMIFXUwUNNgCv7oryWrI/j5YvBHwaoW8L6hxdBCcrMk3EzSFrdbVUhjvxtEKFF
         YUjMygm1tqdTE/De5KVoSUeN+1YKliCnSCrNiBHJbOxTP27Z9JVdh29ZCbyoJ1Dl5qj0
         bHB20S0JDWjl3f3TnBpcoeG9Q79UD7YmnMTUZ//3olI1YS1c2+HC+ElE1ATIHrDzdRpc
         OttSCq8lV8NUZtPExq5i3/jgSKA3XytolC4A9bssnL0fflI+s+f0i0LvybmPcBktUbFE
         kVNA==
X-Gm-Message-State: AC+VfDwxttAutuOZBv7aRFnHPiYCWY6fTfhqNlOcVKId+8/akxvwKGe/
        iUrW3wwJO6r2McLwyD09QdJUpt83OeE=
X-Google-Smtp-Source: ACHHUZ5PX0d5OB9pri5+ZY1X6H6BNKqPf1LX2tvKZ9k/Ni02je/pRGjNefR0kUtdQi8RCQ+Kr1Xr0g==
X-Received: by 2002:ad4:5be9:0:b0:5ef:519:b1a with SMTP id k9-20020ad45be9000000b005ef05190b1amr9913357qvc.24.1682727174081;
        Fri, 28 Apr 2023 17:12:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.226.126.225])
        by smtp.gmail.com with ESMTPSA id n8-20020a0ce548000000b005ef5f7c1ae1sm6752864qvm.105.2023.04.28.17.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 17:12:53 -0700 (PDT)
Message-ID: <644c6105.0c0a0220.c2454.c875@mx.google.com>
Date:   Fri, 28 Apr 2023 17:12:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5578176811000450643=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client/player: Add support for Metadata in BAP Profile
In-Reply-To: <20230428230827.908680-1-luiz.dentz@gmail.com>
References: <20230428230827.908680-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5578176811000450643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=743958

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      27.13 seconds
BluezMake                     PASS      871.46 seconds
MakeCheck                     PASS      11.73 seconds
MakeDistcheck                 PASS      153.80 seconds
CheckValgrind                 PASS      250.79 seconds
CheckSmatch                   PASS      339.61 seconds
bluezmakeextell               PASS      101.70 seconds
IncrementalBuild              PASS      718.81 seconds
ScanBuild                     PASS      1045.45 seconds



---
Regards,
Linux Bluetooth


--===============5578176811000450643==--
