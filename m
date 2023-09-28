Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6715FE732E7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 15:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjI1Pnf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 11:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjI1Pne (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 11:43:34 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F096DC0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 08:43:25 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7743448d88eso526071285a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695915805; x=1696520605; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xw/RiCYz55zNI1rRCM+6UGzPDkGGg41aQoZzD35ghU8=;
        b=TZ19E0vgGfhsyA6J3ARjphLU1FBKkPtErM0DRWBeE8OdjPAMvXOED0ARpdvkR9p/V6
         VVm08E6kxwBUv53Rwe6vo9QBjn27HDwMs2W658uZHvDGL/5immuMnYxLBIvOejVLXDbz
         cG9sPJ52uLc0EWJmDNCBox9BQqpY47U10z8GaNaO+F05kAC1EJV9ltlpwf5OO+D0YjiX
         ROv0K7/q1luByOO7f4FXbwsHW3QE48Ii3pFGYkwpymSxJkAVZwuyTTUXSQuqq+XGyrDA
         0n9pC2kxpaQGhRaKei2HEwo9hEAVgBhmDRN2CgYWsU6c7SSZGruOyxDLgmzMr9K89hJZ
         sjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695915805; x=1696520605;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xw/RiCYz55zNI1rRCM+6UGzPDkGGg41aQoZzD35ghU8=;
        b=RQvkXDRtl2a6kdqRc9w7MhZyAxbR9rCCvmpKRj0I1MbIZysB9nsFWHMNaQppFWaUg3
         oNm71AfZPFQMyP00qQ8v4TTjP2mttJtBUSFci62tjKpvlkq4E2O5VHmu8ejWNu/rd7E4
         9jHt2MpEzq+MNYIZIVkblrsSzmlqFwBfJxIQwOTmk55hO/4wX/iZGVBtjz+Hn7kjnrjb
         207LkTN6VoKvscMufTcs0PqeSfqZEOkcRYyutKTxSyuZicDj8SVF4WltiRH4UcShWcYe
         d18z41xbeHK+7NwImf+mGMbM7rnv1VzMDMC1q7imzsC3LdUklRtsDnlpgiuBcE+JVLyx
         FNRA==
X-Gm-Message-State: AOJu0Yw13Cjj+t/208xwrGT8Cd7Ra/lNAvJQNVGESGGqca7Krq7pXKxf
        iLoK/BrrJrGzILmT+uUqSt7BAm2WLv8=
X-Google-Smtp-Source: AGHT+IHSwszrlhg1qLKq51Jvdb5kYZKLqvfXx9b5asxEQ6dlQjdZ4jnF87W8ivffySqm8Cc4A59BQw==
X-Received: by 2002:a05:620a:2ac4:b0:774:16fc:65d8 with SMTP id bn4-20020a05620a2ac400b0077416fc65d8mr1732753qkb.32.1695915804840;
        Thu, 28 Sep 2023 08:43:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.15.98])
        by smtp.gmail.com with ESMTPSA id h11-20020a37c44b000000b00767b0c35c15sm6305591qkm.91.2023.09.28.08.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 08:43:24 -0700 (PDT)
Message-ID: <65159f1c.370a0220.5143e.96a6@mx.google.com>
Date:   Thu, 28 Sep 2023 08:43:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5024406113049364696=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Test bcast receiver with PA sync, no BIS
In-Reply-To: <20230928142832.3174-2-iulia.tanasescu@nxp.com>
References: <20230928142832.3174-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5024406113049364696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=788549

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      28.84 seconds
BluezMake                     PASS      1018.78 seconds
MakeCheck                     PASS      12.87 seconds
MakeDistcheck                 PASS      163.72 seconds
CheckValgrind                 PASS      268.04 seconds
CheckSmatch                   PASS      357.48 seconds
bluezmakeextell               PASS      109.25 seconds
IncrementalBuild              PASS      856.21 seconds
ScanBuild                     PASS      1107.41 seconds



---
Regards,
Linux Bluetooth


--===============5024406113049364696==--
