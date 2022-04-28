Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435A3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Apr 2022 03:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbiD1DJR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Apr 2022 23:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiD1DJQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Apr 2022 23:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2BE92D1F6
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 20:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651115162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5MQTeNpfi0GJfUx46cs6svvWHy9BX/VsoVzEdXUF2TM=;
        b=FlhBVqcr81lz0hfpp6mtGyX/FdjWsy6CSsSTBR7kngNxboKu6UJc4ZPUklUHLXghouKR5Z
        ILGtCHNPRoryPQsC+p4CL/Vmzp8o9UDOaW9xEVT4aQquk2Zme44PnBUDeXKEoeokto+eZc
        UCCbKX+6/i+8hczEW8KSKGoZa/Areyc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-nnb5NoLmOM28SdU-Aun8ww-1; Wed, 27 Apr 2022 23:05:59 -0400
X-MC-Unique: nnb5NoLmOM28SdU-Aun8ww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03FBE3C01C00;
        Thu, 28 Apr 2022 03:05:59 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0A6E2166B4D;
        Thu, 28 Apr 2022 03:05:58 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     jukka.rissanen@linux.intel.com
Cc:     linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        stefan@datenfreihafen.org, torvalds@linuxfoundation.org
Subject: [PATCH bluetooth-next 1/3] net: 6lowpan: remove const from scalars
Date:   Wed, 27 Apr 2022 23:05:32 -0400
Message-Id: <20220428030534.3220410-2-aahringo@redhat.com>
In-Reply-To: <20220428030534.3220410-1-aahringo@redhat.com>
References: <20220428030534.3220410-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The keyword const makes no sense for scalar types inside the lowpan_nhc
structure. Most compilers will ignore it so we remove the keyword from
the scalar types.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 net/6lowpan/nhc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/6lowpan/nhc.h b/net/6lowpan/nhc.h
index 67951c40734b..2ac7da388c4d 100644
--- a/net/6lowpan/nhc.h
+++ b/net/6lowpan/nhc.h
@@ -67,11 +67,11 @@ module_exit(__nhc##_exit);
 struct lowpan_nhc {
 	struct rb_node	node;
 	const char	*name;
-	const u8	nexthdr;
-	const size_t	nexthdrlen;
+	u8		nexthdr;
+	size_t		nexthdrlen;
 	u8		*id;
 	u8		*idmask;
-	const size_t	idlen;
+	size_t		idlen;
 
 	void		(*idsetup)(struct lowpan_nhc *nhc);
 	int		(*uncompress)(struct sk_buff *skb, size_t needed);
-- 
2.31.1

