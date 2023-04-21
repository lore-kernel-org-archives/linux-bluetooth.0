Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465B7C77B75
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Apr 2023 04:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjDUEN4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Apr 2023 00:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDUENz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Apr 2023 00:13:55 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE59D525C
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 21:13:53 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3e8b3aed55bso8346751cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 21:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682050433; x=1684642433;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zOFoPj3yh0u5JFfeV/0E2qBlbwjRpdVlS6ww7QdXg8Q=;
        b=N11vX1UDWqDHyM7cBS3Wyo5cRaDJrN4taiJ3wOMVkowsBIuxI/TwJy1d7J8umaKelz
         SNHmiD/3fA2R0Y+9XB2Dei9Wo1mLboaCF4wSnnHRY1/Qdu4Oyyw1//jAEaR0HbNQvlsp
         kNyEEHX6aFY0PU6a10LhDPXtyzaIjceyjpARxKdYkKIoq2TW5MBzxPWSl8uRNdHaROUt
         GpyP5nTj5wJ1G/0AJXEJYfX8MDz+WCwvZ8JiD30cfP33nGr4on4LiayJE/kT5rZIQIsx
         AOFSDbieMRpi2qhQdFkQDQrKR1THRlroZ6GiuXUGt8jHfjK8bdHrKcEZyILJJY7EOfoE
         80Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682050433; x=1684642433;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOFoPj3yh0u5JFfeV/0E2qBlbwjRpdVlS6ww7QdXg8Q=;
        b=ism3uAXgLY/OOZ3dVob0oayXld4LUgO+yrKb/gnwwuWii9EQJVdFNZ2UZj+m1M5fds
         5pABe1RqdECfzQ5L/31BBVH1BHNCLlstKCLqlUFZjBLfg0iCPA52hyMjHrQflwRN7pxH
         iyjXEmeFxmfJSoEHEnBdfaUJ1ZozHveO3XMV3bszYknyW/qeTL9FhwGnATW+nQFDRrGb
         jNsGAbUzOJNzjasl39/oKYCWTm4GsB4JgOKyxTn3OtyY7grzGj1ESmPuaKML2fZIRsCm
         n4L1qvM9hAxVzycPPglxXBEOAOLa9l67t/aek8kpdOKzS3gd0lh+N0w8EVl48X0JpgWn
         skuQ==
X-Gm-Message-State: AAQBX9eQLssa1ucJBoz5LPabv3wxjfTpYcf1K+DIbMjev8SWXbEv6L7E
        djST8wL6ONpaQPk54XukVhw0J/vnbts=
X-Google-Smtp-Source: AKy350aGdWsO4JsHJ2bH4Td/gDJWMxY2Cbd5RYwUJVcf6jdyz6rziDAzJ0EO3rLJ1HyxFPatWwBj4A==
X-Received: by 2002:ac8:5c03:0:b0:3ef:6056:e89c with SMTP id i3-20020ac85c03000000b003ef6056e89cmr10486qti.35.1682050432629;
        Thu, 20 Apr 2023 21:13:52 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.200.32])
        by smtp.gmail.com with ESMTPSA id e8-20020ac81308000000b003eabcc29132sm1019164qtj.29.2023.04.20.21.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 21:13:52 -0700 (PDT)
Message-ID: <64420d80.c80a0220.fd2fc.4dfe@mx.google.com>
Date:   Thu, 20 Apr 2023 21:13:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4457412474277148552=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, aarongt.shen@gmail.com
Subject: RE: [Bluez] obexd: agent: Use if-elseif instead of multi-if to check error message
In-Reply-To: <20230421024731.42130-1-aarongt.shen@gmail.com>
References: <20230421024731.42130-1-aarongt.shen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4457412474277148552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=741938

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      27.08 seconds
BluezMake                     PASS      871.37 seconds
MakeCheck                     PASS      11.83 seconds
MakeDistcheck                 PASS      150.89 seconds
CheckValgrind                 PASS      248.84 seconds
CheckSmatch                   PASS      339.22 seconds
bluezmakeextell               PASS      99.80 seconds
IncrementalBuild              PASS      726.24 seconds
ScanBuild                     PASS      1046.37 seconds



---
Regards,
Linux Bluetooth


--===============4457412474277148552==--
