Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C790C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 May 2022 23:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiEBX17 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 May 2022 19:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiEBX11 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 May 2022 19:27:27 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1ED167EF
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 May 2022 16:23:50 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id jt15so2063223qvb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 May 2022 16:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lR0jW10qAOIO6T8z3wNQNhLr4wLQPtXNaPZBtlJlRHU=;
        b=S1qOsOy2lm55sxh7ARH163JjwpZJlnadsxNUOz6+t5hSfYrKRRDxLvf8QQr2FfHqhG
         uXTHvbVbmWHbZbz/7rI2IP/Rd23+DWSSicJbZAtjfPo/IJIs05S2oIqvt/winh2zx6ia
         fG8Ej3fTTuL5dIJ3OSx6kwGJsW9xWZT1yw82pFU5JL+p9RnSO060cZKOeBL9ZadCKWgM
         c7p4uVTihXHFSW2ASzAHCReCSBjt3HstZhXXvtn181+Dss32nzEwH/m++Apx2fWV9jHv
         OIwp1ZqcFB0yUC3mcEHxbkgiMZVabqfDzJBcDzcW/DkBLWJxMprXBUFQCshRMm4/lz8O
         ffkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lR0jW10qAOIO6T8z3wNQNhLr4wLQPtXNaPZBtlJlRHU=;
        b=hCl0VLz1biGrxoUoK31/1GQINeAQdi7pg8NhIwh9xU0VhZ7d11alic4j4SV6tLVoyE
         kCFByl+V6aIuZktEkDdrR21pXZnTncByljawMRD/5HF54qYQw1lVZYwiFu3XPP7yxCxo
         O1neYcnDIf/snlDsUzemAN9oUd1bq0oXtk8rlfWQuFzW0f3CKNcqYgXrKoTQlT8uXDlc
         nAx9deh8cSx/dAQ5z5W4WpoSej0PPHqngld8gL4LmnD1nk71SoRmVIvVuPPrJvnnRFhF
         GhWd739LuirxWY0ovO1wkz8gawYVlpA6dI+FCAITOzaVAYrHIgwMt2+WAp1pJRf5z7JM
         7ShQ==
X-Gm-Message-State: AOAM532kPyhYkp8l3bgvIj+QqA5qB4muqdo8tY0JbbN3JxiEGyRfmMO8
        UQh+Wa1CCz27feGNmwpEls2SKwYI8M9vvg==
X-Google-Smtp-Source: ABdhPJyuEQZfotW35DPai9CqTdm88mojrzSGwbcUmq/QkvubmT1FRKa2EJVSkhBiruQ6VBEc/Yzysw==
X-Received: by 2002:ad4:5bc1:0:b0:42c:3700:a6df with SMTP id t1-20020ad45bc1000000b0042c3700a6dfmr11775543qvt.94.1651533807508;
        Mon, 02 May 2022 16:23:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.232.46.191])
        by smtp.gmail.com with ESMTPSA id n17-20020ac86751000000b002f39b99f69dsm4879952qtp.55.2022.05.02.16.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 16:23:27 -0700 (PDT)
Message-ID: <627067ef.1c69fb81.d6389.78aa@mx.google.com>
Date:   Mon, 02 May 2022 16:23:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4347904233188443754=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Fix parsing of LE Terminate BIG Complete event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220502214517.2363950-1-luiz.dentz@gmail.com>
References: <20220502214517.2363950-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4347904233188443754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=637729

---Test result---

Test Summary:
CheckPatch                    PASS      1.60 seconds
GitLint                       PASS      1.05 seconds
Prep - Setup ELL              PASS      43.23 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      8.64 seconds
Build - Make                  PASS      1279.00 seconds
Make Check                    PASS      11.38 seconds
Make Check w/Valgrind         PASS      440.61 seconds
Make Distcheck                PASS      236.49 seconds
Build w/ext ELL - Configure   PASS      9.00 seconds
Build w/ext ELL - Make        PASS      1282.30 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4347904233188443754==--
