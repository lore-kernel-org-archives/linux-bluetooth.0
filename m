Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371A0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 00:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiFNAkA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 20:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiFNAj6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 20:39:58 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413132CDD4
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 17:39:58 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a10so7881280ioe.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 17:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=a3vrUJ4DUWoEWSNtJkf5kWBQNUWO7/Akk0glaU17Oj8=;
        b=YtHdcAw6TCHC9Hm2fKL652Sp4rrihvULg30cFnvrl4s9smfrW+fOjZZFYkRcnK6Q3s
         ezLwNakQgAhV+EMnJVPw656KtZ5/v8vQ/BeCw8ry7m9wAJ+6ULU5FurAxxAulPSVrzdR
         CCpAeCmomvPHqpevxU0Lg6e8hVEhZBEyH7JjsJQd1E06NHWkSz3+88EdckmD0ZomPo6u
         Zd3MMLpzIy8GXYZJOZKUU+tNXnYe0Gmvln2m4xyfhNQfB4yjVdnDlrCkJFrzIBWlGkAS
         GfKwF8TB+01Ir6auRi467TILklkK4giNlXJBOeoBzfr+//OcqUe+RGjtsmCCjDj4ceea
         miiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=a3vrUJ4DUWoEWSNtJkf5kWBQNUWO7/Akk0glaU17Oj8=;
        b=w7YHsayV2Rz3enSn8aZOAFXZnOn+LRh3pXqpjnOKLuHburGIyjc4qhDHXX5uvYwVup
         0/nQJNUcRE1Zje7kvE/KuYarYwc6QZ36/zWyhE6Z7kZMvNY3Elqm3L7WabYtDcmAT20g
         +oz5pbSr5ggPH93oA5vq6ZMg39jrytLuv0mprwA0IaMSJyoMM87vTejXrQI0nXy/tFqB
         IMTIyEqeuIK5WqXDdsoAXX8yRHVkx78A06XFwd+oZnJiitU5NungTGtxGXqWrH4UClno
         ssE/z5hgy/Ju6J+uud9vV0FwQj1r2OWz2H6V2R19XNjx+XjbDebVSDVyOhNg40P7jQVl
         tHtA==
X-Gm-Message-State: AOAM532Lzjp2ihXy25BgQuYmzhmV3bFhACV1UhDLvinW9ym0iA8C8hb1
        a+a57omz3fz+0Ysw/+uQiRXZ9SadZMGCdA==
X-Google-Smtp-Source: ABdhPJyQNmK+heSGLDrllrCwi5JRIILTpWX9BCFK9WoIe0rMsp9gd2H8Xh76kXWQZAA6MgweRKeK8g==
X-Received: by 2002:a05:6602:14cb:b0:669:e8a5:71b3 with SMTP id b11-20020a05660214cb00b00669e8a571b3mr1170472iow.150.1655167197500;
        Mon, 13 Jun 2022 17:39:57 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.16.137])
        by smtp.gmail.com with ESMTPSA id h9-20020a056e020d4900b002d40b591700sm4638849ilj.7.2022.06.13.17.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 17:39:57 -0700 (PDT)
Message-ID: <62a7d8dd.1c69fb81.9fd0f.47b4@mx.google.com>
Date:   Mon, 13 Jun 2022 17:39:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4928581298724263517=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor/att: Fix decoding for notifications
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220613233419.177421-2-luiz.dentz@gmail.com>
References: <20220613233419.177421-2-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4928581298724263517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=650006

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      0.70 seconds
Prep - Setup ELL              PASS      37.88 seconds
Build - Prep                  PASS      0.57 seconds
Build - Configure             PASS      7.42 seconds
Build - Make                  PASS      1338.88 seconds
Make Check                    PASS      11.80 seconds
Make Check w/Valgrind         PASS      398.51 seconds
Make Distcheck                PASS      212.71 seconds
Build w/ext ELL - Configure   PASS      7.30 seconds
Build w/ext ELL - Make        PASS      1275.21 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4928581298724263517==--
