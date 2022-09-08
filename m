Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3935C6FA86
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Sep 2022 16:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiIHQOl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Sep 2022 12:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiIHQOK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Sep 2022 12:14:10 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6B3E9015
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Sep 2022 09:14:05 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l5so13268784qtv.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Sep 2022 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=nC75F2/bN1p2MI1Zxzkicjub9U0tJEFfGLM+8LcjI84=;
        b=Ao+XwRlZZvzonSgytsV/4CMRnkDceQXHWFDKGn5S8IB6XmqPjitOVGoATstWC6xDsB
         B00yOKm60FwquR6eHEQxqlfhtKfi0mngqo0RjmnLLZuwHvtzslevNAGFOVnT6ipbSd4P
         hop6p7LvXc1RNhaXyc31mJsDJMGOPSK1qmu9UxV5sE+A56xYdbR6J6H92YBNIaNoIH6A
         BzbyzWbDS3tKDBpKAFUPX42B9+kcZjdqRBUnszs/8Uo16D2HwFiljtlcNVy8ZOcXaolR
         kE6KX6x5NAW6RUYGr5NUZHaztbijAO1uOHXsju6xabicyl11cNWblXEzdeMH+OmXS38U
         0zsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=nC75F2/bN1p2MI1Zxzkicjub9U0tJEFfGLM+8LcjI84=;
        b=htWsvKAL6xw7t1z/PKM2gJiwmexehcwXP3RJXtMxZsioD6K3JOQL79u/RB7Vx3Ll9z
         ubtAtfxU2fv0Pv7pwXFe4Upsw3qq4PFfp7g5VWAzVgE2sRFFQpwJSSOQwOH3oiSwjh6g
         7/kjoPK2KKCH2cpscxemZX7c4ItZ3oUw1bkeWXWhHFTROFp8rxdWVIM5KZ8uolZDqG4c
         hMguPhbMeaaXyN6iY7owoamXdzkMz8kbYS20juu6nqmh5bPHZUniKsEaNQIiKx9Ev0x0
         dmnv8OfNxXoGf1VPPCRzehaCweT0RxxoyLie7fqSIrCqJgS4xzblydqCa5BHm741KzfX
         XrnA==
X-Gm-Message-State: ACgBeo2TuFbCKyNYtdLjjo8DtLOAinc2BM9ZndmAzwrJ7Zvv4qSyU7d9
        blbuXGrf3ywgSotNqicyAJ1DMqB1mJoM9Q==
X-Google-Smtp-Source: AA6agR6cRPPTrgwwHoFWtZtUVOElFtDINY0OUssmuqEbdOXGaFz2nADKVwk/UDFGxIJwweCk/0iPVA==
X-Received: by 2002:ac8:5c51:0:b0:344:5510:be77 with SMTP id j17-20020ac85c51000000b003445510be77mr8853070qtj.84.1662653644867;
        Thu, 08 Sep 2022 09:14:04 -0700 (PDT)
Received: from [172.17.0.2] ([13.82.95.18])
        by smtp.gmail.com with ESMTPSA id j2-20020a05620a410200b006b9ab3364ffsm18197816qko.11.2022.09.08.09.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:14:04 -0700 (PDT)
Message-ID: <631a14cc.050a0220.efcb8.efdd@mx.google.com>
Date:   Thu, 08 Sep 2022 09:14:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2385528679091604491=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,v4,1/2] monitor: Add ADV Monitor events to btmon parser
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220908145555.161258-1-brian.gix@intel.com>
References: <20220908145555.161258-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2385528679091604491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=675287

---Test result---

Test Summary:
CheckPatch                    PASS      3.03 seconds
GitLint                       PASS      1.96 seconds
Prep - Setup ELL              PASS      27.49 seconds
Build - Prep                  PASS      0.85 seconds
Build - Configure             PASS      8.75 seconds
Build - Make                  PASS      995.15 seconds
Make Check                    PASS      11.86 seconds
Make Check w/Valgrind         PASS      295.52 seconds
Make Distcheck                PASS      245.99 seconds
Build w/ext ELL - Configure   PASS      8.84 seconds
Build w/ext ELL - Make        PASS      86.53 seconds
Incremental Build w/ patches  PASS      204.14 seconds
Scan Build                    PASS      571.23 seconds



---
Regards,
Linux Bluetooth


--===============2385528679091604491==--
