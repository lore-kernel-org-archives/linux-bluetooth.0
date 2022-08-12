Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE10C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Aug 2022 18:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiHLSuw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Aug 2022 14:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbiHLSuv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Aug 2022 14:50:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DC938A6
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 11:50:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d16so1468526pll.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 11:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=EC0AWL/ElM4bAUckCdNZMxFQ36bLkxzh/2bla1rWMJU=;
        b=5+wohNfr89QwAmCy+O3Uzmkx0Jcuwn3SoUwEB5fvcr/lT6PwTMevtX2Oaj95LYiXhw
         mplCTr6CO3AzLXeIeuKQn0wXyLhAUeEIYOCxq2tdnJsWn/vbe79fn5/2lHT5WF4q7YKF
         fNa4qaV8pReFdQQFWkV0eT300E6Nfne9yoCa5mssXn/i9pHdj+IrVhfPsjNiwBfAG+c6
         iTx6W7+rPSDBU2Urzqz5Owybkul+NGb1IDPjQf5A+vxB4aDWT5GdN1RTZRCB48bSTk9X
         CvM6pt+EFauoCNu4YWM2Eas3CxBRnJe1U0NRlkN/3p5Ujyw638+wzyphaW9uDm6109+S
         42Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=EC0AWL/ElM4bAUckCdNZMxFQ36bLkxzh/2bla1rWMJU=;
        b=C2Z3XZjr4UNmlTY9yecppZbFFU/0iQTfM+SgKHXGZCQ1kibJBk8gNjsNJ81GoQAFxY
         dcyjFcdGBOhQLq5CwzD39X2KJtCD1cH4lU/sPFPitp5LlBM4Fx1/1ubmeb8gUy3NAMAo
         bQpwCCRarUoJNJKCceXWufQaa0x0lJOel27NRc6I3GwzRo4elLCekYsm8y8GEy2xgEA8
         MU4H7S3XIoEvKCEFdOzDw00rYe8AJnqF81vURJ0/DOUpme5tQwzcgBSnoWWxJjflq0ZB
         PXnHFjJ7fMRtndV91G/Yu0W7ES8pyfKy8fPxXvRkFY5VQA72n24DZh7eyh2nEeTrT6rO
         aBdQ==
X-Gm-Message-State: ACgBeo3U+vm1BM3jZhjWtV4ScG9xM0FhELY8Fml6mXBIMIBS3TA2nMfg
        FHxWUlNJin3sgy2nJ9C9DvUeWX9qvzQ2uQ==
X-Google-Smtp-Source: AA6agR613Q1DbXngxGTen9tZHBUDFDy+Nit0w8lTUtFCd+ISLoWEbmHyme/SC1lad9BrnLfwytvbZQ==
X-Received: by 2002:a17:90b:4c51:b0:1f5:b530:af88 with SMTP id np17-20020a17090b4c5100b001f5b530af88mr5607564pjb.76.1660330248865;
        Fri, 12 Aug 2022 11:50:48 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id s15-20020a63ff4f000000b0040cb1f55391sm1656503pgk.2.2022.08.12.11.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 11:50:48 -0700 (PDT)
