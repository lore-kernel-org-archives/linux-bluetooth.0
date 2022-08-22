Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8A1C28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 11:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiHVLmW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 07:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiHVLmV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 07:42:21 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCEB33A3A
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 04:42:18 -0700 (PDT)
X-QQ-mid: bizesmtp90t1661168533tgunjzkb
Received: from localhost ( [119.253.45.138])
        by bizesmtp.qq.com (ESMTP) with SMTP id 0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 19:42:13 +0800 (CST)
X-QQ-SSF: 01400000007000K0Z000B00A0000000
X-QQ-FEAT: 2ebHyxEhYm042sYQ55J/3wC4+/DbmODJyYVHhxOUqjY6qI6Nc8Q3b2OZZ0Zq4
        CGOtOKOKtyy8qhoZclUOXx2YRTjC7kV6EZ1YOKGgLK9Hk+SjzCFM76gKPv4Db2zNwtRysav
        kpjBSvUYjDf9kBJVEX0AOYnqlTOxT26JPjlBBLHWFRimHNPjmrr5d4LgPk2C0Syw1qKe88I
        gfml7k7ZjHy1zNzhEbeygokWXFERv1fkMYnUHvdUjjeVo5YFsnBtx+nJawRB8Ys12AmYkuR
        hdln6hiXWzx0Qku8Pv/BW/vCyqOlUoEJkE6GQgUu8jro77NMQvxPm5uU/T5UoeOlmI3kDGM
        F32BoHUyWL0CpTFI9P1PFITfGR5Ix/9FVpVpQ7V1DB/csh34iA=
X-QQ-GoodBg: 2
Date:   Mon, 22 Aug 2022 19:42:12 +0800
From:   Jiaquan He <jiaquan.he@9amtech.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] test/test-mesh: Fix python warning
Message-ID: <CEE786764994BC33+20220822114212.GA5807@ixamedge-b4f804>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:9amtech.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes inconsistent use of tabs and spaces in indentation and
removes unused import.
---
 test/test-mesh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index fbf2476bf..f49ddeec6 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -97,7 +97,6 @@ import struct
 import fcntl
 import os
 import numpy
-import random
 import dbus
 import dbus.service
 import dbus.exceptions
@@ -113,7 +112,7 @@ except ImportError:
 from dbus.mainloop.glib import DBusGMainLoop
 
 try:
-  from termcolor import colored, cprint
+  from termcolor import colored
   set_error = lambda x: colored('!' + x, 'red', attrs=['bold'])
   set_cyan = lambda x: colored(x, 'cyan', attrs=['bold'])
   set_green = lambda x: colored(x, 'green', attrs=['bold'])
@@ -771,7 +770,7 @@ class Menu():
 			return
 		if len(cmds) > 1:
 			for cmd in cmds:
-			     print(set_cyan(cmd + '?'))
+				print(set_cyan(cmd + '?'))
 			return
 
 		self.menu.get(cmds[0]).func()
-- 
2.17.1

