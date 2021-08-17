Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44523C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 17:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2084D60F58
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 17:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhHQR3w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhHQR3w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 13:29:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217F8C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 10:29:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so6492773pjr.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allthenticate.net; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=otCc8z/aEEvF+KNfFvzdmAaiNHfr5OLeVnhcXBgKijA=;
        b=U2++0E+EufNBgsFBvXore0df7N/iTN3bOHHscRDqEqtG/YrUcwhRQIuIPYnO2s+uoI
         Sw1HcGvtk8mCZKTbfCEJJJspXYmYkFc1g7D+rJKPPkcVmszPTgXGaD6Ea0VgHdJODaOJ
         N2+w5rqjGIh9My+aYlQgP5zGJMhxmnwKWS4yAEuBPkTlrdszAMhN34rkzhRiM5Jz42qy
         wuWr2LNB1bcefc76pnHHmDG++Vrv2sobGmmbFehIV2w81egwWe/k5goh/rqxQRMw4BSF
         CBXFXPSNvKgkESUGduevwT/g3cBWsD8ep/sLtjngih/QpZq8E0dq5kc8OXLgiU7stHcQ
         S6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=otCc8z/aEEvF+KNfFvzdmAaiNHfr5OLeVnhcXBgKijA=;
        b=MMW4OllpuevhADJ//U2TNFCNDtVcehFHth7PAHTxIL2fKmtV6faKiZs6HjKyWPuYco
         1SSN44bD2lu2lhqCDjNXnbeVFjDTHVxls0VUOXmbsjygZzSavVB7F31SL8ahHfuwQIxd
         Z5T8Vpo8H6lsQMdZGZTvUFMLNeiFAqP0nyARB0asPbWmoFIhpo80fWOBZr3P5knAyLo1
         ySC1GFkh7nAKwcrfj2pNAIDcJEE6FQm+Vy3MfmWbw4oWyeJfmNrWwqocjKj9pNTSjVKQ
         3G5I3AoBiI3GQnh55qdLoNA6W5V3WM9sOzX/Fl7hoaMuEsVBQ9wIghXru09jKZLqXH+9
         nBKQ==
X-Gm-Message-State: AOAM532KPAFCsrwktM7OSB4thEZ/K2TROuNQL7osZO3hrdKkFzEoPJRz
        e6B2hMPSHI3J575plNU6RQqcGmJqGDmVuUMh
X-Google-Smtp-Source: ABdhPJxgPa1HPprv/0BMpPFGxMNybeFo1Qq7pyzpuOWdPHSsqn6YCJ/u4DbXkC2cIoVSY5E0XHr0EA==
X-Received: by 2002:a63:303:: with SMTP id 3mr4500608pgd.439.1629221358436;
        Tue, 17 Aug 2021 10:29:18 -0700 (PDT)
Received: from BernieDesktop.lan (wsip-72-222-70-2.sb.sd.cox.net. [72.222.70.2])
        by smtp.gmail.com with ESMTPSA id q3sm3975042pgl.23.2021.08.17.10.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:29:18 -0700 (PDT)
From:   Bernie Conrad <bernie@allthenticate.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bernie Conrad <bernie@allthenticate.net>
Subject: [RFC PATCH BlueZ 0/1] method to notify/indicate to one device
Date:   Tue, 17 Aug 2021 10:29:08 -0700
Message-Id: <20210817172909.18630-1-bernie@allthenticate.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello maintainers,

This is an RFC for an added method to be called over dbus by an
application to be able to notify/indicate to one device rather than all
subscribed devices. 

This is motivated by similar functionality in the corebluetooth API with
CBPeripheralManager's updateValue() method as well as the Android API's
notifyCharacteristicChanged() method.

There is a prior patch I submitted with this feature (12439517) with
style issues that this RFC supersedes. There are some additions missing
from this RFC that I can add if this is a feature the maintainers are
interested in the form of added documentation and overall cleaning up
the added method.   

Bernie Conrad (1):
  Added GDBusMethod to notify one device of characteristic change

 src/gatt-database.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

-- 
2.17.1

