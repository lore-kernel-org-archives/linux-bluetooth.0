Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE11C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 07:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJGHfU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 03:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJGHfT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 03:35:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F3E4C02F
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 00:35:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so3956438pgs.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 00:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YhzLtpLRsZO8+wb5fgI6HiADNZv4hZ1vks0q33USATw=;
        b=OKXagF15cdHVA7JEebUj5zl3NRtAnnssPFLlqWps/3qvGpa9rfqIqZrhRYAtTUGckV
         i8U9ngzZNLuVFls2M4ZkHCXBuyNJHA3s811YzRDK1bPDrwbXAWsCO7ICC5z8MymN8UCV
         KdlABQFWmr8MNZx3XmsMG3CQQr37ZUISbXwanqqMe/xCCBZqBo+EKAMhazJWRRvYJt60
         O49R9VY4tbZgTfWhatVsWaynaLIITKwfyNSDxOmK2HKMliF2EvXkrpsSn3EP71mFmSec
         uw4S+MXrQYoz5WC7w7iZx+zMXfdyDv2da0Rzi54GrOjySEvFO+QGxsMelEG3q9x4+xZD
         oW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhzLtpLRsZO8+wb5fgI6HiADNZv4hZ1vks0q33USATw=;
        b=dtde1908q8r0hj3ptf8kNVOfmcOtX8+EGDr9UIcFGH9tJrw7IiUnng5uz5vSHQSl3r
         Rio9Y2iozgQmuybPRdd7BPC8c72my7Lo42x7QoSlDfFowZSD/GwRkffhhg0WgePL12rH
         0yqwfX1rrtlYnfJbStjfa65KYyZf8V1+rcwddLI9Z4ZHTOa9Yyq/wQezdVTnXuhcBqio
         EBl/Q7pw3ZJ0HFg/kkpl0E4iiFeGANKrye5ciE4jdAU6TcuOrwvBEErmId+4PaNKUiiF
         B+dcj3NTu33bbdO4pMxkUkn8e5tfTrfNpwmr8S9xT/BEdNRJTmB59XLs7WE57JSJw3xe
         IfhQ==
X-Gm-Message-State: ACrzQf3zgjqopQtc9D3ZPsUigZeZ+MB0TpsNPCDhYG7O5UrR5aY3AFB8
        VVWFEs/4aaWH3RyEfX+l3RQ3gJWtZ/VqlA==
X-Google-Smtp-Source: AMsMyM6DzeUDzOD/zZoPQ56EISCcvLV4WPofo30d4ZMX6u6Be4qqRd50ah0EAqx7tBEIBx1N9PCe5w==
X-Received: by 2002:a63:515d:0:b0:42a:cf33:4320 with SMTP id r29-20020a63515d000000b0042acf334320mr3302707pgl.21.1665128116702;
        Fri, 07 Oct 2022 00:35:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.36.111])
        by smtp.gmail.com with ESMTPSA id l4-20020a635704000000b0045dc85c4a5fsm928857pgb.44.2022.10.07.00.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 00:35:16 -0700 (PDT)
Message-ID: <633fd6b4.630a0220.c2ace.1c2b@mx.google.com>
Date:   Fri, 07 Oct 2022 00:35:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5818719328687165241=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: [BlueZ,v2,1/3] audio/transport: Add volume callback to BAP transport
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221007061223.46114-1-sathish.narasimman@intel.com>
References: <20221007061223.46114-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5818719328687165241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683646

---Test result---

Test Summary:
CheckPatch                    PASS      2.41 seconds
GitLint                       PASS      1.40 seconds
Prep - Setup ELL              PASS      31.92 seconds
Build - Prep                  PASS      0.66 seconds
Build - Configure             PASS      10.33 seconds
Build - Make                  PASS      963.09 seconds
Make Check                    PASS      13.13 seconds
Make Check w/Valgrind         PASS      347.55 seconds
Make Distcheck                PASS      292.36 seconds
Build w/ext ELL - Configure   PASS      10.51 seconds
Build w/ext ELL - Make        PASS      101.36 seconds
Incremental Build w/ patches  PASS      359.03 seconds
Scan Build                    PASS      624.27 seconds



---
Regards,
Linux Bluetooth


--===============5818719328687165241==--
