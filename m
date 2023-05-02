Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8363C77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 01:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjEBBcM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 May 2023 21:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEBBcK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 May 2023 21:32:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C161BEF
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 May 2023 18:32:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso3703548b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 May 2023 18:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682991128; x=1685583128;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0rq5fO4pn1ikP+6FczohggTsv1Jy0IYHBlFQlmbzD0=;
        b=JK1OZDKZU6DUdIZCV+S7/AKcN1fVt5Tdkcornj2j1REfOWchEelTpPhdEtZsyP0vrt
         T8Iuueer0BYZfprhw8v8QtPp8ACt3w2ogVz7tIYhSXD5xbpXoXyrRZGZjyneO9LKjME1
         0zuIlfCxMgWCTEQVdazI102rR5K4ei6XOb7X3wSO6hcHKSClsMrCm1JaFcwvDjXYNMXS
         1s6N3DLK9uUm2ltUQmrsNrogUnRmBapHeAb+bS3xQniI8QA7nsPYTIiLnuJ15nWOL1hM
         75KS0r539uYHCip6NBEDds9kYCU6yJg+Y0sn4BDslWGheQv1sBmCsaKJy5+IxCwcDk4E
         8iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682991128; x=1685583128;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0rq5fO4pn1ikP+6FczohggTsv1Jy0IYHBlFQlmbzD0=;
        b=C7BkAJFvxi0xJQkSvwDnELdx160cWlZseK90vXGPEPLHQm4K48NB0z6mQ1DvQVv2NV
         uNKDQ78vcmrfSi9vO2Af0MdMRL8qpcDJrxbINEgvAOK6tabbTOzgTcaj+esMvT3glEFs
         2B5LLmKnU/K34UNFgjnkfunTUx+gT6niNNuXKaM2i/bdgk66ccuvN8oe7gloTfUrep2W
         cq+r8HfCvjPlbJJTcc2NDwj4JT0CUFUwXbYDpqj5qWi9/q3ZP6HrusL/2+gejXl6U0hl
         +DgPlH8CCsNt1G00V1wdwiYj1c1n77ywkviAMEprPT7F7a8+O5cR15wlPRVku4sNWo+x
         lQUg==
X-Gm-Message-State: AC+VfDyQrGX+JM7EavVNMTjDWqA8fixA461vYefeFX+P0q6BhUSVV8Eb
        WNoqBqaHpyDRAhxWZq47MxpKuNuhh4g=
X-Google-Smtp-Source: ACHHUZ6Mr5I2lfD1/zQBuD0Lk/DPXBCD5iEsAjqNQVoUS9lBh5n9S6be5mnIcdZjxe7/PZ2FHeQhMA==
X-Received: by 2002:a05:6a00:2e1a:b0:5a8:aca5:817d with SMTP id fc26-20020a056a002e1a00b005a8aca5817dmr23399660pfb.5.1682991128276;
        Mon, 01 May 2023 18:32:08 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.5.200])
        by smtp.gmail.com with ESMTPSA id 188-20020a6219c5000000b00640e01dfba0sm14142266pfz.175.2023.05.01.18.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 18:32:07 -0700 (PDT)
Message-ID: <64506817.620a0220.1bf91.dbfc@mx.google.com>
Date:   Mon, 01 May 2023 18:32:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0120475352813642945=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/4] client/player: Add support for Metadata in BAP Profile
In-Reply-To: <20230501224410.1119023-1-luiz.dentz@gmail.com>
References: <20230501224410.1119023-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0120475352813642945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=744260

---Test result---

Test Summary:
CheckPatch                    FAIL      2.24 seconds
GitLint                       PASS      1.13 seconds
BuildEll                      PASS      37.12 seconds
BluezMake                     PASS      1257.00 seconds
MakeCheck                     PASS      13.05 seconds
MakeDistcheck                 PASS      204.41 seconds
CheckValgrind                 PASS      328.74 seconds
CheckSmatch                   WARNING   455.54 seconds
bluezmakeextell               PASS      137.58 seconds
IncrementalBuild              PASS      4310.09 seconds
ScanBuild                     PASS      1440.05 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,4/4] shared/shell: Fix smatch warning
WARNING:EMAIL_SUBJECT: A patch subject line should describe the change not the tool that found it
#72: 
Subject: [BlueZ PATCH v3 4/4] shared/shell: Fix smatch warning

/github/workspace/src/src/13228364.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13228364.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):


---
Regards,
Linux Bluetooth


--===============0120475352813642945==--
