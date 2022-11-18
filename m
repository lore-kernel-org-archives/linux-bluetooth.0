Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9397C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiKRFdc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKRFdb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:33:31 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC337DB8
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:33:29 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id 11so3150663iou.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OfZ/BNd0G7TGeDeKiDz+fA9BefP61Y7R5rBt/jB2RtU=;
        b=hTKT8OCuNogdfzjONvwaREnlYX7JErZorVYhFdFC7z4iWQdFLjOqpWshCIRmXaXD11
         Z1SwjY+8m4ysnLLrsUAIGXaTuNwW8eXXuICBGRBshSGWqeZKozO2sUNTvQmaSxPbx7XT
         DAnGNbyj19ChzytlLw1znrFFXHlotTit3w2aH33UB8ZA4IL/JyjvUbYihfKGFRDrPLSp
         TD+XHrO/6v+upRgTu7MPMLLSb1O62UiiyTYH7H98PgTcssjFWsVU424DT0ppIUNProSX
         rxXRMN1LyxG0eD38WZI2GSPU/gbdhYt/lD+fSIxCunGDkNHhrr7+u59krUiaiLY3yzsl
         EsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfZ/BNd0G7TGeDeKiDz+fA9BefP61Y7R5rBt/jB2RtU=;
        b=lvmMjbJxZt9Li8h+YlSzTQm6qVt+OtpJ7Wk21DFacZNY31Iq0vAkDhf1y0O++moMZ1
         jvR3v5JqwlOrpzEwZJwx08ZnuSGtTaTaXPyW4ZeQraXg98uRr0v7a1kKXlpz8+wxvlf8
         qev9kmFvQ4U1xlzFIw1KQrnJawc5Nzh0mr9psOhhRreFYuoBJRoerLOTaFX91sZzL5HD
         A/9KypDQYJWw90bLYDQUuyOljNfL1YMjsOa9dgGIxz1cmreEUMpTu8+6iQRhV7D12euW
         N7+FiwnzXYLoXTXxr7Z77AaYnTQT7qrlCA+ra/l54XVKY4SpihZpuy9Kq+z6s+wG7dBn
         PKpw==
X-Gm-Message-State: ANoB5pleJzAqH5G2mO+Ln/EWi2ns1MusBy+ZgdKY+m3VEkwNDsf4O7EX
        Rdr8FSdyXSzWEU7EcGNzPHbczfjbBvA=
X-Google-Smtp-Source: AA0mqf6oNNfUZNwq960s+7L5glvkSt7SLDp3iqDw0ZLp71QmWpbnDM9kVzJDHyks5/Rra+t7zcoIiQ==
X-Received: by 2002:a05:6602:418b:b0:6a2:8015:afef with SMTP id bx11-20020a056602418b00b006a28015afefmr2915632iob.149.1668749608939;
        Thu, 17 Nov 2022 21:33:28 -0800 (PST)
Received: from [172.17.0.2] ([40.77.7.151])
        by smtp.gmail.com with ESMTPSA id b13-20020a02a58d000000b003633848da58sm946597jam.41.2022.11.17.21.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:33:28 -0800 (PST)
Message-ID: <63771928.020a0220.eb577.220d@mx.google.com>
Date:   Thu, 17 Nov 2022 21:33:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8438080652165562871=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] main.conf: Add comment about LA Audio BAP UUIDs
In-Reply-To: <20221102101224.1463549-1-hadess@hadess.net>
References: <20221102101224.1463549-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8438080652165562871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691153

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      26.72 seconds
BluezMake                     PASS      730.96 seconds
MakeCheck                     PASS      11.68 seconds
MakeDistcheck                 PASS      142.51 seconds
CheckValgrind                 PASS      235.43 seconds
bluezmakeextell               PASS      92.00 seconds
IncrementalBuild              PASS      591.70 seconds
ScanBuild                     PASS      929.26 seconds



---
Regards,
Linux Bluetooth


--===============8438080652165562871==--
