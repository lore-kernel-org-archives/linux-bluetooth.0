Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4317EC00140
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Aug 2022 18:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiHLSIv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Aug 2022 14:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbiHLSIu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Aug 2022 14:08:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F62B287F
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 11:08:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z6so2326212lfu.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=33TnQ81T2VdsnhMA79M0fVoW35zOzD91LpU/CW8o2lc=;
        b=Mf6brwJtVqh4+hKLwlIIi/x6EyyMElRPjgRcz40Ybe5Sl924cR6zjKXgxrWdvjcUNh
         Z8s4Kx3z5wek5GXEI4drviH5242/RSdHvSycFJ1DEHXRh9Fjsm+1Bi7CX5l7ZZYbT5J0
         o4uSaAoPLjOw8Q+7laCeE+/ZcJ/ari4hYNgfmIujWA2tEzYwQNDRyEWCjPNMQAPu2Mpv
         /QC4luSGCTX1hhv3J/h+UhS198xe28Vj/oc9/1Cma4RxJjitx4VkdQ4+jAjjcR+gkOxb
         GKbJevXHi0GJ3hy12fyblAbwN21ln+5x7phJ3/XxvKEfWjiBQ15vuDhxp+XJJCyQflkI
         ScyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=33TnQ81T2VdsnhMA79M0fVoW35zOzD91LpU/CW8o2lc=;
        b=ZRT4va+c/H2KvZN52yF7b/CUEvbpZjl0WP2YXwN8hqsrcbxThZR/TJM7c6Tr6WrGxo
         6XpRa2OR15FFJpIvldHZC4slt7ddoTFdojJ6OcNNRdNXU83fGSB2ilALjIkU8BWR2puS
         CCvJwMQZrIeDZNY7LK9p+NjBxaSvO4/GQUFyLMrQvGW1bkddYzYvJVU9cxFXJ8m8gYfm
         DyiKaFGMUYVl8mwrHdgKv7pN+J/mxcG1MdoPlBDz2Mit9J6o6AyHrG+/c6T7kDUr0ado
         jy8z+CQeHWB8JEwnEGP0Isd3m+E4CEEJAAWmLonKu1KQPMm6pnR4O7fn+g7K4lfha9pl
         CoZA==
X-Gm-Message-State: ACgBeo0ZZcsNU2gC/cvvXf1x2r5bKiomvrRuLFNdl/HHB0V7O0JfZWu/
        zC6cZ3pJniBb5iqFquItK3YVkmL0+s0b3OQyfekwi2PhUXgFk7X4v/8=
X-Google-Smtp-Source: AA6agR5Sbp/VFbEBOamqdTRGRtiABMFnqJ/d0Bhq+tioHvt3jdepeAPRd5DOsg2VRts5iDKpF8hO/+Brk8vFEWO54aE=
X-Received: by 2002:a05:6512:3fa8:b0:48c:ffd1:625d with SMTP id
 x40-20020a0565123fa800b0048cffd1625dmr1513096lfa.251.1660327727317; Fri, 12
 Aug 2022 11:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220812055249.8037-1-palmer@rivosinc.com> <62f5fda0.050a0220.ebb71.24fe@mx.google.com>
In-Reply-To: <62f5fda0.050a0220.ebb71.24fe@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 12 Aug 2022 11:08:35 -0700
Message-ID: <CABBYNZJ-E=FsayEzmpaYMDm5wz-Toba7fPrXHnqd56vEH84fTQ@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: Elide a string overflow warning
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Palmer,

