Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2329DC001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 08:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjHII0A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 04:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjHIIZ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 04:25:58 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8968E1986
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 01:25:57 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76cdf055c64so537327485a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691569556; x=1692174356;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VycpzB6udqIBzbKQFGUhxzOf9JTQAh9fhMkbL429r+0=;
        b=D6+kpcWsyddhD2QTN1biaKx62JbZjuM/RzbUUAbl8CxGVAZpg9vBih9jRTL5h2Lran
         g0daTrUcOqmo5FkDhRcuSnhijSc3bwGEqH/f/qQ+zUhTN8GvuuGJ4/qIj1cqKkM2WX79
         MKTPbmZAYXLW8Ci4JPLKd5eWOAiMNhaVJS+BtEFBkf0PjnH+Q0PVE6GjKU+VMQRS5/of
         nwB2dpimiHaz2mQ6LYNQPd544b0coXFn6aYJgfQ/g7T1/dTxBX0SAdEFsRDr+ESRNS4q
         5/LDwslOP7Z0yLXHlLwG6wUe51OhlAdV23r8FjPvHiUy2axKunA3aFsjvo3rjlhXuHGT
         +5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691569556; x=1692174356;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VycpzB6udqIBzbKQFGUhxzOf9JTQAh9fhMkbL429r+0=;
        b=VwxuCaUSVYHSnl27ZIew493Pvv5nAAXF5cnZn9coo/lpSQCFVInmc4lP+dw9foLXNh
         DPTrrX39I9er+MeXZVOgOtVgdR188rnhrOauc/JjX+KbjWmI1YzUtTw3n8emOKEyQB5G
         pBXpmZ7/+7ZDcxS19yKkGXTtxLv9qvZuIocNZ7XHXKus0ORtJ/m859ceUPeSvDxTKxD9
         BUau2UtDZFuTdTmFnWY786NBR4aNgQZz16Ed4mhGr/wPhHYqJchSMSVf/sqlNfKwhqLe
         IOt8hYgAWqj0o+ptCz+9BmMvyP7f7cWdlYD+KdNHHRNKezBotiOODzY9mbfBWageG35s
         ZD+A==
X-Gm-Message-State: AOJu0YyXgv9SaMDI6BubxO9NuV5kn/XCTsXiovHSdSqMiuJEdz5Q53T5
        YEJftoCzxCvp59hssq2hY4WdZssbUdg=
X-Google-Smtp-Source: AGHT+IFT68HIYRaofeHe+VodZj1QG53CjBzm5lUkS7DBrhYxgIj1LvQavwOH+04l6HMc32H50OdrKA==
X-Received: by 2002:a05:620a:4091:b0:760:6b8e:eba with SMTP id f17-20020a05620a409100b007606b8e0ebamr3027312qko.12.1691569556419;
        Wed, 09 Aug 2023 01:25:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.16.76])
        by smtp.gmail.com with ESMTPSA id v4-20020a0c9c04000000b006300e1db3ecsm4265334qve.141.2023.08.09.01.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 01:25:56 -0700 (PDT)
Message-ID: <64d34d94.0c0a0220.98f04.19f1@mx.google.com>
Date:   Wed, 09 Aug 2023 01:25:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5309129218153282019=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gioele@svario.it
Subject: RE: configure.ac: Install D-Bus policy in /usr/share, not /etc
In-Reply-To: <20230809065143.2002324-2-gioele@svario.it>
References: <20230809065143.2002324-2-gioele@svario.it>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5309129218153282019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774393

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
GitLint                       PASS      0.69 seconds
BuildEll                      PASS      27.58 seconds
BluezMake                     PASS      889.39 seconds
MakeCheck                     PASS      12.96 seconds
MakeDistcheck                 PASS      159.07 seconds
CheckValgrind                 PASS      258.58 seconds
CheckSmatch                   PASS      347.14 seconds
bluezmakeextell               PASS      105.28 seconds
IncrementalBuild              PASS      1470.25 seconds
ScanBuild                     PASS      1075.30 seconds



---
Regards,
Linux Bluetooth


--===============5309129218153282019==--
