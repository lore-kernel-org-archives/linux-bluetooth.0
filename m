Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CA7C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 10:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjGEKOT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjGEKOS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 06:14:18 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1F8122
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 03:14:17 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7866189cff1so204071239f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jul 2023 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688552057; x=1691144057;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K396hkGmauwep0CI4oAHH0TJjsws4B6CrYskpRhJB58=;
        b=ojm3jO+9wP/CgziIYicUFQwZqozL6hKChf4NVyT2mtLCGsV51f30kL39WvRnE2o4rU
         G7MX5P2yrkZTuN/2QOWWR3E0k3xCGFY8zBerRms305fIqj+LxSOI4PJpGUOphKJcsLzz
         XJlFr2Xv3YnQn4WwOoQRiCj1slA8pzDR0i1G6cUHoG4SmUr1qGxV8DpB1Ku2nLrawWrM
         18D6/EyzEUSufvMMPCqEjvl0Qa4cC9x5BpbjwfM3hJWXFuFQs5wW/XwZOaq/Z1Ms1lYP
         S+YzdHx23ZKz4BW954jz0aQi+K3FcLEoo02eYRJfGTvV4gUWcI5ayVY98lONycYMhJti
         e69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688552057; x=1691144057;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K396hkGmauwep0CI4oAHH0TJjsws4B6CrYskpRhJB58=;
        b=iBV1RN4fx/etbOwNTvjEvIq6yhszDKmstMlToPwJgBxd9PE9WKyODxDpj6b4YXks/E
         pSJ69CFDi5fSL/2tCbpngzu8+3ptwe+hpSHItGA1jEy0PB9BxXe2w2syv1SDSg26NQNb
         qAWo/oCGP7DP22w28BxOBB8/OJeSpS3KWhdPTSIJ0nN/ZJqs8NWvps8vDFFq/HT/2/m6
         jP6X0xCB0Td5vb+OjxJ4Z0fu5nb/7w/IzTdjkrEyZjaWzX5u9d/42gOFD499s7GKYWhc
         weStLZ9AlyBc4X06ARAfchafMuZ90taeSCsfWJLK1OJLtRKD760SrILK40rPKBH4adPi
         VXlQ==
X-Gm-Message-State: AC+VfDybQz9dh9OMnj6ZG3+6dP+h91KbYc3pFd58x7D806VM+WPvuzee
        G0eZ9HmRy+5PAuswqRSzvmOkbq7Uv2g=
X-Google-Smtp-Source: ACHHUZ6E2+fCvoDQAQ54HqAPiTx92Z1Qed17paMTVbKOd24OaztNz+SpReyFeSwYQl4wMGuB2APtxQ==
X-Received: by 2002:a05:6602:39b:b0:786:3dd4:4db3 with SMTP id f27-20020a056602039b00b007863dd44db3mr15929899iov.21.1688552056794;
        Wed, 05 Jul 2023 03:14:16 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.123.112])
        by smtp.gmail.com with ESMTPSA id u16-20020a02c050000000b0042b35c7b8c5sm2583721jam.61.2023.07.05.03.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 03:14:16 -0700 (PDT)
Message-ID: <64a54278.020a0220.75013.2ab2@mx.google.com>
Date:   Wed, 05 Jul 2023 03:14:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2778741954319885923=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: adapter: Allow broadcaster to be passed up to application
In-Reply-To: <20230705085131.6643-2-claudia.rosu@nxp.com>
References: <20230705085131.6643-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2778741954319885923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=762577

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      27.33 seconds
BluezMake                     PASS      856.49 seconds
MakeCheck                     PASS      12.37 seconds
MakeDistcheck                 PASS      153.84 seconds
CheckValgrind                 PASS      253.53 seconds
CheckSmatch                   PASS      338.11 seconds
bluezmakeextell               PASS      102.16 seconds
IncrementalBuild              PASS      697.99 seconds
ScanBuild                     PASS      1043.87 seconds



---
Regards,
Linux Bluetooth


--===============2778741954319885923==--
