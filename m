Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862EFC2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 20:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64AE02074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 20:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586897191;
	bh=a+xZOQRukeq33gh1DtCHXa4pGrhdEzvufrkWxoH6f30=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FX/R08iWzNdo4HN52xesFQDbWmSSREyfU4aG4mMf582UVskiSDc6BqhRgpySbQpfu
	 0lmp8mxkphvBhIkJVdGDxo/4q89Ku8n6a5coos6q0C0i93DJe1zOexoQlGAclqB/DA
	 7wfcvt2nZa8OpthVoCQhDThM8QXICZadDB9L/hrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633359AbgDNUqV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgDNUqU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 16:46:20 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 206622064A;
        Tue, 14 Apr 2020 20:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586897180;
        bh=a+xZOQRukeq33gh1DtCHXa4pGrhdEzvufrkWxoH6f30=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h+/qRCj9rJ9tcSbC31ZSPLuHINxO1xbpPRfHKsPacKlF8b15UTNuBYMYL2L7ds2Ja
         RpUT0HawaDjp5lUDa8lsNivrwmm2QBMJ41YuaYMmVu5zdjq3KAsGHnKrUrrxXemePM
         /qIe5lLzDUn+KzcFZToO7MFJr5ba964FsX5f1kZw=
Received: by pali.im (Postfix)
        id 1B9F6770; Tue, 14 Apr 2020 22:46:18 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH] doc: Update documentation for HSP and HFP profiles
Date:   Tue, 14 Apr 2020 22:46:02 +0200
Message-Id: <20200414204602.29215-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CABBYNZ+BD2g35wWHocp25kK_s07y7Yec8+51pEv37bh3U-fR-Q@mail.gmail.com>
References: <CABBYNZ+BD2g35wWHocp25kK_s07y7Yec8+51pEv37bh3U-fR-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix information about default rfcomm channel number in HFP HS role
(it is 7, not 6) and add documentation about default values.
---
 doc/profile-api.txt | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/doc/profile-api.txt b/doc/profile-api.txt
index ec18034..183c6c1 100644
--- a/doc/profile-api.txt
+++ b/doc/profile-api.txt
@@ -16,10 +16,33 @@ Object path	/org/bluez
 			If an application disconnects from the bus all
 			its registered profiles will be removed.
 
+			Some predefined services:
+
+			HFP AG UUID: 0000111f-0000-1000-8000-00805f9b34fb
+
+				Default profile Version is 1.7, profile Features
+				is 0b001001 and RFCOMM channel is 13.
+				Authentication is required.
+
 			HFP HS UUID: 0000111e-0000-1000-8000-00805f9b34fb
 
-				Default RFCOMM channel is 6. And this requires
-				authentication.
+				Default profile Version is 1.7, profile Features
+				is 0b000000 and RFCOMM channel is 7.
+				Authentication is required.
+
+			HSP AG UUID: 00001112-0000-1000-8000-00805f9b34fb
+
+				Default profile Version is 1.2, RFCOMM channel
+				is 12 and Authentication is required. Does not
+				support any Features, option is ignored.
+
+			HSP HS UUID: 00001108-0000-1000-8000-00805f9b34fb
+
+				Default profile Version is 1.2, profile Features
+				is 0b0 and RFCOMM channel is 6. Authentication
+				is required. Features is one bit value, specify
+				capability of Remote Audio Volume Control
+				(by default turned off).
 
 			Available options:
 
-- 
2.20.1

