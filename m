Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F95C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 19:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjEWT1X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 15:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjEWT1W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 15:27:22 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166AA11D
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 12:27:21 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6af78ce91b1so2000237a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684870040; x=1687462040;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O1M1+iy7xvu28C6Xefk1VhIUzyszAU9dTjpFJN032z4=;
        b=sNC7uomzRz5D6rwM3kSgye2IVduA+xkcmXPtZRTpSX2rIQspGg29/kuMFkgutoI0zX
         NgvbUzD/I59N0Umt60VSbqFP1Gg4ML1L76bsWlOYO2A+SPHngQj32MjqLZix4m/669v3
         33SgOg+TOItiU4stGbCnGfBtFo2eh14Wi8chNMOVoZ2MNkL4/5j+kSUAhoSWdGqNli+u
         3vva4oN2nyGKZ309ohUCfMsrT/tEjCtqGJCOVG80e05FXZvcsTa5CzTa6loniZoXwgmU
         atD9bwLn8OSBOQE8209dyUUTvdAfKWHpstemzkuaewkCSsgWu6B2ogbujOULajPSodEC
         HE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870040; x=1687462040;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1M1+iy7xvu28C6Xefk1VhIUzyszAU9dTjpFJN032z4=;
        b=ffFjMl0rngKRgBRqKm5qfQHPaYSbFFsDMOxpWqRIY2/bnWIW7hWgPuRJUxGYEcyBTg
         ZvUzpKkkWa/iAwaL8LxuRYwp4wUdmveU0NM3NYRcHDvbkunwtE0Y57vEb4JCoL2ZusZc
         BKbRWSbcUgfN9UkvKlrWj8mYeVV5AV8E9lfSmLGFixSypNk/ylD1R/x+OiYrY4Z6VWLW
         5yv85l0zLu8ZZ9WeGUfqMYBDg8x7u2jZ11gQ+rS1TFFdITJQ8IKu1GTCjlIk4+dStGNW
         CkFh3+1+YEQfhgjBxiXvjI8ybqZlTiylwb8V/8QQf0QTtFRKY0tLr5EXR6o3GFfLBHHh
         WoDw==
X-Gm-Message-State: AC+VfDy+8kGe/tZvroo/ssjum+Ny5V2T4c2hpfLoTB6JWZG9A5oH7Ujk
        mv/NpJlwIcMoZR9ng/t9Yo9WXOGUISw=
X-Google-Smtp-Source: ACHHUZ7nkxyGy0C9ugbQIGmoCvYWghm17r/k3V+x9fMng8q4cpCuqFZN+tL5nWYe6J5pw2EH9ZFcvg==
X-Received: by 2002:a05:6830:1087:b0:6af:70be:a319 with SMTP id y7-20020a056830108700b006af70bea319mr3143044oto.38.1684870040206;
        Tue, 23 May 2023 12:27:20 -0700 (PDT)
Received: from [172.17.0.2] ([70.37.167.37])
        by smtp.gmail.com with ESMTPSA id n2-20020a0568301e8200b006aaf3e81baesm1859644otr.24.2023.05.23.12.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 12:27:19 -0700 (PDT)
Message-ID: <646d1397.050a0220.11659.ab55@mx.google.com>
Date:   Tue, 23 May 2023 12:27:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6874702422671275061=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] iso-tester: Make QoS parameters reflect the tests names
In-Reply-To: <20230523174906.2751379-1-luiz.dentz@gmail.com>
References: <20230523174906.2751379-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6874702422671275061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=750362

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      29.41 seconds
BluezMake                     PASS      1055.99 seconds
MakeCheck                     PASS      12.39 seconds
MakeDistcheck                 PASS      169.26 seconds
CheckValgrind                 PASS      277.56 seconds
CheckSmatch                   PASS      381.92 seconds
bluezmakeextell               PASS      113.38 seconds
IncrementalBuild              PASS      918.82 seconds
ScanBuild                     PASS      1221.52 seconds



---
Regards,
Linux Bluetooth


--===============6874702422671275061==--
