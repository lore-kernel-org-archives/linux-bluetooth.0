Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4921AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 03:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377620AbiDUDGY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Apr 2022 23:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiDUDGW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Apr 2022 23:06:22 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D22E0FC
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 20:03:33 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id q75so2707875qke.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 20:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=2fAHZVBoD10b9sEc3szIu57dsBBsG0rPRmwIyFWnamY=;
        b=SZoDJvmGHQUqbsKEO3TJOHPS4Ui0sWBR7KBh39Vxx+00W8qdk19Ml3mo4J6i2JsBLM
         hdH0LdRg6n+W9TVTfsXWzad7xOnAP9ikQpzUxZ1/AElsn2SKn1iz46o6mEBlSmjtyEno
         FGhj8FjUMMQAZS0NtLWjluq2Fybi8bqUubetko2RAkjNxnXgzMs0fuYeI7wiPw8jPNXz
         WgiaTscIT9gZxw7cLW7Q37Yye/GJQ9UzZqqlqKgiGK5aomKmFNqXXREklu7P1HSSukyx
         c9dQkZZ79as94S6jwOwiqyFzbr+5C5PFznchJ2zpMdIwrztORrnyzBxydWLdZ2fciUw1
         q6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=2fAHZVBoD10b9sEc3szIu57dsBBsG0rPRmwIyFWnamY=;
        b=X4PMtxCva9IaucUUNYA6NrEHKorgIYmQ82ZVjld0GrBRFmZspAKc5d9dKkUns9Fs/M
         0/iDmE9g/ScgAxT1HgD24Xe4GVbILCuCEZQcLEMa8Xwvq+psleVw3ZGZmyVv6AyEloav
         clla4xlF1aJYhhhKzNuah3qZHpVVxyaDM4No96fAVsBrq8eCdCjwFVF74kra4/bAqwel
         96rrkp8yihpH1ylaRXqJy2malA0HfMPuR8uELHvKmJHK5Ywy5WVyK0FaGudlI2VpMc+g
         v8JlDXXgmddnvJj6SQkA+nxWWcd92sIXs7HBAUtuxIQHgsTH2Uy5qCVG6rh79DgbCMx0
         LnWw==
X-Gm-Message-State: AOAM531wYBSiqceYn50des6OEiFfFfMO8TShLTbm9FFtAFZbrZg46AE8
        oiAyK8EegfDlWzGDg0tmaIPTpxOZ7be63Q==
X-Google-Smtp-Source: ABdhPJy3e0SiwXeXr5M3Ryq9j680Mtne2pNoaVahQi8zse5ev8V31QQbB25dnCrm7pGdMxFkPh0A7A==
X-Received: by 2002:a37:5505:0:b0:60d:9998:6dfd with SMTP id j5-20020a375505000000b0060d99986dfdmr15166108qkb.607.1650510212583;
        Wed, 20 Apr 2022 20:03:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.17.211])
        by smtp.gmail.com with ESMTPSA id r7-20020ac85c87000000b002f2048a946bsm2896948qta.26.2022.04.20.20.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 20:03:32 -0700 (PDT)
Message-ID: <6260c984.1c69fb81.b8863.547e@mx.google.com>
Date:   Wed, 20 Apr 2022 20:03:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4910103825161628114=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] btmon: Fix decoding of Enhanced Credit Connection Request
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220420234609.2968138-1-luiz.dentz@gmail.com>
References: <20220420234609.2968138-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4910103825161628114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=633945

---Test result---

Test Summary:
CheckPatch                    PASS      1.44 seconds
GitLint                       PASS      0.98 seconds
Prep - Setup ELL              PASS      42.20 seconds
Build - Prep                  PASS      0.71 seconds
Build - Configure             PASS      8.42 seconds
Build - Make                  PASS      1245.43 seconds
Make Check                    PASS      12.15 seconds
Make Check w/Valgrind         PASS      437.69 seconds
Make Distcheck                PASS      225.55 seconds
Build w/ext ELL - Configure   PASS      8.50 seconds
Build w/ext ELL - Make        PASS      1234.97 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4910103825161628114==--
