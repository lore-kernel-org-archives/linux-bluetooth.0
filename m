Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC3EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 23:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKIXbq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKIXbp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 18:31:45 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0733CE012
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 15:31:45 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id v8so193161qkg.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Nov 2022 15:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2xyQ77ywJHyu4Ght0Um3uDRaZ0Zd9vqRWGDORGjgoDI=;
        b=GTou4DAwfYullAg066eBGa3BiXtupDArGAHD1ZOkZK8tnEq4DDbGLOwV/YZNVgtHUr
         PPpguN2VdKh9QZWN1u45Bd1SdvPxw+koYN+yIKhw6Slpp0ks0skn0nsXKbsWV16cLtCN
         e2pTtEYDa0QyGsJ5oa9/DoiDfGf5sMqoYkR2EW+hiaa2ZTaaEmSVBab40aXM/tvD1gOX
         yjqDndPGcRI1U03fBPD/m1Dv4cdW17k9UW1xvu/J9qcyhdx8SzgFkrR0h0TvUtkHYAsN
         IYmz+Zp4Y3oxVIx0S4z0R4cdwEqZHdb7Q1xD4l5c4LjL+15NjDZ1wGrywYwd/48RBHby
         6RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xyQ77ywJHyu4Ght0Um3uDRaZ0Zd9vqRWGDORGjgoDI=;
        b=5kOGx+nTNmHUsE+ejBmMwagAUm7LobbpOtiGpg/ARVzglr7qQOaDcn+Y0q6P2FKUX8
         tQ40Sel7Byli306WN9QZP5mMCjJUKg3ot7vd/k5bjNv7ZAroXGSiO9Az15Q3HaskyoxA
         pdzthUHGcByjFes8ZIzgB9aOSyFpYVPe4u1LMEiGhRuAwqhKRg1FpXBF3EIajqe1CjGd
         k64f0n30LVLXBdQXHuU4MXVFyt52uDoFsvuGQ7342cSamDBFrflh2WFrNoXgHAAbNN3t
         eBimjVHYDY67tRQmKjxSqL4W6aW8AIPk8OGPOB0wEGthboA+OITBnL3hk+O05M/k5xch
         5rXg==
X-Gm-Message-State: ACrzQf1dVLs9P4KsbOpoMSjnVoH054jpNsCbch7Kw92dlJitrszd1NgO
        eKuUAllg07hnU0thK62Vr6pA8bOdxBFuwA==
X-Google-Smtp-Source: AMsMyM7GFAtpanozUaWC/i5ULv/nzSu4Bzg4HrqLcN7ifDUeH9+NhFz6TCpUs8zYYmJ2iiNgDQ816g==
X-Received: by 2002:a05:620a:1007:b0:6fa:1ee5:d7b8 with SMTP id z7-20020a05620a100700b006fa1ee5d7b8mr41537867qkj.645.1668036703905;
        Wed, 09 Nov 2022 15:31:43 -0800 (PST)
Received: from [172.17.0.2] ([20.12.0.140])
        by smtp.gmail.com with ESMTPSA id u10-20020ac858ca000000b003a5172220dbsm10857135qta.8.2022.11.09.15.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 15:31:43 -0800 (PST)
Message-ID: <636c385f.c80a0220.bf74.f383@mx.google.com>
Date:   Wed, 09 Nov 2022 15:31:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1207877955710235757=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] shared/util: Add iovec helpers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221109222930.1137690-1-luiz.dentz@gmail.com>
References: <20221109222930.1137690-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1207877955710235757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=693815

---Test result---

Test Summary:
CheckPatch                    PASS      1.51 seconds
GitLint                       PASS      0.99 seconds
Prep - Setup ELL              PASS      27.06 seconds
Build - Prep                  PASS      0.84 seconds
Build - Configure             PASS      8.58 seconds
Build - Make                  PASS      834.09 seconds
Make Check                    PASS      11.92 seconds
Make Check w/Valgrind         PASS      292.31 seconds
Make Distcheck                PASS      237.46 seconds
Build w/ext ELL - Configure   PASS      8.66 seconds
Build w/ext ELL - Make        PASS      84.90 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    WARNING   1104.32 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:165:9: warning: 1st function call argument is an uninitialized value
        return be32_to_cpu(get_unaligned((const uint32_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./src/shared/util.h:31:26: note: expanded from macro 'be32_to_cpu'
#define be32_to_cpu(val) bswap_32(val)
                         ^~~~~~~~~~~~~
/usr/include/byteswap.h:34:21: note: expanded from macro 'bswap_32'
#define bswap_32(x) __bswap_32 (x)
                    ^~~~~~~~~~~~~~
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:175:9: warning: 1st function call argument is an uninitialized value
        return be64_to_cpu(get_unaligned((const uint64_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./src/shared/util.h:32:26: note: expanded from macro 'be64_to_cpu'
#define be64_to_cpu(val) bswap_64(val)
                         ^~~~~~~~~~~~~
/usr/include/byteswap.h:37:21: note: expanded from macro 'bswap_64'
#define bswap_64(x) __bswap_64 (x)
                    ^~~~~~~~~~~~~~
2 warnings generated.




---
Regards,
Linux Bluetooth


--===============1207877955710235757==--
