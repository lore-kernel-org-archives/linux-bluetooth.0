Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AADFC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Nov 2022 07:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiKHHQE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiKHHQB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Nov 2022 02:16:01 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF7131F82
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Nov 2022 23:15:58 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id ml12so9755093qvb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Nov 2022 23:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=31PzCYYqOYeymeHQlU2EObGRfsMGe9VxoST1YDoOV08=;
        b=agFYHIEUuTP0nZQwb+UpNminvzJgqmYn4ZLXTOM5zognrl7eE0tToaOSClraYD07xn
         Bl/Tu48IJpwYRKmRbAywuzVajhYEcRDdsezfsyq32E2p3Ov1yqy7fi8x1GCLbNAk/qjv
         YgcMpn++3rpcpeX8xPiY7nOVUL7trMa2IIjLp6HH3vq8/VwElKRL1W0VNcVehAcDTYiD
         QrrmfRDJE55xbTRQ/ID7/43S/olgHIZReBrU/kSbjAQ18unf6qCUaRJz6bDVwarnjp6j
         1z6bEj1y2oBNpqlvKDHaXvIlZypqZMsS2BiJ1L7e8Er1ij6HKwy1T/DG4J/mdCrKn2bt
         OUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31PzCYYqOYeymeHQlU2EObGRfsMGe9VxoST1YDoOV08=;
        b=irDP+E2gQsse+yCvlmad7cFVNfaNtob9SDL+t2nqQjD2jq2LfOdDMtaAP4hnqMp9Ha
         I3ThSUd1hd4P8Ej+5f03B+O1mEJpVuzEG/4exQHCakRCjFq5P0WkJRckedSMhA/wfA51
         io6SBnt8mUAeUMujY5c8F2YaTFwZLDePeXKuw8pi4IvyLC1bNqrufyZ2uwPgNKrVmE3U
         C2hGhEIu7xOkxzYNOGxaCtk/qkSzqeKhf6WoPlZAFBRNDruwuAnXhXuTVGrjBwFUFTpR
         Q1vdGAQZvQgU6eB1Du3wr1ZyVc65tbyoe9XCGU5FMrkLnmoTQn3PNEquuj49nK3wG7Q7
         0icA==
X-Gm-Message-State: ACrzQf1hpG3u0+6NWbYPguFROvcJl+v4lD3KaWNPkujz9fnhQrN0M9a7
        TaWMRWdshmFEU6AzIkwnLDA4vuroU1vHUA==
X-Google-Smtp-Source: AMsMyM4mxSHcSlTmNNrWl4nEXZuC8El+89fW676epfXNJ5MuCWI94R3rBzyivwPShN5/i2YbRPk9Tg==
X-Received: by 2002:a0c:e449:0:b0:4b9:cfc3:b31a with SMTP id d9-20020a0ce449000000b004b9cfc3b31amr48548068qvm.35.1667891757590;
        Mon, 07 Nov 2022 23:15:57 -0800 (PST)
Received: from [172.17.0.2] ([172.174.55.127])
        by smtp.gmail.com with ESMTPSA id b3-20020ac87fc3000000b003a56796a764sm7806760qtk.25.2022.11.07.23.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 23:15:57 -0800 (PST)
Message-ID: <636a022d.c80a0220.b75f.108e@mx.google.com>
Date:   Mon, 07 Nov 2022 23:15:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7210393194100368504=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org,
        dominique.martinet@atmark-techno.com
Subject: RE: Add serdev support for hci h4
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221108055531.2176793-2-dominique.martinet@atmark-techno.com>
References: <20221108055531.2176793-2-dominique.martinet@atmark-techno.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7210393194100368504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=693092

---Test result---

Test Summary:
CheckPatch                    FAIL      1.79 seconds
GitLint                       PASS      2.09 seconds
SubjectPrefix                 FAIL      1.79 seconds
BuildKernel                   PASS      34.54 seconds
BuildKernel32                 PASS      30.74 seconds
Incremental Build with patchesPASS      55.10 seconds
TestRunner: Setup             PASS      516.75 seconds
TestRunner: l2cap-tester      PASS      17.74 seconds
TestRunner: iso-tester        PASS      17.16 seconds
TestRunner: bnep-tester       PASS      6.69 seconds
TestRunner: mgmt-tester       PASS      107.68 seconds
TestRunner: rfcomm-tester     PASS      10.57 seconds
TestRunner: sco-tester        PASS      10.02 seconds
TestRunner: ioctl-tester      PASS      11.47 seconds
TestRunner: mesh-tester       PASS      8.17 seconds
TestRunner: smp-tester        PASS      9.94 seconds
TestRunner: userchan-tester   PASS      6.99 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.79 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[RFC,1/2] dt-bindings: net: h4-bluetooth: add new bindings for hci_h4\WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#114: 
new file mode 100644

total: 0 errors, 1 warnings, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13035921.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL - 1.79 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============7210393194100368504==--
