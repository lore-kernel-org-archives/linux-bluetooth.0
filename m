Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1A2C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 19:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72C161159
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 19:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhEDTHW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 15:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhEDTHV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 15:07:21 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED516C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 May 2021 12:06:23 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id z16so8432107pga.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 May 2021 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=D/DgHbgMp2CqcVWrFt4aTynyNPJkzpFjZ/FjXGd88QQ=;
        b=RGiioRmIv8+rbfiBt5weVAQKtBybIjfxm1eZ3aq2wdW26+T3aXcnHj8vTxD/ACZosN
         oVzFVQhgxEQRRzoBoynDIlG6Va2Thrt9Yo9g3EobRd20hlHuopaieA/y3SrshC02+cWF
         fUwnTqdqUzUyjO5GA4MgK4xkHyoQYekA7zip76r9Uki91POzHF6UrlC/XcMeOzkvIBq4
         97FPOA4DdWjM8wXmwKUhQaCTtlvASgt8ivd5+FsCGYV6v+IYUMlctyTLRHsl6MCbw9uh
         MqzTIbdmOL61kMhFb9ciakqsW6y3ccupj3cp3/5tZBbnRIf+m3utzd7LcYU+FDB36sQ8
         yA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=D/DgHbgMp2CqcVWrFt4aTynyNPJkzpFjZ/FjXGd88QQ=;
        b=YNkACrhXwc9r9U7kirAINo2v2JwO1Ocuk4qIgZ8h0LnPzygzNcHR7tRc9Id932S+NO
         cUe53wGrTuE2B+6pZg6bUt4HlvI+Pd0zvG7QzJ/+TgjZ5D9Z28YuVI3VXBy+Y800vZ3q
         OR26Bh6sBYzIp/VC6ewbgw9VTvN7IYtNVyAaWBrhbaEL8P6OpoJwvX4+FKgL3oq0v6v/
         G03HwZmhX0shzAgHo2sAul8PsGD/esa3nuNeF1xybUo7qrAxCSjuM6MGSSa3wwbek/fd
         FF06Y/n3EbVgqI4e0Wr2DOnOFArjBg8wYp9vRDGxRTh9jTsSDdSxy2u+9HNXiuzeBWD5
         xxuQ==
X-Gm-Message-State: AOAM531qyK1gua8XBsQXoMbT2jUyqugM0EVM+7N6enDGbCzKxnT0l9ER
        qSmgW8/7xMyaC1OAg3u/Z68=
X-Google-Smtp-Source: ABdhPJyo16RRnJRZ2Zrej17qC7fLweNua+EvC8+TuniIoA67W/eEpoa7rrEjYTntdoqDY7VnQQpudA==
X-Received: by 2002:a62:2904:0:b029:25c:13f2:47d4 with SMTP id p4-20020a6229040000b029025c13f247d4mr25196124pfp.4.1620155183400;
        Tue, 04 May 2021 12:06:23 -0700 (PDT)
Received: from han1-mobl3 ([2601:1c0:6a01:d830::f7ee])
        by smtp.gmail.com with ESMTPSA id l6sm4084074pgc.68.2021.05.04.12.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 12:06:23 -0700 (PDT)
Message-ID: <a2fa72a09986aefe606cbc512ec25b3825987395.camel@gmail.com>
Subject: Re: Convert manpages to rst format
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Tue, 04 May 2021 12:06:22 -0700
In-Reply-To: <CABBYNZJdnBXSEczXOP_y5vNrzSTU5hBC0U-PZE42x8aW4ZSO8w@mail.gmail.com>
References: <20210504050207.841261-2-hj.tedd.an@gmail.com>
         <60910961.1c69fb81.d76ca.db48@mx.google.com>
         <4e7e5ab6161ab4852efc26a3bcd01f2d84b16749.camel@gmail.com>
         <CABBYNZJdnBXSEczXOP_y5vNrzSTU5hBC0U-PZE42x8aW4ZSO8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2021-05-04 at 11:58 -0700, Luiz Augusto von Dentz wrote:
