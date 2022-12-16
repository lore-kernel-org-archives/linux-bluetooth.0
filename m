Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD552C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Dec 2022 07:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiLPHPp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 02:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLPHPl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 02:15:41 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3564EDC7
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 23:15:40 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1322d768ba7so2284892fac.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 23:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AgB2lmw4GdR/ufqJn5Ucbn644EJ4ORsqrft6mRRRycU=;
        b=nuKJ691T4AOb7m89n5dzEEF1hYCHK0kXYJ3MRoZ6zEr8cE7Od/myRVnMkP0a0SVp3q
         +xrU/0HjnALR5jwCJg3Z5300UeiRNEKA4LtrTdmLPDQGrVyXS7mBMVtwhszaSZmBIqil
         TJ94j6GPNJ9490C48wEpnLSwONKL881NU61xZUVQhR/KENiIvVJz6SFZs7ANhvpOVRXQ
         XxoGwqWi13DAyXUBqxWqGOVlf2qMC1SBY8FT9OkZbXg+GlsUrSAWoOZvksG43wKi37d1
         Baq4tpU3oC8RTsSpZOfLO8A/dkub//Ma8jITmjVRnMk+ZH9/LWhRBjPelI1C3ziAM18e
         lCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgB2lmw4GdR/ufqJn5Ucbn644EJ4ORsqrft6mRRRycU=;
        b=qvB5B0Cb7qwDB8omAmUXNfmGSpLIsH9QTPrHe7leCplHWzk/yZLRKj2l5UCRQc9Vj5
         E9EaKeE5nJea7ahtUbF35evIs+toUQwO0mtbmLZw+8dalk0qaNqNtUHikwZSO20RR56i
         gpQsRw+OYYZj1zqXp8bFF/P1VF48bvwSz54lWrgni6ID+0zCnDdQ4XNEf71fKLofP7B/
         mIZbePOm4xUkUp9lrvnteQEoHhCx8yVyqUs6dDr6lfXXl3QFIpIxCIp/CWP9T09Wfo2t
         nIshlzzpte2XoYgh9BmeViS5O8YdJYv2EZPbiAvJiTson+lvBWASFRFG5rco+rrBoEMW
         D+9g==
X-Gm-Message-State: ANoB5pmfRFyf7WlMqQto8RakM1xrONIitTUjN+hHrapF7LOXKtATHKXL
        cpPPwfpvobh+5HPzu9qUTgAvaVvyR18=
X-Google-Smtp-Source: AA0mqf7TAJaZB5sK/xzDSshYZlsdg7smLNRFM5ElnrhHtNMIll28ziTMfjTIRWme4OqDJr2IX3n7vg==
X-Received: by 2002:a05:6871:a688:b0:144:e56a:1a3a with SMTP id wh8-20020a056871a68800b00144e56a1a3amr14498439oab.4.1671174939363;
        Thu, 15 Dec 2022 23:15:39 -0800 (PST)
Received: from [172.17.0.2] ([20.225.149.88])
        by smtp.gmail.com with ESMTPSA id d20-20020a056871041400b0013c8ae74a14sm594898oag.42.2022.12.15.23.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 23:15:39 -0800 (PST)
Message-ID: <639c1b1b.050a0220.f46f.2c70@mx.google.com>
Date:   Thu, 15 Dec 2022 23:15:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5039400527619289679=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [BlueZ] tools: Add identifier for NXP UART BT devices
In-Reply-To: <20221216055832.741741-1-neeraj.sanjaykale@nxp.com>
References: <20221216055832.741741-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5039400527619289679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=705008

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      28.07 seconds
BluezMake                     PASS      996.71 seconds
MakeCheck                     PASS      11.70 seconds
MakeDistcheck                 PASS      152.25 seconds
CheckValgrind                 PASS      250.67 seconds
bluezmakeextell               PASS      97.54 seconds
IncrementalBuild              PASS      835.59 seconds
ScanBuild                     PASS      1048.20 seconds



---
Regards,
Linux Bluetooth


--===============5039400527619289679==--
