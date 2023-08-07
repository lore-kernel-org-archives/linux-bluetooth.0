Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4874EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 12:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjHGMXb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 08:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHGMXa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 08:23:30 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70BC106
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 05:23:29 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76d072daea2so67798985a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Aug 2023 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691411009; x=1692015809;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KW/h9G2sQnmvvL3tPj9aMQStNpV4bpvAnNghAVtH1I0=;
        b=ZWACSx4K9P3o2/xUHiC8MQ4tu/cm90pbADyGX6ckQEO3+AmwEkKwcnvYGbAuRejvjL
         qKlqtSOhhWHs+PO4n/MiLvREF+/RY9ZjBMKQXf01XHkl4v7Dd8+Dx/gFqdAGaHjgaejs
         ME9p9bpmmQFPrM6pWsLLR/gzeaoQpmuFN2+6cyS+CvGk/QJP7AO0t4pnaMzPxt+ezPfi
         TWb3t1yg7JNWI7/JrIs40OCU2ASDsuKIxSXibDmX1GMAgwyji1DWjtBW5iNdFRkjqCS1
         T5pPrm6mjgtbVSbNG7my82aamXT5abKAk1SO3WynDPpzxpPRuOo4JABg/8gS7yQjaN5c
         fh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411009; x=1692015809;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KW/h9G2sQnmvvL3tPj9aMQStNpV4bpvAnNghAVtH1I0=;
        b=cON4YgDHQN4wCGYfJrwRhO8Ea3jbqoaYw07XliPQk/Kkpx+JNL2b+M3X3DHBkbx+m3
         Ype+fYs6KJPE8YVPQDowx4hGBydGzd/m2xkHSeb1GVH55X87HU2BE5ShddOxYEuMKC8U
         Qim67/78kSpth8q+dlyGx4YUgcrtfjixUDQiUHePghjtOWoQVe6dJyF3f4z3iFN9wKpv
         ZcRRtEygukVRJuRs98HF19s/PmKtkdm9aUfkTmGko/Xvmq5Jk1iobHd6UBkxcNuXGRWv
         Su4Qrrv3A4VB6FABZuutlVdkN2ppx5glrHSztusOLc4/+4jEHOv3iJK0EZilFWc/sJTR
         z9Jg==
X-Gm-Message-State: AOJu0YxEpr4GJjn91AOB6ajkG/KxYdb7ULtlf0Ki5VHHDPvX49tXW2fn
        1A7y9mku9+FMLRbsGIW5+z/ZNB4UD1o=
X-Google-Smtp-Source: AGHT+IFXH7NtZwG6zDQlWWdPQBulxUu0tZtOwUc77XoTWuw2no6+0srdBosuc8J6zp4IobexGiEULQ==
X-Received: by 2002:a0c:e4d0:0:b0:63c:ffe1:41d2 with SMTP id g16-20020a0ce4d0000000b0063cffe141d2mr9637063qvm.2.1691411008849;
        Mon, 07 Aug 2023 05:23:28 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.74])
        by smtp.gmail.com with ESMTPSA id o18-20020a0ccb12000000b0063f82020d8bsm1468412qvk.60.2023.08.07.05.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:23:28 -0700 (PDT)
Message-ID: <64d0e240.0c0a0220.f68ce.37b7@mx.google.com>
Date:   Mon, 07 Aug 2023 05:23:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7826338997361266314=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Configure BASE using separate structure
In-Reply-To: <20230807110224.6024-2-silviu.barbulescu@nxp.com>
References: <20230807110224.6024-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7826338997361266314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773597

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      0.71 seconds
BuildEll                      PASS      27.85 seconds
BluezMake                     PASS      876.32 seconds
MakeCheck                     PASS      12.06 seconds
MakeDistcheck                 PASS      157.70 seconds
CheckValgrind                 PASS      258.29 seconds
CheckSmatch                   PASS      344.97 seconds
bluezmakeextell               PASS      104.85 seconds
IncrementalBuild              PASS      1449.01 seconds
ScanBuild                     PASS      1072.64 seconds



---
Regards,
Linux Bluetooth


--===============7826338997361266314==--
