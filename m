Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21C0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 09:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiBPJoE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:44:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiBPJoD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 04:44:03 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F3B29926F
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 01:43:46 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id o3so1509863qtm.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 01:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8wjWUF6yExlyFHsvGimj9nTfGy8vbqcTdR05/PDJF4I=;
        b=APH+EgPoWk3fMvMqPHG/9LaZcGYlq+sxFNd+vy2Z8Wwv2O2pt8k68oHf6OFQSl+g28
         uMvi6j9gElebMyYiyMHLDiwKoJLBoGYXkOfxn8dokltYQ7PBESdPcF1TWgbt/nfd3LzQ
         r/a9twIo82EdR3iZoIyANsA1MKkoN+72TJks+IH7sFSyzfS1UeZE84y5zif5J61HtMth
         zxvNWIarS+kNA0FS6uUcgLSExsM2NHQFJqXbP0fcdI3vUsq8V+63wU02HCYSNRYZKEHj
         bQC4XYekLYQtF3DIe2ZtHkxrWoU7U7kgQRUSiWi29U1JaBPh7oWwShLT4NNyb56cR0Zi
         +aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8wjWUF6yExlyFHsvGimj9nTfGy8vbqcTdR05/PDJF4I=;
        b=UDCy2UqrQwf8DLub5hSQYW+jMTPtumcBiE8ryXKKzPofpni1u+Ste0QKO0HULxH1HV
         ZzvGYcyoellBzbs3IqvI6w9AQ+FLHrhcgUds3wlBdUVLwvgM2Jkvn7nniP60aFXMQWWy
         B2KZScqP9DZaTU0cYVsdZXjXhStn86gLbdlqHRyRcI9YmG0ArMJ2SSK0GfBFrlWOWe6l
         aScrWDdSbDskxbVR+Z756TPCliqJwMzDSuf26726zXzrXWW2s41u1LzwGwHnevVbWCDJ
         ffHeHWRHv65WkeI04ZtP+FTXD/J19tlGgVFdA4LTl9w2JctvreHAl9Y0JHP591kQP4um
         zx6g==
X-Gm-Message-State: AOAM531U0TH8qD0xN1moglTqB999PW6QB+ndvgFgqHQ2JwPKYHR4YNkX
        XkPBBfjwTM4DrahrN6uLeSpzGZU4uhQdPg==
X-Google-Smtp-Source: ABdhPJzxmNIakH5R0jcAnbqBgcxjCDX/92HOV/RUMof0lxyPyLgx/yY1ON3e+6pXVZ+5GBhsBRjpeg==
X-Received: by 2002:ac8:7d48:0:b0:2d6:102:e38c with SMTP id h8-20020ac87d48000000b002d60102e38cmr1348915qtb.251.1645004625384;
        Wed, 16 Feb 2022 01:43:45 -0800 (PST)
Received: from [172.17.0.2] ([137.135.109.179])
        by smtp.gmail.com with ESMTPSA id r13sm13000982qkp.129.2022.02.16.01.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 01:43:44 -0800 (PST)
Message-ID: <620cc750.1c69fb81.b21a0.80d9@mx.google.com>
Date:   Wed, 16 Feb 2022 01:43:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1888096578589858059=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [BlueZ,v1] monitor: fix division by zero about conn->tx_pkt_med
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220216081518.2956782-1-josephsih@chromium.org>
References: <20220216081518.2956782-1-josephsih@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1888096578589858059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614851

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
GitLint                       PASS      1.01 seconds
Prep - Setup ELL              PASS      51.66 seconds
Build - Prep                  PASS      0.93 seconds
Build - Configure             PASS      10.55 seconds
Build - Make                  PASS      1818.86 seconds
Make Check                    PASS      12.41 seconds
Make Check w/Valgrind         PASS      534.70 seconds
Make Distcheck                PASS      283.60 seconds
Build w/ext ELL - Configure   PASS      10.79 seconds
Build w/ext ELL - Make        PASS      1795.15 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1888096578589858059==--
