Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743B6C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 May 2023 21:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbjEKVhG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 May 2023 17:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbjEKVhE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 May 2023 17:37:04 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5D5B97
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 May 2023 14:37:03 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7575fc62c7aso630484585a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 May 2023 14:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683841023; x=1686433023;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T8/O2/geF5d9WiQBKWM7MH5jhW4Vg1Mh5hCs9oObUmk=;
        b=rZVX7j6oZmgqrfdEEoHSRKZBypoMSefesriOC1xG3qAQzoW7fH8q+wBi6jJCwGWWT4
         Qq18hiIOBQMFNiboB/Q6PlyBDWHG9UVauOLuVn2VyrYZ3mgCEK1/nANC76wMHRB5Nx5j
         269JcqRV8s0dvlWzTeEhZUyf/kuUW26KVfAji5+kbU8vLYQkrA3YtdIjeZQZRh0Y3xZL
         KpwUU9pwON12+4CGTfNy8WXs8gfJDirOMDaIpiZpzwCxqa0kru4WOGGj4nS1GP3dS+NO
         NCZma+s5iEoekpe/wWH3tqt0g9y7jnHuWtowwrU1pR1j2kJ/Y0CGIJJSTveRjDCv382S
         l4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683841023; x=1686433023;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8/O2/geF5d9WiQBKWM7MH5jhW4Vg1Mh5hCs9oObUmk=;
        b=LwITPd1hhi8DckhI4UV4Dp5Bq+p49q5I60nOhb8DvFjce6vG+zDinJ89LAwINs3Lx7
         IwXFUKp0ty/ZGWIs1ns/Lhl4ZeM8gRxkSxOSBdmpnHOvmcOkSQQIZJrvw/xKme4hRWJY
         ukDeQkmIrDBWAv1y8pAZmfsKF6yJOgQb+SpM1Ii5qEFYCO5Jglpi1XysLcXJVvsrvCSd
         kId1xx9wST9KPXpX1lgujEZX2RlnKnAzb6J6MFCPF6E0hvocMCTUwIfxI6OuCklJ/6ka
         IuJ8MuQU0VzZKyZBEfdrPrwY4dx3vFqAjp+eigZQ/jOM93CC+szYd90U2FI662cpeijz
         2A2w==
X-Gm-Message-State: AC+VfDy4waP+rMxFa207PJujEVlFSMtS54RGQzbu8l0QjYK5h+IUzSnQ
        h1O5fQ9CqpENjBgvG3R+wXwYOdpTYtQ=
X-Google-Smtp-Source: ACHHUZ4edVDqRqRewRA5XBpiFw7UKG/LzDBARvKxSXDzqcwBXO89EYknv2CDhTUJIXY5mAkQxdqawA==
X-Received: by 2002:a05:6214:29e5:b0:621:363c:ea99 with SMTP id jv5-20020a05621429e500b00621363cea99mr19196147qvb.30.1683841022930;
        Thu, 11 May 2023 14:37:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.158.18])
        by smtp.gmail.com with ESMTPSA id j7-20020a0ce007000000b0062168714c8fsm605857qvk.120.2023.05.11.14.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:37:02 -0700 (PDT)
Message-ID: <645d5ffe.0c0a0220.1d340.3cbc@mx.google.com>
Date:   Thu, 11 May 2023 14:37:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5889115953003025464=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client/player: Add support to Max Transports in endpoint.register
In-Reply-To: <20230511202825.3983806-1-luiz.dentz@gmail.com>
References: <20230511202825.3983806-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5889115953003025464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=746898

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      27.20 seconds
BluezMake                     PASS      886.46 seconds
MakeCheck                     PASS      12.36 seconds
MakeDistcheck                 PASS      156.11 seconds
CheckValgrind                 PASS      253.21 seconds
CheckSmatch                   PASS      341.50 seconds
bluezmakeextell               PASS      103.03 seconds
IncrementalBuild              PASS      738.62 seconds
ScanBuild                     PASS      1058.26 seconds



---
Regards,
Linux Bluetooth


--===============5889115953003025464==--
