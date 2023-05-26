Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473C2C7EE2E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 May 2023 02:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjEZCWC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 22:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjEZCV4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 22:21:56 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE0B13D
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 19:21:52 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39425ea8e1fso221855b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 19:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685067712; x=1687659712;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b69SRt38ujxQqTX5SKpu3rLoc/QRaNQgDQDwu6pL8aY=;
        b=BhDtpXPzsuGvFWWBLvWccSOCZltGoP+lNcgJx+p+N+8qlZRVUDGt+YFD1OoCRPY6m4
         l+nY1C7Pp3eYzc+jLHMfgsSW6IJVWchcaH4rt7w2sG3WSYrjVpL3WFEKi+11kzC7M8O0
         OFV8XXt4YHrYSuX2XH0tySKsRW+wzT8E714VM8ZW3oB2MH646EO9HDdTnjkjrsDRAW39
         zxNFJwh90qNx7QO8qiC4nBTtXTkK2qbW7wrgHp/jZY1Up79DnlDKe22rtESa1yzYzbZ+
         vg/6ldRTkjajG/FGPlPWF3V/LKcvGNFCXX21bsEuPHeRSUG5ybKOn8Ohsv0bxSc9gVMG
         xGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685067712; x=1687659712;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b69SRt38ujxQqTX5SKpu3rLoc/QRaNQgDQDwu6pL8aY=;
        b=kN1anGtJtp9iyuc7M9oseESrWsglmrbr74P3Hri0ReWGUv1ePnDO5E8pkVeL+6yo2i
         gBp/fUR5rWMfFVauSqxI+onZcO2rS3xQHgqQNiLLZJD4/Wnp3CfwsvnIFgkDWx8c0WRw
         j4Zbo//7RbWcREkeW4erP/pTH/wLUu4M7o0ry11jn7VwdRjCvlBy3opNhe7bslmcW0H2
         cvKvFk7mwDn+bhlXCWWP+GdGU352tXRI2e+sMnF03id59IxBXcc8ZIP0M0J9LGVEYsOz
         1uhmz0ottojoH8lw3z//9XfYkfLSw6zlWkl0wWGibX7k6L1RhX8U/iV6DHQBnnSRq0oT
         /E9g==
X-Gm-Message-State: AC+VfDx1J9i8S495JHvX4iWGSR5EwD5yQ7bfEPhm3BtXqcBOvrp0Un1d
        L/MlRJXkyJJWbmNfUP3vFaeggmmeF1Y=
X-Google-Smtp-Source: ACHHUZ76OuKR7W4BpEXQiTV3uGeJ420ICn6vHTrXtrl2CMgoU9btcHboPuX1nkifdFQjAGwxOJ90Vw==
X-Received: by 2002:a05:6808:286:b0:398:1157:91a9 with SMTP id z6-20020a056808028600b00398115791a9mr247886oic.26.1685067711832;
        Thu, 25 May 2023 19:21:51 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.224])
        by smtp.gmail.com with ESMTPSA id y9-20020acae109000000b003985cac8820sm1214543oig.16.2023.05.25.19.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 19:21:51 -0700 (PDT)
Message-ID: <647017bf.ca0a0220.e87d3.6316@mx.google.com>
Date:   Thu, 25 May 2023 19:21:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5638977562601126189=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Print process information
In-Reply-To: <20230525234621.3597759-1-luiz.dentz@gmail.com>
References: <20230525234621.3597759-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5638977562601126189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=751131

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      33.89 seconds
BluezMake                     PASS      1159.05 seconds
MakeCheck                     PASS      12.70 seconds
MakeDistcheck                 PASS      190.13 seconds
CheckValgrind                 PASS      310.78 seconds
CheckSmatch                   WARNING   427.69 seconds
bluezmakeextell               PASS      126.96 seconds
IncrementalBuild              PASS      994.27 seconds
ScanBuild                     WARNING   1366.89 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3552:52: warning: array of flexible structuresmonitor/bt.h:3540:40: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
monitor/packet.c:12367:2: warning: Null pointer passed to 2nd parameter expecting 'nonnull'
        memcpy(tx, tv, sizeof(*tv));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============5638977562601126189==--
