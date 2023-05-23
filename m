Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8548C7EE26
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 22:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjEWWWA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 18:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjEWWV7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 18:21:59 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F9783
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 15:21:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so46883b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 15:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684880516; x=1687472516;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KK8aGiC4NXh53F/yKO9/KJKwIN+VDWzbhPz/sccyLb8=;
        b=nR+EGgbqPEv83ybIeKLmf6n+H8HJS53B0tSt2ZF9oZ3mcBAcfu2PIpA4qdg7sgDB5g
         VEwCE4ePcsASx2P9nwyCpcKPYKac3l/e/tUGqJP5T240/PwqX/4ef6WJlpoVVDWva4lr
         OxDH7/NfeygoNbVkqMyjOp2F5XqgmhSh740K3sd7CynOVA8IuEj4BW0+CfdS8P9zvszO
         5EMqVpie2l32XSPceCOabDyA9C9Hjiq/rGHRXHgILLON3HpjgQGZ1FldgwjdqfNnk33X
         ju0RZqzUBJ1Rily5C8gTYQxgyEUXwOECS/H6RhejrEoAH0/PgRp80cgGiAqwmTgqmwiR
         Qgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684880516; x=1687472516;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KK8aGiC4NXh53F/yKO9/KJKwIN+VDWzbhPz/sccyLb8=;
        b=b2NSLaNdlnPV+FFSqU+Qd1x3tBDst/Bm2Mm4RFswfUGC9aWEcGKEm7Dzeu2PyzCB9y
         8JQFST90QGKRQHCiq4wFVfIzGWtDliBLiYZdtz68bS+VISJRie1o8j+62rcOQBZiqVoY
         qNeC/Zx+EuNMyjV18geIeyBIzfuu5Sm8GgIu2HI9TTfqdX6g11xyCnDZAMf+HCYkcAk3
         Cvc8Fw7mHZYRe0ovbMzp1dFQr18fU/U5zmb4XXvEZA8uwlioO21qBkWhn2rjFtMYMLFE
         IrbX0tlH6hJ1mgJWr8iYmHm6/AO/JIMUDzOSS/BTThkp5Luprd7kZB90i4RIQvrXWXg2
         /ezg==
X-Gm-Message-State: AC+VfDyDwhb49b0KXt8ENYNDadiQ1EMoP2IlLJzPKr10YHjN175fR398
        AaVNh9G4dUSWn+u+8TDg/lgEOPP9EGM=
X-Google-Smtp-Source: ACHHUZ72uxWiRFOFvvhzPfSJg5Mctux6F9PzoSNS8ObRXfhrZQEAIKFQWX++TZZD/7UnIu9Wi8++gQ==
X-Received: by 2002:a05:6a00:23c8:b0:64c:c65f:7322 with SMTP id g8-20020a056a0023c800b0064cc65f7322mr442282pfc.30.1684880516130;
        Tue, 23 May 2023 15:21:56 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.100.246])
        by smtp.gmail.com with ESMTPSA id s20-20020aa78d54000000b0064d413caea6sm751295pfe.179.2023.05.23.15.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 15:21:55 -0700 (PDT)
Message-ID: <646d3c83.a70a0220.5556b.2759@mx.google.com>
Date:   Tue, 23 May 2023 15:21:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3741791772724924810=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Add latency information per channel
In-Reply-To: <20230523205855.2821370-1-luiz.dentz@gmail.com>
References: <20230523205855.2821370-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3741791772724924810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=750409

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      32.70 seconds
BluezMake                     PASS      1010.57 seconds
MakeCheck                     PASS      13.09 seconds
MakeDistcheck                 PASS      186.28 seconds
CheckValgrind                 PASS      301.29 seconds
CheckSmatch                   WARNING   402.43 seconds
bluezmakeextell               PASS      122.56 seconds
IncrementalBuild              PASS      819.97 seconds
ScanBuild                     WARNING   1262.08 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/l2cap.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1806:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3552:52: warning: array of flexible structuresmonitor/bt.h:3540:40: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
monitor/l2cap.c:1640:4: warning: Value stored to 'data' is never read
                        data += len;
                        ^       ~~~
monitor/l2cap.c:1641:4: warning: Value stored to 'size' is never read
                        size -= len;
                        ^       ~~~
2 warnings generated.
monitor/packet.c:12361:2: warning: Null pointer passed to 2nd parameter expecting 'nonnull'
        memcpy(tx, tv, sizeof(*tv));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============3741791772724924810==--
