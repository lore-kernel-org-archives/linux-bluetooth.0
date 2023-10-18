Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D38CDB483
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 22:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjJRWHr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 18:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjJRWHq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 18:07:46 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550C5121
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 15:07:40 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66cfd874520so47240446d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 15:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697666859; x=1698271659; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TmxuLgO2OPFWn/4ZBkovJJHi7q68ANRrEaZMsNWSC8E=;
        b=PHc9RG/vIT45QQCDFMJOIt2wCYUysCMxQ86sFkQKAf1kT05e3zVmX6Li409S8OBinM
         /xU/WLah8JltVZm4lFzMtswVVaJ5E1tFsRy6fQO/umEYIsgM5aJTyGDKAOlUrbr4PMTA
         2aR59xGGn/tP533lntHY3imz7rzGdotdGBCCz69yCGuoSBByCrxspdYuosAcNjTZqGCX
         dF8D8LArbyWnSbJtbOvc+jRSCq6tOecmgU48Pf7zLYK8yJxdgQRfhOkO3PadOFswJApY
         QnJKENXcxXnnKSpLeTRsQBmU/57RPbjf7jjBYWTWgXREamacg0PMQiHgOuHmDl6CSPYu
         I9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697666859; x=1698271659;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmxuLgO2OPFWn/4ZBkovJJHi7q68ANRrEaZMsNWSC8E=;
        b=RY/JPHdBp3xI7cGvx903CG+KJGFp2hGNGEzMjE7h9Fg2/jItzJJ57xA1U3X+WlcXlt
         /UEyeHkjXPYwrs400MIMeZaplFq8x5N3i+HXO9KYcrkMoidcY07KmSzqPVpQDgroaWZa
         yKrTykyx/Zflt4DOK1XZhqp4It6IXPaoyTtv/0iJGJClwA5SSGZEnr74PPsbQNoWR6bT
         vRgKvEgXMcvPbPBLqeeDt+deKwRSOiF22teLoFaV4lSSDAKp9HYkdJ7jnQRTMk7q1q3F
         jdaLVMROFGHzirSUOHoDKl04/xTZQlaXchDNre4vEtjuzOP4Sl0rXrye5wRbp4gd2Sbz
         8iUQ==
X-Gm-Message-State: AOJu0YwkMi6zAlzdNiuuEVCj3lDXGwSJtOEg1eV/G6UlB16pj6y8cg2H
        DL66ohqDarpfXAM9/yM3LQKc0nZfNUc=
X-Google-Smtp-Source: AGHT+IHa03xT7SmblYS3OTipyCpXP+aegNjNHIrhNWX1MqIUGB9/cLnreBRw/JWDRbydRousMDHCog==
X-Received: by 2002:ad4:5bca:0:b0:65b:21c8:2d74 with SMTP id t10-20020ad45bca000000b0065b21c82d74mr642265qvt.6.1697666859325;
        Wed, 18 Oct 2023 15:07:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.43.169])
        by smtp.gmail.com with ESMTPSA id x10-20020ad440ca000000b0066d1d2242desm271107qvp.120.2023.10.18.15.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 15:07:38 -0700 (PDT)
Message-ID: <6530572a.d40a0220.d52be.226c@mx.google.com>
Date:   Wed, 18 Oct 2023 15:07:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7275471775568922457=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] shared/util: Add util_debug_{tlv, bit} helpers
In-Reply-To: <20231018195653.2532882-1-luiz.dentz@gmail.com>
References: <20231018195653.2532882-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7275471775568922457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794477

---Test result---

Test Summary:
CheckPatch                    PASS      2.83 seconds
GitLint                       PASS      1.34 seconds
BuildEll                      PASS      29.80 seconds
BluezMake                     PASS      1041.66 seconds
MakeCheck                     PASS      12.51 seconds
MakeDistcheck                 PASS      181.54 seconds
CheckValgrind                 PASS      281.03 seconds
CheckSmatch                   WARNING   379.25 seconds
bluezmakeextell               PASS      121.31 seconds
IncrementalBuild              PASS      3585.54 seconds
ScanBuild                     WARNING   1135.29 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1859:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:221:9: warning: 1st function call argument is an uninitialized value
        return be32_to_cpu(get_unaligned((const uint32_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./src/shared/util.h:33:26: note: expanded from macro 'be32_to_cpu'
#define be32_to_cpu(val) bswap_32(val)
                         ^~~~~~~~~~~~~
/usr/include/byteswap.h:34:21: note: expanded from macro 'bswap_32'
#define bswap_32(x) __bswap_32 (x)
                    ^~~~~~~~~~~~~~
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:231:9: warning: 1st function call argument is an uninitialized value
        return be64_to_cpu(get_unaligned((const uint64_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./src/shared/util.h:34:26: note: expanded from macro 'be64_to_cpu'
#define be64_to_cpu(val) bswap_64(val)
                         ^~~~~~~~~~~~~
/usr/include/byteswap.h:37:21: note: expanded from macro 'bswap_64'
#define bswap_64(x) __bswap_64 (x)
                    ^~~~~~~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============7275471775568922457==--
