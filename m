Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AEAC43461
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285D4214D8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTO6O/MB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgILGve (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgILGv1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 02:51:27 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A20C061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:51:26 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id j10so6351532qvk.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jEo9swi/0dqO3HOSpVsqcg0CYWt3m3OF8SnW99CIgko=;
        b=RTO6O/MBEYoZDP7CHBMbWHozhmDi8rcBv2N9TBPTraHS1C9WipS5IoBINjw9Yndjy3
         LNHSQk5tYEkBc6jsKmzyRYOxYzDxmMgjW/TiuiW1gwv4YVbVecEo8F4fR8LtnzQ6UdYV
         ySF5+7iQkaML6q8+nhwU4fowIENzE29gkO56i9XGwki6fbNUt1+kIVtoNN6GE9y4R4TO
         sspm0rhE89ogVQt4/0RZpCi1q0WDgh9ecmPdUOnSu+51cWxEC3iukAJax/9R5YjR1Sxh
         JPTOClcdT/g4irlqiqSX7v43LUp+HWIFtptMs75ZCGIBATwYdycnuE1eVF25l7HNKsae
         ax8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jEo9swi/0dqO3HOSpVsqcg0CYWt3m3OF8SnW99CIgko=;
        b=pILKIcONaVRbDXx9kdCd77pv+u/jl8IWsa9m1w0/fBG/KBHdv2Mam5wBEuJ8lnLFik
         LamrMFgA19YMugLtAa/HSpA7rgy50GNyAgNRbkF0eLLQ34+32Cp+kOC/p8Mo82b/GAne
         i8bTuu8SJLN84EudKKev7EUIyKsXndP/mUsgijNCKh8wiw9serhp37aQdMD0hG4rgJep
         nyw8/oWBFPvf6Fn/ubrLe81K9r1MPoyktZvt7QpWeQgTovI4Ek1iQ2vmLdCVZf8LTpb5
         771CBJBQoVKEc1RfXu03Pn62+t+wtxYtRMp+tycrvKglVuHzUtrtFzr0BFK106u2eEp7
         HmtA==
X-Gm-Message-State: AOAM533a30xwZ8FuZv4X8GJE3J60jEQtHNSAzuaVCfTaNhw4MYQNcOH2
        vqJEAEzCWAxrqIBGJaUXgV+E1krcNMJTOA==
X-Google-Smtp-Source: ABdhPJwmSsTyfiBacZ+aQzZCl+AxB+JxbKWgxpcUB1UXeVaXm9JwP4lnR/iocL3l6LnR/GTrr78+yg==
X-Received: by 2002:a0c:c304:: with SMTP id f4mr5301062qvi.8.1599893485177;
        Fri, 11 Sep 2020 23:51:25 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.17.224])
        by smtp.gmail.com with ESMTPSA id x59sm5891253qte.14.2020.09.11.23.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 23:51:24 -0700 (PDT)
Message-ID: <5f5c6fec.1c69fb81.37dac.f57e@mx.google.com>
Date:   Fri, 11 Sep 2020 23:51:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2710110518128234941=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: [BlueZ,05/17] emulator: Add SPDX License Identifier
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200912062357.23926-6-tedd.an@linux.intel.com>
References: <20200912062357.23926-6-tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2710110518128234941==
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
WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'emulator/amp.h', please use '/*' instead
#54: FILE: emulator/amp.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#54: FILE: emulator/amp.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'emulator/btdev.h', please use '/*' instead
#81: FILE: emulator/btdev.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#81: FILE: emulator/btdev.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'emulator/bthost.h', please use '/*' instead
#99: FILE: emulator/bthost.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#99: FILE: emulator/bthost.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'emulator/hciemu.h', please use '/*' instead
#117: FILE: emulator/hciemu.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#117: FILE: emulator/hciemu.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'emulator/le.h', please use '/*' instead
#144: FILE: emulator/le.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#144: FILE: emulator/le.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'emulator/phy.h', please use '/*' instead
#171: FILE: emulator/phy.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#171: FILE: emulator/phy.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'emulator/serial.h', please use '/*' instead
#189: FILE: emulator/serial.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#189: FILE: emulator/serial.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'emulator/server.h', please use '/*' instead
#207: FILE: emulator/server.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#207: FILE: emulator/server.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'emulator/vhci.h', please use '/*' instead
#234: FILE: emulator/vhci.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#234: FILE: emulator/vhci.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

- total: 0 errors, 18 warnings, 88 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============2710110518128234941==--
