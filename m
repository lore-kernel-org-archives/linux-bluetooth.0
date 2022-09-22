Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8AEC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 23:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIVX07 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 19:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiIVX0y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 19:26:54 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2BE10C7A0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 16:26:53 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id h28so7340235qka.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 16:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=QsvgJnTTvfYyMdK4+m24QIATZJDrIc7958cCUo7FctU=;
        b=ZxP5rkKmfhr6895ZQM5+Zz3zUYl3NPS5QNfbabeJ1uvM5F7F2AjHrR++u7MA3Akejw
         3TVvkTqTHVCwEP0ezIDjq0J9T0dY7QawH2odXGmI4IxmMKK76BlLttmz5ej4PIJ5aVBg
         gf8Dq8gSadZEEblVBNSO3x3pD4ps13VpIiY2blVNy3mXDbaft9EnbkRiAV2lkCAjzohL
         kkMomk6UA7gBy5CXaF+K5cPF4RXWD8M+5CctjJaF/jMibmqCPdxorhQg0dCJb93y/bNm
         7hzxY4XK55654nGZ+xsxfI79RZh7n5LNMrcJl02pDxvbqoWC0bkj5oDJWE4GzX9qvG5B
         XC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=QsvgJnTTvfYyMdK4+m24QIATZJDrIc7958cCUo7FctU=;
        b=qFsyM7yi9D6Q74JJ9jMz/D4dM86r/FkFRFIRGlp8rYjSr9+jxPoqwmWyiQ7QFNe4xe
         YopsIkDCleIioSOI8ru6Qdgj/cpNSnffPM2NkDBAeTJv/U4DYqHTmrMtsMF1L9Kg+loY
         koSfKbAS7BqOADfgyswYthvtbhWWfmKUNar8Qj+lvEkh2OITGD4Oo5137kypVycJD8l3
         iWOtZD0tQDfalauCP5Nz+vj7yUIlIwytOca1Hx2JDCUQ74QZLpTKafuQJWXcigQkjLOR
         j0sMABiY6y57XW4nq50489SIU7UY3vOBTEKyDiz2Z5/Nt9qeBQ6NLoelWmF4B4IfumwX
         24FQ==
X-Gm-Message-State: ACrzQf03eb2da6M/WUFyYVpasGDTk+MfydeHZfQoPu59XpkBWdeUXgkm
        oBGv4L/HcktfSIApYqiwz8MdK7CM/pp1ow==
X-Google-Smtp-Source: AMsMyM7DLK8FLgtbve+/P1Vp7sQY4HuI0sV/d+2Hw+mSSHabClwM6TRI6eyAvnv34Hs89e+ChKNBqw==
X-Received: by 2002:a37:f50b:0:b0:6cb:be4d:6ce8 with SMTP id l11-20020a37f50b000000b006cbbe4d6ce8mr3919197qkk.135.1663889212680;
        Thu, 22 Sep 2022 16:26:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.51.96])
        by smtp.gmail.com with ESMTPSA id dt9-20020a05620a478900b006cddf59a600sm4812784qkb.34.2022.09.22.16.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 16:26:52 -0700 (PDT)
Message-ID: <632cef3c.050a0220.70b6e.306d@mx.google.com>
Date:   Thu, 22 Sep 2022 16:26:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7875208178649514498=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Mesh demon switched to using kernel Mesh MGMT
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220922223102.640173-2-brian.gix@intel.com>
References: <20220922223102.640173-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7875208178649514498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=679632

---Test result---

Test Summary:
CheckPatch                    PASS      4.12 seconds
GitLint                       PASS      2.16 seconds
Prep - Setup ELL              PASS      26.03 seconds
Build - Prep                  PASS      0.78 seconds
Build - Configure             PASS      8.19 seconds
Build - Make                  PASS      719.47 seconds
Make Check                    PASS      11.86 seconds
Make Check w/Valgrind         PASS      287.40 seconds
Make Distcheck                PASS      237.01 seconds
Build w/ext ELL - Configure   PASS      8.28 seconds
Build w/ext ELL - Make        PASS      83.69 seconds
Incremental Build w/ patches  PASS      197.42 seconds
Scan Build                    WARNING   523.64 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
mesh/mesh-io.c:118:18: warning: Access to field 'rx_regs' results in a dereference of a null pointer (loaded from variable 'io')
        l_queue_destroy(io->rx_regs, l_free);
                        ^~~~~~~~~~~
1 warning generated.




---
Regards,
Linux Bluetooth


--===============7875208178649514498==--
