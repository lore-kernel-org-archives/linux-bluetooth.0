Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CD9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 02:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343648AbiBPCsM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 21:48:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbiBPCsK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 21:48:10 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858C019C33
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 18:47:59 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id ca12so862392qtb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 18:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OmDiAuo0Sg6JwR+Y+Ph5WJF8B14X5J6eyBQVJbHNDpE=;
        b=U63Voo4Cf4g/I480cikoMKOWT+yIsvcBT4e7LfEoV78jF1DTf4qnJihCyTKfn9UPuo
         eGq9OFYH0q8FXld84QjLSidQ+D+AMIJJap+C827LEkmgITNYG8NZTNs1iCPiaYyr7fGZ
         D5/UqfjDeZgAbyM/VkyfXzeNtkqznRZV4Q3XmGNM0YVWTKyaVyIMS3YdjGd89PMKJINQ
         t162KWsQ2O+8q6eZKXDbW7udNLqbQjOrXGtnXzEHR4RsrCICNt7kh9kubVH8KTVeQpof
         eM1kMtPMIdGmghev3Qo4i836prFQ01oxyGGs6jXeF6JlDbANXKgcVh0XqH3ofyXwWFHT
         6Psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OmDiAuo0Sg6JwR+Y+Ph5WJF8B14X5J6eyBQVJbHNDpE=;
        b=XngDorUwDkKxQe/nz3sjep4IVcUxjNrBMshy2KfJQ3G+8V+6XoJ7be1cXKAx/WF8jM
         9PgWWibyoMsOkGGN55choanEFw9fykiyF8pVvmpU8ZjM7PLMlsc1UsUUhj9crIkAHXvj
         b0V2S8XY+Bn5XxZ89siboAXZJeRORqHZpwNxXebZVoRPSFv6TddTZnj2ZBQmwIonLIfC
         J4SAmAI9FapR5RI4N+MHix5EJU0lLNBwppCtRyybtE5tTKI4SfyJEjvtFgOw3u+ulisZ
         VxlAxEP7EUWEeTl2O60z6YkQ8wHwXh3YUssAAEjiwbttAnFmaG56PkT6PyvoKqY2Eg8a
         fBcA==
X-Gm-Message-State: AOAM530yWYp3+77u5TB2Djzdchx3vvN7sGNSAyVYOWQStDiuszL4qGod
        avzgsHAv/vhpgnfJouBckvP871tFM5/fvw==
X-Google-Smtp-Source: ABdhPJxIspQwegoMvPziHMPyowrV8KhAiiJd7JFQchNPqn9eMwHA3GRsEWtael6ddOj0SN+G00h+kg==
X-Received: by 2002:a05:622a:1828:b0:2cf:51e6:b5d4 with SMTP id t40-20020a05622a182800b002cf51e6b5d4mr704803qtc.148.1644979678562;
        Tue, 15 Feb 2022 18:47:58 -0800 (PST)
Received: from [172.17.0.2] ([13.82.220.109])
        by smtp.gmail.com with ESMTPSA id q139sm6850714qke.104.2022.02.15.18.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 18:47:57 -0800 (PST)
Message-ID: <620c65dd.1c69fb81.219fb.4da0@mx.google.com>
Date:   Tue, 15 Feb 2022 18:47:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5757022944950741700=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,DO,NOT,MERGER] Test Patches
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220215233902.3090-1-hj.tedd.an@gmail.com>
References: <20220215233902.3090-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5757022944950741700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614726

---Test result---

Test Summary:
CheckPatch                    PASS      1.41 seconds
GitLint                       PASS      1.04 seconds
Prep - Setup ELL              PASS      54.15 seconds
Build - Prep                  PASS      0.95 seconds
Build - Configure             PASS      10.99 seconds
Build - Make                  PASS      1876.89 seconds
Make Check                    PASS      12.92 seconds
Make Check w/Valgrind         PASS      553.35 seconds
Make Distcheck                PASS      289.38 seconds
Build w/ext ELL - Configure   PASS      10.65 seconds
Build w/ext ELL - Make        PASS      1829.24 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============5757022944950741700==--
