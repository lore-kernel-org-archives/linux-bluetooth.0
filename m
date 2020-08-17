Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FE5C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 21:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2DBC20674
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 21:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNDNHba4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgHQV0D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgHQV0C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 17:26:02 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A71C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 14:26:02 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id q7so12998674qtd.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UuJE2iFxGr+pK6Ja4BJ1thQ9MqtdEznWrskfkznhejE=;
        b=PNDNHba492pImbDK8n3vNAOHennFHh43XZDD22jWKsr0o4q9nfOD1qXBmfmziGbI/l
         +SuAE98GFR4CL6aoVLp/rCv3zDY94i36+wO8D8c8wOquq4lOydG6esVry6mMtwJy6DJq
         uJgEzcVeKfScoSpTqRByYxAR6/37QI0v/90L4OtP7MtwjSChpqAB/gplsmZQkjMMM7qf
         osG2hSGI5i1Pgz+3bEmNUQBTumj8Nl7wx0tx8hCaPVmLSP7hLzw6SG9RlMVe7BAdwgzV
         L/Xn/SoH+5UIiaPvDClLAuMkDW8fvW5sQtAjsSUDMA31INh2wfwwGRfWJFRmxYzZ4dxU
         RPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UuJE2iFxGr+pK6Ja4BJ1thQ9MqtdEznWrskfkznhejE=;
        b=gl1fdyUJVJ6/9nNFeXsaXAUshxG0PMCC9ecrw0Dw03mBLujrcaK2FQJeAsbF2lWHvh
         6mG8xYsA93+fdnRTxNr/CvccfoKvQveF3X+fxVXPP/ttV2iLdetAONQEVu+78JlajgcU
         2hJbXQfCEuDOPfZcRRNDU5Lcfva+j0n6JHYE1JhKCCMKF0zfI1e4NYxffRyxk6uQ3Giu
         MJ47f0u76Lvd5wktmLLRSMRzUsqiA4gbxYbpf+/AIYGtbz0Mq6zxhga9NKb9UjnxZb9A
         I6fmZqvLVfw0dkZ7lKRcbv433lr+4lUdbbH2v3VQtsTESyewCuVLQPoxOWR8LWRXvyux
         B/8w==
X-Gm-Message-State: AOAM531XukcobqlwGMXCPBLFmqGUOFUYM/Pp0xqkVBJDjmyWKSPRwX2v
        w8ceqH+FpW5U3zwlmCcO0Fn3XK56gvehgSP2r1YXp/alaeYAO72jhGja+PPHHk+nOSs4u4CcuwA
        1+2tpB46oEmTdSTJAwLqbzn+n+vwB9Fq13GMswFAsQHnnuXJJ6I0+7/IvrzCuEXRYRso0oCTese
        wB
X-Google-Smtp-Source: ABdhPJzzyTfAyRTReEtDGwLWv+RW4ISuz4YtMgTA1DqFUi/nRnmjVdpNhrvG4lb961gJF0qRqvp8q4axPmoF
X-Received: by 2002:a05:6214:3e8:: with SMTP id cf8mr16285641qvb.74.1597699560661;
 Mon, 17 Aug 2020 14:26:00 -0700 (PDT)
Date:   Mon, 17 Aug 2020 14:25:54 -0700
In-Reply-To: <20200817212554.3844965-1-yudiliu@google.com>
Message-Id: <20200817142545.RFC.v2.1.Ibaa1dfd49179a141c19a651f3c2132a28b71b344@changeid>
Mime-Version: 1.0
References: <20200817212554.3844965-1-yudiliu@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [RFC PATCH v2 1/1] adapter - D-Bus API for querying the adapter's capabilities
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Archie Pusaka <apusaka@chromium.org>, sonnysasaka@chromium.org,
        Yu Liu <yudiliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Initially this is introduced to query whether WBS is supported by the adapter,
the API is generic enough to be extended to support querying others in
the future.

Reviewed-by: sonnysasaka@chromium.org

Signed-off-by: Yu Liu <yudiliu@google.com>
---

Changes in v2:
- Return an array of strings instead of a dict

Changes in v1:
- Initial change

 doc/adapter-api.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 1a7255750..8fbcadb54 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -204,6 +204,18 @@ Methods		void StartDiscovery()
 					 org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
 
+		array{string} GetCapabilities()
+
+			This method returns a list of supported
+			capabilities that is populated when the adapter
+			initiated.
+
+			Possible values:
+				"wbs" - Wide band speech
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.Failed
+
 Properties	string Address [readonly]
 
 			The Bluetooth device address.
-- 
2.28.0.220.ged08abb693-goog