Date:   Fri, 12 Aug 2022 11:50:48 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Aug 2022 11:50:46 PDT (-0700)
Subject:     Re: Bluetooth: L2CAP: Elide a string overflow warning
In-Reply-To: <CABBYNZJ-E=FsayEzmpaYMDm5wz-Toba7fPrXHnqd56vEH84fTQ@mail.gmail.com>
CC:     linux-bluetooth@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     luiz.dentz@gmail.com
Message-ID: <mhng-5239dd44-fb77-4767-9f7c-2d2188bd1444@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 12 Aug 2022 11:08:35 PDT (-0700), luiz.dentz@gmail.com wrote:
> Hi Palmer,
>
> On Fri, Aug 12, 2022 at 12:19 AM <bluez.test.bot@gmail.com> wrote:
>>
>> This is automated email and please do not reply to this email!
>>
>> Dear submitter,
>>
>> Thank you for submitting the patches to the linux bluetooth mailing list.
>> This is a CI test results with your patch series:
>> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667062
>>
>> ---Test result---
>>
>> Test Summary:
>> CheckPatch                    FAIL      1.60 seconds
>> GitLint                       FAIL      1.01 seconds
>> SubjectPrefix                 PASS      0.84 seconds
>> BuildKernel                   PASS      41.49 seconds
>> BuildKernel32                 PASS      34.89 seconds
>> Incremental Build with patchesPASS      50.21 seconds
>> TestRunner: Setup             PASS      605.56 seconds
>> TestRunner: l2cap-tester      PASS      20.02 seconds
>> TestRunner: bnep-tester       PASS      8.10 seconds
>> TestRunner: mgmt-tester       PASS      122.17 seconds
>> TestRunner: rfcomm-tester     PASS      11.73 seconds
>> TestRunner: sco-tester        PASS      11.48 seconds
>> TestRunner: smp-tester        PASS      12.14 seconds
>> TestRunner: userchan-tester   PASS      8.96 seconds
>>
>> Details
>> ##############################
>> Test: CheckPatch - FAIL - 1.60 seconds
>> Run checkpatch.pl script with rule in .checkpatch.conf
>> Bluetooth: L2CAP: Elide a string overflow warning\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
>> #88:
>> In file included from /scratch/merges/ko-linux-next/linux/include/linux/string.h:253,
>>
>> WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
>> #95:
>>                  from /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:31:
>>
>> WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
>> #98:
>>     inlined from 'l2cap_global_chan_by_psm' at /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:2003:15:
>>
>> WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
>> #99:
>> /scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:44:33: error: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]
>>
>> WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
>> #102:
>> /scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:420:16: note: in expansion of macro '__underlying_memcmp'
>>
>> WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
>> #107:
>>     inlined from 'l2cap_global_chan_by_psm' at /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:2004:15:
>>
>> WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
>> #108:
>> /scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:44:33: error: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]
>>
>> WARNING:USE_RELATIVE_PATH: use relative pathname instead of absolute in changelog text
>> #111:
>> /scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:420:16: note: in expansion of macro '__underlying_memcmp'
>>
>> total: 0 errors, 8 warnings, 0 checks, 18 lines checked
>>
>> NOTE: For some of the reported defects, checkpatch may be able to
>>       mechanically convert to the typical style using --fix or --fix-inplace.
>>
>> /github/workspace/src/12941909.patch has style problems, please review.
>>
>> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>>
>> NOTE: If any of the errors are false positives, please report
>>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>>
>>
>> ##############################
>> Test: GitLint - FAIL - 1.01 seconds
>> Run gitlint with rule in .gitlint
>> Bluetooth: L2CAP: Elide a string overflow warning
>> 9: B1 Line exceeds max length (85>80): "In file included from /scratch/merges/ko-linux-next/linux/include/linux/string.h:253,"
>> 10: B1 Line exceeds max length (84>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/bitmap.h:11,"
>> 11: B1 Line exceeds max length (85>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/cpumask.h:12,"
>> 12: B1 Line exceeds max length (91>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/mm_types_task.h:14,"
>> 13: B1 Line exceeds max length (85>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/mm_types.h:5,"
>> 14: B1 Line exceeds max length (84>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/buildid.h:5,"
>> 15: B1 Line exceeds max length (84>80): "                 from /scratch/merges/ko-linux-next/linux/include/linux/module.h:14,"
>> 16: B1 Line exceeds max length (88>80): "                 from /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:31:"
>> 18: B1 Line exceeds max length (104>80): "    inlined from 'bacmp' at /scratch/merges/ko-linux-next/linux/include/net/bluetooth/bluetooth.h:347:9,"
>> 19: B1 Line exceeds max length (118>80): "    inlined from 'l2cap_global_chan_by_psm' at /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:2003:15:"
>> 20: B1 Line exceeds max length (167>80): "/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:44:33: error: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]"
>> 23: B1 Line exceeds max length (124>80): "/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:420:16: note: in expansion of macro '__underlying_memcmp'"
>> 27: B1 Line exceeds max length (104>80): "    inlined from 'bacmp' at /scratch/merges/ko-linux-next/linux/include/net/bluetooth/bluetooth.h:347:9,"
>> 28: B1 Line exceeds max length (118>80): "    inlined from 'l2cap_global_chan_by_psm' at /scratch/merges/ko-linux-next/linux/net/bluetooth/l2cap_core.c:2004:15:"
>> 29: B1 Line exceeds max length (167>80): "/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:44:33: error: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]"
>> 32: B1 Line exceeds max length (124>80): "/scratch/merges/ko-linux-next/linux/include/linux/fortify-string.h:420:16: note: in expansion of macro '__underlying_memcmp'"
>
> How about we attempt to fix the root cause in bacmp:
>
> diff --git a/include/net/bluetooth/bluetooth.h
> b/include/net/bluetooth/bluetooth.h
> index e72f3b247b5e..415a5f3afc98 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -344,6 +344,9 @@ static inline bool bdaddr_type_is_le(u8 type)
>  /* Copy, swap, convert BD Address */
>  static inline int bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
>  {
> +       if (!ba1 || !ba2)
> +               return -EINVAL;
> +
>         return memcmp(ba1, ba2, sizeof(bdaddr_t));
>  }
>  static inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)
>
> We could alternatively make it compare the pointer first so in case
> both are NULL it returns 0 but since memcmp itself causes warnings if
> NULL is passed I guess it safe to assume NULL pointers shall be
> considered considered invalid, that said perhaps the problem is if one
> would consider -EINVAL a return of memcmp so returning negative values
> becomes ambiguous but the original intent of bacmp was to compare
> bluetooth addresses so users normally don't check what the error
> actually means and instead just use its return as a bool.

I'm fine with that, but just from looking at the bacmp() callers it 
seems like many of them would need to be changed to handle the -EINVAL 
as they're assuming it looks like memcmp().  IIUC the -EINVAL aliases 
with possible valid memcmp() returns, so it's not super clear how to 
adjust the callers.  I guess none of them could have null inputs now as 
otherwise it'd crash so maybe that doesn't matter?

I'm not really a bluethooth guy, but LMK if you want me to take a shot 
at it.
