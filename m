Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B851ACD37B4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Sep 2023 18:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjIQSmc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Sep 2023 14:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbjIQSmV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Sep 2023 14:42:21 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A31F9
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Sep 2023 11:42:14 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-770ef96aa01so254350985a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Sep 2023 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694976133; x=1695580933; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5FGv+Wm61BucArBchuA95C1nYWUHMLRNjF+8ELSKlwM=;
        b=AZKKhUQySkuwt53sBveS7SmcRjaYN5D3f00FDocixPiLHJ1iZnx8SFIG4++NMGXVc0
         6zh3YgBsPkufleNuorGPBjy4VdMPao+yl4BZJAE0zzzWdFXlTaaY5PALlLuCNaqvXWVC
         ZkfoIR7ByuiLnMXjfX98bVdp69y59D78NyfANk0TsU03mVSPo7j6XeZq5Xkr/4+1J2xQ
         e5iVpIOt9Enf7bV+PBivCEeVI2fcLMBHmRzQNcS+IA74yBzatnbf2G0o7ZGkBRHx/VOr
         1lXjvpdmkaDwrOekh+9F1gxfJ7MzsMqWYVCl09W+00tFvxDngqKsw1hCKBnuaidy4DwV
         H3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694976133; x=1695580933;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FGv+Wm61BucArBchuA95C1nYWUHMLRNjF+8ELSKlwM=;
        b=Et40vGXh1KYNl6UDiZavpsLIVJW9yrUgiQOSkUBgVJ/MqIm9lB3CajZ8kQBf237yC8
         SWL9CJNuuiQ1nOykeRfP1XBXHqcvwpTTfRE8QKwTYgK3QHozTfBiIhSTZAIBYWf23moo
         olCeUKc+T6Ist2uFuq7qLMvnr1ecPX0RV2Q5NjtjMppYLRIr6QFGTCKhfDnaDF6zvVX/
         2dDgxxQZ7dcFas5bAqZiHM8f66JFwtwxQpSFDU4EdH9F4MnVUHQzL14F8QJdWp1ibobr
         qtvxu9lFN3Y2uaa5XJAB5oDmlOyWgfDicvbRlamMKBAX4qCw42cdRgXwyDtRrXkZsiK3
         6oUg==
X-Gm-Message-State: AOJu0YyWVOavXYgqFO+KImmzeprfpoWMmKVnbmCQ1EfCJTySoqekZHr/
        mXKovWXtWLuBq6geUSObmwmPtnc/xPs=
X-Google-Smtp-Source: AGHT+IFgnU821jRDdyx2TJSpnlY/zzHUtB71CGfusIh6QGAh3ec1X4HMRdV9p7RgcRvdK4ULFJjUeA==
X-Received: by 2002:a05:620a:29d6:b0:76d:3475:2e05 with SMTP id s22-20020a05620a29d600b0076d34752e05mr9748181qkp.11.1694976133512;
        Sun, 17 Sep 2023 11:42:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.74.37])
        by smtp.gmail.com with ESMTPSA id r25-20020a05620a03d900b0077253239ed0sm2613618qkm.15.2023.09.17.11.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 11:42:12 -0700 (PDT)
Message-ID: <65074884.050a0220.2caf0.9929@mx.google.com>
Date:   Sun, 17 Sep 2023 11:42:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8060711568485585756=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, koba.ko@canonical.com
Subject: RE: [BlueZ,V2] configure.ac: Add enable_btpclient and enable_mesh for internal ELL
In-Reply-To: <20230917172520.46145-1-koba.ko@canonical.com>
References: <20230917172520.46145-1-koba.ko@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8060711568485585756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=785020

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.54 seconds
BuildEll                      PASS      28.51 seconds
BluezMake                     PASS      1007.29 seconds
MakeCheck                     PASS      12.57 seconds
MakeDistcheck                 PASS      161.74 seconds
CheckValgrind                 PASS      262.90 seconds
CheckSmatch                   PASS      353.86 seconds
bluezmakeextell               PASS      108.10 seconds
IncrementalBuild              PASS      867.01 seconds
ScanBuild                     PASS      1096.14 seconds



---
Regards,
Linux Bluetooth


--===============8060711568485585756==--
