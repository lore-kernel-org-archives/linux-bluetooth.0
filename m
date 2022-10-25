Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAC7C38A2D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 23:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiJYXGo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Oct 2022 19:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiJYXGn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Oct 2022 19:06:43 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA03E8AA8
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 16:06:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b29so9047711pfp.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 16:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cjFnMu8cs2WPvno/b+5cFk6HfUuLPIn8s7JheAk8I2o=;
        b=ipPv+YoWVm/kh02aQbLXc2XDdMj5JyYtVgQTNBJayp+y8TCvAXsWYWdqtXsh779QxO
         TA0Aji93jY0rhxLGWNuwPAT80t8pnFhb2gdNa+vLH9HZN+TmZcF4VxTOUIlHZJ8T308X
         C2M/OEBzq22h/zbaE3nNNzUUNg+8ezUvn43KpdmAAVO6lV1m0s1F28Z/R6ofY7Um4le0
         sYZI/QBhEIUM3SpXBQ0ZP3zbop9VaF4PUVE9YiJXDwCQLDGFWNWq6yfPdTcZrAmX7V/2
         z0ydv5tcXKsfsx40jQYnTt6Vr8jlFhNk4oD0A9FoOnMtqHFmkrV7AbT5QzhmKYUs8Igl
         HqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjFnMu8cs2WPvno/b+5cFk6HfUuLPIn8s7JheAk8I2o=;
        b=aJ/sTogGBnpOljixKMXEdmvwcayhOsOvL73g9E4fDzjf3eD1cDJJYC4Xn37cpy7pGR
         haCYr65C4FATrrQq5MPprclU9ieL4NYf/VMwH7k2jZaOgbH1qU1nUmQxyqljRmt1F2FF
         NltCoanUAyp9WyKlzPdXoM95Hcdk7i9pv2Q/wOu8eFQisJ7oOG/DO7/b/WKQPPbyTgS9
         nkTT+0Fi4mR6plzd8M28cvajClT6IJ1YTSnuBk3IWYrfsc86I2i7ln0eiGe8D+e0Ghte
         JnGaRm7RFTTrEBROE+IlMiHG0f/WMMwpIEl25GJj6SpRRFjaoVbPThZIv1LicmlRMbfM
         Cm5g==
X-Gm-Message-State: ACrzQf3FPp9fTgKdjiC58s7FHII7Tp8J9Ziu9KWG7qvYcJX8EcFXQ63+
        WcCUj4SniDdeCMru+HvrmYi2y8ymusM=
X-Google-Smtp-Source: AMsMyM6C/k4/8+AH6xoROj45AcQ0o6+GWFLsaUN4UVgSiMQ7GybposLUWGMMLGqRpvyV4zWy/EWrFg==
X-Received: by 2002:a65:464b:0:b0:42c:b0:9643 with SMTP id k11-20020a65464b000000b0042c00b09643mr35537164pgr.232.1666739200676;
        Tue, 25 Oct 2022 16:06:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.236.56.14])
        by smtp.gmail.com with ESMTPSA id z16-20020a170902ccd000b0017a0e78ed0dsm1665433ple.254.2022.10.25.16.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:06:40 -0700 (PDT)
Message-ID: <63586c00.170a0220.e5218.3c42@mx.google.com>
Date:   Tue, 25 Oct 2022 16:06:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8781501828438130558=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] doc/ci.config: Add configuration for CI test
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221025221645.2344340-1-hj.tedd.an@gmail.com>
References: <20221025221645.2344340-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8781501828438130558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=688840

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.38 seconds
Prep - Setup ELL              PASS      26.41 seconds
Build - Prep                  PASS      0.55 seconds
Build - Configure             PASS      8.10 seconds
Build - Make                  PASS      756.14 seconds
Make Check                    PASS      11.53 seconds
Make Check w/Valgrind         PASS      291.28 seconds
Make Distcheck                PASS      238.67 seconds
Build w/ext ELL - Configure   PASS      8.19 seconds
Build w/ext ELL - Make        PASS      85.03 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      484.12 seconds



---
Regards,
Linux Bluetooth


--===============8781501828438130558==--
