Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AE2C001E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 12:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbjG1MWa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 08:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjG1MWL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 08:22:11 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAED49ED
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 05:20:02 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63cfa3e564eso12377216d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690546790; x=1691151590;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gMuBuPwEDlsM0/nAvqTQpBcDmrE03AEfusqt68cL4Lg=;
        b=nMc3a4g59c6z4WqTHW9dV4pioi7hqQMiZy+w9496CXsBbh7rjAuGt2M5nGRPR5nAQW
         0YncNdBwKB/PWMMqN9OgUhvOxl1vaGZIrzzwW5B+b+VFIDpsXXutiYFXVeQG7vGhEAjR
         gXsJT6WJk1g7CyhAQQpTVRjJbjMmWqjwpz2RaehhxAQF/bo8J5xh0IP1M8nqqbdzplRK
         Zw0GPHHLlT1aMMykWj90CiIMW/gIxVXp27VmjSChn40neRYRpX66Ddg9tE3nASroktGU
         2bjeCpRzt005xjbSJl5qqUVgmobpHdCfj98sSPvGiKX8+fVTAt7lacpBLK6494c4Q9n/
         htmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690546790; x=1691151590;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMuBuPwEDlsM0/nAvqTQpBcDmrE03AEfusqt68cL4Lg=;
        b=CBy4miKUX28/7Ek6sSm1lp8i9YE+8/tRLOup5Rm5yJgDY1APwlV5WC21P/ZRYHBSdj
         Ta+MVWAcM/xay93tXvWyyB9J5MgCQhTslQIH1ubz+PYYPYvnrxV6pUGG9BC36k0TM8xq
         s/Uo3mv9p8R7x2GO+krPi/z6iX1ObF7bAy827DKq8bwWWZ3ysP/tF9K4DJFpfiw2IVlj
         JxUqSeVVfOWeXkQICWt/9XEcP6l2RJATdSxjnS1hkrLysfCMNf6vD8P/E3nGFIjKzgoc
         pLrdlydNnbMlAP5oK08P10dBFVKBQYjEpyj8Aw6orn3z4KzebuJqNBkkdK2/+Zk9OGKi
         6HVw==
X-Gm-Message-State: ABy/qLZELGWihZduYe/grN5GWgv69ooARgj8VtDnrorkyt7Svim+rMRK
        xDHV5mBNeXzaQuG8zOeDHEtnylRC2M8=
X-Google-Smtp-Source: APBJJlHGVxSuQzzzfUbHTIKla1/WtP5EVZ5NI4yDSQndO1MKnwfxTJF3zc9yxrMBOWzP+Q4W0KviXw==
X-Received: by 2002:a0c:b406:0:b0:63c:fbd0:84a6 with SMTP id u6-20020a0cb406000000b0063cfbd084a6mr2459952qve.5.1690546789879;
        Fri, 28 Jul 2023 05:19:49 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.255.0])
        by smtp.gmail.com with ESMTPSA id m10-20020a0c9d0a000000b0062b76c29978sm1203933qvf.6.2023.07.28.05.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 05:19:49 -0700 (PDT)
Message-ID: <64c3b265.0c0a0220.8ef23.4aaa@mx.google.com>
Date:   Fri, 28 Jul 2023 05:19:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6738810955935200749=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] advertising: Fix peripheral adverts when Discoverable = false
In-Reply-To: <20230728105604.948472-1-simon.mikuda@streamunlimited.com>
References: <20230728105604.948472-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6738810955935200749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770527

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      32.33 seconds
BluezMake                     PASS      967.12 seconds
MakeCheck                     PASS      13.52 seconds
MakeDistcheck                 PASS      184.18 seconds
CheckValgrind                 PASS      303.51 seconds
CheckSmatch                   PASS      401.78 seconds
bluezmakeextell               PASS      122.84 seconds
IncrementalBuild              PASS      791.91 seconds
ScanBuild                     PASS      1251.06 seconds



---
Regards,
Linux Bluetooth


--===============6738810955935200749==--
