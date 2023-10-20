Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E80BC0032E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 20:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJTUMW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 16:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJTUMV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 16:12:21 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB173D63
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 13:12:15 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-457c057bdb5so498507137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697832734; x=1698437534; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rBM5TzpFi0HCqH8JqE+pbn4CeHzCghPd0dwJZ6obmxo=;
        b=ACMFuAQBBSPVe3FX7T8MqU5RV6LX3YIp+PWreWxHuJ7dVZk6K9Fv4XSz+DIp+U/ZHa
         nmiI6tiZCYdIa2vbJtLzPqFxLTgC6tv2lhaUiQYVENhX2pyqB+xY1YmtU+TH7B1uljnX
         N3QkqvVwIRe50Hfi3mCO3X2QEuJ7Kg3hzCEeYc9CV+A9UqS3bQ5IMH0ufyYGkqJlyMwM
         lBjJeUpjRTlgm5H0YMvyByV2EEhuzhcBQbIHdM5i51QRKv/lW1/XWjCxDy6xO/XkYhno
         W+R5moEGYgoBRlTYRrcP5HEYV6VBIpza8JZoYT5VR8AtQPlKmqlsg/kLVNWvSGXiCQGn
         gnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697832734; x=1698437534;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBM5TzpFi0HCqH8JqE+pbn4CeHzCghPd0dwJZ6obmxo=;
        b=O6WpYyqzgoXsFJ5jgSc+CH7Tx+s5u42E2pGMBqpjpy5xwZIbvjjxAfF3SaiA8kc+q5
         faRpX0wJha0BzzYeklVz5HzStvJEXmsCFI1YYV1l51GFXfnkcmx7ZZu25G26QqN0m618
         fvBKRjrfhKI1XeanWZ/f+2pYuEUA37PGKxWK16vhHeQHI3F9QlDs5Vy1adE1uSwagOU7
         v9Sfp3sMUx4lQTV8onF0RF0lwOST166mb6V3NFVAyTJDpuPk1B2aE+PlI+q+/EO3+4Od
         0Jt4x3R4MVB7jvsErItrtTqblxvOAOVbluNtBMNSe9unQ5skf/WVmbf/3hC/f002rt2c
         GORQ==
X-Gm-Message-State: AOJu0YwTUR+NL5rk/dIGWpdwVltK5qmBeKrFOnKYdqtOoo/RZPTftCC6
        arE710SJkEZYbckBtoIsgAWEawS/Nq8=
X-Google-Smtp-Source: AGHT+IFZkefMpwhFV2hkWpY/xTT4pobXXloDNRyZX0tdJIsWRRRSS7JUrh+vWWLMJ95PQOjwmcXpjA==
X-Received: by 2002:a67:c283:0:b0:457:bc46:8ba3 with SMTP id k3-20020a67c283000000b00457bc468ba3mr3043185vsj.9.1697832734552;
        Fri, 20 Oct 2023 13:12:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.76.129])
        by smtp.gmail.com with ESMTPSA id vv6-20020a05620a562600b007770d47c621sm860879qkn.66.2023.10.20.13.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 13:12:14 -0700 (PDT)
Message-ID: <6532df1e.050a0220.351c3.42f2@mx.google.com>
Date:   Fri, 20 Oct 2023 13:12:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3897125527613006995=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/4] shared/util: Add util_debug_{tlv, bit} helpers
In-Reply-To: <20231020180834.3010421-1-luiz.dentz@gmail.com>
References: <20231020180834.3010421-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3897125527613006995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=795210

---Test result---

Test Summary:
CheckPatch                    PASS      2.89 seconds
GitLint                       PASS      1.37 seconds
BuildEll                      PASS      29.71 seconds
BluezMake                     PASS      1085.10 seconds
MakeCheck                     PASS      12.59 seconds
MakeDistcheck                 PASS      185.35 seconds
CheckValgrind                 PASS      284.84 seconds
CheckSmatch                   WARNING   377.39 seconds
bluezmakeextell               PASS      122.42 seconds
IncrementalBuild              PASS      3643.09 seconds
ScanBuild                     WARNING   1170.95 seconds

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


--===============3897125527613006995==--
