Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E29CDB482
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Oct 2023 20:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjJNUgC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Oct 2023 16:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjJNUgB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Oct 2023 16:36:01 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35917B7
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 13:36:00 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-419787a43ebso21168431cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 13:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697315759; x=1697920559; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GV5el7z90cHB//Pitf29YW8UHfdygVM14+aCWx9SQso=;
        b=kxYBpr0F0Zxcz769zcFQzf2FfM0UAh1M0v7Pufoz2fgh9fwpuywu6O3d56F7O8KMYS
         MQZtcUfcgw8WTkoZfwiR7tqaFhmIzKOUN6wGIeqN82adzNexbH7YXeq2W18+0rH54CAs
         u11+eCOAmhOrN5BQAG4w/WherPBQq3/QLoSRCbZgCNOnt74SXWVE38yPXegSRLIxGSAQ
         NX05WI4FeyW1zCTSwBZRmMFklkLtqGtLXYLyKMNCvTzAmYKO1Tv9YQFjQQ5+Y+Zh17AY
         0unmxW78Ut44jjJdh+vHzqozjXUiCjwFdlYntfOCr7/1zX7ZTm1K4VckLs95cH5WHUVG
         eS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697315759; x=1697920559;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GV5el7z90cHB//Pitf29YW8UHfdygVM14+aCWx9SQso=;
        b=RsQK8xMydEqw/BnJpw58C5qKvTYcLuLKGK0roeGRG2LZU8iJ2AFHvpQKOuyp2DDOmY
         cANQOf960Cqq5YVAf1lQKiRnOH3UMkPnGWX2tFO/O7lxXcCF2yDvmNekNWROsVNf0R17
         0V8LIoW2tHcKUoqCHkoo75VT3zJpdlzqzS/YpYx/Xt+Z35ac/WlwMGC35RMoKlwpX1lt
         65DABGYIG2EOj2PnKNfbXqO7ePnv9FX//JdhsoMptYUmkprQlZ+h09hPLFa3h1kNrjD0
         ixFTGZH5Ywzox6ixFbwrvizmg3sb8JCD7jWTD+nTZPVbLOB4yZpswcO3GpJjM5eAg8Tf
         z4/g==
X-Gm-Message-State: AOJu0YyseOVEss+6GRpYhRA8wxd1iBW7uebjvcKdtLFxgAIqkC2WDGPW
        w+DTLxKXbkwLijzKWTnSMNGSBeqwtPM=
X-Google-Smtp-Source: AGHT+IFVYYeGjapsGN4ni+7LWFAmPaYvwVpdFI978IpWWEpJZZJnWlOrJQ1nRjJYBiT8R6aJHgoCQA==
X-Received: by 2002:a05:622a:1209:b0:412:a69:3a01 with SMTP id y9-20020a05622a120900b004120a693a01mr35707592qtx.6.1697315759160;
        Sat, 14 Oct 2023 13:35:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.96.44])
        by smtp.gmail.com with ESMTPSA id g28-20020ac8775c000000b00419792c1be7sm1732183qtu.30.2023.10.14.13.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 13:35:58 -0700 (PDT)
Message-ID: <652afbae.c80a0220.15f93.7dba@mx.google.com>
Date:   Sat, 14 Oct 2023 13:35:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2508316305839072861=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] btdev: Fix NULL pointer dereference
In-Reply-To: <20231014191609.1883047-1-arkadiusz.bokowy@gmail.com>
References: <20231014191609.1883047-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2508316305839072861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=793240

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      27.98 seconds
BluezMake                     PASS      805.35 seconds
MakeCheck                     PASS      11.51 seconds
MakeDistcheck                 PASS      175.45 seconds
CheckValgrind                 PASS      268.81 seconds
CheckSmatch                   WARNING   362.31 seconds
bluezmakeextell               PASS      116.69 seconds
IncrementalBuild              PASS      699.10 seconds
ScanBuild                     WARNING   1066.45 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:420:29: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1083:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1456:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn')
        send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
                   ^~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============2508316305839072861==--
