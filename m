Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A34C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 23:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiKIXl0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiKIXlY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 18:41:24 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D66919016
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 15:41:24 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id x13so346420qvn.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Nov 2022 15:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T9BnTH3Fq9lX6gbF0mGLN7++7OOBREsnqwTrtBtlDOw=;
        b=Pr2w22HOyeHFW7ihNW5/Lqw+55+H2Z+E4YZmwMa4FwD0Cxk/XaYN4aSAnmIMaHoxgp
         kl2rk0xj7T0jEgWuSB/bWwpuQDfGqOxBbBDFSQvC7H51jOAAY070ZW22P05+SAeYLt9C
         hd5quQB0Ot4WyMaRArHj7RPhwbNc6WpgiA6HnooE2VqYgFegFFC18NaOkJv2KljAwRN4
         5JnSZroSTSIl+kTIFjsh0fltoWBj644mgI8JSWe30JxPlsqWsmA20gJ+qIdyxXQQ9Fk5
         3YPfb2kOSVFeNVR7kJUWj20K3AL0m+RcdM1383HEJ5vh7G+6uAPQtAWpE15rmCZf3Ba8
         h3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9BnTH3Fq9lX6gbF0mGLN7++7OOBREsnqwTrtBtlDOw=;
        b=xtMt9kc+tuLParkHZmO4fMHcJq7mT5NGtCO9IJSGYERrDqIJesETomSDlgu62sTcEP
         D/ppQXXJc4U8qvuz2WaIlgNO5LqvEai1pydIN7VYcwlqtqfNh+Ii2gCuqk7dEWaz8ClW
         yAkMPb/isHHa5DnMzIjt6kif6X7R9ktN31VxnRAk61fJSGm5022ZcCB+4f+3HjINEGfl
         hR2guPkfLOaLc/aVRdSRPT/HmmPTnjT69D+hK4iN/6bQRShEDxBrhFH0zLLvV9pKWU/6
         kJ35UItosyI5Oq0eHHyBTnf3X/IrqLSo3Ntk5yoND48tRqm1p6w3tGx9iEwAIawBE4Ie
         rilw==
X-Gm-Message-State: ACrzQf3jJxVY7qHzazWjxtiOOj3ZyKLh9mehHLiR8TQ12GiqlSWQbDAZ
        h7+T+AorExETmqQrz/Hr3KPpgJJ1vuB79Q==
X-Google-Smtp-Source: AMsMyM6t+iK+Mh2gGaKRakXThoRv+nTPi9MMpJgJwQljz+6feF9Iw/0sy31lzAdIXr+TCCUslE58ug==
X-Received: by 2002:a05:6214:5292:b0:4bb:634d:6505 with SMTP id kj18-20020a056214529200b004bb634d6505mr57646529qvb.61.1668037282888;
        Wed, 09 Nov 2022 15:41:22 -0800 (PST)
Received: from [172.17.0.2] ([20.168.255.255])
        by smtp.gmail.com with ESMTPSA id z10-20020ac87caa000000b003a50d92f9b4sm10453492qtv.1.2022.11.09.15.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 15:41:22 -0800 (PST)
Message-ID: <636c3aa2.c80a0220.1694c.ddcb@mx.google.com>
Date:   Wed, 09 Nov 2022 15:41:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2959600679409093291=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] shared/util: Add iovec helpers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221109222947.1137901-1-luiz.dentz@gmail.com>
References: <20221109222947.1137901-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2959600679409093291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=693816

---Test result---

Test Summary:
CheckPatch                    PASS      6.33 seconds
GitLint                       PASS      4.08 seconds
Prep - Setup ELL              PASS      28.02 seconds
Build - Prep                  PASS      0.82 seconds
Build - Configure             PASS      9.02 seconds
Build - Make                  PASS      878.85 seconds
Make Check                    PASS      11.77 seconds
Make Check w/Valgrind         PASS      297.61 seconds
Make Distcheck                PASS      244.45 seconds
Build w/ext ELL - Configure   PASS      9.06 seconds
Build w/ext ELL - Make        PASS      86.87 seconds
Incremental Build w/ patches  PASS      411.79 seconds
Scan Build                    WARNING   1200.99 seconds

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


--===============2959600679409093291==--
