Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3D3C00528
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 23:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjHDXWk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 19:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjHDXWj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 19:22:39 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547EB4EDC
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 16:22:37 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-56661fe27cbso1728803eaf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Aug 2023 16:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691191356; x=1691796156;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LDRLBIhdMnLwuWPtmzoW9ucFi4Mb7xqOcIzKUWGhKcc=;
        b=JzxyFTNqK/GkQ5pI2GDk/l3tirkV7Utg2hHl+bNLhmPxwg3YSlTWwsvAEswg3vovbE
         nnqJK7DXwaFNGKev/BWFdsqda2MOfglLil36hAcPM4p5RRqG8Xbj9gzctjgr4rMxPxcz
         rBum30b5j1H+TzmHTRFgxAMsnzoHy/kvDHWXa0RXxaIAoxx2X06j6+5IlTj5B0e/i9SW
         53n1LMNei7vjXzW1JVoI7ndRU8jf3RdLakrPse7WtoH5GbOGMjqZs76DoACsiUcBceaX
         bygzBMh3OA1Ieh13AqkK03BcJNQ+aJWz3ck7Nx/Jg9JeEIG/w4r29DNn1/OQqrxu5cCj
         HZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691191356; x=1691796156;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDRLBIhdMnLwuWPtmzoW9ucFi4Mb7xqOcIzKUWGhKcc=;
        b=UZyoQupz1mchnNTsczZQdVYevqEjX/2w4NKcMJsc1gNFAElWloFfkeaxt8UqN+7rEI
         tzkc/z0KTs8QjdAs9C994ReJaaQYbvRiDi5qExhLhu2a6LtJkDjf+xzF+opXWowdB/mY
         yL1bgy92wyBCbpQHxGqubJiYLPq4IVWyAXVRqJkuqWs3YcoqEdQFtl+SGtIn82eL09p1
         h/XAtbo52jwvxl1vn/ys7SK7+VrSJ8/zW+tVPz041rEtBcWbwujxD5WAWh4mhxOyB69p
         lIngLhkVAIrgSlR4km3lZmjID7Sv/8FTq9TkqzOyzMnP/8HK+JWgVu8XOe9SIGttZjm0
         zKkA==
X-Gm-Message-State: AOJu0YwyKSXGoWGcz7iQvL1wXo0WPEzrubVd0fIk591gj6Mohg9n1qJ+
        LW8rh7+BL5V9ZRP3Va4uPpueoo2hW8N3pg==
X-Google-Smtp-Source: AGHT+IFknxcdUAOiwTWWp8jWhYElv+E6tv5bjM5dx7eAtA2F77ndn9Szlo2BULmK74hizNCPiUCK/w==
X-Received: by 2002:a4a:3050:0:b0:569:ac56:ca98 with SMTP id z16-20020a4a3050000000b00569ac56ca98mr3268049ooz.3.1691191356327;
        Fri, 04 Aug 2023 16:22:36 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.220.107])
        by smtp.gmail.com with ESMTPSA id v10-20020a4a8c4a000000b0054fba751207sm1635211ooj.47.2023.08.04.16.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 16:22:35 -0700 (PDT)
Message-ID: <64cd883b.4a0a0220.ed960.a0f4@mx.google.com>
Date:   Fri, 04 Aug 2023 16:22:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5306368315898373530=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] iso-tester: Fix test ISO Connect2 CIG 0x01 - Success/Invalid
In-Reply-To: <20230804215733.1049271-1-luiz.dentz@gmail.com>
References: <20230804215733.1049271-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5306368315898373530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773285

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      33.67 seconds
BluezMake                     PASS      1007.74 seconds
MakeCheck                     PASS      12.90 seconds
MakeDistcheck                 PASS      188.31 seconds
CheckValgrind                 PASS      301.79 seconds
CheckSmatch                   PASS      406.93 seconds
bluezmakeextell               PASS      124.09 seconds
IncrementalBuild              PASS      828.35 seconds
ScanBuild                     PASS      1284.84 seconds



---
Regards,
Linux Bluetooth


--===============5306368315898373530==--
