Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36746C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 04:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLIEeE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Dec 2022 23:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIEeD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Dec 2022 23:34:03 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDC920BE8
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 20:34:01 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id f7-20020a4a8907000000b004a0cb08d0afso539829ooi.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Dec 2022 20:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hd51xJXXo95k2JPa1hPp9eA4kjKtvrXXIOYO+aGOZpc=;
        b=PMe4CS68uuPYgx52rHhHRCohWEDlL7NPb3L+ZRTG1NUJYH1pcEra7DxTV3y4r8GjQH
         S8c5rkh8/DWDdtom1BEGdgFgmqj6GQD0TkNl7dG58GMz1rNFtE+HGuaRp14QrA6GqYoh
         wYulvBqn2hLEUD5dR30wg6nZwN1xNoWMj3JqxW6g5WeioCcrOdQ210nxYdwtZ53lJsTw
         4nuAMauL4TwaK89ixD3HCms0YtHkpJPQXX7ao9yiqfJuxJwz9VZJbZUO59Xdzr5UK2SJ
         G3W0QRKKBnG3bcMPVBj1Xy7RCKbD7RIS+PFW84sNkOkQPvXjpYfRKKlui9C1YLw6voNh
         xWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hd51xJXXo95k2JPa1hPp9eA4kjKtvrXXIOYO+aGOZpc=;
        b=lBXrHht0CqaYUsnD3wS5a5g9btOmumcIIStybCX1hl250cA1uhobvFMEQnB2fmJkqq
         qcexC4Qq4DSHIvifgJvZW6i0YW0kCIQnuNxxP4AO39+sQk4jdE1h5Sr+PjG9IQbSars9
         TaqhhxmKgB8tWK2fe6qXSl125HmEIzQBP3PJXojL0nY3EoY9XbK4un6HsJbKgmQsQ4Wc
         qnemXtxWbTIVmOELxDnt4wELRyBuGgwsBfnXXtprFADXMioceDmk/a4THTu30oCZfZM1
         ZI+jEZMBVuDfUq0l+SiP+XU03JZqhAeTRBdpSkUMFBthRRYP9XNgEPOLHHIoFhnp4987
         +rRg==
X-Gm-Message-State: ANoB5pmau7IlB457q0uLx3/Tymi8NkRj4+BfmxMYbSWla6w+HnSqvemX
        wfCIt72QmwtI0J1wABAf8D1dehe9gH0=
X-Google-Smtp-Source: AA0mqf4jJlRrBYwhxaQlDSN+0PtPMsrPVDdBE7UYpsBaq4zBa6H54NE8TQyh/k7u9Sdr3GBz0t9f5Q==
X-Received: by 2002:a4a:d02b:0:b0:49f:47e:de57 with SMTP id w11-20020a4ad02b000000b0049f047ede57mr1948607oor.6.1670560440204;
        Thu, 08 Dec 2022 20:34:00 -0800 (PST)
Received: from [172.17.0.2] ([13.84.157.154])
        by smtp.gmail.com with ESMTPSA id c127-20020a4a4f85000000b004a0ad937ccdsm107107oob.1.2022.12.08.20.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 20:33:59 -0800 (PST)
Message-ID: <6392bab7.4a0a0220.1d0d9.0515@mx.google.com>
Date:   Thu, 08 Dec 2022 20:33:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3089061436973064717=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/5] shared/att: Fix not requeueing in the same channel
In-Reply-To: <20221209010314.707606-1-luiz.dentz@gmail.com>
References: <20221209010314.707606-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3089061436973064717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=703146

---Test result---

Test Summary:
CheckPatch                    FAIL      2.52 seconds
GitLint                       PASS      1.41 seconds
BuildEll                      PASS      27.40 seconds
BluezMake                     PASS      1009.44 seconds
MakeCheck                     PASS      11.49 seconds
MakeDistcheck                 PASS      149.64 seconds
CheckValgrind                 PASS      248.26 seconds
bluezmakeextell               PASS      97.45 seconds
IncrementalBuild              PASS      4456.90 seconds
ScanBuild                     PASS      1048.52 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,3/5] shared/bap: Read PAC Sink/Source if respective location is found
WARNING:TYPO_SPELLING: 'occured' may be misspelled - perhaps 'occurred'?
#86: 
means an error must have occured so this attempt to read the records
                         ^^^^^^^

/github/workspace/src/src/13069110.patch total: 0 errors, 1 warnings, 158 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13069110.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3089061436973064717==--
