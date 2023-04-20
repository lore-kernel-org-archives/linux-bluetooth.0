Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59C7C77B72
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 03:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjDTDqu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 23:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjDTDqs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 23:46:48 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FE9449D
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 20:46:47 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6a5fe1ebc42so230897a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 20:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681962407; x=1684554407;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Su3yR5BkEbEJXd4paYq8mmEqa+I0NGvnkEHqx6cD99k=;
        b=ijo1SctHF/aRFZQ51Zn4wcMHVHnwC7Duu6T/PDmofm/L5SOMgy36k/G/pqSg3Nox1f
         VQ311E5bvTdaUkAKEV9c75cXKh/Y1TvcwyYMn2c5R4qKkmTHk83wV5LRVXkyk4cbNWiQ
         I22qWas7+gxIZt6lzamvoy+PsyY4Q7lBb7H6bG/MdRsUraii+3rWYK675AytdcieatNd
         E6qcWAKWExaDsBqR1QNSb/dwyAc2AHNDUZRd2EewFXVA/vPLYpFedyTQeK1mQy0M2ENB
         y74N8FxFYI6dvTdsVadSO2D1jm0phlnV2B9TIjtTZyQ/5MVI/gNCeueoWs2Pwv3Cbs3O
         mv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681962407; x=1684554407;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Su3yR5BkEbEJXd4paYq8mmEqa+I0NGvnkEHqx6cD99k=;
        b=WzF+M35WRXZbfftA9z5FA9vZ1rOP/6adWAwRHYfsMXqRCQ2YJfI3+fWed1ioZHitBz
         r9fhaXl5x3nRs5fons2eh52fR98ppL4sdf4BceZNv32+NFlGpmr2aj1LixKX2CY4mlYn
         6w24KAKIJWeApy2K9VvvyiYLvEvrLfU3XOrEEeHwmsNC0psFXJxRT4c5LmBnDN6vjS0U
         xmfajZpARQL7myyOZX32+WF2tAEAuzqsoRt2N8oc4sY1+JfjgAYjK148cpMT+hDe2drw
         88LJieptTaDiHIriPlXWDNvbVthsMS8G8RuvttnxTPsveFt3lpZy8lQttxnmYq1F7RYn
         0h+g==
X-Gm-Message-State: AAQBX9dXGsDDInqh6cOWCeip4GOucPPaMc6WfMGROc81d+F/wZ52Upz4
        VtmMqmWGeoY1FhgBZjdM9EL+6nRhtj8=
X-Google-Smtp-Source: AKy350bAl8gy1bdd9ydXZ25woBKagjjZgnDBYG6F8kb8pA1kLLDzzsmBiOgVVerHEpWRT0it/hvDBA==
X-Received: by 2002:a05:6870:3412:b0:184:433c:a175 with SMTP id g18-20020a056870341200b00184433ca175mr183120oah.22.1681962406699;
        Wed, 19 Apr 2023 20:46:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.171.141.231])
        by smtp.gmail.com with ESMTPSA id k3-20020a9d7603000000b006a2ce5f3641sm350521otl.8.2023.04.19.20.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 20:46:46 -0700 (PDT)
Message-ID: <6440b5a6.9d0a0220.593cb.1c4e@mx.google.com>
Date:   Wed, 19 Apr 2023 20:46:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2187720846931267642=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, aarongt.shen@gmail.com
Subject: RE: [BlueZ,v4] obexd: support to reply folder name to store file
In-Reply-To: <20230420022554.14159-1-aarongt.shen@gmail.com>
References: <20230420022554.14159-1-aarongt.shen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2187720846931267642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=741525

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      27.30 seconds
BluezMake                     PASS      918.48 seconds
MakeCheck                     PASS      11.54 seconds
MakeDistcheck                 PASS      154.20 seconds
CheckValgrind                 PASS      253.35 seconds
CheckSmatch                   PASS      340.07 seconds
bluezmakeextell               PASS      101.97 seconds
IncrementalBuild              PASS      772.74 seconds
ScanBuild                     PASS      1064.97 seconds



---
Regards,
Linux Bluetooth


--===============2187720846931267642==--
