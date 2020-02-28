Return-Path: <SRS0=e/tT=4Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D53C3F2D3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DC1246B5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2b4J8ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgB1XrG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:47:06 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:36567 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgB1XrG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 18:47:06 -0500
Received: by mail-pj1-f54.google.com with SMTP id gv17so1921537pjb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 15:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGeJvn5f/TortUIRqyBMZXkJuSujmHw43Jjf8CfXFrs=;
        b=O2b4J8ryDahyS7lpY8162t3HFqXeCp0CXxcNxL/8YSXZd+jYAj3ZeWDLe/AkVbDFQD
         BDRMjxlRFkpkFDD7MmoaVM4skqhRKyxHIullb8DIgkUF5udY53w8eFSbvMm74viRioX/
         Z9NwUZCMgFQJ6vVfbGL0DDTu4twyKP7ZbwicJseqfJGRhYLQYd0CtpokdqD20h1Hx4FR
         HLH/S2HBRkS2J+zM9pB9gH4XEnpwIaB/YU5+9XqjZymNlnSHxrV5YLxbE2cH7RDfUcfi
         476A/cCYwJnse0N4nX/JdOthimp/WQqnRjePJmsVnu8JyTKmPfYU6NJwyH7uOVjejjSK
         nVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGeJvn5f/TortUIRqyBMZXkJuSujmHw43Jjf8CfXFrs=;
        b=LbKaiBpEESWaYwgARGJslJnfYdYWvAxB45IEw3PYTLZrssI4u+fsCZee/BTuDS6lrT
         +mmVbq80ZyUgxajpFcC3z/BBqPs77XqS5eUXTRrvYIGeENvve7RLiGL3wnftB9XHVF6Q
         cD6cKlWGjgqvsHSi2aWNvtN3jkfH0s1YMg1oOGOAABiuBAP2pKjVJq2Nh0KD0BILsEej
         WEwvbD1O0ptzB9zZpyWBFEE4K7JzIthZeknXLucncjc3sde+GcxOvougpr1mC54VtKgx
         5PmsjhU8BgC+O3GyDD5rOSegsco3QhF5BfYcUuXONi8a/FE6Ie9jr93dSXLTe5OwbJMP
         gikw==
X-Gm-Message-State: APjAAAWPI332+LXDzzuuB+juITkTbQPIl2a1G+NSrXsAHM8aSPJksDOr
        Iu/O6x0LnTjadMTMyHKhv8qAaap7XC8=
X-Google-Smtp-Source: APXvYqz7o4tEOhiX/UEouRTs8Mpl2TR2tej2rEwpTfGwMtn+U8eUwtBzsW2X3TImABtjejKcQzmGTw==
X-Received: by 2002:a17:902:7797:: with SMTP id o23mr5940809pll.298.1582933623334;
        Fri, 28 Feb 2020 15:47:03 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q13sm13643954pfn.162.2020.02.28.15.47.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:47:02 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 00/12] Userspace Bluetooth 5.2 initial support
Date:   Fri, 28 Feb 2020 15:46:49 -0800
Message-Id: <20200228234701.14614-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces the initial support for Bluetooth 5.2 features:

* ISO channels:
        + tools/isotest command line tool to run validation tests

* L2CAP Enhanced Credit Based Flow Control Mode
        + tools/l2test has been update to include the new mode

* Enhanced ATT Bearer:
        + Client and Server support
        + Include all new procedures
        + Automaticlly detects and enables channels
        + Number of channels configurable via main.conf

v2: Dropped ISO changes since there still under discussions how it will be
supported, change ECRED to EXT_FLOWCTL and use BT_MODE to set it.

Luiz Augusto von Dentz (12):
  lib: Add definitions for Enhanced Credits Based Mode
  btio: Add mode to for Enhanced Credit Mode
  l2test: Add support for L2CAP_EXT_FLOWCTL_MODE
  share/att: Add EATT support
  shared/gatt-client: Add support for EATT features
  gatt: Enable EATT bearer support
  shared/gatt-server: Add support for Read Multiple Variable Length
  shared/gatt-client: Add support for Read Multiple Variable Length
  shared/gatt: Add support for Handle Value Multiple Notifications
  gatt: Add support for Notify Multiple
  core: Add support for setting the number of GATT bearers
  monitor: Add support for decoding EATT

 attrib/gattrib.c         |   5 +-
 btio/btio.c              |  53 ++-
 btio/btio.h              |   3 +-
 lib/bluetooth.h          |   2 +
 lib/l2cap.h              |   1 +
 lib/uuid.h               |   3 +
 monitor/l2cap.c          |  39 ++
 peripheral/gatt.c        |   2 +-
 src/device.c             |  18 +-
 src/gatt-client.c        |  85 +++++
 src/gatt-database.c      | 125 +++++--
 src/hcid.h               |   1 +
 src/main.c               |  14 +
 src/main.conf            |   5 +
 src/shared/att-types.h   |  25 +-
 src/shared/att.c         | 780 ++++++++++++++++++++++++++-------------
 src/shared/att.h         |  18 +-
 src/shared/gatt-client.c | 287 +++++++++++---
 src/shared/gatt-client.h |   5 +-
 src/shared/gatt-server.c | 389 ++++++++++++-------
 src/shared/gatt-server.h |   2 +-
 tools/btgatt-client.c    |   2 +-
 tools/btgatt-server.c    |   4 +-
 tools/l2test.c           |  10 +-
 unit/test-gatt.c         |  25 +-
 25 files changed, 1407 insertions(+), 496 deletions(-)

-- 
2.21.1

