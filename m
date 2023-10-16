Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3303DCDB474
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 17:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjJPRxM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 13:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjJPRxL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 13:53:11 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA78A7
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 10:53:09 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3515deaa7c1so19564275ab.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697478789; x=1698083589; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mdRcp3Mz7afY74JIdYRLptkbNsR6r5DiHWw3DEinxoY=;
        b=I/IszNVSoIfIBUHd3ROt5PVGdZQo1qbRc/Wa/cz70Gyee7Ib1Gj6RRkXAP1c35x596
         RsS7jxIFX7LWStZOlrS+Sg7Ht3KtI3C8+pGAkgmfDAT5AiGEYUt42evzakbxpQ+8ZpKv
         drna4vQoSZKen/LZRWZsj+J9wEQuCnSOvJN0QFXPE3OFVEBO9IX6L6yZXfeccdB74BDq
         axh/80g48oLJDMGohPYfYszIRg7QD99dObk6x9x+5helMyBSCY4wiRbX6lP7xROBVof8
         tlqegKxF1DgWbb3LIg1JvW+p//hIJOQqTkeYyxnoE5/lH4pvGmQLOhpwojcqs40GiEv8
         8mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697478789; x=1698083589;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdRcp3Mz7afY74JIdYRLptkbNsR6r5DiHWw3DEinxoY=;
        b=FUObC1l34iPUKIWBQA6TEuDRI0Y10yk1MZLESLxxJNEUbJoUywIESLULMGq3ilZbi8
         dB4ofR8NvWH9obFJIXVc1etIJ+uBQKeeYFLppmpVTuwwLaiR+4J4aVGqrYQd7LGzg1jW
         BFD//j0dvOOi7qSblGeoIRUuyxPmP5XEwOa/jqyeEqOwce9+5QGwqMUp/dPhzN00bSOS
         tHIH1XKSRvZOLmsDGlVjDQ0d++YALVSu6M63ov9atxUhTQn3wGObUK9boSAPSPq6CSf8
         gcO546oVG91j5dfDghzDWcVYiT9ITvknf2UuBqfSViaYV02PQoLULJotRrDHf+VPXHSw
         0bFQ==
X-Gm-Message-State: AOJu0YxskxEtbWKautnlH8zFlWW8XgOl9RLzhYdRyxKhgIIBtkuUJqLF
        77RzZy3zMoP1tV3vqCcc6lIQU1laC1M=
X-Google-Smtp-Source: AGHT+IG8lHB15ACtahyfy5ybOp+652Yg2+b0YUgGlo0gMU6zBe2D30x5Ezisg/5Y5V0NVCWhcL8/ow==
X-Received: by 2002:a92:4a10:0:b0:351:47fd:e9d4 with SMTP id m16-20020a924a10000000b0035147fde9d4mr107231ilf.20.1697478789025;
        Mon, 16 Oct 2023 10:53:09 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.197.248])
        by smtp.gmail.com with ESMTPSA id j20-20020a02a694000000b0045b05457189sm603264jam.92.2023.10.16.10.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:53:08 -0700 (PDT)
Message-ID: <652d7884.020a0220.1d82.0bac@mx.google.com>
Date:   Mon, 16 Oct 2023 10:53:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2931215514850985745=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Add Modify Source initial implementation
In-Reply-To: <20231016154900.3094-2-iulia.tanasescu@nxp.com>
References: <20231016154900.3094-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2931215514850985745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=793607

---Test result---

Test Summary:
CheckPatch                    PASS      2.06 seconds
GitLint                       PASS      1.10 seconds
BuildEll                      PASS      27.73 seconds
BluezMake                     PASS      798.70 seconds
MakeCheck                     PASS      12.22 seconds
MakeDistcheck                 PASS      175.13 seconds
CheckValgrind                 PASS      267.39 seconds
CheckSmatch                   PASS      360.77 seconds
bluezmakeextell               PASS      115.59 seconds
IncrementalBuild              PASS      2814.91 seconds
ScanBuild                     WARNING   1102.61 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
btio/btio.c:1852:4: warning: Potential leak of memory pointed to by 'addr'
                        ERROR_FAILED(err, "bind", errno);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
btio/btio.c:41:3: note: expanded from macro 'ERROR_FAILED'
                g_set_error(gerr, BT_IO_ERROR, err, \
                ^~~~~~~~~~~
1 warning generated.
src/shared/bass.c:1294:3: warning: Potential leak of memory pointed to by 'subgroup_data'
                return;
                ^~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============2931215514850985745==--
