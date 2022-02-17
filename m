Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4622AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 08:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbiBQIAb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 03:00:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiBQIA3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 03:00:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A12E271E22
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 00:00:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so8749568pjl.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 00:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=XUPLUSCPffK2pWhvqPQWwRcABz61nJ1o3E+Dwg4URBw=;
        b=dAho1OrSiQNwLL+3DuLHMyXLv6+PvckfgcAGyqqNbp8Ypgrf7UZZN6hPecg8nSjlXR
         y6nCACxsTNlV8tCkCtRhDaM8ZwCOpsRUR/hFs6RPqUaqnUPus2jiB5LdX8es8PhHPBzh
         Kbhg9nNwc+hxYY7zie1q9wdcUgX6jKAek/8OWVZT2ZoGtqGE9UBODiIYz2qxLm44fNLh
         u+e2WDVeqZtEC31uQOKi7z1p8PEoVmdXGp2B0rsMARgAHHe1W2Q7Z0twK4upwRcDHf1k
         JKC77xupV1OuVGkopoUjwCnfMPjdhN/6s8lHrCkj/4PS/Fmp8CWtIGjW0lHj2ALww/jI
         HQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=XUPLUSCPffK2pWhvqPQWwRcABz61nJ1o3E+Dwg4URBw=;
        b=ssPzDMEItM9jdsDtKyARuIOiqbFQ4mkJ+EkDS8XoiFZrisYqWbidHk776vHfcq0bGd
         OHkh6AZqNGidZuSy6hB8+uQpe8TbanfoeQ3jWLMYNGNG53+BG+lTUwNRHgzxI+pV0+rQ
         vAZ6IE/Ek6YChK4nBmoxh0LnveWqWRUyI7eT2ROTY80tY+xQfEg/Qizmw/jDAhEaFQfl
         aCpbiKA1jMMfDii2OvwyCT/tYW95Y3FEUXZMH80zDha7x/CtDzQDjPIWv1xkhseFKI+I
         G14BikXDNl4/7uTiGfDvgOTKxcYFEM+rOXwU3Ipr7He5IpEhNRBKDvgpI3zj4rXMW9ay
         z13A==
X-Gm-Message-State: AOAM5333Z78ByFdMZT541QPL3Nd3uyWdz/o+exnHKW51J2Rhd2Fv9BC3
        C0tKjke5kQqyYaDMNw5lnhkHXOFSPao=
X-Google-Smtp-Source: ABdhPJwEel/oEHskyHnOO3y7ASEb8mmvSAfVycg2B4WouaUrzyOQZBppc00xbrqF8tmBdWKI3g2AxA==
X-Received: by 2002:a17:90a:1701:b0:1b8:bd06:4653 with SMTP id z1-20020a17090a170100b001b8bd064653mr1882225pjd.94.1645084815564;
        Thu, 17 Feb 2022 00:00:15 -0800 (PST)
Received: from [172.17.0.2] ([20.36.28.85])
        by smtp.gmail.com with ESMTPSA id z14sm42484916pfh.173.2022.02.17.00.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 00:00:15 -0800 (PST)
Message-ID: <620e008f.1c69fb81.e8e70.8a3f@mx.google.com>
Date:   Thu, 17 Feb 2022 00:00:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4375799257908287292=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] shared: Fix the incorrect type with bit shift
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220217063145.50497-1-hj.tedd.an@gmail.com>
References: <20220217063145.50497-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4375799257908287292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=615253

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       FAIL      0.37 seconds
Prep - Setup ELL              PASS      49.17 seconds
Build - Prep                  PASS      0.59 seconds
Build - Configure             PASS      9.06 seconds
Build - Make                  PASS      1702.34 seconds
Make Check                    PASS      12.60 seconds
Make Check w/Valgrind         PASS      502.72 seconds
Make Distcheck                PASS      259.75 seconds
Build w/ext ELL - Configure   PASS      9.78 seconds
Build w/ext ELL - Make        PASS      1660.32 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] shared: Fix the incorrect type with bit shift
9: B1 Line exceeds max length (114>80): "  src/shared/btsnoop.c:339:18: runtime error: left shift of 65535 by 16 places cannot be represented in type 'int'"




---
Regards,
Linux Bluetooth


--===============4375799257908287292==--
