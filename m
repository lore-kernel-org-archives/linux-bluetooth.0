Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09023CDB465
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Oct 2023 21:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjJNVQQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Oct 2023 17:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjJNVQQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Oct 2023 17:16:16 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92FBCE
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 14:16:14 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3af609b9264so2145547b6e.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 14:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697318174; x=1697922974; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1XTbyfQJ4E9/+d4qhWbjp05QbKekFcqYNoBUprXU2qo=;
        b=h6hLbtH0F3oWyficvPxxbQMDq2iWR0j/AiladWHy+91H6y4Dbi9lQXhk9xNF6TbHQT
         Hrw2SoQkxD65zoA4wbIzDxHc9wokDqZ7+/jEgO7YmggO7u/XOj14dr7ayOqxlspX9zpU
         3ECOp38bu6WgQWh9XZ19Rs0+acw1l9TQs0t2IxJGl8Tsf1Krz85pneK0MwMWeSRIjKBa
         WKno2u7XUka+3Tb0E8uqhaVs4gL47Fkax9EfSwY+YORpEqGHaGWaj8MTm6FNGAo9gR/n
         3Ybz6HeFvGvYFfKUhaMnTb1afzk5PQuqvOEaHuQDeKiVOdKwgSXPJA7h0Hf4C7gHOgL6
         s9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697318174; x=1697922974;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XTbyfQJ4E9/+d4qhWbjp05QbKekFcqYNoBUprXU2qo=;
        b=t4SP528PVTNgJFL8YCtM/1AbmSYfwfScOb5RAm30kaJLkMdcOMJ4vy3Yvl88mtN3QY
         5KIL4GUFEdsrFrDuhcigBkxx4rE3Dk69ylBJlxqEIYXX5TuZ21zfYPryVb/8DTrAO6cV
         u/NlYFGBjYCUfR5XHKYNc96BshC/mRnGI9Yq6jDW6s/miMXIHJt1iuhMbf0kc1x/MUxr
         qejqipzi/GnOEs/Q+ymBsmkoFGmdGdLZhuTEKDvhE2sVqfzdASq/JCMFlGxvrP0kgCzv
         7Fds7gW1NDGHLbtJCIeI88miEkTHhwT+QTwXcmQpd9QwBsLhswuTOm++AKJUqdvhQfxd
         Qo0w==
X-Gm-Message-State: AOJu0YxWR69+NL9f/sDhMVb4haJCpAYO0RelEh0/oU/YZa7hve6ggTdA
        e55o5xEOPhb5K4PQz91Nqbg3j63ZFcQ=
X-Google-Smtp-Source: AGHT+IF3JsODNrDpXCnysDv/E/6i5k2zVKhpcZEF/K6zf6j5alJ9pERE33CfD8FmC6wcN0YravFCdg==
X-Received: by 2002:a05:6808:989:b0:3ae:1031:594 with SMTP id a9-20020a056808098900b003ae10310594mr31630199oic.34.1697318173919;
        Sat, 14 Oct 2023 14:16:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.154.0])
        by smtp.gmail.com with ESMTPSA id v5-20020a0ccd85000000b00655e428604esm1966465qvm.137.2023.10.14.14.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 14:16:13 -0700 (PDT)
Message-ID: <652b051d.0c0a0220.85d2e.8327@mx.google.com>
Date:   Sat, 14 Oct 2023 14:16:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3878334311445795490=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] btdev: Do not call auth_complete with NULL conn
In-Reply-To: <20231014194120.1884126-1-arkadiusz.bokowy@gmail.com>
References: <20231014194120.1884126-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3878334311445795490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=793242

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      29.36 seconds
BluezMake                     PASS      900.58 seconds
MakeCheck                     PASS      12.56 seconds
MakeDistcheck                 PASS      178.02 seconds
CheckValgrind                 PASS      277.59 seconds
CheckSmatch                   WARNING   368.83 seconds
bluezmakeextell               PASS      119.38 seconds
IncrementalBuild              PASS      753.77 seconds
ScanBuild                     WARNING   1122.62 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:420:29: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1083:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1334:24: warning: Access to field 'link' results in a dereference of a null pointer (loaded from variable 'conn')
        pending_conn_del(dev, conn->link->dev);
                              ^~~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============3878334311445795490==--
