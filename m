Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06629C7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 May 2023 08:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjE2ICi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 May 2023 04:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjE2ICf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 May 2023 04:02:35 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87956AC
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 01:02:34 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f6aa6171a6so17342581cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685347353; x=1687939353;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lt4gqpGJbCM9oHRYgaUidDYqVXw65c/wgiowT0WLSO4=;
        b=MqIblVpA637hXpbDoCF/XxH69WNq/4o87I9aTLydFma1dT8y6HKm+xM+h3TxhmbbV1
         wggNcy6/pwM2DRNO+iJyDo+jvr0uS1TYnfEsJFT7TLyBmPaSZ/i+mK0Ry1EIDsSBeANY
         8WPvi0ofn8YnxqK5SvbAtGa0MlmaUoJKsUnQJohnzM0ChmFSRJguxMaXvCtvCd1T0jl1
         VzecN/pvoaDcEisusYEBw5+OyB2xGYF40rhWmRzFUgrvpN+2BXn5ToHIaIypL1591Akl
         GXiX+Ag0NdVlUqXXHp3PUnaQ8nZvGxjS5X1Snv6SUwxt7PIxzQTPE0XU5Y1I815pjvgv
         sK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685347353; x=1687939353;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lt4gqpGJbCM9oHRYgaUidDYqVXw65c/wgiowT0WLSO4=;
        b=LfqfIqXbwBB1H3vUyIzjMJ7sk7EJPeXLUCxM1lcmyQ6WGg+lDPUysrmmrLOgmkcEW7
         pQZQAaAhqFDhU5sz35uOtfodbWw92FsEnqPJGkw9HSJ0BPR3R/MPHmeIXr3mUaadg9ei
         r0QD7zlI29DCVtlLuk/VOyt7res37QKFIrplkMWUOWVYsAIqTWtSR0qC8SsKAqjQVT3p
         s8WJXcAyILi+Ftn0MN9/QFKsDrtmg5N7g2DLrg/hQ89d/i/worAyuN4fcHaFva6eaW5R
         nZfBIwFwgFsUNyBtJvDbM+KEuQBVTdzcJsAdGzAW+g5sj5uKTI0xH5LvS3odt9l1WqGO
         JUSA==
X-Gm-Message-State: AC+VfDwrYjgcHXwimGkya5zVJOhvpDDmrLRE3pmuYCG29KYK1oDGfeVU
        pA0Hv0VsHQ4R+fZ4WNq9NnKdcYrwifk=
X-Google-Smtp-Source: ACHHUZ5/f4DuOfeeHU1l/XBj4OfC369iwIQEpNEJzZ9Ckhw6JN5zCG0zMTblcbwJP3RfWjyPgy9CFg==
X-Received: by 2002:a05:622a:1815:b0:3f6:c0c4:3712 with SMTP id t21-20020a05622a181500b003f6c0c43712mr6091736qtc.33.1685347353434;
        Mon, 29 May 2023 01:02:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.33.112])
        by smtp.gmail.com with ESMTPSA id q20-20020a05622a031400b003f6b8556547sm3645001qtw.32.2023.05.29.01.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 01:02:33 -0700 (PDT)
Message-ID: <64745c19.050a0220.9803d.dcaf@mx.google.com>
Date:   Mon, 29 May 2023 01:02:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2357861443986493307=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Add BAP Broadcast AC tests
In-Reply-To: <20230529062458.3632-2-iulia.tanasescu@nxp.com>
References: <20230529062458.3632-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2357861443986493307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=751751

---Test result---

Test Summary:
CheckPatch                    PASS      1.19 seconds
GitLint                       PASS      0.70 seconds
BuildEll                      PASS      27.73 seconds
BluezMake                     PASS      1133.60 seconds
MakeCheck                     PASS      11.93 seconds
MakeDistcheck                 PASS      165.18 seconds
CheckValgrind                 PASS      267.18 seconds
CheckSmatch                   WARNING   362.33 seconds
bluezmakeextell               PASS      109.58 seconds
IncrementalBuild              PASS      1875.52 seconds
ScanBuild                     PASS      1087.08 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:416:29: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============2357861443986493307==--
