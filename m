Return-Path: <SRS0=sa5O=ZF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4FBC43331
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 00:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9653D206BA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 00:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKMAeY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:34:24 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:59935 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKMAeX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 19:34:23 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id AFE99CECF4
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2019 01:43:27 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Proposal for key blacklisting via mgmt
Message-Id: <D3DDA56B-7CEA-46EE-96AB-D78280B49921@holtmann.org>
Date:   Wed, 13 Nov 2019 01:34:22 +0100
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

since there has been various devices that have hardcoded keys and each shipped unit will have the same key, it might be required to have keys blacklist and refrain from pairing / connecting to these.

I would propose to load a blacklist of these keys via mgmt via bluetoothd instead of hardcoding them in the kernel code.

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 0d11aa035649..71b01b38f9f1 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3014,6 +3014,38 @@ Set PHY Configuration Command
                                Invalid Index
 
 
+Load Blacklist Keys Command
+===========================
+
+       Command Code:           0x0045
+       Controller Index:       <controller id>
+       Command Parameters:     Key_Count (2 Octets)
+                               Key1 {
+                                       Key_Type (1 Octet)
+                                       Value (16 Octets)
+                               }
+                               Key2 { }
+                               ...
+       Return Parameters:
+
+       This command is used to feed the kernel a list of keys that
+       are known to be vulnerable.
+
+       Currently defined Key_Type values are:
+
+               0x00    Link Key (BR/EDR)
+               0x01    Long Term Key (LE)
+               0x02    Identity Resolving Key (LE)
+
+       This command can be used when the controller is not powered.
+
+       This command generates a Command Complete event on success or
+       a Command Status event on failure.
+
+       Possible errors:        Invalid Parameters
+                               Invalid Index
+
+

Regards

Marcel

