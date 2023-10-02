Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A28E784AD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 13:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbjJBNuY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 09:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbjJBNuQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 09:50:16 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38F9CD5
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 06:50:02 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7ab9f1efecfso5863646241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Oct 2023 06:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696254601; x=1696859401; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6aLXU11nDP/PCYZbWYodULt/th2+K13lsusMAyIFtcM=;
        b=LoMWFo7a520//wsGox6Be/ADAsKknYyljXyN9n6KrYE8ZQNg9ZkufBa9Oy435GTwDk
         B7Hj3fi71GXRdMeHTUZybI5YCErpjDOirAuEe0QrNrqUWYMN/BKGP5iCmJ1QzVA2cSPo
         EWTojUSlfUcbATTGREJY98KVw5heChnsJCLIwksQulVgt1vIUqSGX71UCP3IcOtmH4Ju
         agImpTgcs4OO0M0wfn95iyfuKxGfc06cSp+58vaafxgUnLEPCJ5AIWk/5P/ezZUvsqag
         Bm2W6G9DFvyz5X0vFM4GxejkxkDSDV1pWyjYzH68LfggTKeH833SrgffQclzzlclvM9V
         dC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696254601; x=1696859401;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aLXU11nDP/PCYZbWYodULt/th2+K13lsusMAyIFtcM=;
        b=ZsGRUyxYz4qmzf1KozXylp6Gl5wKX0bi6P9Zjga60XhWJrqPCCB8ifTvWDJtgJwFpd
         xBN0eT5UwWwlHXQkOYlF8l8DQwMDz599ReQoOfxHZ2FGU/Al3sD75L09XoxD7xSKujey
         XVdf/lofwQpp7zx/ijDfrgUpNKmZKtDxX4KuMvc5sOI8lnMYUPFXLNhMoH9AwzVxpqUC
         rvZ/5mWZYtUXWAxGZdVdwNAgrE4WfVBcn1hOaGNcuufaW+vI5c4mrFHQzdM6tg8R5Vy5
         nGPstcGhLEZ0xcQxfpOVwioOhkzPRmvmlZSheH1vT+1zOxOMEdV5Q5FsSWfvhUbfp2t4
         l6Jg==
X-Gm-Message-State: AOJu0YysH6jsJpDPgAYsVPTq0ZShbgB4kZ4805xmmHyVLb4pRvGjUE7j
        8TejkIOT1ZB1oUsKH92aMjU5NePYRi8=
X-Google-Smtp-Source: AGHT+IEmptl/Gv3/9mvFpc8gp4EhcyCgRNMsm+Y6ZPnTsR62xFn4xlTm5DTUhwLz5NFAJJpKZyvkIA==
X-Received: by 2002:a67:fd56:0:b0:452:607d:8603 with SMTP id g22-20020a67fd56000000b00452607d8603mr9155218vsr.1.1696254601255;
        Mon, 02 Oct 2023 06:50:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.36.16])
        by smtp.gmail.com with ESMTPSA id h6-20020a0cf406000000b0063c71b62239sm3608851qvl.42.2023.10.02.06.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 06:50:01 -0700 (PDT)
Message-ID: <651aca89.0c0a0220.a767f.c70c@mx.google.com>
Date:   Mon, 02 Oct 2023 06:50:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3173144808462820912=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: client/player: Allow the user to control BIG encryption
In-Reply-To: <20231002123738.22210-2-vlad.pruteanu@nxp.com>
References: <20231002123738.22210-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3173144808462820912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789283

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      27.66 seconds
BluezMake                     PASS      785.70 seconds
MakeCheck                     PASS      11.74 seconds
MakeDistcheck                 PASS      160.64 seconds
CheckValgrind                 PASS      257.83 seconds
CheckSmatch                   PASS      350.25 seconds
bluezmakeextell               PASS      106.06 seconds
IncrementalBuild              PASS      687.48 seconds
ScanBuild                     PASS      1039.99 seconds



---
Regards,
Linux Bluetooth


--===============3173144808462820912==--
