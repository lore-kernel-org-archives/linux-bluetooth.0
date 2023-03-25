Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E5EC6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Mar 2023 02:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjCYC1o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 22:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjCYC1n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 22:27:43 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758C318A83
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 19:27:42 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id qh28so2901488qvb.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 19:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679711261;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lcwr2Kd3/25AD+mzfk7NtcjdPc+eIvQ9nQO3HF6SYs8=;
        b=bZkUnqqY/s+CYSdXmKxcezG8Tx3e0mPxycsKUACT+QVPd2qfFYQwA+f87+Qa6D9NiP
         6eQQzzAhIsD5Ke5bAJWTEQqwhiaeTA+j8XFII6ZXqvigo3ELNozYCxstfK0jbkka0R68
         deS+iZp4Gyr4sTsQVQdRDH+Qva8quMy4u1RoGzvi2/uoPljli7ebCz2d13eIR6bN7+Ds
         e6Xa1qZ4M8pyq/Fw6EZwmCWXMhapMQt38P61SEcdoaih30G8Xc26gRWipW67dEKR6DSf
         oPh2uBtPrAvWQPD/m+tR0CDmIFiDsfp0qgZzQMMvXBwz1ihHEIOLlbieguhgy9TG+ZAG
         6Lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679711261;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lcwr2Kd3/25AD+mzfk7NtcjdPc+eIvQ9nQO3HF6SYs8=;
        b=tscV6ulA6nvfj2NCwJBa3WiCkKQfjSZtsh2f/ccM2HbpxKoh84qtVfLRhfEvnsVSAA
         qJ3oJXVvxmN6Zw/Fjzc9OCy8BLgrf9y3dm3Q1fnKtffNoTA69h2eGy/ImI1OCIfufnJC
         TY4pvM7Zq6+plbPwkVqYCgy0ugQZn/pyy6Vn6MlUDeojWKdwY3I1CNbEYu7oqL1rOsZT
         byNrmhPM6k9uviQ+kLf3XigTN4revnebP2Pp/dax42XnUgphTbxuU8AU78sMv96Opzxw
         xFi4P3n7UX+KdYqefFvX8TqJDP2KeDN3v33KSPWBYl+aMs6TDz7oTBokNT1xeIvxqUnh
         R6GQ==
X-Gm-Message-State: AAQBX9eSIqrwPoXWd61RCXnd3VZ4L3HXkNSCD94j3/vOJDfg75H6K3pR
        KeCMvMlauU9o+0L9gxWQ10nBBOoKcQs=
X-Google-Smtp-Source: AKy350Yuly35Z0+YZiz5LG2zHxevqewa35Lor0vxglHOwR2gF/snSvVT17OlVuWZihn5CytB5MAAjw==
X-Received: by 2002:a05:6214:2349:b0:5d1:f504:fda9 with SMTP id hu9-20020a056214234900b005d1f504fda9mr6882386qvb.26.1679711261470;
        Fri, 24 Mar 2023 19:27:41 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.255.85])
        by smtp.gmail.com with ESMTPSA id cw2-20020ad44dc2000000b005dd8b9345aesm1140492qvb.70.2023.03.24.19.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:27:41 -0700 (PDT)
Message-ID: <641e5c1d.d40a0220.65636.54c4@mx.google.com>
Date:   Fri, 24 Mar 2023 19:27:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1916653679885171966=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] shared/gatt-db: Make gatt_db_attribute_get_value public
In-Reply-To: <20230324233856.3693370-1-luiz.dentz@gmail.com>
References: <20230324233856.3693370-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1916653679885171966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=733736

---Test result---

Test Summary:
CheckPatch                    PASS      2.00 seconds
GitLint                       PASS      1.35 seconds
BuildEll                      PASS      26.61 seconds
BluezMake                     PASS      775.64 seconds
MakeCheck                     PASS      11.40 seconds
MakeDistcheck                 PASS      150.29 seconds
CheckValgrind                 PASS      242.80 seconds
CheckSmatch                   WARNING   324.85 seconds
bluezmakeextell               PASS      98.44 seconds
IncrementalBuild              PASS      2446.98 seconds
ScanBuild                     PASS      960.47 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1799:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3551:52: warning: array of flexible structuresmonitor/bt.h:3539:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============1916653679885171966==--
