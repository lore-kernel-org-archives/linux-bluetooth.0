Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5907AC6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 12:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiIWMZd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 08:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiIWMYb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 08:24:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C8E13E34
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 05:19:41 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l10so11574319plb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 05:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=nLJ+izHOiRyUAuD//O64Ou8s+PQAPGSjg9TxSKrgAq8=;
        b=qhbMx40J8000ikOiuFyQXVqsWBxRH7ltC08AjKUsqWt/dOih2VLo3ZqSHQQMp+lmhj
         +Bf4VOBLCiKRprHyokPonMuD50S02MZdSmgJkBzvKCHcbe75VD/4pRK9MdoDyymzTp8i
         OyXJQ+CyxrU2qo2ePU+im4LYGz/jSYeKfGNys8qpoe+NCvnSMvpUWLlWcYk9miagpafo
         vTSYDToxyr9FO3NHgZu//cuQohYdUbNQW+DMdk1nr3Sq53U7XzB6AQ93Gq9tRpWwCvcU
         ycW95ut3sc3obxYcd/tKkV7otEh6m+oBx1vI4fKWInd0XmIruFhHxSj4E0ZWbRO+CX/n
         7+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=nLJ+izHOiRyUAuD//O64Ou8s+PQAPGSjg9TxSKrgAq8=;
        b=Jc3BJLBuu0nxwnvqsKfSGtNO3MgsQMytCwzr6muZsNL9+xKSgrrEDWgRw5A3lZ2Hlz
         U+Ceq74Gf3WA8YtGLP4xByYgkKKIKDzMGODAfmwYYwyFzH0DlpjQ3+WwfeYi0rdTgyUs
         ThTLnoLBCwg5FFWc288h6/oZ/j/Rf9UR0eUG+dSuirOawGkIqnkKM5hzPpc4zhpku9oD
         ErmetOTsu0FaJvBbkSK4PUWvpf9HHOnvH+qsL8p3rLZ1hCj5cP4NOhlnCuGKVW/vxQof
         qz5ZPZ4iviwUOIFM2I1O/yYjyXukzC9AynpqE9TJ7J7XwtSJ11qpJQLEm7TIsB/i9PS+
         0dqQ==
X-Gm-Message-State: ACrzQf0eXY9d8Bi2RUMslx/xccTeBmUnKcsDEGa99jA2h2wVDR5fElep
        V49uEFvpGA2iCW3kv5rt83QvC3MyL9o=
X-Google-Smtp-Source: AMsMyM6eMVMhAIqXHhDj/jNZffkIrdAfEA1RMAx37b2CH4r26Kcd2L64sjTO5R9tttncfgL+iLxq1Q==
X-Received: by 2002:a17:90b:1bc3:b0:203:84d:59b1 with SMTP id oa3-20020a17090b1bc300b00203084d59b1mr21215912pjb.37.1663935580170;
        Fri, 23 Sep 2022 05:19:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.85.178])
        by smtp.gmail.com with ESMTPSA id h32-20020a635760000000b004340d105fd4sm5542637pgm.21.2022.09.23.05.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 05:19:39 -0700 (PDT)
Message-ID: <632da45b.630a0220.af032.b813@mx.google.com>
Date:   Fri, 23 Sep 2022 05:19:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0233064075733175249=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [BlueZ,1/3] client/player: fix printf format string
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220923105141.20176-1-ceggers@arri.de>
References: <20220923105141.20176-1-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0233064075733175249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=679835

---Test result---

Test Summary:
CheckPatch                    PASS      2.07 seconds
GitLint                       PASS      1.40 seconds
Prep - Setup ELL              PASS      33.40 seconds
Build - Prep                  PASS      0.86 seconds
Build - Configure             PASS      10.63 seconds
Build - Make                  PASS      1109.03 seconds
Make Check                    PASS      13.06 seconds
Make Check w/Valgrind         PASS      357.62 seconds
Make Distcheck                PASS      304.53 seconds
Build w/ext ELL - Configure   PASS      10.74 seconds
Build w/ext ELL - Make        PASS      108.05 seconds
Incremental Build w/ patches  PASS      377.76 seconds
Scan Build                    WARNING   772.37 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
monitor/analyze.c:381:2: warning: Value stored to 'data' is never read
        data += sizeof(*hdr);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:382:2: warning: Value stored to 'size' is never read
        size -= sizeof(*hdr);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:398:2: warning: Value stored to 'data' is never read
        data += sizeof(*evt);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:399:2: warning: Value stored to 'size' is never read
        size -= sizeof(*evt);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:418:2: warning: Value stored to 'data' is never read
        data += sizeof(*evt);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:419:2: warning: Value stored to 'size' is never read
        size -= sizeof(*evt);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:527:2: warning: Value stored to 'data' is never read
        data += sizeof(subtype);
        ^       ~~~~~~~~~~~~~~~
monitor/analyze.c:528:2: warning: Value stored to 'size' is never read
        size -= sizeof(subtype);
        ^       ~~~~~~~~~~~~~~~
monitor/analyze.c:629:2: warning: Value stored to 'data' is never read
        data += sizeof(*hdr);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:630:2: warning: Value stored to 'size' is never read
        size -= sizeof(*hdr);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:646:2: warning: Value stored to 'data' is never read
        data += sizeof(*hdr);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:647:2: warning: Value stored to 'size' is never read
        size -= sizeof(*hdr);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:710:2: warning: Value stored to 'data' is never read
        data += sizeof(*hdr);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:711:2: warning: Value stored to 'size' is never read
        size -= sizeof(*hdr);
        ^       ~~~~~~~~~~~~
14 warnings generated.
monitor/packet.c:410:4: warning: Value stored to 'ts_pos' is never read
                        ts_pos += n;
                        ^         ~
monitor/packet.c:455:4: warning: Value stored to 'pos' is never read
                        pos += n;
                        ^      ~
monitor/packet.c:7477:2: warning: Value stored to 'mask' is never read
        mask = tx_phys;
        ^      ~~~~~~~
monitor/packet.c:7485:2: warning: Value stored to 'mask' is never read
        mask = rx_phys;
        ^      ~~~~~~~
monitor/packet.c:11229:3: warning: Value stored to 'str' is never read
                str = "AoA Constant Tone Extension";
                ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
monitor/packet.c:11232:3: warning: Value stored to 'str' is never read
                str = "AoA Constant Tone Extension with 1us slots";
                ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
monitor/packet.c:11235:3: warning: Value stored to 'str' is never read
                str = "AoD Constant Tone Extension with 2us slots";
                ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
monitor/packet.c:11238:3: warning: Value stored to 'str' is never read
                str = "No Constant Tone Extension";
                ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
monitor/packet.c:11241:3: warning: Value stored to 'str' is never read
                str = "Reserved";
                ^     ~~~~~~~~~~
monitor/packet.c:11242:3: warning: Value stored to 'color_on' is never read
                color_on = COLOR_RED;
                ^          ~~~~~~~~~
10 warnings generated.




---
Regards,
Linux Bluetooth


--===============0233064075733175249==--
