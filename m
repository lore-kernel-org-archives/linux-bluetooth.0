Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E97FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 22:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48502613F6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 22:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhELWlE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 18:41:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41842 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1391959AbhELVfO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 17:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620855236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zmpVYh0nlS5zOA8MasiH/aAsbKCxqcrKieGO3ZPl4Ks=;
        b=TtT0m/bGiPZNDR2DtxzJ/nu61Q8NfcxiLSi60IOL6wq9YWNh4Dggnax+xc0q8XPAaoShF3
        kuTmA2GyUH/1QjQj56jLDeBDognBfWoCdfa0A1seDmhZd2PLWmk12R+s3Ka0oN/pVA0hhE
        IEFZ3OYZ1Wz5gmXtUJ6w0HWEvZ757HY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-WCNVdAIeMTyzSQ3RuoO02Q-1; Wed, 12 May 2021 17:33:45 -0400
X-MC-Unique: WCNVdAIeMTyzSQ3RuoO02Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 309AE1020C36
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 21:33:45 +0000 (UTC)
Received: from ivy-bridge (ovpn-112-130.rdu2.redhat.com [10.10.112.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4CF360CC6
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 21:33:44 +0000 (UTC)
Date:   Wed, 12 May 2021 17:34:11 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [Bluez PATCH 0/6] Fix various memory leaks
Message-ID: <20210512173411.134acc8e@ivy-bridge>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

Was checking the code view static analysis and found a number of
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

