Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DE8C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 13:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5728B6145B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 13:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhENN6O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 09:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229889AbhENN6O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 09:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621000622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aYbOKMv29hq6OKyh0UBK1UyMpK22hUmKrOQvrD3ysxA=;
        b=MAQTHrqOtlVXNHWmZufmzoIgZzXCfk0eNq1BcBjecIsPIqdaqr4iD62HUW8Xb4Tm8Kou1/
        ELZTose9VIxNA08thtjCO76J1WOqh8ufRmCExF9+HwOIz8oIBHndwlhF3HFnaxWI0VlDDh
        Dn4dcULHXt5pGnf2RftSpnZZyIjc4cE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427--wu5gQh9NyOrCjYhsmjDWw-1; Fri, 14 May 2021 09:57:01 -0400
X-MC-Unique: -wu5gQh9NyOrCjYhsmjDWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16C0F102CB70
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 13:57:00 +0000 (UTC)
Received: from ivy-bridge (ovpn-117-226.rdu2.redhat.com [10.10.117.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF5FE60CC6
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 13:56:59 +0000 (UTC)
Date:   Fri, 14 May 2021 09:57:28 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [Bluez PATCH 0/6] Fix various memory leaks
Message-ID: <20210514095728.2b7cbef5@ivy-bridge>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I was checking the code via static analysis and found a number of
leaks throughout the code. This patch should address most of what
was discovered.

Steve Grubb (6):
  Fix leak in mesh
  Fix leaks in obex
  Fix leaks in plugin
  Fix leaks in profiles
  Fix leaks in src
  Fix leaks in tools

 mesh/rpl.c                     |  4 +++-
 obexd/plugins/filesystem.c     |  2 +-
 obexd/plugins/ftp.c            |  8 ++++++--
 obexd/plugins/messages-dummy.c |  1 +
 plugins/hostname.c             |  3 +--
 profiles/audio/avrcp.c         |  4 +++-
 src/main.c                     |  1 +
 src/shared/shell.c             |  1 +
 tools/mesh-cfgclient.c         |  2 +-
 tools/mesh-gatt/gatt.c         |  1 +
 tools/mesh-gatt/node.c         | 12 +++++++++---
 11 files changed, 28 insertions(+), 11 deletions(-)

-- 
2.31.1

