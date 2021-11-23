Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17899C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Nov 2021 21:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhKWV5h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Nov 2021 16:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhKWV5g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Nov 2021 16:57:36 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F74C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 13:54:28 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 132so627993qkj.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 13:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/xtuRr53Eqp6M8EGF8aQteUHIIs5n/oK3Obbl6z4+5E=;
        b=lsacGS6zhoczV4oeXCX5hWNszHmbjBstD9AqRR/Z6r3e585BRd1+zucJoJcsjpX5dF
         nZeRRT+C2QQObjsWJqFtwhFMHMzDnBeCxrShSLmlcy9NY4lYyOrNLECyGBNpPPBpB8EN
         a2c5z0UQuQNtDrEjU2kXcJ99XvvitkNQKJqIDRWNqpIEfDr0G0VXqMwnvYslQy0+pPa2
         maHlJHdMCRvCuUsrcZWjjDiYm/hZH7CCq5GBHZRZ3OOe9vEaI/SWzsiHTd3WdAKzLxlW
         Fjvvf7APt8Q7H9ESBMhiIYHObcgBhLtiSgh+scke0aDBHfvnA2CYQItrmx4y7fvnG6tU
         rQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/xtuRr53Eqp6M8EGF8aQteUHIIs5n/oK3Obbl6z4+5E=;
        b=sRs/0D/DdsMBInNrHdjA+/p7lMxuEVX42QtjXRW0YLkMG5PrJkQoYbOFqiyp4H4hA5
         i+IlAugurpe3jVT1IEMqmZvcSUFXdzkeKjHTsRZpGy+5VmaETVoz1LocuOXspOTg9LWS
         jccyPKo/3bcSaozTJMJZ+sT0xOQjh5rpryiOcGq9eM/RhvIGteBL7wDg5VsYy7LguYq8
         1w+rRAftthN1ZznE4X3Qvd8bEC/5JHG79FGzKvSwIEav2Wc++PhTiuOa2iYI42C7H4SS
         0aLd1H9eb9NymRaJ68WTXqsyfSWWl0iJlQAhjd55zGLXwvLLKTg/bquGk+YkliPTUVMa
         OF3A==
X-Gm-Message-State: AOAM532yDaF5nRk/3D6GfvU7HzeO4YyT2nI/mCNGrQA2EZ1C8cqCp88/
        8RNu3Dgye2Pb1gKMrJN0ZTcd44V5SGvS+pfV
X-Google-Smtp-Source: ABdhPJzefyswtYn1gvqQc08ufbYvVOzsJK31UPhntMVub0Bmp5b2uZtrqms+W5IsLdCf4OwqHDOUQA==
X-Received: by 2002:a05:620a:d96:: with SMTP id q22mr673546qkl.219.1637704467170;
        Tue, 23 Nov 2021 13:54:27 -0800 (PST)
Received: from [172.17.0.2] ([20.122.51.211])
        by smtp.gmail.com with ESMTPSA id i23sm6604371qkl.101.2021.11.23.13.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 13:54:26 -0800 (PST)
Message-ID: <619d6312.1c69fb81.7a59.37dc@mx.google.com>
Date:   Tue, 23 Nov 2021 13:54:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3554765279675850340=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] build: Check for linux/uinput.h and linux/uhid.h
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211123213450.2595964-1-luiz.dentz@gmail.com>
References: <20211123213450.2595964-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3554765279675850340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=584863

---Test result---

Test Summary:
CheckPatch                    PASS      1.38 seconds
GitLint                       PASS      0.93 seconds
Prep - Setup ELL              PASS      42.36 seconds
Build - Prep                  PASS      0.48 seconds
Build - Configure             PASS      8.05 seconds
Build - Make                  PASS      179.89 seconds
Make Check                    PASS      9.19 seconds
Make Distcheck                PASS      214.98 seconds
Build w/ext ELL - Configure   PASS      8.16 seconds
Build w/ext ELL - Make        PASS      171.20 seconds



---
Regards,
Linux Bluetooth


--===============3554765279675850340==--
