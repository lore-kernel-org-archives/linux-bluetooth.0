Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F11BCD98C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 23:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjJJXSe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 19:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjJJXSd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 19:18:33 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450888E
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 16:18:31 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c63588b554so4233755a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 16:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696979910; x=1697584710; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NlYcBclCrOfZocHUPXSQqkeQ3lZ8boMeiRj6gqvmbuI=;
        b=hxMtCoOnECDM3Apg5gP94DaHA2zouhId15zuaWGvXAkB3kPcCkn1btMxkJfS64qMu+
         uUC/14WMtdShAsxz/eHpOhsfG3ivDUOnhO3PnVeoXOTXKOc61RzsziYEqLpzdQcA3HTS
         sVfe9v2/CCbPXVz4Z3mOTOG5G5Ic8j/Qt8qAIs3nE++0luU7m94EIqupupJvT1F3Egll
         ukpNWn4oC4sRZS8lR1oxxTo4sh12+PjSKykK1/PCrqndsywi1IrbnJaCJdcWJ7xGlque
         zSxYhYkbeZpwAqq0FhRucWTfWgL79mMANvprQReTEQrCHBli8Aop2LW6ZN21r71ApouL
         x/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696979910; x=1697584710;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlYcBclCrOfZocHUPXSQqkeQ3lZ8boMeiRj6gqvmbuI=;
        b=VdmlOczg0zGj7kmo6xEaWDgmD2yKnZzwGQIEzT6ZzsdTmbT3gaa7W5OxIuSc63kHCD
         9cPT/v7JMPnu1a4mhq0GTUTfvwoA6V1SeWanbmruJ4TcTEVe+L5wrjx7P2nWcSDjy8G1
         dqgzPOKihDTrWAZcpYmQ4bNpnVb6Jr+0hYGR7Ks5B9zOlWHHaYqgJyD9mmQNClfSi/0J
         t6nrjCVpSW3jTtCoPRrieTld05/D0ex4TvVW7NVfzXezqypuh8FemKMngv9tO+osX1lA
         +gQuOWR5lKEQw/Uzqw45PAhFZdG6cOav6dLDV6IlFB4qsK2bYDl27LAPjlwfdo51cm6k
         lk9g==
X-Gm-Message-State: AOJu0YxMwSczNPIetIXy3onYhtz42H+f1gaC7kCKrt8dGxVrRDSqImmS
        b3KXyCfzZahYJx9ck2UrmpoYw4JOsSU=
X-Google-Smtp-Source: AGHT+IFhN55IWs/UmrkWbY+hu2NOya2rIRLyquzQYZWugJrX/ir9JsCXMmHg9GQz+cfnEfV+LfKKMg==
X-Received: by 2002:a05:6870:d60e:b0:1d5:aa83:c225 with SMTP id a14-20020a056870d60e00b001d5aa83c225mr21292001oaq.21.1696979910365;
        Tue, 10 Oct 2023 16:18:30 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.229])
        by smtp.gmail.com with ESMTPSA id r6-20020a056870734600b001dd60c202e6sm2511236oal.10.2023.10.10.16.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:18:30 -0700 (PDT)
Message-ID: <6525dbc6.050a0220.56f6e.0315@mx.google.com>
Date:   Tue, 10 Oct 2023 16:18:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4367529435538727859=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] input: Fix smatch warning
In-Reply-To: <20231010215853.629963-1-luiz.dentz@gmail.com>
References: <20231010215853.629963-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4367529435538727859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=791982

---Test result---

Test Summary:
CheckPatch                    FAIL      0.66 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      28.97 seconds
BluezMake                     PASS      996.51 seconds
MakeCheck                     PASS      12.73 seconds
MakeDistcheck                 PASS      169.57 seconds
CheckValgrind                 PASS      268.41 seconds
CheckSmatch                   PASS      360.78 seconds
bluezmakeextell               PASS      111.29 seconds
IncrementalBuild              PASS      858.81 seconds
ScanBuild                     PASS      1115.70 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] input: Fix smatch warning
WARNING:EMAIL_SUBJECT: A patch subject line should describe the change not the tool that found it
#71: 
Subject: [PATCH BlueZ] input: Fix smatch warning

/github/workspace/src/src/13416197.patch total: 0 errors, 1 warnings, 48 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13416197.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4367529435538727859==--
