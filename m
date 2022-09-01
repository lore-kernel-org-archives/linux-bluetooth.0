Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3B5ECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 03:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiIAD2C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 23:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIAD2B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 23:28:01 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115C96150
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 20:28:00 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id f14so12366466qkm.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 20:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=+dhva4o40EuE1l9eqFMD/8NG+nYr6KG78E3LJilfxzo=;
        b=hRnoZYUjO7DFRLiw5f8F34Qwvj7lFzzXh9uVqrRhwSDab8zi1bggWeeLqAUF3w8dur
         c3SpjCxKgaeBRe2Pc5JCItPr3T834qnKDkvaL6MH6kT7K7bzofPkJx4a2LMBJ28+MPn3
         OCdPWVz5GW7I2blMOYiOZW8rPI/n2FTAI+Jg67fT5XEg2rXj2zFFcIQkFGjKgB0KZsxM
         4wGlxqxCwTBEpAC4KiFHfRSgv8/4A6Veb7w/nNnK+SbnOnFWd4Sj5Mndiwsfe7zccvbs
         BR4l2TfaPqsSuwvKBYnPoAhBDgMFsCLGpVSS5oIBz8mvQk5xirWiEFnhpj3zNSp4aY8j
         VRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=+dhva4o40EuE1l9eqFMD/8NG+nYr6KG78E3LJilfxzo=;
        b=PkfR7oQF5wKTWEhuJ/JVjNWwo4E4EieH7Jh3LgJyP0d8CjBkXeVyh1datHYZxDdXWu
         SKwF55hZld30TdbFSwT2VkEzBCQYXFxuwyRuiXMeHcLtN2DP5JIkLbgbR3r/0/dXUlnR
         3PJvCgNmkdexjBzBj/OWPaFqth3BS9KsSIhw0ZtJwlbbIx6zmU7fC2lgUcsP2xpdYahd
         Nl4tZL07TvmkeVM4L86rbt9T/Sgdr65tIZC3dCStWd5XbFCD7RSHGVIz03S+PttD3Dir
         cc1m/Tj+xaUepwu82uMXLXCSE0Fu1CNkNH21hV5gn/8Gdt7F0EDnOiNxjxLFqfmEBUZd
         +s2g==
X-Gm-Message-State: ACgBeo35Qf/12+KAsvynZorhZ+svhfItgXJ5lxLWbIgUFMsNJcrKpfSa
        Yr8iAr1lvJ4ZqOOiWzplGyNt4oCZF/1ILA==
X-Google-Smtp-Source: AA6agR76EGGPe3OabsbTiHgup1s0oBVh6E6KoObut1kAy+zi45ZBUZlTPD3TbqUyc6fVScvL8ov34w==
X-Received: by 2002:a05:620a:1a07:b0:6bc:3aa1:90fb with SMTP id bk7-20020a05620a1a0700b006bc3aa190fbmr18055251qkb.292.1662002878970;
        Wed, 31 Aug 2022 20:27:58 -0700 (PDT)
Received: from [172.17.0.2] ([104.211.0.151])
        by smtp.gmail.com with ESMTPSA id z198-20020a3765cf000000b006b8619a67f4sm10572149qkb.34.2022.08.31.20.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 20:27:58 -0700 (PDT)
Message-ID: <631026be.370a0220.f7596.fe92@mx.google.com>
Date:   Wed, 31 Aug 2022 20:27:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1043069314355351197=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Add mesh testing support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220831235932.290032-2-brian.gix@intel.com>
References: <20220831235932.290032-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1043069314355351197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672998

---Test result---

Test Summary:
CheckPatch                    PASS      4.62 seconds
GitLint                       PASS      2.24 seconds
Prep - Setup ELL              PASS      31.12 seconds
Build - Prep                  PASS      0.88 seconds
Build - Configure             PASS      10.05 seconds
Build - Make                  PASS      950.81 seconds
Make Check                    PASS      12.98 seconds
Make Check w/Valgrind         PASS      334.75 seconds
Make Distcheck                PASS      277.41 seconds
Build w/ext ELL - Configure   PASS      10.23 seconds
Build w/ext ELL - Make        PASS      97.15 seconds
Incremental Build w/ patches  PASS      231.34 seconds
Scan Build                    PASS      746.78 seconds



---
Regards,
Linux Bluetooth


--===============1043069314355351197==--
