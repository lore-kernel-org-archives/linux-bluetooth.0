Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C4FC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7B2206FA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfiO2Fmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgCLKGf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:06:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45159 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgCLKGf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 06:06:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id m15so2817991pgv.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=27oyMvKKiaAWsWXeWpc+V3ciGi01660vPlxNUTCdChs=;
        b=YfiO2FmtxsYqyxKfCxmblNB/wNYxB0NALzLaMisbLjnXqMAEKCuhjEm559fKB1zNKe
         aC9t6ZVFKAFU4HxxaIDpjA/ETK6l9JPgdgpeYGqS0+LsutuUkAZnWHL33kKQnqbsyyZP
         WFEgo5ybZRV5iFZSvI4WNPPhdWYDKPDlbq1L7yh0LUCbX6AStFvFON437Rb+ol3fwNPb
         kwGSNeG+HFH2qIZisbeFRjw6fbdGdKJP9LHDpIC++qtdQLgZru0UbckZAMA231Sky6JL
         iTtigMFihfPhWYK9fYGRGuqoQQz+Ab0mOqSvNa2tDkFkJuWpxOrCT+8MD3bXJrRjabyz
         YRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=27oyMvKKiaAWsWXeWpc+V3ciGi01660vPlxNUTCdChs=;
        b=M6TYXrxd+j8KBylt7gD8j/7eDD1QIF6sVIUUIya+s6ETQ5MG28pvlLyirkIvzCHJ2b
         qKT90jsDdftFgQUQ1Rh+Fe/zNevkOlCdAiXYhzdjqCq7c+TvuOHTgjJTCQCoq/XqqF9G
         kNYAboZktRdjb9PcmbALlWBjQFW2zfqOwi7wBr48UEw2tO1PQgebXwi96w1J9gM+KY64
         DFnnal1w+huM6xo2rvLRlzRxzkIv79OSfj4PEVsQn43eLn5zD8lN8qp0eyRaErlWQfpw
         LmlJx7kzP+Ds4qbwY5fOUzRsjHtE2cqif4kEq2AJs1vWYmGpKKZ1X+USs+Ae6A8za/9U
         wJgQ==
X-Gm-Message-State: ANhLgQ0NTE3hqA25xw/UVxJzkxj944yynJS8KSbx0ygD1+Pc/q88o9Z2
        wy6DZyU5gVrxuyVZAtmgfxAYcG8HzYY=
X-Google-Smtp-Source: ADFU+vtdmgBTiL74xkm7eY0eGRE/rHXCkG9H2fc+Td8A6pwlvAfkcc+ELr6VZN+sc/EZXVKjK4/aNQ==
X-Received: by 2002:a63:82c2:: with SMTP id w185mr7223990pgd.382.1584007594147;
        Thu, 12 Mar 2020 03:06:34 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id e9sm10578295pfl.179.2020.03.12.03.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:06:33 -0700 (PDT)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org, nsathish41@gmail.com
Cc:     chethan.tumkur.narayan@intel.com,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH 0/7] LE LL Priavcy support enabled
Date:   Thu, 12 Mar 2020 15:37:47 +0530
Message-Id: <20200312100754.3445-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

With this LE LL Priavcy feature available if BT controller supports
LL Privacy when privacy is enabled.

The patches are verified in below case.
Pairing - where the IRK is added to device Resolving List after 
identity info & IRK is shared in SMP.
Unpair - Delete the resolving entry from the Device resolving list
Local IRK change - Whenever there is change in local IRK (privacy) the
resolving list entries in the device is updated.
Whitelist - filter policies for whitelist is updated based on LL_adress
resolution support.
Reload Resolving list - device reset/sysmte reboot the Resolving list
reloaded in to the device.

Sathish Narsimman (7):
  Bluetooth: LL Privacy Delete Store Resolving list
  Bluetooth: Add device to Resolving List
  Bluetooth: Update the Resolving list when Local IRK changed
  Bluetooth: LL_PRIVACY re-load resolving list
  Bluetooth: LL Privacy Check and Update the Resolving List
  Bluetooth: Enable LL Privacy
  Bluetooth LL Privacy update White list

 include/net/bluetooth/hci.h      |   3 +
 include/net/bluetooth/hci_core.h |   7 +
 net/bluetooth/hci_conn.c         |  32 ++++
 net/bluetooth/hci_core.c         |  20 ++-
 net/bluetooth/hci_event.c        |  32 +++-
 net/bluetooth/hci_request.c      | 251 ++++++++++++++++++++++++++++++-
 net/bluetooth/hci_request.h      |   2 +
 net/bluetooth/mgmt.c             |  10 +-
 net/bluetooth/smp.c              |  11 ++
 9 files changed, 354 insertions(+), 14 deletions(-)

-- 
2.17.1

