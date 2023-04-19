Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834F7C77B73
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 15:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjDSPaO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 11:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjDSPaK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 11:30:10 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473703AAA
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 08:30:09 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6a5f7d10dd5so1496177a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681918208; x=1684510208;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7yRNSuG6h8PA9hp5jzyCyHI3oHKK+DOLJcXH4tmRshs=;
        b=X4vON1p/WNUd/zkqsVrRp3pjb9Jpa4BfPWbDpG0dN/VnUxZyhcJ9YRgolhkI0aTmHq
         shV/imppHTB6gKrQt6mcAohGHVwlkrQZrGYHIuy1ENKn6o3CFHuV7j2fx6n5G7ezRv//
         GAqy9tFrSMC944xH4w/ph97w1/9jGDo+JHPyEe47lLG+o3681C7GI/mu5zis0t1fniLm
         W5e0uqbicOX0BCP6FLPnY3vGju+sPdCkeZv0f/wI2kqVLKlBhzdF/eGTENuZvrNWe3Z7
         LRfqm7f7vm+fYbfXSBWI0Cvw79EOU8XdwZwv58sSbrruF5fEukI5huriH1s7F4Du6eGq
         yZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681918208; x=1684510208;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yRNSuG6h8PA9hp5jzyCyHI3oHKK+DOLJcXH4tmRshs=;
        b=Z5CR5GF3LvxeAaB+6wo+6Io5RNhD2OOHj7LpTxqipfrdgp5oY86Hd0IlBou2gM+7je
         cgev7u+6DOl6vvxgue2SiIavOLALcUjVlqACL1+583SfGOtO3rGrylzzsXipIC/iZJaX
         oVEYIlbjGRf9zQGFe4UVCPQXqb6ZFMcfBXBjTecbWpsX0zI4Ae7yrJVgIkKTembP1lqr
         JiRyFYHz9XUEcGjWtiLzrJ6dW+9exD5+T2ytL9QQCGfNp9jqwtuK79+nPRUK9E1rIf4s
         2U97NQoacW5RRi8G4PqqjqH4fN3voAix27UzpMr35PFTIAF3guAqNsruOGuuRM+o91d9
         pwuA==
X-Gm-Message-State: AAQBX9fcOWKg2uN7ECQ3kcdrPX3GZyLyQ7Qbnlv7iZrjrR2IjIgTYNRP
        gwGS1wk/pQD7+GxpvQlQX5sreUXjFAg=
X-Google-Smtp-Source: AKy350ZN5ewikgoXAa7D/3qchKFFocRuSrnK0n34apfq5VFFYgCCdim0DzCefdeS7rSngFlLM+MAiA==
X-Received: by 2002:a05:6830:1315:b0:6a5:eaf1:d744 with SMTP id p21-20020a056830131500b006a5eaf1d744mr2921990otq.35.1681918208455;
        Wed, 19 Apr 2023 08:30:08 -0700 (PDT)
Received: from [172.17.0.2] ([52.171.141.226])
        by smtp.gmail.com with ESMTPSA id m1-20020a9d6ac1000000b006a1287ccce6sm6719803otq.31.2023.04.19.08.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:30:07 -0700 (PDT)
Message-ID: <644008ff.9d0a0220.dfbca.1c74@mx.google.com>
Date:   Wed, 19 Apr 2023 08:30:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2723451424607868744=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Add additional Broadcast tests/options
In-Reply-To: <20230419134354.61950-2-iulia.tanasescu@nxp.com>
References: <20230419134354.61950-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2723451424607868744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=741362

---Test result---

Test Summary:
CheckPatch                    PASS      1.38 seconds
GitLint                       PASS      0.86 seconds
BuildEll                      PASS      27.03 seconds
BluezMake                     PASS      805.57 seconds
MakeCheck                     PASS      10.96 seconds
MakeDistcheck                 PASS      153.72 seconds
CheckValgrind                 PASS      247.22 seconds
CheckSmatch                   WARNING   328.39 seconds
bluezmakeextell               PASS      98.60 seconds
IncrementalBuild              PASS      1890.85 seconds
ScanBuild                     WARNING   995.64 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1800:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3552:52: warning: array of flexible structuresmonitor/bt.h:3540:40: warning: array of flexible structuresemulator/btdev.c:413:29: warning: Variable length array is used.emulator/bthost.c:584:28: warning: Variable length array is used.emulator/bthost.c:741:28: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1074:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1386:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn')
        send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
                   ^~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============2723451424607868744==--
