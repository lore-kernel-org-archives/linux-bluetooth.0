Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D04C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 09:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbiKRJdd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241702AbiKRJdb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 04:33:31 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0C32194
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:33:27 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jn7so2218458plb.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0j5iVbUicTICmhWh5rDVg0bSjdYuaVFJ6m1lg1rW0U=;
        b=Y1U6ToUgFWbRO3ePqO54lTADP3EkVNUjPe1YpQzkFlw865YybS+8xFWc5V/2YRWwSM
         YRDFpGT/77QEVeBzdno5ZzqdtxkIhQ1VHwxHnCLHWJr6nkaVYuz+81dvdXxxVaE5f89B
         vn6QrVPTVbYNc/t9/5FETAjNQTRlQZdGWtQlNBegHONqXSKLO24Ijzdu8ow6bPIMfaUT
         0HmfD1wDhdjfw2v9UjIDUQzsK4iohJHlDbB8lWJQsTIAzi+aHQrJta2epryew57rGW5J
         yOSwrL8Z0OihnIqaBBrdrj9IWvQoY6Yyl9uGGcWjoDPhBUxuyIoCuSdau0ClJx14rtom
         E5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0j5iVbUicTICmhWh5rDVg0bSjdYuaVFJ6m1lg1rW0U=;
        b=o1Av0ZWT5m3nP8MrzEK2oVVGEnddNieHw2xhl5fU8u/FU5EvZNOkAxCmE8A8OCFYXy
         9XMDn0tHkQIv82++q5iItK8esVSA7t/RP5oyyYOmO7N+SoZDvbAjYWhFKNlk1UhofTRZ
         weBUikOzih7K6ClubEmL1wuIND0cYGhEmyE+oh3j5yCDVwn4ca+jQuU8L1UkQmBQy9S9
         jv44GTpSCXc9n2QMr5DtEsXui03YO0EkbkHOg9EOzhJgNS+kziMNVrYjv/Ec0cz7byks
         DYEIGB9ZVH7xsiXJTg8W2SWJkqstuAAR1fqh18OOhOUeTVrLq2udrbRCH5gf2oITEey/
         jxIg==
X-Gm-Message-State: ANoB5pkdIzJ7NxTizOUIH1pz9apLMH7Sfil+Pt8svEqBzSD4dAPXmjN7
        SOsgjAqx2d5TEC6AwftLn0+ZiZYZONo=
X-Google-Smtp-Source: AA0mqf61xTmAjm+xGJ23dLcU/NOgUXyl1UmhEkfLadWywDGWZ7RaEyVQ/3op6CvKNNLkKR+KUZlESw==
X-Received: by 2002:a17:902:ab8d:b0:178:7040:9917 with SMTP id f13-20020a170902ab8d00b0017870409917mr6758285plr.109.1668764006773;
        Fri, 18 Nov 2022 01:33:26 -0800 (PST)
Received: from [172.17.0.2] ([13.64.245.183])
        by smtp.gmail.com with ESMTPSA id f7-20020aa79d87000000b00560cdb3784bsm2684958pfq.60.2022.11.18.01.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:33:26 -0800 (PST)
Message-ID: <63775166.a70a0220.775c7.47a3@mx.google.com>
Date:   Fri, 18 Nov 2022 01:33:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0601789895424151427=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Fix MSFT filter enable
In-Reply-To: <20221102175927.401091-2-brian.gix@intel.com>
References: <20221102175927.401091-2-brian.gix@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0601789895424151427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691340

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      41.11 seconds
BuildKernel32                 PASS      37.32 seconds
TestRunnerSetup               PASS      510.53 seconds
TestRunner_l2cap-tester       PASS      17.83 seconds
TestRunner_iso-tester         PASS      18.17 seconds
TestRunner_bnep-tester        PASS      6.47 seconds
TestRunner_mgmt-tester        PASS      120.23 seconds
TestRunner_rfcomm-tester      PASS      10.83 seconds
TestRunner_sco-tester         PASS      10.13 seconds
TestRunner_ioctl-tester       PASS      11.69 seconds
TestRunner_mesh-tester        PASS      8.17 seconds
TestRunner_smp-tester         PASS      9.90 seconds
TestRunner_userchan-tester    PASS      6.84 seconds
IncrementalBuild              PASS      38.07 seconds



---
Regards,
Linux Bluetooth


--===============0601789895424151427==--
