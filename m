Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124F0C71136
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Aug 2023 06:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356685AbjHRGU1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Aug 2023 02:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352567AbjHRGUE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Aug 2023 02:20:04 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324B035A6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 23:20:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bdf98a6086so4845555ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692339601; x=1692944401;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cKVmpxwCJY1NjQFR/nW+hEA/4849Zh4IYgMrvDyNSvM=;
        b=C+7gfNrNHgPqy62u/3Xl/CS6xVinldHwxNPHI4DUcmxga4hyMTqsL9uHevRe4oZG59
         d5GnOdmqS2xN8FUT1PqO0fTAhBlB4nKvwj5tdLrGTBRmahaFB7dOqgl3MZCDfRPtXNKN
         QDArTmVkhaObpeBOSQNoMMUuxZt5DI49kSO/vIY+KWm+IrxTYWugcTC+NuQH9/ygMqZo
         MpSVnhqu+Tl+f2mV9OU8sE6pw5SwWK7DBmBd88nwvNd1yvHFNjVXGicvcEvBP0rE3uI5
         pmRAr2gc/ZtIDY3DoU7MoZpFEl/xI2LL32C9WQmlqgib6/jFa1IGhnqe9Uk3o7eoKtmM
         Jo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692339601; x=1692944401;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKVmpxwCJY1NjQFR/nW+hEA/4849Zh4IYgMrvDyNSvM=;
        b=SqIZqa5JeYDcmHouGxEbDZ7v7KdtfBIvPHZGX33UiYcPEda9BX/hGpa6YC91ljhsod
         WihrV2wMtWnoFiEcdCRDpl7yFiTlm72gJdL3iLoWAwgd4xSsGzesLv4qBSvm7Zh3pheP
         LH1ciQRn74kwB3zt04vyVPagF/0vpyuUnSuysl438TdzCqD9jyNjljDnpTMWprpsFClv
         bz2z3k5fIE3awLiArxS660WiBV48IbjMMTEBRCWzUTVfbsADn4Q0oMSqIwZJxEUnWtI9
         b+zGS5TrvVAirFTkfEqXRg3tVXpMvjsKLoQh5szRSkQzej3gbW/1R2PHyefCC8nZIt/V
         pGqg==
X-Gm-Message-State: AOJu0YzaJ0W120v8DbbWP7pJJv1llIBA67dGKxwLqGXKGLT8oUoxAWAf
        HLe8eLv4Uriney7GrZf4qYvuqWDc27s=
X-Google-Smtp-Source: AGHT+IEUB8qNr50wh/kGVD+UDIiXt5T4QJnqNd8Hl+waQ4/mPI4w5pctTglrtYUQJ6JW1LhrIENcDg==
X-Received: by 2002:a17:902:f54d:b0:1ae:8892:7d27 with SMTP id h13-20020a170902f54d00b001ae88927d27mr1654764plf.42.1692339601322;
        Thu, 17 Aug 2023 23:20:01 -0700 (PDT)
Received: from [172.17.0.2] ([13.73.50.88])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902748a00b001b39ffff838sm843340pll.25.2023.08.17.23.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 23:20:00 -0700 (PDT)
Message-ID: <64df0d90.170a0220.2350c.1cea@mx.google.com>
Date:   Thu, 17 Aug 2023 23:20:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5048510887881706277=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lokendra.singh@intel.com
Subject: RE: [v2] monitor/intel: Add decoding of PPAG Enable command
In-Reply-To: <20230818044542.532700-1-lokendra.singh@intel.com>
References: <20230818044542.532700-1-lokendra.singh@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5048510887881706277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=777282

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      31.66 seconds
BluezMake                     PASS      972.48 seconds
MakeCheck                     PASS      12.98 seconds
MakeDistcheck                 PASS      179.92 seconds
CheckValgrind                 PASS      295.03 seconds
CheckSmatch                   PASS      392.40 seconds
bluezmakeextell               PASS      119.40 seconds
IncrementalBuild              PASS      792.17 seconds
ScanBuild                     PASS      1209.03 seconds



---
Regards,
Linux Bluetooth


--===============5048510887881706277==--
