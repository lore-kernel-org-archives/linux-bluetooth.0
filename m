Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62224EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 22:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGLWlg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 18:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjGLWlf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 18:41:35 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0871E1FF0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 15:41:31 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b73b839025so26686a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 15:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689201690; x=1691793690;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1ney/XvYEIVM6mcuQADe9AthIvZJ+LNZIjZNMliIRNM=;
        b=DCtm8Xhu34pyS5j2WNAWwsGwyIqR1TL0MvRjVFwJdIgYzAad/F2stV8Rjew4F84nPq
         mtCzGfmIy3AJKs1BmhKdBCusistilzzdTScEjcfas5Tz0XqNmjzjACAx2Ww/c8MMvs/V
         SKv7K08GOlxaBUcNL9VdFhIxpIpcpyOFn6YNdeiou2AssfoJStxarAaOPz78kqx431ZC
         JiwJI5NZYiPKMbwEgQrNYvpe3D86MhwhlQ5/wu00QYLaY+sbwKW6OxSIH3o5p2oRit5o
         OfGTqOfsDI+H5Htb8+vZWqLVfFWbvm4OOmxyZ1GKBjZ7K36uAcLofijBjNBX36ill357
         Wx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201690; x=1691793690;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ney/XvYEIVM6mcuQADe9AthIvZJ+LNZIjZNMliIRNM=;
        b=k85xhJNpfuZqcaC4zjwyyL5/xOM1GZxy613QJRTAPHoyJcWWVZiBkUTsLc4sPTc63K
         agJIzRRR3AOOf8JmCSvpRvXkMCKXNHNVH5g/yQuh/+EcTZ/bg15p4KxarF6dDXuD9+4t
         nGLX88dLFqIyudcbn+DbZ/0wEmpXc8YIONsLBExld7s400/mrgTgJyNo0J0fvgQl4sam
         ID+HKdcOgQ2V/Mzc7bsA/jJWI4tSkkHmnXOy7UBTkUsAxHBjAtV3LkbWpRqhEnYe8AKS
         WVgWBGFeUMDcR6+DxznePyNyaRsuUOAXUUVvaD8aL3IEaO7jn/1kJ+n7u67v+DkD97R4
         DZFQ==
X-Gm-Message-State: ABy/qLYXd1dAWjuX8fOExh6m4gir1/TXTpE7VZerlkn5077Nh0OgkuSd
        WzynED+L2RUcuWuo8QoTPJ1t8TYy4Y4=
X-Google-Smtp-Source: APBJJlFBGD0RitbREwROuy+pGI+F7BJRHK6ZDFb9yhm6ZblmTMywCsP3YEyhv/xv6j4/BroDBJP1ug==
X-Received: by 2002:a05:6870:5ba1:b0:1b7:4870:9075 with SMTP id em33-20020a0568705ba100b001b748709075mr100727oab.6.1689201690064;
        Wed, 12 Jul 2023 15:41:30 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.173.33])
        by smtp.gmail.com with ESMTPSA id 124-20020a4a0682000000b0051134f333d3sm2281901ooj.16.2023.07.12.15.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:41:29 -0700 (PDT)
Message-ID: <64af2c19.4a0a0220.fc79b.f013@mx.google.com>
Date:   Wed, 12 Jul 2023 15:41:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2622323322866279839=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/5] shared/ad: Use util_iov_push_* helpers to generate data
In-Reply-To: <20230712193854.1862996-1-luiz.dentz@gmail.com>
References: <20230712193854.1862996-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2622323322866279839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=765012

---Test result---

Test Summary:
CheckPatch                    PASS      2.76 seconds
GitLint                       PASS      1.54 seconds
BuildEll                      PASS      33.65 seconds
BluezMake                     PASS      1194.55 seconds
MakeCheck                     PASS      13.10 seconds
MakeDistcheck                 PASS      191.75 seconds
CheckValgrind                 PASS      314.67 seconds
CheckSmatch                   PASS      435.57 seconds
bluezmakeextell               PASS      130.95 seconds
IncrementalBuild              PASS      4989.68 seconds
ScanBuild                     WARNING   1400.37 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:191:9: warning: 1st function call argument is an uninitialized value
        return be32_to_cpu(get_unaligned((const uint32_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./src/shared/util.h:33:26: note: expanded from macro 'be32_to_cpu'
#define be32_to_cpu(val) bswap_32(val)
                         ^~~~~~~~~~~~~
/usr/include/byteswap.h:34:21: note: expanded from macro 'bswap_32'
#define bswap_32(x) __bswap_32 (x)
                    ^~~~~~~~~~~~~~
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:201:9: warning: 1st function call argument is an uninitialized value
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


--===============2622323322866279839==--
