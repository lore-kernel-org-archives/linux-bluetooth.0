Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA05EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 Oct 2021 10:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B89EF61B31
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 Oct 2021 10:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhJCKVD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 Oct 2021 06:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhJCKVA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 Oct 2021 06:21:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2826FC061780
        for <linux-bluetooth@vger.kernel.org>; Sun,  3 Oct 2021 03:19:11 -0700 (PDT)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1633256347; bh=mp7dZypWt3wKCO7N16QhLoA3VAxzpjiyGc49Cau5Kdw=;
        h=From:To:Cc:Subject:Date:From;
        b=Yf8RQxiwqi3cGkd0VX7xObRjI9Snx0K9B1Jrt+zrpkVJRwe4vu+JTV3WjgQvYH1gp
         XCbJSUylN13Ll2gcAflgb3KM7iq81Toi6Td/3KMnthPEUuQOvzM/5LSIDj0FDLmpVl
         wSOtxpR1MDcC9Ux+M+5kIZd8eP/kMFxi3QrmkTOE=
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH BlueZ] Use accurate icons for headphones and headsets
Date:   Sun,  3 Oct 2021 12:18:34 +0200
Message-Id: <20211003101834.45448-1-thomas@t-8ch.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

While these icon names are not part of the spec standard names [0] they
are in practice implemented by at least Adwaita, Gnome, Oxygen, Arc and Breeze
themes.

[0] https://specifications.freedesktop.org/icon-naming-spec/latest/ar01s04.html
---
 src/dbus-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/dbus-common.c b/src/dbus-common.c
index 384f27700..5e2c83d52 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -72,9 +72,9 @@ const char *class_to_icon(uint32_t class)
 		switch ((class & 0xfc) >> 2) {
 		case 0x01:
 		case 0x02:
-			return "audio-card";	/* Headset */
+			return "audio-headset";
 		case 0x06:
-			return "audio-card";	/* Headphone */
+			return "audio-headphones";
 		case 0x0b: /* VCR */
 		case 0x0c: /* Video Camera */
 		case 0x0d: /* Camcorder */

base-commit: c1e6d6c46fcab55ec820bb83396fff57ffd22e26
-- 
2.33.0

