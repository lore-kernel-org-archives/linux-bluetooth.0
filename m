Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5ADEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 06:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjG1Gdd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 02:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjG1Gdc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 02:33:32 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9514D30E2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 23:33:31 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34637e55d8dso6827985ab.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 23:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690526011; x=1691130811;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ROQy5r1qL/jfF8QfLDJC/zvVm/0+jsOUA6usLFK2GvY=;
        b=IgNt6MxhcXb9nT7wu1JXyhAs5EGDy51XzISOOVJCIboGGVDBMy6fgOI/QNI/VIcidZ
         BtysXNK3tEs5cxR2nw94guE1+GVoUtv6dlHFNtS8Hpi+iARmnhM8u7hiJPARGdScMlNm
         0s8g+9mXe3dduzrdzIMLAKhFgPLUXgkdMSdYYArxBONqsWBeFZgvtvyb/1d4vBLBEiLI
         iCKlSOG+69Ip2eMjZiWi1DcYymeq9GncDTNc8DFBnw2cRuMynqAU9gNtJOyX2R83f4fC
         mhWegxlrmguIPzEUTpgHKxhNeSfjdyzNQ80xsHKOejJ+zRBmm6DGxYFDw0fkbk7LyYrG
         Yy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526011; x=1691130811;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROQy5r1qL/jfF8QfLDJC/zvVm/0+jsOUA6usLFK2GvY=;
        b=VHBJbzP8exj9MVK7giCASfL2benKCf3j+FHjliNJosYeKSHubkIcoEc42Uy7AbajgX
         gU6D3bi7IUTJSmFGJuoXrWp2xw8UXBQkNVeukykSiHGJI7330DMN5p3k04kGKlXAzK9i
         qcCMwdbPGql8vBNwy5+k1jckx7GakhTe3Li2zZXsbg/0SntTTfdhQW/SeHbzKgnUGrIN
         nBFjVSScvmurAvcz3cU81WaZDl7gsrmZHHv0kO3ri85baNvbANOMTVfbCpQpnq5s9JmZ
         +Uhvz3R6+Ru3vBt5Aai4jxZ0jmw6/Qg6+cGjeNtbKXHQMqZSRAz23+Xj5svDozzvHPah
         pmKg==
X-Gm-Message-State: ABy/qLZKgR1O+ZHpZPZA+eFnG+s2A8e9ToNF6tWUvxNovl+DRwpyjaJN
        UVu6hwSITAzr5heT2FAgVB3Rn63g3to=
X-Google-Smtp-Source: APBJJlEnku2aKberlfSTNVU5/u124FiTbxrrzvccSyBAD1IkPH0HjNlPDfuhXAspireXDpr6Cv4kNg==
X-Received: by 2002:a05:6e02:b41:b0:348:add7:f8e1 with SMTP id f1-20020a056e020b4100b00348add7f8e1mr2212958ilu.30.1690526010838;
        Thu, 27 Jul 2023 23:33:30 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.5.30])
        by smtp.gmail.com with ESMTPSA id g7-20020a02b707000000b0042b1dd89b0bsm900370jam.155.2023.07.27.23.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 23:33:30 -0700 (PDT)
Message-ID: <64c3613a.020a0220.f7f2b.19e1@mx.google.com>
Date:   Thu, 27 Jul 2023 23:33:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0864041245708320034=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Adapter1.ConnectDevice
In-Reply-To: <20230728052506.582394-2-simon.mikuda@streamunlimited.com>
References: <20230728052506.582394-2-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0864041245708320034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770400

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      27.01 seconds
BluezMake                     PASS      793.15 seconds
MakeCheck                     PASS      12.10 seconds
MakeDistcheck                 PASS      159.63 seconds
CheckValgrind                 PASS      252.47 seconds
CheckSmatch                   PASS      338.10 seconds
bluezmakeextell               PASS      102.34 seconds
IncrementalBuild              PASS      657.82 seconds
ScanBuild                     PASS      1022.18 seconds



---
Regards,
Linux Bluetooth


--===============0864041245708320034==--
