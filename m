Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2E4C54E94
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 23:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjAXXIB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 18:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjAXXIA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 18:08:00 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14C83754D
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 15:07:54 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id d188so14809577oia.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 15:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EWZkb5dTuQey5hR+Ex537evUJ1+GwgrKughkd86OrXY=;
        b=HfNJ1/qpfVuc+kfpfnZCRozAuntWt3Y3zUP0HYp8lwsCNnUw6u68qgQZSxe+tlymop
         oo2Fxb/9lKxMDaLMHVUBn6XjWGexuC1tPv5TI5N3crGGP+GuyOqiHlxavdxpNyOa3ntV
         1o1U0oVxXf3zSGDm9E2C+w6dU5DiVyjs7Tmkk6xhUIJ+s9PoCZv/Fl4VChbVBb23QnQh
         8Nideifyxqi49zxv014tPlKECh4QHm7Kdu8XyUseYpvtfzX4jjO3mgVxWZGYRseiEDLw
         m+WbdZrf5MkB9U+ily1uUS+wRbWn1H6+aUeomNwnYehTBLTxuDpwftYcmUtkpwsq9Nbr
         MeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWZkb5dTuQey5hR+Ex537evUJ1+GwgrKughkd86OrXY=;
        b=eOJ2FS+jrpj0r4klr2fsl76YSxJq4CK0ZtjFUllpc/dsx0knTg4xcYrclZ7sVJvYt0
         qocSbgzAxOFGE6IgV0TvXnjbSCV0M+D+FuCpDbjUtYcWFDle2fE0J98+HBVcylyJVjQj
         1SWW8HvT3lZ7sIg1VIlSrAUVeHBZ4xGAgmoxGJkwSqkTwZSofJkN6WH/MXlJPie0lBDq
         SDdWNNpbltMkex6Rz2a38gT842+WvWY5HrdiRvvOY7BjtnKo9V2ZbV591L7H8QzN3DIE
         UiF1kjbTmOThAlo7+KZXfJYadlfXQclQQamJywfmfsqHY25vIHTL+aIOhmMC6zjuNahm
         YBTA==
X-Gm-Message-State: AFqh2kq0TNwwSYfLACUHTYEwbcvLXE5adYicaj1AqAxYumq8hZusuAjK
        FsysBBQ6NL7MLy8eA5kTTQO3OnOjLzc=
X-Google-Smtp-Source: AMrXdXtPTrylllplYUpMEetsX5lmX6y65wpn7UrgdD+6spcqIzmj3JtWyAKAY9ePOJyOgbCKFxHpkQ==
X-Received: by 2002:aca:2402:0:b0:364:88b:842c with SMTP id n2-20020aca2402000000b00364088b842cmr14495284oic.24.1674601674140;
        Tue, 24 Jan 2023 15:07:54 -0800 (PST)
Received: from [172.17.0.2] ([65.52.35.18])
        by smtp.gmail.com with ESMTPSA id q9-20020a056830232900b006705829996fsm1488749otg.56.2023.01.24.15.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 15:07:53 -0800 (PST)
Message-ID: <63d064c9.050a0220.39c8e.6c58@mx.google.com>
Date:   Tue, 24 Jan 2023 15:07:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3446226641721294608=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com
Subject: RE: [BlueZ] AUTHORS: modify email address
In-Reply-To: <20230124220416.312697-1-brian.gix@gmail.com>
References: <20230124220416.312697-1-brian.gix@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3446226641721294608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=715289

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      27.13 seconds
BluezMake                     PASS      769.57 seconds
MakeCheck                     PASS      11.24 seconds
MakeDistcheck                 PASS      149.43 seconds
CheckValgrind                 PASS      241.13 seconds
CheckSmatch                   PASS      321.20 seconds
bluezmakeextell               PASS      96.49 seconds
IncrementalBuild              PASS      612.90 seconds
ScanBuild                     PASS      970.85 seconds



---
Regards,
Linux Bluetooth


--===============3446226641721294608==--
