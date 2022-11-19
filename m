Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F91C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 03:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiKSDsI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 22:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiKSDrG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 22:47:06 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D43CBFF6F
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:46:55 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id r81so5248259iod.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kTua1T8GByZt+y3D0ajO9VAFmVtY5EUhzq1dy/UNlcw=;
        b=YXsqL/CFp1Zns0aRdK7hV5lyL1Xxz6USFGnrcpcT0q5Y4Wcg7y4E9Y+QEMKWVFlyYZ
         Zd86hVRKgdCZgCc9K1Ee4UR+W7RawxYbSTohLgVO6C0V7bO1GEfa8UWX1R1uHt3hRJxC
         MGcpbgAxQxpSbfyfQVDbbDrroXNZ2EOY8aCojqqcgPNnVbLsOnOVTOlN3ZCWj+LccvvL
         Zj3iWE35/aY5XHrEumnd/IWvxTSzfIoSp8Op3DFS7NjI4WQs4Qeji6X6gCe/wUjdp3vS
         mQYU5c15XzDDeOwnfeB4VqQAnqXYhoTtHk4/kiutQH2hUIUrC1bsdIFV/kXYsSkRT4M4
         Rtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTua1T8GByZt+y3D0ajO9VAFmVtY5EUhzq1dy/UNlcw=;
        b=A73n7+Iez0j67iIpIQIGxem/GaWsDhFI4Mq9O1Vs2LCvYE/jkkp6i1d4GBK3VfsVXt
         h1S3m5X6TSDy6Ws14ZtNpZOUbFY6/DMeR5Ol0gKlKN1iiRfzvuliSs7ZMgoztjvTW6c/
         puAp5zzUg9U8GuDHA9E+8nwY7xCnbyv34KZ1xFROHe/5GvE6qGdjso6QqBmorvLt+2iA
         EHTrbgqjB478A9Niki4EmF3lFVyeSUlDMRogE6q5StjSMB2flfX+JlbWNx+lTCOUaESw
         R5H7CzahrjUWuXb9L0bbRcor46+c/M2SeytDYpalT1H9pr/hAiFGB2PjsgN9s2royJuX
         mlSQ==
X-Gm-Message-State: ANoB5pnxJ41AdHED1tApe0DdBn05GVn7I8DKIJmrsVjMsDFWaN3uSzL/
        6u8/Dzv/UAiZ0ktV8FbbETcmCLYMIWY=
X-Google-Smtp-Source: AA0mqf4/XHMrRoc0pYuqBczc/JMIFjA7yPG79pkAb9IjqwQAZRCtdRCoXLUAKNFlxw0d4oT5zzpb2w==
X-Received: by 2002:a5d:884f:0:b0:6a1:2062:9855 with SMTP id t15-20020a5d884f000000b006a120629855mr4691560ios.214.1668829614384;
        Fri, 18 Nov 2022 19:46:54 -0800 (PST)
Received: from [172.17.0.2] ([20.9.79.185])
        by smtp.gmail.com with ESMTPSA id s22-20020a0566022bd600b006a102cb4900sm1962722iov.39.2022.11.18.19.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:54 -0800 (PST)
Message-ID: <637851ae.050a0220.6c8d0.4712@mx.google.com>
Date:   Fri, 18 Nov 2022 19:46:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6898934298534600909=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3] doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052513.57081-1-hj.tedd.an@gmail.com>
References: <20221116052513.57081-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6898934298534600909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695796

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      26.26 seconds
BluezMake                     PASS      739.13 seconds
MakeCheck                     PASS      10.79 seconds
MakeDistcheck                 PASS      143.81 seconds
CheckValgrind                 PASS      238.37 seconds
bluezmakeextell               PASS      92.29 seconds
IncrementalBuild              PASS      595.56 seconds
ScanBuild                     PASS      934.18 seconds



---
Regards,
Linux Bluetooth


--===============6898934298534600909==--
