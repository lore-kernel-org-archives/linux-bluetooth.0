Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82389C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 04:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF9F6105A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 04:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhJYEaI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 00:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhJYEaH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 00:30:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1062DC061745
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Oct 2021 21:27:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso10387410pjm.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Oct 2021 21:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W55TeDyNqdPZ1WGRGEzTag6Zly+QJrbYLWRGgBNRgxk=;
        b=LIBYt+Pn/uWdmi0g7RBJSYUetXh1euJKDqZGRtAb6FKz/d0Oo4PPyHx9NNGki8FSdy
         sYI0IMTAWWvnFUfuV52J7gu13dwAlcv8t7f1VQHL8HTcvajSzj8to2CbOkY3UHmgL5rh
         9T7m7JTIPD8t1BT3RzJnP9l7fAO6o1Yoxpq7UrUwD6h8XS4P177X+5lzUqCWOM2ChsZD
         S0nebK66EiPZiwx2bhJB8MWs0NqXjothGniX0aBig7jSoH6lf/EqTzn+rHrfY9VzpDPs
         /FUbuknKO1fD2JnACM3qx8DFEJ0UwruoX+E6mAVLzfLtXa5Uupz45TeTseXrjh3butMJ
         dX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W55TeDyNqdPZ1WGRGEzTag6Zly+QJrbYLWRGgBNRgxk=;
        b=5RFBjxOUYXH3XVPw+xr5ao5Nip/MO9JKdGhcZWiAF28AdpCwT13tYy26WattdUWocm
         ib1e4lLp01FNKYG20DXqM9ioj8zGCdqsO2JJKZeF6DGmTdG6Vrf9nQQVwXGq45dScn00
         HiBbEO9pmb1bIDu4SvdrEewyDLmdSIZb4ekTbIeN/Yqbz6lDGO9eVADcl+P2+1vz3CNm
         tuIyz5dcnh2BL/IbUAjVbjMXx2kh/FztqoohhKcVfacTRSqEEVUyiH8fMcBJJMV1vImX
         0JiWiSL1J1Nnvn93qQtKM/iqp0Nf3v+QvKV7WEa4pWtMKiFWSHA/1FaOiiJVbh1oRjVa
         /YMA==
X-Gm-Message-State: AOAM533MoOWcZ9jZ5GLw6gJv2J/8oRiRIBroLunK/fCn2SVsYwAqdAmV
        DZBIhl1IccBbSr46Srea8XOvQcyngvvpRA==
X-Google-Smtp-Source: ABdhPJxqgXtbF1wHe+y7FAeRGgfswrL79TumAPp2OVdE5dx8UsCYp9+B4QOmRn8u9+VaaabjqJD3aA==
X-Received: by 2002:a17:90b:33cb:: with SMTP id lk11mr32535249pjb.0.1635136065297;
        Sun, 24 Oct 2021 21:27:45 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:d228:1bef:af2a:db8e])
        by smtp.gmail.com with ESMTPSA id p9sm16749120pfn.7.2021.10.24.21.27.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 21:27:44 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] tools/mgmt-tester: Update the expected manufacturer of emulator
Date:   Sun, 24 Oct 2021 21:27:43 -0700
Message-Id: <20211025042743.477763-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the expected manufacturer of the emulator for the
following test cases:

> Read Ext Controller Info 1                           Failed
> Read Ext Controller Info 2                           Failed
> Read Ext Controller Info 3                           Failed
> Read Ext Controller Info 4                           Failed
> Read Ext Controller Info 5                           Failed
---
 tools/mgmt-tester.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index f490dc261..00663d15f 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5668,7 +5668,7 @@ static const struct generic_data conn_central_adv_non_connectable_test = {
 static const char ext_ctrl_info1[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
-	0x3f, 0x00, /* manufacturer */
+	0xf1, 0x05, /* manufacturer */
 	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x00, 0x00, 0x00, /* current settings */
 	0x09, 0x00, /* eir length */
@@ -5713,7 +5713,7 @@ static const struct setup_mgmt_cmd set_dev_class_cmd_arr1[] = {
 static const char ext_ctrl_info2[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
-	0x3f, 0x00, /* manufacturer */
+	0xf1, 0x05, /* manufacturer */
 	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x81, 0x02, 0x00, 0x00, /* current settings */
 	0x0D, 0x00, /* eir length */
@@ -5744,7 +5744,7 @@ static const struct generic_data read_ext_ctrl_info2 = {
 static const char ext_ctrl_info3[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
-	0x3f, 0x00, /* manufacturer */
+	0xf1, 0x05, /* manufacturer */
 	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x02, 0x00, 0x00, /* current settings */
 	0x16, 0x00, /* eir length */
@@ -5779,7 +5779,7 @@ static const struct generic_data read_ext_ctrl_info3 = {
 static const char ext_ctrl_info4[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
-	0x3f, 0x00, /* manufacturer */
+	0xf1, 0x05, /* manufacturer */
 	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x02, 0x00, 0x00, /* current settings */
 	0x1a, 0x00, /* eir length */
@@ -5838,7 +5838,7 @@ static const struct setup_mgmt_cmd set_dev_class_cmd_arr2[] = {
 static const char ext_ctrl_info5[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
-	0x3f, 0x00, /* manufacturer */
+	0xf1, 0x05, /* manufacturer */
 	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x81, 0x02, 0x00, 0x00, /* current settings */
 	0x1a, 0x00, /* eir len */
-- 
2.25.1

