Return-Path: <SRS0=bD4U=NR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F157C32789
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Nov 2018 11:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2176D20862
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Nov 2018 11:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jklm-no.20150623.gappssmtp.com header.i=@jklm-no.20150623.gappssmtp.com header.b="evNrdL/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2176D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jklm.no
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbeKFUcH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:32:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40357 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbeKFUcG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Nov 2018 15:32:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so11023409lji.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Nov 2018 03:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jklm-no.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WlOv4mQt5pfuA3hp3qkVJClXS0zOCPbX514IeBSPkVQ=;
        b=evNrdL/yRn/ZtyV+bdUvrDR3CXTkw8mf+++TrUMlp/PLdew+WasCrRPOtkujaxi5Hw
         KWXFi7hW2H3F98yEcUKbyE6EYhzBeVBswwdnLReXaKNy8MTL8lSYUYGi1YDlXBPePcIo
         hta8SYDsC2DMhKzqV7HGrNFAvqOzXSe6+bL+Ld9sD0e3c0/1c8j6m1toF5g1XqWF/VTz
         dEtA3rLYy1hGHMobnfrCpDJIv0QOyZ1udzwQowyYJpCoet1NN4tPvppzpJME71X+LN3S
         WPK7+JJztagQyF5mTG+al3MJuBjOYfKqLeWgNF9dTf2fEmSuiaTdErE4BNdfd3SYojBW
         ShlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WlOv4mQt5pfuA3hp3qkVJClXS0zOCPbX514IeBSPkVQ=;
        b=sxc+QmwGH8NQP234b2xPmy3ioGRs8hEtHZbEF0rXM62kh+FMAyM8w7XUuGAR9S298R
         4labEC6/ishlehZvXJvSKNBL7gFuvFjOcnC5iS0JVFb5aB+9cFpFcU+MMr6RI9zIpz99
         P9fB9ojznBzQ32CYB8x7d+sFsC+eafnK5mXhZQwuxjQ1lPzmKSZB91wGlh0zbq7z5YZu
         IPtQup9J69RWWmq9N5MnCNkBWhsupYEMKrSi1H6tSwHNGGfoJTX13h2NhjnvKweUgHuF
         J2wUrHrPQbLfwvS77kPe7l5Kuyt9+zAsQxWBGkZq4CVvgI/vTolad1tBzVh2fBYQqRwl
         AKbQ==
X-Gm-Message-State: AGRZ1gIjVwCruRDK7ZYTtlg+mqL61t4WnUwPboYEKpL6sek13otus7v6
        YKAfw4vu5CxokRc5krZWkS4cRn+HPkM=
X-Google-Smtp-Source: AJdET5eanCh5wnhPYc1t9x0MZlWbMuZ7kQ7gYaP/LTcejZRX/YLCi9zh2hkSJ+BDc3eaUSTlKR3bBw==
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr17250138ljk.55.1541502444574;
        Tue, 06 Nov 2018 03:07:24 -0800 (PST)
Received: from localhost.localdomain (ti0036a400-1845.bb.online.no. [85.166.114.60])
        by smtp.gmail.com with ESMTPSA id d25-v6sm4013389ljg.68.2018.11.06.03.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 03:07:23 -0800 (PST)
From:   Tom Gundersen <teg@jklm.no>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tom Gundersen <teg@jklm.no>, David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] bluetooth.conf: remove deprecated at_console statement
Date:   Tue,  6 Nov 2018 12:07:17 +0100
Message-Id: <20181106110717.8817-1-teg@jklm.no>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As described in [0], this likely did not have the intended effect, so
simply remove it. The change in behavior is that up until this patch
it would be possible for root, lp, and any non-system user to potentially
gain access to bluez' dbus interface. Now this is extended to also allow
any system user.

[0]: <https://www.spinics.net/lists/linux-bluetooth/msg75267.html>

Signed-off-by: Tom Gundersen <teg@jklm.no>
CC: David Herrmann <dh.herrmann@gmail.com>
---
 src/bluetooth.conf | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index b67a954a2..8a1e25801 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -22,18 +22,8 @@
     <allow send_interface="org.mpris.MediaPlayer2.Player"/>
   </policy>
 
-  <policy at_console="true">
-    <allow send_destination="org.bluez"/>
-  </policy>
-
-  <!-- allow users of lp group (printing subsystem) to 
-       communicate with bluetoothd -->
-  <policy group="lp">
-    <allow send_destination="org.bluez"/>
-  </policy>
-
   <policy context="default">
-    <deny send_destination="org.bluez"/>
+    <allow send_destination="org.bluez"/>
   </policy>
 
 </busconfig>
-- 
2.19.1

