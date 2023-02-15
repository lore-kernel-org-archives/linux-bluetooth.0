Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C50C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Feb 2023 02:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjBOCbK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Feb 2023 21:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjBOCbJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Feb 2023 21:31:09 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB66A305C1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 18:31:05 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id be8so18925796plb.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 18:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N56l61UXIcT25GAe/BihPJ9RZAK+koZRxtSlm8zTpdo=;
        b=l6fCvkiKEIy5nSqxhsWqsKLGT6Vi7e9Z/yq2veBi/tByiNFBZ/49TtGLGj85Kdz5ZL
         e2cwWNdGJ+ttcJMRCU8OtbFZ7ehuWvo+qSExRODr8A+pe296lSurxfg8IZH9TEG9RWbg
         kvxRovCLiqE56bX0VH6i8wFfB1RVC8iBGDwfuZiCVDbCIL8bs/+F9x3nauom76VXWEA+
         k3jc/Gsaq8dL1ZSotbZIHbV6lreFK28MH6OT7aM7jp07v/SelvcethrM+LuIjJYIdnuu
         hU9cpn0e4/RWqlA9PsqHxhN2VNPopUalF3MB1DkUhP1rZ7ANqif4ZgT2U/O9hI8tCIDK
         cp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N56l61UXIcT25GAe/BihPJ9RZAK+koZRxtSlm8zTpdo=;
        b=gQpm3CnJ+31XpZncbJDjNmoiF9qJiIYoGjUdaJIQLQuSkHDgMX1wSlFMhBqcx94gc9
         oslaeD1zhQ9KaNJim9ORo+5uli7hhIvxL9l4jXSdvu4aoG4G/ZTiI8fXAmwgv2SHjhYM
         R0BwDxgQqZ3HGZm/eVa2FiRl/7WungcYBA7oXdYDCn935+ca5eUj2Wuo3dQvY7SPKcMm
         qO5kGY6nQkoYNb5WQ0oo2Ev1TP6owCSZAh6LRKpK3DlYQULxGnLmjUw+9OfS7MEaoWMP
         uucUkB2oirRUUuTEqIGJHw1a7E2HsM3nj6wi8dhb5i2bRBIelLUKUSBVKDpLveonM43i
         trRg==
X-Gm-Message-State: AO0yUKUYFfJMq5C2Zzom3BQulpy8p8MQnxbdbZWum/uHm55bHl4ixaXU
        HItAhZu6kTYY9gkUl+bcehVTB+OClug=
X-Google-Smtp-Source: AK7set+3qd9R0dxiZPnVr6upothrJVLKbZ9YQipOnThcJSaN+acj4aiY4HMwzsGtxOQ507g2udRthg==
X-Received: by 2002:a17:90b:4d04:b0:234:d78:9b58 with SMTP id mw4-20020a17090b4d0400b002340d789b58mr1032612pjb.19.1676428265055;
        Tue, 14 Feb 2023 18:31:05 -0800 (PST)
Received: from [172.17.0.2] ([13.88.100.114])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a6ac100b00230befd3b2csm228842pjm.6.2023.02.14.18.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 18:31:04 -0800 (PST)
Message-ID: <63ec43e8.170a0220.48dfd.095d@mx.google.com>
Date:   Tue, 14 Feb 2023 18:31:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8726905180620607671=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor/att: Fix ASE frequency values
In-Reply-To: <20230215005629.990585-1-luiz.dentz@gmail.com>
References: <20230215005629.990585-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8726905180620607671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=721925

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      34.10 seconds
BluezMake                     PASS      1196.15 seconds
MakeCheck                     PASS      12.62 seconds
MakeDistcheck                 PASS      197.54 seconds
CheckValgrind                 PASS      322.15 seconds
CheckSmatch                   WARNING   437.05 seconds
bluezmakeextell               PASS      130.74 seconds
IncrementalBuild              PASS      996.10 seconds
ScanBuild                     PASS      1420.39 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============8726905180620607671==--
