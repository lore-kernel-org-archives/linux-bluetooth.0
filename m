Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1EBC77B7C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 May 2023 10:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjEEKYU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 May 2023 06:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjEEKYT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 May 2023 06:24:19 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B496518DFA
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 May 2023 03:24:18 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3ef49c15454so7474861cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 May 2023 03:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683282257; x=1685874257;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RyA0GoJwI75K0d/3rCAW1jwayQeAfMB8YQXqt42h2jw=;
        b=RTmZSj6zfOoBkUepNZ/hafQcYkMJTp0N+fqgdQ487YQKa75HrGppwU7gNSx+c5RRvS
         8XTkcVKPnz7sfgVtp+b1RbkSePRpcH446D5L1p95x5vgr+NE8GrG+99UYl70gcyb8zA5
         X0c0NigLLFgTANuWE9Y/q5fZpma9DFeA9r1T3x+DiU3qdDms+ygG5Z8MNQ/xu4V7pId+
         uddzcLOoIVcuiq4lJ1XTCr9UtqanlEs2WuLpYhDgNa9fhZtDGVkgqQwfuEPROzVM0Umi
         9twrQc4aaNcGGbhgYI5csOtMxs5hwz8Rv1bOaVLjDud08W2WjxSITed50vg9rYub7EG5
         X7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683282257; x=1685874257;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyA0GoJwI75K0d/3rCAW1jwayQeAfMB8YQXqt42h2jw=;
        b=K2qCZsZSkEdbigAtKMOnxcowEMwEy8qIVvoj7mJQhu1RJ8txndy4wefuvjuhXyLnvo
         1+aTR7KkyoxlLM1iW4hmw4K5LzpdnBgwWAgucfMWqA92YOSLvNXw1KPQOodfwiiciwtL
         qk4Y7jXber3TRcrDVljLkbV1mljb8TZ6PdH9ozGIAE7SctjXmIraUmrlLdj2MurCc3od
         j2D46T76vocQGMw6m9PmCPbuCJFb2YbpAZ2ePngieaPP2143sJrV5LatpUzeynitPj9Z
         QzykLKkv2SyQPQYx7Oi5OFLImJuLpvOFeXCxvUeTfVf5yUsxoOtbT/if05LGize6C/7n
         TREQ==
X-Gm-Message-State: AC+VfDyl5q4ZjfV59QkwvnNvT8xMUl8zL28V7/R/tAcUBzNNjEB/2ezn
        ww28ptfvY8n1SqCv1/4V1b3k+vrijLc=
X-Google-Smtp-Source: ACHHUZ7nxxQKp7ZfPJLfWxt4cxxfjd2yNcx7DOj69+FE4RzvfTp3cK1FMUF1jloOjVPY9kwek0u84A==
X-Received: by 2002:ac8:5c10:0:b0:3f1:be88:7178 with SMTP id i16-20020ac85c10000000b003f1be887178mr1679959qti.42.1683282257304;
        Fri, 05 May 2023 03:24:17 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.200.50])
        by smtp.gmail.com with ESMTPSA id o11-20020a05620a130b00b0074f1ff2e0aasm473177qkj.46.2023.05.05.03.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 03:24:17 -0700 (PDT)
Message-ID: <6454d951.050a0220.cf39a.15fb@mx.google.com>
Date:   Fri, 05 May 2023 03:24:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2923051421073040169=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: [BlueZ,1/5] lib/uuid: Add BASS UUIDs
In-Reply-To: <20230505082943.92033-2-iulia.tanasescu@nxp.com>
References: <20230505082943.92033-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2923051421073040169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=745222

---Test result---

Test Summary:
CheckPatch                    PASS      3.69 seconds
GitLint                       FAIL      1.98 seconds
BuildEll                      PASS      27.18 seconds
BluezMake                     PASS      876.48 seconds
MakeCheck                     PASS      12.32 seconds
MakeDistcheck                 PASS      154.47 seconds
CheckValgrind                 PASS      249.05 seconds
CheckSmatch                   PASS      338.42 seconds
bluezmakeextell               PASS      101.88 seconds
IncrementalBuild              PASS      3620.01 seconds
ScanBuild                     WARNING   1030.84 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,3/5] shared/util: Add iovec helpers for pulling/pushing le32 and le24 values

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[BlueZ,3/5] shared/util: Add iovec helpers for pulling/pushing le32 and le24 values"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:174:9: warning: 1st function call argument is an uninitialized value
        return be32_to_cpu(get_unaligned((const uint32_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./src/shared/util.h:32:26: note: expanded from macro 'be32_to_cpu'
#define be32_to_cpu(val) bswap_32(val)
                         ^~~~~~~~~~~~~
/usr/include/byteswap.h:34:21: note: expanded from macro 'bswap_32'
#define bswap_32(x) __bswap_32 (x)
                    ^~~~~~~~~~~~~~
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:184:9: warning: 1st function call argument is an uninitialized value
        return be64_to_cpu(get_unaligned((const uint64_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./src/shared/util.h:33:26: note: expanded from macro 'be64_to_cpu'
#define be64_to_cpu(val) bswap_64(val)
                         ^~~~~~~~~~~~~
/usr/include/byteswap.h:37:21: note: expanded from macro 'bswap_64'
#define bswap_64(x) __bswap_64 (x)
                    ^~~~~~~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============2923051421073040169==--