> Hi Tedd,
> 
> On Tue, May 4, 2021 at 11:25 AM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
> > Hi
> > 
> > On Tue, 2021-05-04 at 01:44 -0700, bluez.test.bot@gmail.com wrote:
> > > This is automated email and please do not reply to this email!
> > > 
> > > Dear submitter,
> > > 
> > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > This is a CI test results with your patch series:
> > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=476657
> > > 
> > > ---Test result---
> > > 
> > > Test Summary:
> > > CheckPatch                    FAIL      1.09 seconds
> > > GitLint                       PASS      0.49 seconds
> > > Prep - Setup ELL              PASS      48.06 seconds
> > > Build - Prep                  PASS      0.11 seconds
> > > Build - Configure             PASS      8.27 seconds
> > > Build - Make                  PASS      205.97 seconds
> > > Make Check                    PASS      9.56 seconds
> > > Make Dist                     PASS      13.28 seconds
> > > Make Dist - Configure         PASS      5.14 seconds
> > > Make Dist - Make              PASS      82.48 seconds
> > > Build w/ext ELL - Configure   PASS      8.44 seconds
> > > Build w/ext ELL - Make        PASS      191.12 seconds
> > > 
> > > Details
> > > ##############################
> > > Test: CheckPatch - FAIL
> > > Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> > > Output:
> > > monitor: Convert manpage to rst format
> > > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > > #125: FILE: monitor/btmon.rst:1:
> > > +=====
> > > 
> > > - total: 0 errors, 1 warnings, 224 lines checked
> > > 
> > > NOTE: For some of the reported defects, checkpatch may be able to
> > >       mechanically convert to the typical style using --fix or --fix-inplace.
> > > 
> > > "[PATCH] monitor: Convert manpage to rst format" has style problems, please review.
> > > 
> > > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
> > > 
> > > NOTE: If any of the errors are false positives, please report
> > >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > > 
> > > tools: Convert manpages to rst format
> > > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > > #111: FILE: tools/bdaddr.rst:1:
> > > +======
> > > 
> > These errors can be ignored since no SPDX header is needed in the manpage file. Also
> > even if the SPDX license header is added, the checkpatch cannot parse .rst file and
> > still shows a warning.
> 
> Isn't there a way to make checkpatch ignore those then? I can apply
> them either way but going forward it would be great to avoid having
> these errors.
> 

Yes, there is a flag SPDX_LICENSE_TAG to turn off this check.
I will turn this off this then.

> > > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > > #252: FILE: tools/btattach.rst:1:
> > > +========
> > > 
> > > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > > #411: FILE: tools/ciptool.rst:1:
> > > +========
> > > 
> > > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > > #652: FILE: tools/hciattach.rst:1:
> > > +=========
> > > 
> > > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > > #1102: FILE: tools/hciconfig.rst:1:
> > > +=========
> > > 
> > > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > > #1503: FILE: tools/hcidump.rst:1:
> > > +=======
> > > 
> > > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > > #1889: FILE: tools/hcitool.rst:1:
> > > +=======
> > > 
> > > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > > #2160: FILE: tools/hid2hci.rst:1:
> > > +========
> > > 
> > > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > > #2298: FILE: tools/l2ping.rst:1:
> > > +======
> > > 
> > > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > > #2469: FILE: tools/rctest.rst:1:
> > > +======
> > > 
> > > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > > #2675: FILE: tools/rfcomm.rst:1:
> > > +======
> > > 
> > > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > > #2919: FILE: tools/sdptool.rst:1:
> > > +=======
> > > 
> > > - total: 0 errors, 12 warnings, 1414 lines checked
> > > 
> > > NOTE: For some of the reported defects, checkpatch may be able to
> > >       mechanically convert to the typical style using --fix or --fix-inplace.
> > > 
> > > "[PATCH] tools: Convert manpages to rst format" has style problems, please review.
> > > 
> > > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
> > > 
> > > NOTE: If any of the errors are false positives, please report
> > >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > > 
> > > 
> > > ##############################
> > > Test: GitLint - PASS
> > > Desc: Run gitlint with rule in .gitlint
> > > 
> > > ##############################
> > > Test: Prep - Setup ELL - PASS
> > > Desc: Clone, build, and install ELL
> > > 
> > > ##############################
> > > Test: Build - Prep - PASS
> > > Desc: Prepare environment for build
> > > 
> > > ##############################
> > > Test: Build - Configure - PASS
> > > Desc: Configure the BlueZ source tree
> > > 
> > > ##############################
> > > Test: Build - Make - PASS
> > > Desc: Build the BlueZ source tree
> > > 
> > > ##############################
> > > Test: Make Check - PASS
> > > Desc: Run 'make check'
> > > 
> > > ##############################
> > > Test: Make Dist - PASS
> > > Desc: Run 'make dist' and build the distribution tarball
> > > 
> > > ##############################
> > > Test: Make Dist - Configure - PASS
> > > Desc: Configure the source from distribution tarball
> > > 
> > > ##############################
> > > Test: Make Dist - Make - PASS
> > > Desc: Build the source from distribution tarball
> > > 
> > > ##############################
> > > Test: Build w/ext ELL - Configure - PASS
> > > Desc: Configure BlueZ source with '--enable-external-ell' configuration
> > > 
> > > ##############################
> > > Test: Build w/ext ELL - Make - PASS
> > > Desc: Build BlueZ source with '--enable-external-ell' configuration
> > > 
> > > 
> > > 
> > > ---
> > > Regards,
> > > Linux Bluetooth
> > > 
> > 
> > Regards,
> > Tedd
> > 
> 
> 

