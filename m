Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2229BC433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 16:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3927611AD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 16:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhEDQIF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 12:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhEDQIF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 12:08:05 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB2FC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 May 2021 09:07:10 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id i14so7553508pgk.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 May 2021 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=DbSouu197zNzkty8gUSN+JSb9OGxmHZcwb8+PoCsR14=;
        b=cUXhhLSjgA4CcOWQpI6HU5QEk9+Cb3iorZlhyTLTSCmw5gAPu65BlbYj2R4kO2YeiP
         2r3Ct5kIA13urTE3qB94w+DHkbPcJ3D2SbpgwA++uiOC8whh/2CPfTMzzXtYnLKLm8iM
         Q8MqjYHhJqGNekbcDPQk/Z+BbzrAsH5xD8h+CTVFvHGC5plgEYPeUvUbcgMXvxuhTo0z
         k7VPdVYdVlqqth0vhF6yjlIgbwRUQam/RwatUyDfzq68L0uOg4/W4nA5kVXbwxEuzCW9
         Krj+9al3gwRRiXjv4Tkm+wJL4/CZFdfUpYU61QQ65rP8urOhHG+SEcw3blIZRpFgUP58
         iFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DbSouu197zNzkty8gUSN+JSb9OGxmHZcwb8+PoCsR14=;
        b=tWuW47huZbbF0agC9EckiznPP+qLcPn8EqbodB8xsUHjnW5CSCHlLqElFybWnKW9lC
         kBZalFIgDrzUdXeqhtUt0fbUe05/z7hDhtSA2zAIWp4n3X5YbXgskpv+gQ+0RzaXmh6G
         ZBZsPMNcfDo3TCcrr1/bQVJRLEUiFIYbgRE/6yfMg7Zp9C3d8kX6dIH/vxuyMqYfTqUl
         hepGoEl8XqyLhSzKkiGWSF7bs+0G2cieWQLc3ZH9/77B1b34uo2yyM7cQ5ltB8LgyPRq
         RM3ruo6QPEmyBdgcblzKZWDdpcWJjT6CgXH+YY8bK8bAR7Eh/rm4OehsQ03nx7YFLQHy
         mqNw==
X-Gm-Message-State: AOAM533KTwc1CXZemcASZxiXpKe0e03v6ijp+yxNg4zKH0D0UdCnmSQz
        XElm5685mIQK7Y++ZVnMBKd2tsuKJWpenw==
X-Google-Smtp-Source: ABdhPJw99GxOUyklrnJIPhztId74ZwbvTLmkPxmDGx51BNPSL+XPMV1EfZ/zOOxf6BJlRDXYXpU0zw==
X-Received: by 2002:a63:2d47:: with SMTP id t68mr24094830pgt.416.1620144429467;
        Tue, 04 May 2021 09:07:09 -0700 (PDT)
Received: from han1-mobl3 ([2601:1c0:6a01:d830::f7ee])
        by smtp.gmail.com with ESMTPSA id k38sm3678582pgi.73.2021.05.04.09.07.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:07:08 -0700 (PDT)
Message-ID: <4e7e5ab6161ab4852efc26a3bcd01f2d84b16749.camel@gmail.com>
Subject: Re: Convert manpages to rst format
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Date:   Tue, 04 May 2021 09:07:07 -0700
In-Reply-To: <60910961.1c69fb81.d76ca.db48@mx.google.com>
References: <20210504050207.841261-2-hj.tedd.an@gmail.com>
         <60910961.1c69fb81.d76ca.db48@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

On Tue, 2021-05-04 at 01:44 -0700, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=476657
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    FAIL      1.09 seconds
> GitLint                       PASS      0.49 seconds
> Prep - Setup ELL              PASS      48.06 seconds
> Build - Prep                  PASS      0.11 seconds
> Build - Configure             PASS      8.27 seconds
> Build - Make                  PASS      205.97 seconds
> Make Check                    PASS      9.56 seconds
> Make Dist                     PASS      13.28 seconds
> Make Dist - Configure         PASS      5.14 seconds
> Make Dist - Make              PASS      82.48 seconds
> Build w/ext ELL - Configure   PASS      8.44 seconds
> Build w/ext ELL - Make        PASS      191.12 seconds
> 
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> monitor: Convert manpage to rst format
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #125: FILE: monitor/btmon.rst:1:
> +=====
> 
> - total: 0 errors, 1 warnings, 224 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> "[PATCH] monitor: Convert manpage to rst format" has style problems, please review.
> 
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> tools: Convert manpages to rst format
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #111: FILE: tools/bdaddr.rst:1:
> +======
> 
These errors can be ignored since no SPDX header is needed in the manpage file. Also
even if the SPDX license header is added, the checkpatch cannot parse .rst file and
still shows a warning.

> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #252: FILE: tools/btattach.rst:1:
> +========
> 
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #411: FILE: tools/ciptool.rst:1:
> +========
> 
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #652: FILE: tools/hciattach.rst:1:
> +=========
> 
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #1102: FILE: tools/hciconfig.rst:1:
> +=========
> 
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #1503: FILE: tools/hcidump.rst:1:
> +=======
> 
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #1889: FILE: tools/hcitool.rst:1:
> +=======
> 
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #2160: FILE: tools/hid2hci.rst:1:
> +========
> 
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #2298: FILE: tools/l2ping.rst:1:
> +======
> 
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #2469: FILE: tools/rctest.rst:1:
> +======
> 
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #2675: FILE: tools/rfcomm.rst:1:
> +======
> 
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #2919: FILE: tools/sdptool.rst:1:
> +=======
> 
> - total: 0 errors, 12 warnings, 1414 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> "[PATCH] tools: Convert manpages to rst format" has style problems, please review.
> 
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
> 
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
> 
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
> 
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
> 
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
> 
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
> 
> ##############################
> Test: Make Dist - PASS
> Desc: Run 'make dist' and build the distribution tarball
> 
> ##############################
> Test: Make Dist - Configure - PASS
> Desc: Configure the source from distribution tarball
> 
> ##############################
> Test: Make Dist - Make - PASS
> Desc: Build the source from distribution tarball
> 
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
> 
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
> 
> 
> 
> ---
> Regards,
> Linux Bluetooth
> 

Regards,
Tedd

