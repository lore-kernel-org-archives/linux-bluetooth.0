Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DA3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 00:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiJGAWT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 20:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiJGAWS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 20:22:18 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75B7C510A
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 17:22:17 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a25so2000328qtw.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Oct 2022 17:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh0KCxBZnFmVfLH0MF/BL5MOIVCol/odPyfKKs28rEA=;
        b=ThWgOzIgF+Fe6p2b0SyXzeiDrdYhtRvuBCj/jSzzBKBUohhBGntSlynWu2AjIL2pr4
         f2gVjftzBm2QBGx/b/PbR1WGIHVoevv/JpiMeikerJq2hW6ghH4ow+94ASR1dAYwPGP/
         OxoBT6Mp8l986qhpUm8/y02y4OYdUKOT3JIXywnNxRU7uuJnvLO0WQcavKEA8mocLPrA
         5YZAfoh1BXddKp51il1USht5FK0HZPRxbMIp34p+UAJoWVHhWVtz8Xq2rDLl3WySYpT9
         VIkJCqjEblQUi5fk6g53TKE4wSJqz1rcHdmsLUrPbJOrhEX7mk/lGDgASYaEbj8H+DGm
         7sBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xh0KCxBZnFmVfLH0MF/BL5MOIVCol/odPyfKKs28rEA=;
        b=ZbOI996ovGxznlLw2ztuFI7XPNq4iQsLzNNZxZnIXNkM+IDVXGnP82i9N5lhua2wn4
         EDl25Vt1zfofEP+rKj/5Tk/rRxXyi41ILCiC9ySdlDQ+p/EwIj3xlsgZdmK2RZDZ4aLv
         CVpKX4ptfF+giN1i7AA/NzEb2VWGu1vNpL5+GvTCb5WM844rQLclSzo+tJ7vmOSlXgn7
         pcwrOAkNrgETEm6geo8fhKmILYkE+l+r2+56IlRGd69leu5uzOlo80425up5OJ317+BH
         lB2qsKksjB6urzxhjBCyN0mOVw9wbzT+YB4yWY5SL4G5wZo17w+q+RPK2AJHF6BK0Rb9
         1BUg==
X-Gm-Message-State: ACrzQf1m0gJNxIaPoV/L4Y9aLdMy47GZMSCkq909e3ALwdvj66FnN/eG
        kwh26DyRZXj0Hm9IFroGvmRhV1X5j74=
X-Google-Smtp-Source: AMsMyM7GIAaH6yEk/83JyNlHjp+0SfJOYeh7DrzseAg8ojEjNXh6vAPwe2oYgdboD1Io3RaHrEfk4Q==
X-Received: by 2002:a05:622a:1182:b0:35c:c062:ec0a with SMTP id m2-20020a05622a118200b0035cc062ec0amr2522025qtk.654.1665102136770;
        Thu, 06 Oct 2022 17:22:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.122.110.87])
        by smtp.gmail.com with ESMTPSA id bl21-20020a05620a1a9500b006cf38fd659asm417181qkb.103.2022.10.06.17.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 17:22:16 -0700 (PDT)
Message-ID: <633f7138.050a0220.b1e0d.0ed2@mx.google.com>
Date:   Thu, 06 Oct 2022 17:22:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2296197321577520220=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] tools: mgmt-tester - Test for HCI cmd after static addr set
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221006225326.641765-1-brian.gix@intel.com>
References: <20221006225326.641765-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2296197321577520220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683610

---Test result---

Test Summary:
CheckPatch                    PASS      1.44 seconds
GitLint                       PASS      1.03 seconds
Prep - Setup ELL              PASS      31.87 seconds
Build - Prep                  PASS      1.06 seconds
Build - Configure             PASS      10.08 seconds
Build - Make                  PASS      1052.67 seconds
Make Check                    PASS      12.72 seconds
Make Check w/Valgrind         PASS      348.11 seconds
Make Distcheck                PASS      286.74 seconds
Build w/ext ELL - Configure   PASS      10.59 seconds
Build w/ext ELL - Make        PASS      104.76 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      655.40 seconds



---
Regards,
Linux Bluetooth


--===============2296197321577520220==--