On Fri, Aug 12, 2022 at 12:19 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667062
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.60 seconds
> GitLint                       FAIL      1.01 seconds
> SubjectPrefix                 PASS      0.84 seconds
> BuildKernel                   PASS      41.49 seconds
> BuildKernel32                 PASS      34.89 seconds
> Incremental Build with patchesPASS      50.21 seconds
> TestRunner: Setup             PASS      605.56 seconds
> TestRunner: l2cap-tester      PASS      20.02 seconds
> TestRunner: bnep-tester       PASS      8.10 seconds
> TestRunner: mgmt-tester       PASS      122.17 seconds
> TestRunner: rfcomm-tester     PASS      11.73 seconds
> TestRunner: sco-tester        PASS      11.48 seconds
> TestRunner: smp-tester        PASS      12.14 seconds
> TestRunner: userchan-tester   PASS      8.96 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL - 1.60 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> Bluetooth: L2CAP: Elide a string overflow warning\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #88:
> In file included from /scratch/merges/ko-linux-next/linux/include/linux/string.h:253,
>
> WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
> #95:
>                  from /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:31:
>
> WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
> #98:
>     inlined from 'l2cap_global_chan_by_psm' at /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:2003:15:
>
> WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
> #99:
> /scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:44:33: error: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]
>
> WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
> #102:
> /scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:420:16: note: in expansion of macro '__underlying_memcmp'
>
> WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
> #107:
>     inlined from 'l2cap_global_chan_by_psm' at /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:2004:15:
>
> WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
> #108:
> /scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:44:33: error: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]
>
> WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
> #111:
> /scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:420:16: note: in expansion of macro '__underlying_memcmp'
>
> total: 0 errors, 8 warnings, 0 checks, 18 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12941909.patch has style problems, please review.
>
> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - FAIL - 1.01 seconds
> Run gitlint with rule in .gitlint
> Bluetooth: L2CAP: Elide a string overflow warning
> 9: B1 Line exceeds max length (85>80): "In file included from /scratch/merges/ko-linux-next/linux/include/linux/string.h:253,"
> 10: B1 Line exceeds max length (84>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/bitmap.h:11,"
> 11: B1 Line exceeds max length (85>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/cpumask.h:12,"
> 12: B1 Line exceeds max length (91>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/mm_types_task.h:14,"
> 13: B1 Line exceeds max length (85>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/mm_types.h:5,"
> 14: B1 Line exceeds max length (84>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/buildid.h:5,"
> 15: B1 Line exceeds max length (84>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/module.h:14,"
> 16: B1 Line exceeds max length (88>80): "                 from /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:31:"
> 18: B1 Line exceeds max length (104>80): "    inlined from 'bacmp' at /scratch/merges/ko-linux-next/linux/include/net/bluetooth/bluetooth.h:347:9,"
> 19: B1 Line exceeds max length (118>80): "    inlined from 'l2cap_global_chan_by_psm' at /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:2003:15:"
> 20: B1 Line exceeds max length (167>80): "/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:44:33: error: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]"
> 23: B1 Line exceeds max length (124>80): "/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:420:16: note: in expansion of macro '__underlying_memcmp'"
> 27: B1 Line exceeds max length (104>80): "    inlined from 'bacmp' at /scratch/merges/ko-linux-next/linux/include/net/bluetooth/bluetooth.h:347:9,"
> 28: B1 Line exceeds max length (118>80): "    inlined from 'l2cap_global_chan_by_psm' at /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:2004:15:"
> 29: B1 Line exceeds max length (167>80): "/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:44:33: error: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]"
> 32: B1 Line exceeds max length (124>80): "/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:420:16: note: in expansion of macro '__underlying_memcmp'"

How about we attempt to fix the root cause in bacmp:

diff --git a/include/net/bluetooth/bluetooth.h
b/include/net/bluetooth/bluetooth.h
index e72f3b247b5e..415a5f3afc98 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -344,6 +344,9 @@ static inline bool bdaddr_type_is_le(u8 type)
 /* Copy, swap, convert BD Address */
 static inline int bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
 {
+       if (!ba1 || !ba2)
+               return -EINVAL;
+
        return memcmp(ba1, ba2, sizeof(bdaddr_t));
 }
 static inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)

We could alternatively make it compare the pointer first so in case
both are NULL it returns 0 but since memcmp itself causes warnings if
NULL is passed I guess it safe to assume NULL pointers shall be
considered considered invalid, that said perhaps the problem is if one
would consider -EINVAL a return of memcmp so returning negative values
becomes ambiguous but the original intent of bacmp was to compare
bluetooth addresses so users normally don't check what the error
actually means and instead just use its return as a bool.

-- 
Luiz Augusto von Dentz
