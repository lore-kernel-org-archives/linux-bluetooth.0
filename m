Return-Path: <SRS0=3ySR=RW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FD3C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 15:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8041D2083D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 15:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDMkZhox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfCSPFF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:05:05 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:44224 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfCSPFF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Mar 2019 11:05:05 -0400
Received: by mail-oi1-f176.google.com with SMTP id i21so12838385oib.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2019 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IOOUM8KS2eVpKf2azO4j10aXB0CwhQTSsMxRzkswIpM=;
        b=RDMkZhox+OLIkykci83Bzg99i9+11foKV5IdtejfR8fIwwF1tCCqj5q1FQL2gzwPKq
         t7a111oAsuQCWM6dk7FUgksEx/Ubkh4w1/Xf+DCpkBgkYwoXQM56lATjQfWIod+4ZXP2
         I0qQi2CxiKWb3IogIv5nN9rLHTN2yTLJv65exdI8Y/v1bUEN4tI5R9fl+Q2xfnUQHfeu
         S/G5WVELdG1IGKtdmAYwzwlrKRxj3ap+tJ0X/G5EIyuJl/pe4gn5hShWT7dvGzxT/jy4
         6xwtK9XLibXrTk64GUTpmmxPw8eNINY13U3cxl8cbxVZHQ58S+64hVro2qYk0NXxthMm
         /IkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IOOUM8KS2eVpKf2azO4j10aXB0CwhQTSsMxRzkswIpM=;
        b=m/DZOOrHkZP+abvGKSUVAyPBQKWfyEqiAHM4wSVNRDNtIiRPdc4z4mryFpUmQ7dxxs
         OzTAH0/l5TAA9Dvoet6rfycViWN56nXdGlU6r9msdAKx5xSK6EbZIYibLdyqp3RuDFTc
         YOsR9ZUYWcx3oejsD2hBDCgdtkCLaon7TW5ITa4wTTkmYcy76+/jaKz1jFF9lKWSsTQ5
         lh0vNEOWCYAe8AjCKi+pTL8AyjR24fQlKp3fMxvKFmUVRUsDH3YHMcjLzxX0P9TVACNe
         bx29c1C968UN6C/dmvZ9QbDlmtLjOY7LIIM0vk9QCHzXODmX69MfMi8o7qWotfE46yYC
         H/+w==
X-Gm-Message-State: APjAAAVzGSoEwpR3rej91pvcABWTa8dMNevCVq6NGd2LTRSQWOvYAl45
        LMmYGQ4ZAMDoFw1AkxAfBvSZdN4xIiUVUeHiFjPqoLcR
X-Google-Smtp-Source: APXvYqwg34bsdfu6Tk2/FTcf2KUPvSczMx3xVPfR7VWOSMUcirpRZhLoF+qAWYXSESMceO8od2C4y/gHLOsabtq1auQ=
X-Received: by 2002:a54:410b:: with SMTP id l11mr1769343oic.77.1553007904607;
 Tue, 19 Mar 2019 08:05:04 -0700 (PDT)
MIME-Version: 1.0
From:   Yauhen Kharuzhy <jekhor@gmail.com>
Date:   Tue, 19 Mar 2019 18:04:52 +0300
Message-ID: <CAKWEGV6aTNGcOcfO5xL+H0P95xh=6dOTdCnvNMrGCxpR1G-aJw@mail.gmail.com>
Subject: bluez: Disable GATT client at non-initiator side?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I am trying to implement GATT services with bluez API.

If external device initiated LE connection to device with bluez
running, bluez start to discover services at initiator and, if one of
characteristics required pairing, request pairing. This is not
intended behaviour for some reason in my case, so I need to disable
GATT client if bluez is not initiator side of the connection, similar
to ReverseServiceDiscovery config option for non-LE.

Is it possible by any way? As i see code, device_attach_att() function
in src/device.c initializes GATT client unconditionally in both cases.
For debug, I disabled client initializing and this seems works for
external-initiated connections.

-- 
Yauhen Kharuzhy
