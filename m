Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B535EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jul 2023 14:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGUOdq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jul 2023 10:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjGUOdo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jul 2023 10:33:44 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8884830E8
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 07:33:39 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a3a8d21208so1452642b6e.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689950018; x=1690554818;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=15YHMqfXgxA/3Gmn+Z4R/08JemEr6ov8EUVGjbgUUiU=;
        b=bR31LYYXYIQC6IAnz1e/ukypHKFo5EkdLpBzJNuBNrCwf5QPZCX3OJLz/aT36Rm2AA
         lkwv7JmmeFBsJBzVI5ntKGhUFYHtBqQTQyAqv2ivlo9Qk9onUZiBv357vU/gxufrvGZ8
         daGaeK1tOKXqtSgor0PwYRpJbwLp/d14Cd0koIoR+8mIKSvJC0AIl6O1wT2zpY+M5kvU
         rJDUHcpXZWBSCfRfXL37CtNt6zmp57w41dKVMtS3K14bQMWHzyblHt7lC2d1jDPSV3rx
         8pfY2GbyyhGZEdSw9WJNRGP3EiU7uu52Jf08RRt/VS4sQA0ZlDgycMPjIV0TTPfO/B0K
         kV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689950018; x=1690554818;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15YHMqfXgxA/3Gmn+Z4R/08JemEr6ov8EUVGjbgUUiU=;
        b=H1rkRDOpSTC8OOWBEhr63oRP3GkMvwXfIEwW/X0hluobKOGQJAxJijdR97HLQjnvf4
         Klxj3I4qbbv0nzu6iBQp71btgSYNcR3iV1EW4sGHg02Q3hJsp0Q0Y94e9ZZmnV0lMrQ5
         MHndLgzIDNBnpg97BiQxDcL4SoN3ehV1omkCY7RgMZRMof7AEZ2S0Z4c8edIBPfdFoOv
         6e8tsdnUE1X6Uyfx4rdh5FZ0vN9rWG+dh6b0osFOb5wsfpi0xx3T//IoxIEZGdvn9FOe
         cfcVdGk1kfSoNOZKuq26+o+8UYktqY21e05Xid8bQLPSKk1JvLUvC2/er2fBtHXJsftV
         1+Ww==
X-Gm-Message-State: ABy/qLZaKFPUax0/+TwCaAZAGx3P36nzl0Z+OKVRL27Nt9kXUUkU0uuZ
        3FcOsK4JGlt32bBwyEaeE9kDkorLs+8=
X-Google-Smtp-Source: APBJJlFd0hk2yEfYu/lpAdTFNPVzQooEuFV/LLnqzEaG7p1Vwoysf7r/l/+rf6xy+yyyMPZfb0GB7A==
X-Received: by 2002:a05:6808:2a48:b0:3a1:c820:5944 with SMTP id fa8-20020a0568082a4800b003a1c8205944mr2076065oib.45.1689950018362;
        Fri, 21 Jul 2023 07:33:38 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.221.130])
        by smtp.gmail.com with ESMTPSA id 14-20020aca090e000000b003a414415693sm1443055oij.44.2023.07.21.07.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 07:33:37 -0700 (PDT)
Message-ID: <64ba9741.ca0a0220.4df92.946f@mx.google.com>
Date:   Fri, 21 Jul 2023 07:33:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1487156054519698677=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lukasz.rymanowski@codecoup.pl
Subject: RE: Minor monitor changes around Broadcast
In-Reply-To: <20230721120320.147496-2-lukasz.rymanowski@codecoup.pl>
References: <20230721120320.147496-2-lukasz.rymanowski@codecoup.pl>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1487156054519698677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=768234

---Test result---

Test Summary:
CheckPatch                    PASS      1.71 seconds
GitLint                       PASS      1.17 seconds
BuildEll                      PASS      33.72 seconds
BluezMake                     PASS      1198.26 seconds
MakeCheck                     PASS      13.50 seconds
MakeDistcheck                 PASS      201.39 seconds
CheckValgrind                 PASS      325.06 seconds
CheckSmatch                   WARNING   449.45 seconds
bluezmakeextell               PASS      132.61 seconds
IncrementalBuild              PASS      3938.19 seconds
ScanBuild                     PASS      1351.01 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3551:52: warning: array of flexible structuresmonitor/bt.h:3539:40: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3551:52: warning: array of flexible structuresmonitor/bt.h:3539:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============1487156054519698677==--
