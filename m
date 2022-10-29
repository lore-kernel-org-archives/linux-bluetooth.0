Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9281DC38A02
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 17:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJ2RmG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 13:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ2RmF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 13:42:05 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA44B4B5
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 10:42:04 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso9586866fac.13
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 10:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B5kFABbgy0knbTQrBQ9zhhfskBaEnXXVQsL7hay6HtQ=;
        b=bna6SBawNBH5QGZTRtvuM8i7bY+L4Z2QXOgCpw3QuCdwZLp7vTYP+DkQh2UBgH8fsh
         ZttdNK+2JexIlXSrIJV1o1jbjSxlLU11l7P3/UeZMls2qTaTEhDMBr0grFv/6ys9pNQp
         HK1+p5fMS4qY7kv0FRaQ7H0RkwKh89k7G4PfRIz8na3Uy5gr/KM662/229xeYBlFIcE+
         jQ6uzgXuWf6HLaKAiKuBV3TT1WvuOjWL5FuxuIFgA+kOXk1BxlBlTjJHx4jfGEQGtTKi
         M748LiM8x5QLE708uY21Bx115mArMm4WCJ85tddcjbP9+b+BXzn6AFjSXn3F70jkN05T
         kxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5kFABbgy0knbTQrBQ9zhhfskBaEnXXVQsL7hay6HtQ=;
        b=kyUbvsOA5pCr1n2gt/WXg/Yd+WkiP8Vwub4/gxWfZwdfOqXFJyI3eMm4Y01fOCbbL2
         5FbHQrA9A4gqExvYYUsZAu1OwEcLFJ5expcuv2p1SC6kSFhoGlW5uHxcKEz1SMaZmi7R
         S4M8nya+jkFcI2TOiPDHC3Jz1atufEV9kq2sdS2IXdDTdcS0T2d4QPb6FkvEo+5wMFse
         KpEuKZhpQS3k443shOEIlyYjnEy66GMyC1MMZqx9bMa9LmVIsgmAY6NPZAUxJVvbaRio
         N/RPOJ87VyHdpO/rcecbhqUtTEB8ZoFtJ6AR6My3aLJf81UMuIRc21HkkEsVnHu5Tl59
         gDKA==
X-Gm-Message-State: ACrzQf1gM1AwOpUfYDKjW80SJq3XK06G3SGFtBSnFQGrD8nvnH4PiJBL
        U/yeFG7HKQ7M/bYRMz/AVihZTfzeUrc=
X-Google-Smtp-Source: AMsMyM5fwqKRXnOQOrW8E7PptiGZDyGLQlGIp5Kg9vnNvkNmiF/OwiB2T6qqeagHhDsDjaYMUfo0pQ==
X-Received: by 2002:a05:6871:154:b0:136:5e72:d59b with SMTP id z20-20020a056871015400b001365e72d59bmr2768841oab.87.1667065323562;
        Sat, 29 Oct 2022 10:42:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.4.81])
        by smtp.gmail.com with ESMTPSA id t14-20020a056808158e00b00349a06c581fsm714390oiw.3.2022.10.29.10.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 10:42:03 -0700 (PDT)
Message-ID: <635d65eb.050a0220.79231.22a9@mx.google.com>
Date:   Sat, 29 Oct 2022 10:42:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4347787766990947980=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhay.maheshbhai.maheta@intel.com
Subject: RE: To add support for Metadata, CID, VID
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221029170408.175533-2-abhay.maheshbhai.maheta@intel.com>
References: <20221029170408.175533-2-abhay.maheshbhai.maheta@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4347787766990947980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690159

---Test result---

Test Summary:
CheckPatch                    PASS      5.60 seconds
GitLint                       PASS      3.64 seconds
Prep - Setup ELL              PASS      26.71 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.32 seconds
Build - Make                  PASS      749.65 seconds
Make Check                    PASS      11.86 seconds
Make Check w/Valgrind         PASS      292.31 seconds
Make Distcheck                PASS      240.14 seconds
Build w/ext ELL - Configure   PASS      8.38 seconds
Build w/ext ELL - Make        PASS      85.77 seconds
Incremental Build w/ patches  PASS      503.62 seconds
Scan Build                    WARNING   547.38 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
client/player.c:1770:25: warning: Dereference of null pointer
        iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
                               ^~~~~~~~~~~~~~~~~~~~~
1 warning generated.
profiles/audio/media.c:1159:3: warning: Potential leak of memory pointed to by 'metadata'
                error("Could not allocate name for pac %s:%s",
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./src/log.h:62:2: note: expanded from macro 'error'
        btd_error(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~
1 warning generated.




---
Regards,
Linux Bluetooth


--===============4347787766990947980==--
