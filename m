Return-Path: <SRS0=lrWy=7U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A1C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Jun 2020 14:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F992067B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Jun 2020 14:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvbBV1HA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgFGOHP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Jun 2020 10:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgFGOHO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Jun 2020 10:07:14 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93147C08C5C3
        for <linux-bluetooth@vger.kernel.org>; Sun,  7 Jun 2020 07:07:13 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id g7so7103550qvx.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jun 2020 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=r5hkKMH8GAi57wgPb3vi/CJhAEGohBoYXpFfqB/jFeI=;
        b=BvbBV1HANU/e9sZExjx6HZJWV7aZRU+TRaMFzcItczBspA0DYXmKzmNBmUt7pYWD/d
         WUMEfCUmnugJ302GArcvsSp8aWPJiPqckYv4dj37TI2nQppJD7CLJr8uyVeg8jYZSWa6
         ABT6I6UuxbGcMh/ayMaS8/uecmsjRKczcmaDtTBr0KJ6GYCbliLweQRzFszU1z23vpOe
         XP2tBLmTs77aVeho4Z0Oe7BFvYmMxz6pl9PF1muG6V0HxzMJrInbMIQ6B323+NQ1Pkd2
         jBEAGdQ5JxIQAc6/SJKdtC5nmHxXklx+ipQ6LZbslTw3GEghhZRu0B9eiuBh1th0Tid8
         JJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=r5hkKMH8GAi57wgPb3vi/CJhAEGohBoYXpFfqB/jFeI=;
        b=pm37ylWVSHVa8HV8fIrMKIGAePoF8l5OCfBL8qABG274wgX4RXD7Wg6T9/836Yc9qS
         Vi+AiCyOy8dmeJSSmG7Wc0/WYGExqhMwAurIcMr0JS7ctPJSzdCHZbx+UoTNuw1yAHee
         ebCY/ypYTe+SK4pTEf7tTDul415plBy8zIhCkercYlMiukeB3yw7i6HIVD0Wa6196p8d
         eavuE5MrF+x0Q35riWH8rocjsBfqTmQwN8Rcj8ugg9JP931C5g12cpPJrKIMGmOYph6k
         1dIgsUuE8ezIJeyIjbDAQ2eR4te1TT9fbeY0KoCSBq2EDWYpuVq/MCrctTb32QF2ZMBG
         sYbA==
X-Gm-Message-State: AOAM5330JTgvT+jOk8UXMr+wSX9IE0a5DMtDw8pgDRnNEzC97BIApYOJ
        66LEuAdqn5nVlKiCpzSfrc+u1Gu+BkI=
X-Google-Smtp-Source: ABdhPJx5s1cvtDYayrvf+3vSApIv/BbiVR/BSPt8i4D+NszWMzDEzvGnk+xtHQu/PBoD3sp5CX7olQ==
X-Received: by 2002:a05:6214:390:: with SMTP id l16mr18114506qvy.220.1591538832493;
        Sun, 07 Jun 2020 07:07:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.94.21])
        by smtp.gmail.com with ESMTPSA id q24sm4947936qkj.103.2020.06.07.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:07:11 -0700 (PDT)
Message-ID: <5edcf48f.1c69fb81.ed5fe.be78@mx.google.com>
Date:   Sun, 07 Jun 2020 07:07:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2557617359983499127=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, przemyslaw.fierek@silvair.com
Subject: RE: Segmentation fault in the mesh/node.c
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <116e6cc1-5a49-a833-689b-4f00880e455b@silvair.com>
References: <116e6cc1-5a49-a833-689b-4f00880e455b@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2557617359983499127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#22: 
11:58:15  =================================== FAILURES ===================================

- total: 0 errors, 1 warnings, 74 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============2557617359983499127==--
