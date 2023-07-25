Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B018C001DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 08:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjGYIq0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 04:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjGYIp5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 04:45:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1184B35BD
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:44:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-992ace062f3so913204766b.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690274676; x=1690879476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gE05xU+PHcDSrqS28hhREBSzicKkqBqbPVrCLbwhBSw=;
        b=Q2WS/5imCslFrQ7LZ7YpT8pWimRUYOmB9cyrWLkn70DOn13VYi/MM2gNhjJO3z6mtD
         +V37rF/zJaFhUjkxFXRnA1avrCZuEINySrw70mW8IGBefEBoVXkfkou+R5vO5YftoeUq
         qcKXCu+BmuusE2cprEgMWaHT0qjD4tAUebYsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274676; x=1690879476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gE05xU+PHcDSrqS28hhREBSzicKkqBqbPVrCLbwhBSw=;
        b=FqLEdLVAgj3mnFigrFVfO/7fhbhcWyPIzEMBLeERST1pzaupWb5AtzmkWmJzmAGdSM
         PYp+hGJIJ8M3fFZDYrIK1zu/mYh/UmYcyzoGo6N4IeAY0QKIBDIQBH7RfnzqMPZ7EcjX
         3Myi+uKlM9sd73ANgkzYFQlg4fMHatGfPD82qSCR60G3SdKIRhaczP4lI8Wbqaromchh
         zC8bvY4lMdtyXq6FCYRAVowJyra0XADgc+TP7PPYm0DbUimpqC0OEbORcQ2o2ZaSFScn
         rpLdpDHbP3PDDVGd/uqgSUe5X9jcUXpHcZ1p2icSoOty+zvFWCHEbn4wmsCAAl80mFix
         CRbw==
X-Gm-Message-State: ABy/qLbNNPUXtKkMG4tfkjT1H6jXhoAA0fXbZ4kMBBfERl6PRjkSIBn2
        61nOx79XDO/Nhi89VaHWQ+SFYFE+5O4ZvIaSg68=
X-Google-Smtp-Source: APBJJlEInkwq5CrPCNhHUFx6daTITp2uhrg5LIQOVaygWbgTFw1V8JUSCNKSxMxiRSwp0f+xy8TxHQ==
X-Received: by 2002:a17:906:64cb:b0:99b:4668:8666 with SMTP id p11-20020a17090664cb00b0099b46688666mr13303644ejn.6.1690274676603;
        Tue, 25 Jul 2023 01:44:36 -0700 (PDT)
Received: from Legionbuntu.. ([2a01:c846:10c0:200:ed64:7921:ba0:11aa])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906164a00b00977cad140a8sm7866577ejd.218.2023.07.25.01.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:44:36 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 0/8] Various fixes and refactors
Date:   Tue, 25 Jul 2023 10:44:23 +0200
Message-Id: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixes for pairing and discovery for dual mode devices
Fix for EIR_BREDR_UNSUP flag
Add handle numbers on dbus for client
Minor refactor, fixes

Simon Mikuda (8):
  advertising: Fix setting "BR/EDR not supported" flag
  adapter: Be able to use ConnectDevice for discovered devices
  device: Refactor device_discover_services function
  device: Rename start_discovery function
  device: Fix pairing and discovery with dual mode devices
  device: Handle error from discover services request after pair
  gatt-client: Add read-only handles to dbus
  adapter: Ensure that file exists on IRK write

 doc/gatt-api.txt        |  3 +++
 profiles/input/server.c |  2 +-
 src/adapter.c           |  7 +++--
 src/advertising.c       |  8 +++---
 src/device.c            | 60 ++++++++++++++++++++++-------------------
 src/device.h            |  3 ++-
 src/gatt-client.c       | 36 +++++++++++++++++++++++++
 7 files changed, 83 insertions(+), 36 deletions(-)

-- 
2.34.1

