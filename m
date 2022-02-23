Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261CEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Feb 2022 10:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiBWKVr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 05:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiBWKVr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 05:21:47 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A0C8BF34
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 02:21:19 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id fc19so7357370qvb.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 02:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=SjLCEpvzSUyQo3FkpAbVzo/guk9ohrm5QXp4r2U+/qE=;
        b=EJRHXGWEV9gLHJLUFMSUx1fx/EWVj/J1T+vY5TdxBr59NzwGEGzuF+ixoSZBeNRnMR
         jo0kZ5FKbvJPJQfmbQlK0QmFutu88tg0UCWv1h4alcr2CKI3GAZh1PO8EMCzmPOCemZd
         42ERWtHzj1Em4bYRKIup+q5Xj/jcA8g/zyozSRgDn1wnSjxinQoBu16+Ei35e3x5EnvU
         Me/Sl/ky7TLxudozpiqhYw5WlDSkiGHBVOkP2xDQKnHrJ/HSXNs6t2e4yhCiU0Beevhg
         B8wbXK5E6OG/pUqFXlcz1d87ShDrgSUayCl/A7vK9tf7Lq7/GMH4L7Xd6kvfJZv3kReT
         7P6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=SjLCEpvzSUyQo3FkpAbVzo/guk9ohrm5QXp4r2U+/qE=;
        b=KB6t2cugdRex8GN3du1UlBl3qb71vQGnSJybP6JpLvabGGoBCrArisqZZhrAoKHAcy
         MQjFSoiSVdXKnyjNaXCP+IwX72AJ7SeGvBREf9ULmfIOlfHpol3inTVpkhEjX+CdauNs
         +aYn4/yYZXvR7iJg37Sa9v3ZrQlPKoMYM4tXE2NzpvkEnQ5hPEnqoEPqugApTTKqSr2o
         HlpVVyEohFptRz5N0mwTYFMlXqHc13HAe5oTmv+IVvNnh7NNAyiWD6PvTKXsU9nBOcFf
         CDn8ZMDTh+YGTBV6wnQdO2jbJlHIm73JDm++qORA6pbS8UQz39iuWCNd7CIe7LFksmNt
         d9ww==
X-Gm-Message-State: AOAM533yD6Lqjq96CpSzmb88U3vii/Cnq8KesMJmGcsdJu/YE0bD8zz2
        Ui0zWYsmSKmL+z81Yc1+WwDe/K72V47oZg==
X-Google-Smtp-Source: ABdhPJx1imajeBMxVYvjond1fLoMEhNKUaXc+ntkFRqdje2X9Sawi7bOK19RKeYsZHvWG7TaQbyxZQ==
X-Received: by 2002:a05:6214:5003:b0:42f:bc42:6ce4 with SMTP id jo3-20020a056214500300b0042fbc426ce4mr22496196qvb.63.1645611678934;
        Wed, 23 Feb 2022 02:21:18 -0800 (PST)
Received: from [172.17.0.2] ([40.70.3.137])
        by smtp.gmail.com with ESMTPSA id h190sm1506853qkf.70.2022.02.23.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 02:21:18 -0800 (PST)
Message-ID: <62160a9e.1c69fb81.4d09f.86f9@mx.google.com>
Date:   Wed, 23 Feb 2022 02:21:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1486129743558863676=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: adapter-api: Document per-client discovery sessions
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220223090059.310361-1-hadess@hadess.net>
References: <20220223090059.310361-1-hadess@hadess.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1486129743558863676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=617064

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      1.01 seconds
Prep - Setup ELL              PASS      42.66 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      8.65 seconds
Build - Make                  PASS      1406.67 seconds
Make Check                    PASS      11.89 seconds
Make Check w/Valgrind         PASS      444.90 seconds
Make Distcheck                PASS      231.57 seconds
Build w/ext ELL - Configure   PASS      8.72 seconds
Build w/ext ELL - Make        PASS      1416.29 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1486129743558863676==--
