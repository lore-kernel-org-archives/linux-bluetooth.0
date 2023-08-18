Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7E0C7EE24
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Aug 2023 16:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378435AbjHRQKa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Aug 2023 12:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378524AbjHRQKV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Aug 2023 12:10:21 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C936F3ABC
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 09:10:19 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-56ca1eebcd7so709257eaf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692375019; x=1692979819;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nZLIUm8yk89BJA4GM9+USL+hNnl8Zh/3t50TbnoS3J0=;
        b=WIlidvTkqtNw7nsuGlyAjrvesrjCf4JOHars6h7JQRuSbY+2u1ozTcnCr13RUKvEAg
         /QyDQ8KBAvMfNgeQLyzJZRILGTyVxrk9Y6ksLIq71UZqKOpwnEvEsCLnJUOSlIeAv5dN
         fATyU+jv9liLadStgE1QX4PKM80MWDcUf2Tvg4IiH/pBVJ8Hv05GOx5WrWk2g8gbaKdc
         OsaNIxlmLZB0hGgUlgGYIHIb9nDT0YCkS4n4Oer6j4sRUrkiL3VTznhzxNCh9SThGryt
         wPWw9KW6aaVh9j/V725vKdnSdGbvMzxLraZL1fIQ1+O6jFv72GmUcoyoMDB5T9KCEWL7
         4p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692375019; x=1692979819;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZLIUm8yk89BJA4GM9+USL+hNnl8Zh/3t50TbnoS3J0=;
        b=IpwUbO6nxnvECAFSEliKJA/QDXjjaL/wZ2iQ8uRQO0BWJLoe7PselIjNV4AwBdRGAx
         dZsyQW9A3ytZoDrraCB2xth2jM19xtk/LIgCQmnvXEnpEL3S05+WTq4zA/VR7RPUInRi
         hB6xabONmZdel4nCZJq/RYG3YfKLQT/SwCGbQYvj0EppdgawP9ZVXvpfE/49iRPujokg
         8i5TP182sR8rLZVEgp4qYTKVq2121c5VzNt+zuQhSMMiu3iodH6h+vcgne3zZ+cU9WWe
         ZjwLeGAFG2eXBfIpk+O9swzBLVd89Z+A/cnCGerjooguQx9GXBc/8Bn2/6E+PI3Z0g2a
         xLUw==
X-Gm-Message-State: AOJu0Yz4fRX1oWIfocOS0QCJVdpOYUgpgwkwPlf5fgsALZI3mHW8pzNy
        QUvBCIp4RgF2Dj3hNOMTfEQRc0pV62U=
X-Google-Smtp-Source: AGHT+IGzTR5LB0/XLS4DV10vHaSzxIwcqTwr2BXFEJnSkJiGQUD7PSk0HYJXlO7dRhRq/JWP3lukLA==
X-Received: by 2002:a4a:3c17:0:b0:56c:99e9:4d92 with SMTP id d23-20020a4a3c17000000b0056c99e94d92mr381964ooa.3.1692374997080;
        Fri, 18 Aug 2023 09:09:57 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.72.144])
        by smtp.gmail.com with ESMTPSA id i14-20020a4aab0e000000b005678320f1f2sm855319oon.13.2023.08.18.09.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:09:56 -0700 (PDT)
Message-ID: <64df97d4.4a0a0220.b7bd8.5a6f@mx.google.com>
Date:   Fri, 18 Aug 2023 09:09:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1238106813073042847=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Configure broadcast endpoint with BASE
In-Reply-To: <20230818133552.20673-2-silviu.barbulescu@nxp.com>
References: <20230818133552.20673-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1238106813073042847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=777409

---Test result---

Test Summary:
CheckPatch                    PASS      1.67 seconds
GitLint                       PASS      1.00 seconds
BuildEll                      PASS      33.79 seconds
BluezMake                     PASS      1222.66 seconds
MakeCheck                     PASS      13.32 seconds
MakeDistcheck                 PASS      195.98 seconds
CheckValgrind                 PASS      330.86 seconds
CheckSmatch                   PASS      453.69 seconds
bluezmakeextell               PASS      134.44 seconds
IncrementalBuild              PASS      3207.96 seconds
ScanBuild                     PASS      1441.11 seconds



---
Regards,
Linux Bluetooth


--===============1238106813073042847==--
