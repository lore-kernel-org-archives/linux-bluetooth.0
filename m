Return-Path: <SRS0=CMXm=WX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468ECC3A5A3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Aug 2019 09:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1853E206BF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Aug 2019 09:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ZjVjwFB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfH0JIw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:08:52 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:43441 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0JIw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Aug 2019 05:08:52 -0400
Received: by mail-lf1-f49.google.com with SMTP id q27so4957908lfo.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2019 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucr3dvXXpoITP/+tTtkOCSKvMPjGOYLix5t9MYhJgJc=;
        b=ZjVjwFB1E6O+yt85GTuP/5RDz0+0/1y4OnkUAlHwNZ1gCx4AoK+58t//+WbH5oMtV7
         1GNUnUvLyIqd2z4nBGqddMFVSYz83jIKXVOsepuJfWYjnF6nwTWCuZVW+kluavlBiNYe
         GM1wA7Au58JC8g9fOd5SyWVdm1iZvkYXWXjRGJuJDrP8dugIJM4vyLo09R6J4HZRtAuY
         MQZ0A36ZbkG9bYVMtciOqg5NerWP3g53M98d4u2lU0+11CPylbWcUTh6JKNAI5QE+UR9
         sf7yJeBSBWemzdK1BTCiCYIaOR47jEPtFyP+UXW0piQ6mjgljxNSHrp0cuXh8iAu4hZ+
         PRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucr3dvXXpoITP/+tTtkOCSKvMPjGOYLix5t9MYhJgJc=;
        b=UuIoouct/0lHzsR4lAsizmwHRnfVHV2oXrHz3b9Plww29TamoMwbj+zvezmm+LXsQ0
         S/qDBPYNa9NctN61kMVoZxCq55Ucbgsq2HHDOyzlLOwkMHPI5BOZtg7LePI2moLF5E+G
         L80OJEYWwUUykMPDKYipbjjYmdSGHopDE0P00uWV9YVPbPqnmr3krsPHSO0zDyJ4kAZT
         fdWDc71Xe05bSn9ZUtKk1k/mt51eECyja6IYc6HzdpE5UVbE9APgf5Xu+hXrLem3YktG
         rpq6PjTgr/kEoviJsw2V9JSMbY9DqZTmx/UuwS2VM02n37+Wx/P1PZH0QEeTYYb1lL2P
         lotg==
X-Gm-Message-State: APjAAAXMZyLXw6WfpQHgVEyOy0ITf5q7T1lpLEqS3UVCQJjiB9FqwfgZ
        O6lNgZRvVFT+17e++Va0sfQbh9qeG2w=
X-Google-Smtp-Source: APXvYqyjIXgMn0uyxzHPzSF0hl6jmxYurP95SJMI+CF4Ua2lVO+GqWFvz9DT+GDu+kRhZw9NHizCng==
X-Received: by 2002:a05:6512:50a:: with SMTP id o10mr8613720lfb.170.1566896929811;
        Tue, 27 Aug 2019 02:08:49 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v2sm2525625lfb.88.2019.08.27.02.08.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 02:08:49 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/2] mesh: Implement org.bluez.mesh.Node1 properties
Date:   Tue, 27 Aug 2019 11:08:42 +0200
Message-Id: <20190827090844.21394-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch-set implements previously defined properties on Node1
interface and adds two additional properties: list of unicast addresses
claimed by the node and the current sequence number value.

Michał Lowas-Rzechonek (2):
  mesh: Implement properties on org.bluez.mesh.Node1 interface
  mesh: Add properties to Node1 interface

 doc/mesh-api.txt |   9 +++
 mesh/net.c       |   4 ++
 mesh/net.h       |   1 +
 mesh/node.c      | 143 ++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 156 insertions(+), 1 deletion(-)

-- 
2.19.1

