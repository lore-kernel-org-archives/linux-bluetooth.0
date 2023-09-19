Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6CDCE79A8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Sep 2023 21:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjISVgH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 17:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISVgG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 17:36:06 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58795AF
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 14:36:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690d9cda925so237896b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695159359; x=1695764159; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pd3JfP5O2MXkCIeQnovWvH5L2nq5kTiO4EEqaYGONcc=;
        b=DZLEze/BxN3dZv0neILKtC/UdUlb4CeEjj7j/98OZZwzACdOcwI67Nh9673eh8Q90a
         VzGgpj6dF6XvKVysXLFkPJzomFFTl515OGZJKdT8zDkBbmAJeXSkKJndL5bLR/GclkS6
         qk8s5LSAyTYrMJ2KxNa/vbVn6p7LNqocjvpWiETAJGGluwnwcjtd5RXQGAqMzmbqi0kI
         jhq0IVAx1Tm+yKAQfzt8eZdrEhBBf6IgpgbM8gj3dN2hpVlkbWvQw3Ka//k0XqeINGmP
         +RfkPBTvtCxqlVABp+yZNRounTGOaovl9GNQOc7hizmyRi1QcyFVHTy6q4PdRUtY+khi
         MmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695159359; x=1695764159;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pd3JfP5O2MXkCIeQnovWvH5L2nq5kTiO4EEqaYGONcc=;
        b=bfUC5jyvpGwSK6d+8SEGFw/btCKV7D0y3r5b1lT/lwLARnUIq/8K6+uiCeC1YD6/iG
         G75mFjTlAg3cRq7N9zPi9Q/ZxGlo4221AAK313zoc/oRQ2XaE5Uoj0J45fLiLccmE3x4
         WccImvZwCZVptEzpTDZSz3F0qtknEp+Y1+ZCZX5IvBkqp+LkM2o1pUct3hWY6AThgiyq
         AjMQIFw7Np0UfQV7uDancYkNqI8NfWJ1Sievx2eOUUXs13O5Gp5P1bK+ndZmT8yyvs51
         7xzqqx+l1+obSdtZTNHnCPUqRGlP07K4e6bqVO785V1qQHfTwhMpwau/GYanSDXw4huA
         ITXw==
X-Gm-Message-State: AOJu0YztsPDpFE0GLtCn8FeZPyqu36lnBAP4evfwpRVsG6noqtUyIHYx
        zUfkaa+cGje06h7i3igqUIm8Xi2dc49Xig==
X-Google-Smtp-Source: AGHT+IGVrKpHlvLYW+tw1NFHOsWiidLDACmyXhe2todA0Vx0HA1djEVRMre7HzahU0pYsPZxaDBK6A==
X-Received: by 2002:a05:6a00:1587:b0:690:c1a6:1c3b with SMTP id u7-20020a056a00158700b00690c1a61c3bmr906174pfk.33.1695159356264;
        Tue, 19 Sep 2023 14:35:56 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.44.118])
        by smtp.gmail.com with ESMTPSA id s11-20020aa7828b000000b0068fe5a5a566sm9246132pfm.142.2023.09.19.14.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 14:35:55 -0700 (PDT)
Message-ID: <650a143b.a70a0220.d830.0757@mx.google.com>
Date:   Tue, 19 Sep 2023 14:35:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0081501842556696884=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] media-api: Convert to ReStructuredText format
In-Reply-To: <20230919200607.322939-1-luiz.dentz@gmail.com>
References: <20230919200607.322939-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0081501842556696884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=785737

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      37.38 seconds
BluezMake                     PASS      1265.87 seconds
MakeCheck                     PASS      13.80 seconds
MakeDistcheck                 FAIL      13.43 seconds
CheckValgrind                 PASS      339.34 seconds
CheckSmatch                   PASS      478.30 seconds
bluezmakeextell               PASS      143.17 seconds
IncrementalBuild              PASS      1081.22 seconds
ScanBuild                     PASS      1497.04 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[2]: *** No rule to make target 'doc/media-api.txt', needed by 'distdir-am'.  Stop.
make[1]: *** [Makefile:11772: distdir] Error 2
make: *** [Makefile:11848: dist] Error 2


---
Regards,
Linux Bluetooth


--===============0081501842556696884==--
