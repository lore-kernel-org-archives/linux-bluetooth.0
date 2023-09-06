Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08BCEB8FCE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 13:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjIFN0S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 09:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjIFN0R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 09:26:17 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BE110E2
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 06:26:13 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-76da0ed3b7aso220813985a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Sep 2023 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694006772; x=1694611572; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zLebv6M1Str+MZMhZELMZgguGa/OGxhBOo7jodfX3O0=;
        b=d0lPl3DU+ZzvZqltv10Q1jU1h7XeNQmNgtM2hkqhynBVuMIJIaqwwMEZ+VwZmqUCu0
         VY2WQx5ubxLErlmCQaGjz7lwfBo8W+0KNObr8qG6YR/WVY980ZQny6HUV7NAywlgU654
         1fuxmrQsII4WLqTnV7pbQbwOYj5M3PknnfN2LZQLZJB7mpxn11BALCfJdIO62u8CFbt0
         6TYw0F76CE1wZWxNPuiwGFduJe4+qZ4u/zcIXRi6YrnMsOfebomtpV1IfmoroaJsxSJY
         YTosURtXfJVPwsG9mI3X7GkAcUM9QuJPmMvwPQDWqnCA8uhpI7pOo7L/lsya0I/9CZa1
         SuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694006772; x=1694611572;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLebv6M1Str+MZMhZELMZgguGa/OGxhBOo7jodfX3O0=;
        b=lG7wzOY07JGgbC/zc7QUsgUYaJuS8NQhA20Zg61NvUWzCwc91HtoEHWXwd1qUjSD34
         MY4luFeEwTpXgT8CuC9EvxvNK4M3ovd6AISauImq4FQ4EHtDtk1AYTA9LXsEGiVKBEhq
         yKn4t3B69WEQSm+q+mQGzcbivXx/jwu6pWQMxW0wUCaGsuFu2Wvrd9ymzU2PIZBp7cR1
         CjvAD0657aNYgDKfxeVkG+NZX7mr1xq0TiPTqOdkB5TzhWYg7qI3JTp3gz056t9i7F4S
         IYY+SHRz/0NAlEcSHND46Ar2tA/XJWY+EujWicql0LRt88K69foBSY8/39T8wcD+Cya0
         /tQA==
X-Gm-Message-State: AOJu0Ywb3raLDpAPUNsvaiCqrobd7XWBiMNZDs3xikR/0n8vSfKLpCcj
        JKovooRONpol/cDcHxq7vLifjM7A6w27gQ==
X-Google-Smtp-Source: AGHT+IHfZxBO8tjhecv9ScQVzHUG62SStv+qRQvnykQL7YxmO9GEnH5+cYVbsWD7jqZLUXGgUogtsQ==
X-Received: by 2002:a0c:ab50:0:b0:647:248b:3614 with SMTP id i16-20020a0cab50000000b00647248b3614mr17121366qvb.4.1694006772271;
        Wed, 06 Sep 2023 06:26:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.63.101])
        by smtp.gmail.com with ESMTPSA id a8-20020a0cb348000000b0063d588c4111sm5506814qvf.82.2023.09.06.06.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:26:12 -0700 (PDT)
Message-ID: <64f87df4.0c0a0220.12a8a.2242@mx.google.com>
Date:   Wed, 06 Sep 2023 06:26:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0319371334861652116=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: btio: Fix BASE copy from getsockopt()
In-Reply-To: <20230906114234.10617-2-claudia.rosu@nxp.com>
References: <20230906114234.10617-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0319371334861652116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=781979

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      27.76 seconds
BluezMake                     PASS      886.12 seconds
MakeCheck                     PASS      13.61 seconds
MakeDistcheck                 PASS      159.08 seconds
CheckValgrind                 PASS      261.68 seconds
CheckSmatch                   PASS      349.78 seconds
bluezmakeextell               PASS      106.04 seconds
IncrementalBuild              PASS      722.14 seconds
ScanBuild                     PASS      1088.63 seconds



---
Regards,
Linux Bluetooth


--===============0319371334861652116==--
