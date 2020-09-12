Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD8AC43461
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76E3214F1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIg9Gq4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgILGvi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgILGv2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 02:51:28 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABCFC061786
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:51:27 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id q10so6373523qvs.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DRgLgheDgaTzIsNwst0UPPo4qnSXc9Nu/gQeniCRqPU=;
        b=dIg9Gq4pgh7G/iIMQJUFXYQRyMbuevSKgybUu2gZLQzHZXge3rxzbp/xciTbS6b7pY
         CIW4T5KVhRcnEgxwwgRNUHV6QlYuFDurWzusSBMZDFgRGkLpDM1AMArw3rTmGGupbcSf
         PDEV0thCHDQ+4JggtSBYCXFOaM8MaFI55pRwcBPs81eJ0T1avCgravU9ainhbtCTMxfp
         R4wd6GsKyIKJibZHIbnGBlVEPxfHWl3qynHUSnhlY1bxsKShpSS0eA/Ya7tDMkpBzt2P
         WhpGczp/+jI3qLUooPfmb15SHp1imn4g1mxwPYOnraz8gPB+B2klfhlwIm7c1icDO2/p
         sMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DRgLgheDgaTzIsNwst0UPPo4qnSXc9Nu/gQeniCRqPU=;
        b=UOnAaBfbVFmfGyY6EcLp4Crsqpxe8WQoF6tQkzLiH8r6eJGj0AA9G8cyJDv4wZxXX4
         4hr7rpiHATle/I5MOYujb+JNAGCxIfZhp5ikZ+KtufTJC26TrCrTRGuJDv3g0VEizzSg
         BLg44O4cSYoYs1ELHOegUaGFARSX8wIGd0w94WesNpRHnS7K5FK0MePlQFNYE3xXuREO
         4IPpJH47snUTCax4rSj54BXRfgaqCkJMUCh9k07Bn1OskuFzwPdy0SWwcL9ChPbL5pqu
         jbdBSNIghRySdW/hNM523H6pKZLLUZn6Fww9IIP599jA9fgrzeyxR3B8x3E5GYkfRUrE
         +vbA==
X-Gm-Message-State: AOAM53390eRRZ60l7F4irsWJF58LDOYrOq+BSv3uuNFD+AM8+Bb9SXjm
        cQh6cc/lD3Xt47YwsSg1ICQue8kUQh921Q==
X-Google-Smtp-Source: ABdhPJwS7u8Snj5z6ppNGotIH+xEs+e2L8gtJY9fspEmpMfipXl0BP6A/7RVMN6C6vcOfLXuoEK3sg==
X-Received: by 2002:ad4:4f8f:: with SMTP id em15mr5100445qvb.65.1599893486139;
        Fri, 11 Sep 2020 23:51:26 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.17.224])
        by smtp.gmail.com with ESMTPSA id 203sm6013182qke.59.2020.09.11.23.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 23:51:25 -0700 (PDT)
Message-ID: <5f5c6fed.1c69fb81.ecf77.009b@mx.google.com>
Date:   Fri, 11 Sep 2020 23:51:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1496939985822898260=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: [BlueZ,11/17] obexd: Add SPDX License Identifer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200912062357.23926-12-tedd.an@linux.intel.com>
References: <20200912062357.23926-12-tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1496939985822898260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/client/bluetooth.h', please use '/*' instead
#94: FILE: obexd/client/bluetooth.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#94: FILE: obexd/client/bluetooth.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/client/driver.h', please use '/*' instead
#112: FILE: obexd/client/driver.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#112: FILE: obexd/client/driver.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/client/ftp.h', please use '/*' instead
#130: FILE: obexd/client/ftp.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#130: FILE: obexd/client/ftp.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/client/manager.h', please use '/*' instead
#148: FILE: obexd/client/manager.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#148: FILE: obexd/client/manager.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/client/map-event.h', please use '/*' instead
#166: FILE: obexd/client/map-event.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#166: FILE: obexd/client/map-event.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/client/map.h', please use '/*' instead
#184: FILE: obexd/client/map.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#184: FILE: obexd/client/map.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/client/opp.h', please use '/*' instead
#211: FILE: obexd/client/opp.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#211: FILE: obexd/client/opp.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/client/pbap.h', please use '/*' instead
#229: FILE: obexd/client/pbap.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#229: FILE: obexd/client/pbap.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/client/session.h', please use '/*' instead
#247: FILE: obexd/client/session.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#247: FILE: obexd/client/session.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/client/sync.h', please use '/*' instead
#265: FILE: obexd/client/sync.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#265: FILE: obexd/client/sync.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/client/transfer.h', please use '/*' instead
#283: FILE: obexd/client/transfer.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#283: FILE: obexd/client/transfer.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/client/transport.h', please use '/*' instead
#301: FILE: obexd/client/transport.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#301: FILE: obexd/client/transport.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/plugins/filesystem.h', please use '/*' instead
#328: FILE: obexd/plugins/filesystem.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#328: FILE: obexd/plugins/filesystem.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/plugins/ftp.h', please use '/*' instead
#346: FILE: obexd/plugins/ftp.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#346: FILE: obexd/plugins/ftp.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/plugins/messages.h', please use '/*' instead
#391: FILE: obexd/plugins/messages.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#391: FILE: obexd/plugins/messages.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/plugins/phonebook.h', please use '/*' instead
#454: FILE: obexd/plugins/phonebook.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#454: FILE: obexd/plugins/phonebook.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/plugins/vcard.h', please use '/*' instead
#481: FILE: obexd/plugins/vcard.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#481: FILE: obexd/plugins/vcard.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/src/log.h', please use '/*' instead
#499: FILE: obexd/src/log.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#499: FILE: obexd/src/log.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/src/manager.h', please use '/*' instead
#526: FILE: obexd/src/manager.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#526: FILE: obexd/src/manager.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/src/map_ap.h', please use '/*' instead
#535: FILE: obexd/src/map_ap.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#535: FILE: obexd/src/map_ap.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/src/mimetype.h', please use '/*' instead
#553: FILE: obexd/src/mimetype.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#553: FILE: obexd/src/mimetype.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/src/obex-priv.h', please use '/*' instead
#562: FILE: obexd/src/obex-priv.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#562: FILE: obexd/src/obex-priv.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/src/obex.h', please use '/*' instead
#580: FILE: obexd/src/obex.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#580: FILE: obexd/src/obex.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/src/obexd.h', please use '/*' instead
#589: FILE: obexd/src/obexd.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#589: FILE: obexd/src/obexd.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/src/plugin.h', please use '/*' instead
#607: FILE: obexd/src/plugin.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#607: FILE: obexd/src/plugin.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/src/server.h', please use '/*' instead
#625: FILE: obexd/src/server.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#625: FILE: obexd/src/server.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/src/service.h', please use '/*' instead
#643: FILE: obexd/src/service.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#643: FILE: obexd/src/service.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'obexd/src/transport.h', please use '/*' instead
#661: FILE: obexd/src/transport.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#661: FILE: obexd/src/transport.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

- total: 0 errors, 56 warnings, 260 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============1496939985822898260==--
