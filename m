Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F99C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 11:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbiBQLZU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 06:25:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbiBQLZT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 06:25:19 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBE71285B5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 03:25:04 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id a19so7555466qvm.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 03:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1YxyHBpK86vwn21nZ+fk41SlHyv83GHveDi1OfwvzaE=;
        b=aWEiM76wmuY0xCd83yJE4ly0LZJ693pr2EXGYu6lbCMc1vSGl8AJh6kD36bMo8iDut
         TYi790a1GILYDxfKXBI82pwikneEPtPnTwVvZjPkdi1t8pMPOmfTwAAKZFIv/dKHX2zo
         mHK836SsgW6ZG2Diz4u6haLBISrQimvbxEgeXZdT/LhJfA6DNESNe/jFY/LOMl1nhw2q
         IlxyMF3kc59vRqVZN4yj4POY/57qp5Q9uD6aaaC2M190I61BV3GNE04T2WSSRoKNgN5/
         /2GPHZBbF5rQuX6AYuaO544CqHFoAYklJ8LOHInRqbG8/8RwE1FrRe9QXU2Pu/djBAVz
         86kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1YxyHBpK86vwn21nZ+fk41SlHyv83GHveDi1OfwvzaE=;
        b=Y36icaXIHBGn9a+AmqTWGCnXmmLNhtiT6R/cQscpWeLdGcPleikB6qs2klsMmUCGu9
         qCgmC69naKVXU+Rvsi+Ph4NbzVdHzdpCQyla0ZLVPVagU9XGAIzJSWxRtWUHJ4FcYanq
         xOLs6CPVZ86eUMxZOLqTIIM+EqrOZHXKJ4epRVx6AlHxCnhPxCNZW5L6gl6ZEiC1jQPh
         31r/OabAE51avlizM04JtjO0TMhyqgyQuMISHJBhDEoLmsu5WIDpA+p3W/6XYaS2nOz+
         VziLkDrUaoBz8MDllQ7zqsyu2o0YwAUslMQqArRnGteveAeqf4/UgrmK74dt0zUfL3xg
         pX2A==
X-Gm-Message-State: AOAM5335W47ftpN6+QKSZNZL/DIMguV5CLKAIIP4Xrnp9RFg1JlJlc0w
        eHN7h9lHVnWQz+c7q7JeDRFAw3jrcOA=
X-Google-Smtp-Source: ABdhPJzVbrqlDnwWN9vI1YiEk63AALcgXjetVAktuJLFmDIPwTLoA96SaZdTTPapO+kfLx4o1Ofv9Q==
X-Received: by 2002:a0c:ef0f:0:b0:430:1cc5:1e48 with SMTP id t15-20020a0cef0f000000b004301cc51e48mr1625401qvr.29.1645097103372;
        Thu, 17 Feb 2022 03:25:03 -0800 (PST)
Received: from [172.17.0.2] ([20.186.104.68])
        by smtp.gmail.com with ESMTPSA id h4sm3654705qkf.66.2022.02.17.03.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 03:25:02 -0800 (PST)
Message-ID: <620e308e.1c69fb81.c75a9.73ec@mx.google.com>
Date:   Thu, 17 Feb 2022 03:25:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2949382723288457851=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bluez@heine.tech
Subject: RE: [BlueZ] Makefile.tools: remove duplicate link entry
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220217095647.2693176-1-bluez@heine.tech>
References: <20220217095647.2693176-1-bluez@heine.tech>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2949382723288457851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=615314

---Test result---

Test Summary:
CheckPatch                    PASS      1.44 seconds
GitLint                       PASS      0.98 seconds
Prep - Setup ELL              PASS      44.01 seconds
Build - Prep                  PASS      0.75 seconds
Build - Configure             PASS      8.77 seconds
Build - Make                  PASS      1318.86 seconds
Make Check                    PASS      11.85 seconds
Make Check w/Valgrind         PASS      453.09 seconds
Make Distcheck                PASS      249.38 seconds
Build w/ext ELL - Configure   PASS      8.83 seconds
Build w/ext ELL - Make        PASS      1288.74 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============2949382723288457851==--
