Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32321C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Nov 2023 16:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjKAQhh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjKAQhf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Nov 2023 12:37:35 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0FD101
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Nov 2023 09:37:33 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7aca968a063so119655539f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Nov 2023 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698856652; x=1699461452; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ivqwjvknf1Fb4FSlmFMPIWpbekSgD7k+xvMq3QYmWIg=;
        b=ZDktKS11yCVTtsh5laRpiXSzd2M7fMlw/cvYkDdMu9DaqLCXH5LyP9Zka/Ri5bEQ8E
         ARkX07nwOJto1bufZ8neX77ZoKvNny04b2QYIDR1cQW/bQof98haUxDUQHjJhWYe9nQg
         X59QMCIdqHnpIzL+YHqqEatCReKD7lhIdXLG9o01bxH7Lr6OHPRPJiJBgaM+4npKYX4R
         Ibz8H4TCDOGmf6sCP/YD8QjiqF782J4OYwGCr88v17s4NoK5uDt9/2WtLzt0/emuWFtH
         OFQMEdTPXCArwc7p/RVZ568ZanYxxvf3+n2zRdLars2fKo/voQHgX/qlhJPaKzrA9sSD
         vm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856652; x=1699461452;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivqwjvknf1Fb4FSlmFMPIWpbekSgD7k+xvMq3QYmWIg=;
        b=IOTZU8yvUF83vFucTNiysHwtBeKiD2r63HfGufA8Pn3I0ZnVbiSDtNxMoy6zEdVl8M
         V0+QOqbTTF//iFErv8uOOb0xSDZ4pMnalPPF8FREHIuvrbrMkgchmp4WNvg1HHrvequQ
         JAopBMihfnU1b7MLjWhh8vJ5hCaBqkv4Z+Dj6xWfNgsJgVji83T/jxP1GHqmYb1jymgN
         TuzwtBnrVKU/vLZYDb05A0rH9EU4Fyi9bRZNGLK8Y+fqBk7gP0UwfLnELTp12EwOLOqC
         vRFqjfiwiVhRca7aBBpBrU2/f546HHJUdJ2p8LA2OS+TkVA4zo3IFrToMfPEsleADg1z
         mZ4w==
X-Gm-Message-State: AOJu0YycDfN2i/0DbcWsTaGEjkaVKX+wY+z/3YCwpiJ5q/iNSv6LD+Je
        KgdxqJl+7diRF1GVOVKQ/nUbVblboQ4=
X-Google-Smtp-Source: AGHT+IHHmOycFEK/AJIaR4iqH1hX1AppWt2jkcXSbgTTuezjuUEIJqJkLaoXhffJHzPylIsMgQY49w==
X-Received: by 2002:a05:6602:2e8f:b0:7a9:63ff:29ff with SMTP id m15-20020a0566022e8f00b007a963ff29ffmr22060247iow.7.1698856652283;
        Wed, 01 Nov 2023 09:37:32 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.52.245])
        by smtp.gmail.com with ESMTPSA id r9-20020a056638100900b0042ad887f705sm1055263jab.143.2023.11.01.09.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:37:31 -0700 (PDT)
Message-ID: <65427ecb.050a0220.c362e.1b2f@mx.google.com>
Date:   Wed, 01 Nov 2023 09:37:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5185216946255171299=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Add test for bcast AC 13 reconnect
In-Reply-To: <20231101153122.5618-2-iulia.tanasescu@nxp.com>
References: <20231101153122.5618-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5185216946255171299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=798194

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      27.61 seconds
BluezMake                     PASS      825.75 seconds
MakeCheck                     PASS      12.35 seconds
MakeDistcheck                 PASS      175.30 seconds
CheckValgrind                 PASS      268.33 seconds
CheckSmatch                   PASS      361.86 seconds
bluezmakeextell               PASS      116.24 seconds
IncrementalBuild              PASS      709.40 seconds
ScanBuild                     PASS      1070.42 seconds



---
Regards,
Linux Bluetooth


--===============5185216946255171299==--
