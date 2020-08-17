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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7285C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 21:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 835302072E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 21:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rpu0OJSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgHQVV7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgHQVV6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 17:21:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A02C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 14:21:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p138so19835260yba.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 14:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HAjGBhrOHTQnEFg1YCoKCKzFr3JrN5+1ofDPMY2xqK4=;
        b=Rpu0OJSyGJxFS9UuwUtd0mU9gFyAmXO12edBrAUxGaBXAtDdejm4NCx9TRQyTszDjk
         D53GPQC7Wg6UkSP0zFxHFVbB1SGN3N5o+T1tpxagbRSy+Z3pzVuceLhRCG9bK2mws8u6
         Ob+kQqm+n5vr9HgrLxoEale2LhmZvWpCJYU6AYfhgl9DsaTchS9Gk0Um1Dm78ta11Xo7
         86jFu+JL8RBhE4/oEgvEUCCD1PpiwJXID2UyWC+PknrQMEAwjlmLfx6jWzV84U1V2i6C
         p735ZrMODb42p/iTJ3xqnh/3c6C681ewexsn93FbnpWCU+PsejbMv6DIHAQhoGi3jpA4
         jKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HAjGBhrOHTQnEFg1YCoKCKzFr3JrN5+1ofDPMY2xqK4=;
        b=cxegf+L55e85DdOO5tjbZRu5Qg3OWhCzYMc6Xoo1bb120lLuOdIrC8L18usGQCSlJS
         mRoSJGlXRc6gbmulT+ORyp44f+GdjLxoM9enp5Wl3mg0DFc5wQbQu9IMzqe9dbOFeyXu
         cdtuNn6nv7tBJ4itKbDfjb2+9hx9g6OK+mQX/UMv0HiSpCPzzAOcJe066HGxOTliE3Ls
         3gp6TeN5t3iiHZj98rtzdqDmb5U7DelvPc9jgpbdv09PemRQr9ApGjF4vAF/TnZHc0eM
         Vu8fFNImR3meG4bNNJ2CoTdcK3G4PjM37rnyvSizfMH7JH6kfeYsHiSmiMrj+8RVa9Xz
         4DvQ==
X-Gm-Message-State: AOAM530XwNNNhu0J9WQ1jJoxcBKpfCi8K2tzfPpcC5fea7dQ0LhxterX
        6C3yLKIddyP+QxbJcvMb45b8HA3elVolC2BCTNNpFd6k8v/dPLIk78deOSUuuDtlhs3NXa3s3R6
        H7zay42/GsjsJ2Lk/sbv//T+No4dn26sVYM+p09x21Eya0///M4QCpPTduZ0h1emtsERL9WYOsO
        ye
X-Google-Smtp-Source: ABdhPJyljiHFDW7gVNnYT0WajY171oBNUGXZDCZKHV4qVg4w5JqJ0Lk2FbU8yLAsf6lwqgIrY0se2Vccxslz
X-Received: by 2002:a5b:3d2:: with SMTP id t18mr23479124ybp.176.1597699317061;
 Mon, 17 Aug 2020 14:21:57 -0700 (PDT)
Date:   Mon, 17 Aug 2020 14:21:48 -0700
In-Reply-To: <20200817212148.3839311-1-yudiliu@google.com>
Message-Id: <20200817142137.RFC.v2.1.Ibaa1dfd49179a141c19a651f3c2132a28b71b344@changeid>
Mime-Version: 1.0
References: <20200817212148.3839311-1-yudiliu@google.com>
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

 doc/adapter-api.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 1a7255750..250d0e9b3 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -204,6 +204,23 @@ Methods		void StartDiscovery()
 					 org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
 
+		dict GetSupportedCapabilities()
+
+			This method returns a dictionary of supported
+			capabilities that is populated when the adapter
+			initiated.
+
+			The dictionary is following the format
+			{capability : value}, where:
+
+			string capability:	The supported capability under
+						discussion.
+			variant value:		A more detailed description of
+						the capability.
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.Failed
+
 Properties	string Address [readonly]
 
 			The Bluetooth device address.
-- 
2.28.0.220.ged08abb693-goog

