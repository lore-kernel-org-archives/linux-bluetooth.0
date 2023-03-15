Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BAEC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 23:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjCOXmG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 19:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjCOXlt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 19:41:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663B427492
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 16:40:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k2so13948488pll.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 16:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678923541;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FKqRh7O3d9EXWk4dS+J4pzEgVEY+UZzZqriHwfGuMp4=;
        b=aViycjnqjqW96JjVIO7peRN8ftxfrFB8IriDaZyZfvJHTbAP9bpAbyfCovtx9t58mS
         u5Lkigv4S7qy9gtl1waBR8d6ofdpKPppV8i3ch8xJRMMdNHyoM08rUYvmeFfd1NWbsuD
         ZAKmbtiZc/+hKMkuoeuicqgGxuKJU+glCnB14bOGCxbefPUYDZxP9kI0inREkM/ZYn1M
         mzH2tFRgZFupO4tWVcwxlVUNsI6ZbvYs6ctzHdWXs/HCQa+3H8stmj9L8oSGokGTiJDs
         tbgE9p+uKDHdlR2jiq/OJi37ZAL3iJKYBNgbQfkpMalGhWG1MW6SlwCJU3fpkThG0PKC
         gCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678923541;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKqRh7O3d9EXWk4dS+J4pzEgVEY+UZzZqriHwfGuMp4=;
        b=1JqHjV234JKeF6zX8/6hFDIy9jGhY7XJAuVWzvxx31se1zH/39sAj41jtUlpzVpGaP
         l6lNu2QhsJeUDC82nAYbv+aqX1WwJplWZhaT4NTMjnxjsvXod66+m3WRXnqXe9ZRjj6R
         gR+r17Q8WS6b2XZTDCZBgwktn2Qv63sV6RX3xSOTNet16gvyuX+USc9LWtpbbBStVuBp
         XgNWjPASQ2Q+TOdboZNmhlh5j8/a/r7j1TraOcWSMEsuY/8R3I1toiY9PIGjeizdXDsU
         qjtTJiqvWmkuoWGCmyXLPWlaqC/XkV6IZRTNap8SN4KU04V20ax46Ljvq45MG+XjT/Rk
         cxkQ==
X-Gm-Message-State: AO0yUKX1zedxWI9YnA94ECQtlwz0V8/nWQ+Xi5up3gaU93Clm86EJjW0
        1itBRGbpMKQ43rEZ7ZvttVQwM5m4z74=
X-Google-Smtp-Source: AK7set/K+mZB4BYJ+K/X1sJT8exv0HmtV7114x9jYsbK/qqdy1x8r6O5+sImi3CxYUNUdZIOHUKO9w==
X-Received: by 2002:a05:6a20:b28a:b0:d6:da7f:a1bb with SMTP id ei10-20020a056a20b28a00b000d6da7fa1bbmr369873pzb.55.1678923541446;
        Wed, 15 Mar 2023 16:39:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.44.55])
        by smtp.gmail.com with ESMTPSA id h17-20020aa786d1000000b005a9cb8edee3sm4050294pfo.85.2023.03.15.16.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 16:39:01 -0700 (PDT)
Message-ID: <64125715.a70a0220.a5ee1.a02a@mx.google.com>
Date:   Wed, 15 Mar 2023 16:39:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7137365938261064212=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/2] transport: add CIG/CIS/PHY properties, don't show unset QoS properties
In-Reply-To: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678918574.git.pav@iki.fi>
References: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678918574.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7137365938261064212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730524

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       FAIL      0.76 seconds
BuildEll                      PASS      26.01 seconds
BluezMake                     PASS      736.33 seconds
MakeCheck                     PASS      10.85 seconds
MakeDistcheck                 PASS      146.21 seconds
CheckValgrind                 PASS      238.48 seconds
CheckSmatch                   PASS      318.73 seconds
bluezmakeextell               PASS      95.66 seconds
IncrementalBuild              PASS      1200.09 seconds
ScanBuild                     PASS      935.85 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/2] transport: add CIG/CIS/PHY properties, don't show unset QoS properties

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,v2,1/2] transport: add CIG/CIS/PHY properties, don't show unset QoS properties"


---
Regards,
Linux Bluetooth


--===============7137365938261064212==--
