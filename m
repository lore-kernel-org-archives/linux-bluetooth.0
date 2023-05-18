Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33608C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 12:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjERMAR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 08:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjERMAO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 08:00:14 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72383C2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 05:00:13 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-19674cab442so1413650fac.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684411212; x=1687003212;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OKxQ0l5tFC/m2HxLb9wF9AYy1/i+XiVGfquJKw87BFo=;
        b=rEsuf5xJzUTWHlTFjDn4P/Z3wRDNI0pPkS41w00zL+wmA3FdeRP1YlB8gf2KXnCwEl
         2GZlIieAEPAdWfWI6P4cfuPTf4FvXpkM6Kx2jlAPGYOiDU4VqCZjT+sWIf2prSrfgjsu
         ZsM6ZHq/feHkN5rfumNBk058eubMdwXzPabXuNJGiaFT14NIiSwlAaLgozIDn4GUsVaI
         DAyryXRH9nqKN73qFJP+U/7tZe1L1Cj762URA93oBhfYrTBqsjHbgl7NiSFf4NfJsjjV
         vrsWGYZK1F/g2LUs8grtvB8LUInTisuEdNoXLGPSdlsmeEEMRKlk3hNR2iu3W56ycE2r
         0Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684411212; x=1687003212;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKxQ0l5tFC/m2HxLb9wF9AYy1/i+XiVGfquJKw87BFo=;
        b=lAgV5FNha678//l0g01lL1KVtJjf6vA3KAd8tn8QF781s8ZFC3VKfQ/yhzzzkEM0bA
         MxJbnBctPffdBcZg0W74p+LV02Fx1N3hNvmZPHJOVrRMnUYBeQkdBn1i7EUkf+R9XflO
         6I/eb3fzcwyZnwXWJwhAeuBDehWkb2uNzq9hJaV9G2hxHgqD5UDhNAZ+4EJVyPNL7J4u
         nnGeMLh5+E93qO1tbpPC4xZm3I5cvKogeq0Kkwi7xKccDfQfm/vJFsF2d5EYTjN+zf4K
         QnMqIRgomWgIEmv/CLO+pb/2IUuvpMLJyVjoCQuMUxpCuQRL5qlwfrQZPYxMRpSwjQfx
         td9w==
X-Gm-Message-State: AC+VfDyklivZpo4RuQcve1uQz12FibB00J5WfrVeEo/2ni6oP50XWh8A
        Xntr3dpwBlHkVRBiTcY9OZo7ZR4UUCc=
X-Google-Smtp-Source: ACHHUZ5zKnznGjQaT4HYmOgZe3uvmf1B+fOBoEvunAqhNilhnepoQIDytNTNVDZIRnqA8/EY70e+og==
X-Received: by 2002:a05:6870:1a86:b0:196:51e7:6454 with SMTP id ef6-20020a0568701a8600b0019651e76454mr571607oab.51.1684411212441;
        Thu, 18 May 2023 05:00:12 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.171.1])
        by smtp.gmail.com with ESMTPSA id j20-20020a056870d45400b001925ab4a7ddsm676816oag.22.2023.05.18.05.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 05:00:12 -0700 (PDT)
Message-ID: <6466134c.050a0220.3cd74.2e28@mx.google.com>
Date:   Thu, 18 May 2023 05:00:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0941605365304892822=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v4] Bluetooth: msft: Extended monitor tracking by address filter
In-Reply-To: <20230518113021.30431-1-hildawu@realtek.com>
References: <20230518113021.30431-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0941605365304892822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=748870

---Test result---

Test Summary:
CheckPatch                    PASS      1.54 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      38.77 seconds
CheckAllWarning               PASS      42.40 seconds
CheckSparse                   PASS      48.52 seconds
CheckSmatch                   PASS      131.83 seconds
BuildKernel32                 PASS      37.98 seconds
TestRunnerSetup               PASS      528.32 seconds
TestRunner_l2cap-tester       PASS      19.09 seconds
TestRunner_iso-tester         PASS      25.14 seconds
TestRunner_bnep-tester        PASS      6.75 seconds
TestRunner_mgmt-tester        PASS      129.47 seconds
TestRunner_rfcomm-tester      PASS      10.29 seconds
TestRunner_sco-tester         PASS      9.58 seconds
TestRunner_ioctl-tester       PASS      11.40 seconds
TestRunner_mesh-tester        PASS      8.38 seconds
TestRunner_smp-tester         PASS      9.46 seconds
TestRunner_userchan-tester    PASS      6.93 seconds
IncrementalBuild              PASS      34.51 seconds



---
Regards,
Linux Bluetooth


--===============0941605365304892822==--
