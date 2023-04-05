Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFD5C7619A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 12:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbjDEMVJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 08:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjDEMVI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 08:21:08 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57764EED
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 05:21:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id cu12so23524400pfb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Apr 2023 05:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680697264;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=24y4xvuqm2QTtJeN4F6nnObiqeKpXBVzTchWqBmEtis=;
        b=DkrNs6J1Dy2zq4ws7tYq3klj9iuxMhvDnnwzfcCizB+76EVcS+iJTaoZp/gb2ztZaM
         1zLcq7b6pjTUWlrmPyqXMH/Q2lRi5iADR2Lh30sQ+PNXKTSnpjgGf/4Nb/6fjo9JoGDd
         Q4eQvQtV1C2SIuMD8bZF9dYEELED65wxSl/kSeO3OCo0F5/dakVeZat6VS1APpOLXB7M
         6MW11po39z51tHd8FWw1vKhtXCwZN/t0fmNopB6V9rgSn/jA6LY9BLu2uaN2mAB37aYp
         NR6BcrmVaY9yHnxmFtzfO2qQhbaAtncVKV+SfHIUVVqBab6373cK13VsWVn9JAMHLO2w
         BpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680697264;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24y4xvuqm2QTtJeN4F6nnObiqeKpXBVzTchWqBmEtis=;
        b=sFnGkp9WAvXaj6dnkrIQuD+gGZJNkGA4DeTOyJJQM5EcliTR+96upggNtmV0uR3eab
         GRdGiB+85GlK/ihkknGg6RGBrGXyvmb3PV5gavugZoyg/Ffi5cnKy71WWe6N3Z7wRS+g
         TH9kyL+4w48UmTuufe/4PO5whG8wwgnlxGnZ0BdTKiOxx8+B7Fq1Cn91g/OPa5yXicib
         hx/pEL0sUhImuYL18oRw2QnqaarhVqoIMLKAS2wmslV1cJTSSa6x/7j4tqMWpRVeYNj5
         Gxir6bC0Clg/nXnLzoq9UqeGmRvkKRKrOmYm0PvbOx4QNUXwFYYYKiOai9yYhgaEcSdZ
         ISqQ==
X-Gm-Message-State: AAQBX9fiy7K+arCJkqTu28iNtqCK7hwxBxa7EcRh80V5pKYsGrNPagc/
        f0xBaW6vAoXrRIZBIO5VjopMro6kdOs=
X-Google-Smtp-Source: AKy350YYCLLkBF1flTMbJ9f9IAgMNFU4yUtW5Lm1w7otzqx5vIAAQ47jxp74h6dlmYfz7ETCDp/AgA==
X-Received: by 2002:a62:1757:0:b0:625:13f3:9409 with SMTP id 84-20020a621757000000b0062513f39409mr4422621pfx.26.1680697263694;
        Wed, 05 Apr 2023 05:21:03 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.61.32])
        by smtp.gmail.com with ESMTPSA id r14-20020a632b0e000000b005030a00085asm9340120pgr.46.2023.04.05.05.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 05:21:03 -0700 (PDT)
Message-ID: <642d67af.630a0220.e52ca.3609@mx.google.com>
Date:   Wed, 05 Apr 2023 05:21:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3658167039473265271=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: monitor/att: Add decoding support for BASS
In-Reply-To: <20230405105442.14281-2-iulia.tanasescu@nxp.com>
References: <20230405105442.14281-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3658167039473265271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=737147

---Test result---

Test Summary:
CheckPatch                    PASS      0.83 seconds
GitLint                       FAIL      0.60 seconds
BuildEll                      PASS      32.86 seconds
BluezMake                     PASS      986.54 seconds
MakeCheck                     PASS      12.82 seconds
MakeDistcheck                 PASS      177.75 seconds
CheckValgrind                 PASS      292.17 seconds
CheckSmatch                   WARNING   388.45 seconds
bluezmakeextell               PASS      115.23 seconds
IncrementalBuild              PASS      809.55 seconds
ScanBuild                     PASS      1209.26 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/1] monitor/att: Add decoding support for BASS

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
33: B2 Line has trailing whitespace: "        Value: "
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============3658167039473265271==--
