Return-Path: <SRS0=//f6=62=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722A4C54E90
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 02:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C1A206B7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 02:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=espindo.la header.i=@espindo.la header.b="akR6g7MZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgELCgu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 May 2020 22:36:50 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:19340 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgELCgu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 May 2020 22:36:50 -0400
Date:   Tue, 12 May 2020 02:36:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espindo.la;
        s=protonmail; t=1589251007;
        bh=wxzwnvn6BiRQzeMZ5loWkkBMEUrg3WtO6DMyai84heE=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=akR6g7MZCnHSNbJ2qSN/7tFNmjcLazQ8FGqvmh4HhxBRmAlKJZSdCzpb1P28LDBk3
         6zizpG/3826qNT/eMbjKi3RpR9II5pK89DEXyl6qngFiwIRdGbY6yLxT7kpvBkVU5c
         XTUnK0+dZAgS0mzYWYPiJWD8hnFjeNBfkpJ4nPtQ=
To:     linux-bluetooth@vger.kernel.org
From:   =?UTF-8?Q?Rafael_=C3=81vila_de_Esp=C3=ADndola?= <rafael@espindo.la>
Cc:     luiz.dentz@gmail.com,
        =?UTF-8?Q?Rafael_=C3=81vila_de_Esp=C3=ADndola?= <rafael@espindo.la>
Reply-To: =?UTF-8?Q?Rafael_=C3=81vila_de_Esp=C3=ADndola?= 
          <rafael@espindo.la>
Subject: [PATCH] Mention disabling SELinux in HACKING
Message-ID: <20200512023609.43163-1-rafael@espindo.la>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Running bluetoothd from the build directory I noticed that as soon as
a bluetooth audio device was connect, bluetoothd would be disconnected
from dbus and print

Disconnected from D-Bus. Exiting.

Luiz Augusto von Dentz suggested trying with SELinux disabled and that
solved the problem.

This patch just documents how to disable SELinux before running
bluetoothd from the build directory. I would love to say more about
why that is needed, but could not find anything on the audit log.
---
 HACKING | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/HACKING b/HACKING
index e10986fcb..29b136b34 100644
--- a/HACKING
+++ b/HACKING
@@ -76,6 +76,9 @@ automatically includes this option.
   Copy configuration file which specifies the required security policies
     # sudo cp ./src/bluetooth.conf /etc/dbus-1/system.d/
=20
+  Disable SELinux
+    # sudo setenforce 0
+
   Run daemon in foreground with debugging
     # sudo ./src/bluetoothd -n -d -f ./src/main.conf
=20
--=20
2.26.2


