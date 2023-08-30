Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5912C83F14
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 20:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjH3UWI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 16:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbjH3UWG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 16:22:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BB4F4
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 13:21:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bee82fad0fso455545ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693426828; x=1694031628; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uUwuACKLw7Uj75bYjDPzph717qP4lpf5OjxRt+HTsVI=;
        b=N0cgK0IsrUY+os9j293TqYtFdqdRZxYHKycx1TMdNLJvB+bolU4Vm3dGDx+BpnHd5b
         OCSVDxz4bSAIZ2te/MgbO7zOgj4wfxlqUL5SmhlfGZNRkH88P6zjSo7r+njOBOOQGgKP
         YTTmcDPLNFJQfetctTjYg7dXISQ3wGtyxp4Bs0nxYkpsX/b9M9VxQEs7VGYiki/3RgVx
         F/TMACqmr2sXR2s8kCAPxKS2Ix4YF9wzjWisQt4x7IVBI9XoXuBD/NYC/n7LvRU1bsTe
         +tOZmN2JTyh74yp8JE1lEz6c4mTmZkWlcZWbatV9SER6A0c+iqL3kyYsVshsFSsp8rvx
         dMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693426828; x=1694031628;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUwuACKLw7Uj75bYjDPzph717qP4lpf5OjxRt+HTsVI=;
        b=Q5ol0aBJZBszZVFC6OXcxU27GZU4dfB7fg4y4QxZA6qLisWSUt81s14PMzAsQAifrQ
         2W4y0DldtMXM4UnSOc8Bz7J7SNQCnf7AO001g60I9UA94YW7UE4KxCYgtHLzd0xxidN7
         7lUzsrmRmgZc6duW35HFA3/dAfgj903h17DofMsE7IvKh00zlYLXR2TPNP9Z+syGsKKg
         Kaf/n7PsvK827wUkG29++3BbZ+Z9gT/ybsNMR0RT3N8XIHl8ZL/Xb20wlCv2pLg/ddkE
         +snhL/PGA+vrX2tn+ambYIqLR+jHgRGTpBLsEzTfPtraEb1fC5q8hkyU/nNgYq+DWX83
         iqtQ==
X-Gm-Message-State: AOJu0Ywusv7TegrYC1pJxAD6TrmiL+4FuSFzbLOclJtbYxMQh5qgG/RF
        oBkV8Hr7O2BbkZsPyWqbL+cwm0xqJ49L0A==
X-Google-Smtp-Source: AGHT+IHiXVEzDMt2iiL76lugbOOYYlvihNLk3p13J8EWVwPtUd9xFk87ndmMEBDCz1JTi1vnZF0YLQ==
X-Received: by 2002:a05:6a20:914a:b0:140:3775:3086 with SMTP id x10-20020a056a20914a00b0014037753086mr3596127pzc.59.1693424466756;
        Wed, 30 Aug 2023 12:41:06 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.2.247])
        by smtp.gmail.com with ESMTPSA id c21-20020aa78c15000000b0068c023b6a80sm10786894pfd.148.2023.08.30.12.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:41:06 -0700 (PDT)
Message-ID: <64ef9b52.a70a0220.eb89f.31f8@mx.google.com>
Date:   Wed, 30 Aug 2023 12:41:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8117627623808675920=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Pass BIG encryption info through QoS
In-Reply-To: <20230830130147.359016-2-iulia.tanasescu@nxp.com>
References: <20230830130147.359016-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8117627623808675920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=780615

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      42.94 seconds
CheckAllWarning               PASS      45.29 seconds
CheckSparse                   WARNING   50.15 seconds
CheckSmatch                   WARNING   136.01 seconds
BuildKernel32                 PASS      40.44 seconds
TestRunnerSetup               PASS      611.18 seconds
TestRunner_l2cap-tester       PASS      37.57 seconds
TestRunner_iso-tester         PASS      82.05 seconds
TestRunner_bnep-tester        PASS      14.97 seconds
TestRunner_mgmt-tester        PASS      269.92 seconds
TestRunner_rfcomm-tester      PASS      21.61 seconds
TestRunner_sco-tester         PASS      24.98 seconds
TestRunner_ioctl-tester       PASS      24.81 seconds
TestRunner_mesh-tester        PASS      19.39 seconds
TestRunner_smp-tester         PASS      19.40 seconds
TestRunner_userchan-tester    PASS      15.09 seconds
IncrementalBuild              PASS      38.78 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============8117627623808675920==--
