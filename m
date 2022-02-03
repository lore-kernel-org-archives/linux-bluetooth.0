Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5F7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Feb 2022 16:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351928AbiBCQEC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 11:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbiBCQEC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 11:04:02 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E294DC061714
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 08:04:01 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id p14so2872394qtx.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Feb 2022 08:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=4ksTX68Nqy/5NnV8NkRgu+9vo7FxQvCRMLoUNvG8dxA=;
        b=qk9F8Fkpf44B7GKm9bh1VfPDAbUyE/pH3MAyy5VZZVODEL33rHD72kyvFdYL121uwF
         ZhmI7kiPNYWrgGUHsK7abx51iwIjeC/ScWGb2T0GB17QkZZ0a4QNwlgQj94kIc9Ludf/
         xw1qJiKbczklHgLo/yQf9577VEMiMPSjdf7dZrmeiDLwXRWwkXdWcx1fEaRDfU+Db9jj
         I9zkVonzHAhO/Oi6X9mRF5yvNtiMxiLMaAEUpPWUT2ujE/2GdtHOytxLgx3TQvl2jE2G
         ZtnMdhEOWMHyreV6xdj5ZjbkZsK2fDJd/nEAjXXZabORdddF28D2IuKhbe5futjW4FRC
         pEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=4ksTX68Nqy/5NnV8NkRgu+9vo7FxQvCRMLoUNvG8dxA=;
        b=vhlKFkes0YIY7cjyXmtPP/goLqTr5kFsWbnAkUHhwZLlemZF+MTV8ayU3soc6W1iuL
         BSW3ZdugjUE00gIpH15iaFGMynab/XU7IEEo0Lr0m7DRzWrdMV34J7CPmRqf/YmB5ezZ
         EESG1P35d0lisZmlTyXFv5n46eT814PExLisHx2UbHqSgE/3kfUcz/a16b5of1OtkubQ
         +zbrlDgTLdQSK2DqZ4R4clnUAGEcoaQ+sygwmxjkoaxAl6hjgSnnz/o0mbyNEQ98WCGp
         9WFeHjwDzxq9sdUvJ/6FEbWzX+uCVVLghbISu9z/iJ9FwNUGeBjb5bSPXD4DNrJaVIjH
         SQtA==
X-Gm-Message-State: AOAM530IFOlFgTtc7b6Md2nXXTDICxElIsh0MkS42WI52FYR6Xty01nd
        dre324GL2mxgB7xLHPopelxtBKtxQCUF8w==
X-Google-Smtp-Source: ABdhPJwZH9luayvGFK6AIfH5tlzx+AOZLnYF3vWUBTmaYHy82L3ZBGlymn6d9A8T8Z6t48XLdXUnag==
X-Received: by 2002:a37:3c7:: with SMTP id 190mr23405440qkd.677.1643904240769;
        Thu, 03 Feb 2022 08:04:00 -0800 (PST)
Received: from [172.17.0.2] ([20.97.219.228])
        by smtp.gmail.com with ESMTPSA id z4sm9516566qtw.4.2022.02.03.08.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:04:00 -0800 (PST)
Message-ID: <61fbfcf0.1c69fb81.24177.ab28@mx.google.com>
Date:   Thu, 03 Feb 2022 08:04:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8577941167051518371=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michal.lowas-rzechonek@silvair.com
Subject: RE: [BlueZ] mesh: Skip unneeded logs
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220203143800.746093-1-michal.lowas-rzechonek@silvair.com>
References: <20220203143800.746093-1-michal.lowas-rzechonek@silvair.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8577941167051518371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=611026

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      1.08 seconds
Prep - Setup ELL              PASS      55.08 seconds
Build - Prep                  PASS      0.87 seconds
Build - Configure             PASS      10.89 seconds
Build - Make                  PASS      1945.03 seconds
Make Check                    PASS      13.23 seconds
Make Check w/Valgrind         PASS      575.62 seconds
Make Distcheck                PASS      306.57 seconds
Build w/ext ELL - Configure   PASS      11.14 seconds
Build w/ext ELL - Make        PASS      1926.99 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============8577941167051518371==--
