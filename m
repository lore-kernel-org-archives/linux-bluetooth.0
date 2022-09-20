Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640B4ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Sep 2022 11:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiITLIb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Sep 2022 07:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiITLI3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Sep 2022 07:08:29 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647F667CB0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Sep 2022 04:08:28 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i3so1323204qkl.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Sep 2022 04:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=5Ga2nV01dEjt5CnxV/6JGI493WgtdyrnFfc4ufrsUdo=;
        b=Kd1zWZ0KsN/xLAgYrylIrJVlxNxh0DCQ8NIvTkdnGqVbJ0Qs2niv4p8WeIbSjS7wZi
         rWnkItSYJdBA4jwkwH60g2Ah72Sp3ZrlkDONjpcfAUsZZFu+ziPEHB7AC21USNKmpYTO
         xZvCcleCl6XfX66xPO45OtDgjvtotSvIaejKF/V89PZUvFbfcJIwzTy024NdIwXAilIJ
         h+txKBZvaQyfsjcOKp8ucCkvuwOd+0U3mBs1jozIdg59Gc78WAMGVeLQrzzH/ULlne/U
         K7jCnJ/tQ2AX7CoRC9CFti52FeMik1dd/qtlY+3rbcda9y58Vt3Su+CmcBf8pqXq+YCD
         XEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=5Ga2nV01dEjt5CnxV/6JGI493WgtdyrnFfc4ufrsUdo=;
        b=7lRIe+adM2QJlKYLZrojrKWuTlHuBpePHsnLaG9iOqJCHZyXBI4c2nAI1Udft2A3Be
         CAzqba2prWs+oV6kSfbK8WAfrrA6uorkYRR/jld3pa1c0DD7PTIwZ0WpnpMhpIRJbxi/
         pO1fNd0DHLm8IvIuqg31uyI8x4tD3yahgFvx0MA/fsmHa1KEVNw2kbK2NogsjouX6iwo
         sVhgfi1ciPC9Ia1SlTyrtxsprN+STkNEsIatjkdhCHb6D2tjH7NSO8n6avIOaZtiI3II
         LIvkfDQq/6HjzJuy5wr1NXPg91zVYhNKm/8ee199IpmAf7v59ZHOAJm4qmA+OUYr8L3k
         jdQQ==
X-Gm-Message-State: ACrzQf0fkcf1Ir3we8I/pYPXt7eVyRo9wBYK3Z6Dk05ZzKCNjo1+u0Kr
        wHs0jUShG4w+FssIi2oJ/4BMty08NVT0eg==
X-Google-Smtp-Source: AMsMyM7PKZvHLFLaQJ13rmcfBVUIK/bhbtFGByIyRDBo+1rYm87rvogzfDBHu0s6Qka1uW9XLFUZJw==
X-Received: by 2002:a05:620a:4726:b0:6ce:9ea8:4c23 with SMTP id bs38-20020a05620a472600b006ce9ea84c23mr15505210qkb.127.1663672107456;
        Tue, 20 Sep 2022 04:08:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.40.135])
        by smtp.gmail.com with ESMTPSA id b23-20020ac86797000000b0035bb6298526sm756014qtp.17.2022.09.20.04.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 04:08:27 -0700 (PDT)
Message-ID: <63299f2b.c80a0220.8f78a.1489@mx.google.com>
Date:   Tue, 20 Sep 2022 04:08:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7894268012441669976=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: [BlueZ,1/1] sharaed/vcp: Add bt_vcp_set_debug
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220920102847.599893-1-sathish.narasimman@intel.com>
References: <20220920102847.599893-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7894268012441669976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=678585

---Test result---

Test Summary:
CheckPatch                    PASS      1.83 seconds
GitLint                       PASS      1.06 seconds
Prep - Setup ELL              PASS      26.98 seconds
Build - Prep                  PASS      0.83 seconds
Build - Configure             PASS      8.74 seconds
Build - Make                  PASS      838.71 seconds
Make Check                    PASS      11.93 seconds
Make Check w/Valgrind         PASS      290.35 seconds
Make Distcheck                PASS      242.06 seconds
Build w/ext ELL - Configure   PASS      8.85 seconds
Build w/ext ELL - Make        PASS      85.16 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      526.53 seconds



---
Regards,
Linux Bluetooth


--===============7894268012441669976==--
