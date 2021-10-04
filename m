Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B141FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 21:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B20B614C8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 21:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhJDVzO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 17:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhJDVzO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 17:55:14 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7592C061745
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 14:53:23 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id o13so5140347qvm.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=h0FygUV5jg50NnWPBSUc4Z/uF5lvOB1etdxFUvBU+GY=;
        b=ECsk57u6ftQry5YRKbHJb3BvICM5g4kOg1lY0wV1AE+80m0v8oZZ/2kmQ8eczy4FTz
         C1Va9bMxXmSPXPoVTHa32x+bSlxsZneVsNKfdqvv8fy1E191DyLppOQcgPgf4yePBDDm
         FwVrjmhTDc5U+6E6qYeZ8FKj3yQTVEz4yoz980JYyCvytP0hERKwn+TBlJ+wxmRd/kwu
         vVJqwkcE0g8WisKa197/VgYHRD8wRzHpyWkDs/G6ywxD5oFKniEMsmAAv6IEySElCsIu
         hHxFjXU9x6AljJ2dXpaYA7i/n1lhucXS9eHORBkN1tzPZRoMg+fzhpUaCPjUb4pq8Oi4
         TavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=h0FygUV5jg50NnWPBSUc4Z/uF5lvOB1etdxFUvBU+GY=;
        b=RAeijjcAzyeMhks0TlThsLu+zZMuvt1SymF6Y+lS3TsUynouUkNFxae8SLWS2qvJhb
         szJie4JRy8sv89ZCmUnj4zreMZ8rm1BMVohVhji2DenlyURKQSSjUzXONvo6xqXHCeQI
         uDYyCfmE7R0WZ+pQfH3/lYIZH/ye82H1f4mVywcNTmYEjXs+rAxCFN4cKz66Dhxl5Pdf
         0YmqVlpIm+cA23eXBocrHaIpKHozaiQBUhc7dKL5Uz55rzfFg6ROowNK4E5IgssIxpHo
         lPnCvoSgvDV/chQbnNzoMvFD8SC13TE0F7mosT44jGDLIH8MzF5spyJuGJIsOJWz7wIS
         NyHg==
X-Gm-Message-State: AOAM530hUzgM6MGwB6YmjG6ozxmFVA4EfKc/EGH3jL16tv/gn/3m2MQT
        xtiK5ajwsw/iPzyXhImcFnf+STKRI5865g==
X-Google-Smtp-Source: ABdhPJysTus+f8iS3IohXbO65hgDO/Gge82TmePa/QaxdlaWn2C0Oo7oIcipML/YQfGHwISIns9BjA==
X-Received: by 2002:a05:6214:b91:: with SMTP id fe17mr15684231qvb.45.1633384402803;
        Mon, 04 Oct 2021 14:53:22 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.15.113])
        by smtp.gmail.com with ESMTPSA id b14sm9949070qtk.64.2021.10.04.14.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 14:53:22 -0700 (PDT)
Message-ID: <615b77d2.1c69fb81.12be2.023e@mx.google.com>
Date:   Mon, 04 Oct 2021 14:53:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2383519645065840477=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ,1/2] shared/att: Add bt_att_resend
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211004212652.4074831-1-luiz.dentz@gmail.com>
References: <20211004212652.4074831-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2383519645065840477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=557369

---Test result---

Test Summary:
CheckPatch                    PASS      2.70 seconds
GitLint                       PASS      1.86 seconds
Prep - Setup ELL              PASS      41.46 seconds
Build - Prep                  PASS      0.47 seconds
Build - Configure             PASS      7.71 seconds
Build - Make                  PASS      177.42 seconds
Make Check                    PASS      9.51 seconds
Make Distcheck                PASS      210.93 seconds
Build w/ext ELL - Configure   PASS      7.81 seconds
Build w/ext ELL - Make        PASS      169.19 seconds



---
Regards,
Linux Bluetooth


--===============2383519645065840477==--
