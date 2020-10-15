Return-Path: <SRS0=NBlN=DW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C10C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 07:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B7C22249
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 07:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=snewbury.org.uk header.i=@snewbury.org.uk header.b="pB9UK59L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgJOHVw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Oct 2020 03:21:52 -0400
Received: from know-smtprelay-omc-9.server.virginmedia.net ([80.0.253.73]:38625
        "EHLO know-smtprelay-omc-9.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgJOHVv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Oct 2020 03:21:51 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 03:21:51 EDT
Received: from mail.snewbury.org.uk ([86.24.188.28])
        by cmsmtp with ESMTPA
        id SxUjkDrYVq8OASxUjkJBI5; Thu, 15 Oct 2020 08:16:14 +0100
X-Originating-IP: [86.24.188.28]
X-Authenticated-User: sjnewbury@virginmedia.com
X-Spam: 0
X-Authority: v=2.3 cv=WuMFz+Xv c=1 sm=1 tr=0 a=1Au+4VMCrm8g9YIHxruHCQ==:117
 a=1Au+4VMCrm8g9YIHxruHCQ==:17 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=afefHYAZSVUA:10 a=VwQbUJbxAAAA:8 a=N1CowNylAAAA:8 a=UZ73P_w1n-BTV5vS_wMA:9
 a=K8SlBP7GSjnIyugU:21 a=NnTW0SDxVMPq-83p:21 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=sPYuha5Ws6K-Rx_L469D:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=snewbury.org.uk;
         h=content-transfer-encoding:mime-version:user-agent
        :content-type:content-type:date:date:from:from:subject:subject
        :message-id; s=eater; t=1602745986; x=1604560387; bh=dTtpDHmLF/F
        xSta1ppJY67m+4/DzF2TaW56Kftc4E+s=; b=pB9UK59Lqplhpf0hUYyUzzCm0xB
        gy6Gmq/E8NF7rhPTStQn1UtMjt9cAfyGz+wYOIqxwa4e1WXwXueTur86A5t3CXFy
        e07+EQhazi+R3vjHx0pEXAB29I73EwOmLWsaPTdZnWbFbkVIB4iTYn/Ch5o2GaXC
        whd3LCe1QRV7GHWE=
X-Virus-Scanned: amavisd-new at snewbury.org.uk
Received: from artifact.local ([IPv6:2001:470:6efd:f101:0:0:0:a58])
        (authenticated bits=0)
        by mail.snewbury.org.uk (8.16.1/8.16.1) with ESMTPSA id 09F7D6XU384179
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2020 08:13:06 +0100
Message-ID: <f6d623eecc635022b85a31359b2f11b0104267c5.camel@snewbury.org.uk>
Subject: [PATCH] 100% CPU usage on keyboard disconnect
From:   Steven Newbury <steve@snewbury.org.uk>
To:     linux-bluetooth@vger.kernel.org
Date:   Thu, 15 Oct 2020 08:16:18 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJCyJ++rpvgTVYS+j392wwaeFwQNPqIP30kYEdaSOdI0znHSJXA1lhPK5NA1zyOMqpMZ0tazl/Jiut4THeZ3vXi77oDikmuN2UuDXBI6ToXTGb08tbLb
 iLNYmoSI1R3ENjiuefezlN4sdk+eJ9AQakuZtMPzUjm4iCE5CNEipFfRsoyWzlJ5vGO4dmb0jCETJA==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There are a couple of issues with g_io_channel usage in bluez which
cause CPUs to spin on half-closed channels.

This patch fixes bugs where bluetooth keyboards fail to work on initial
connection, and cause 100% cpu on disconnect.

Also fix bug with similar symptoms triggered by some other HID devices
such as Sony PS3 BD Remotes.

In the previous discussion on the kernel bugzilla below, it was
suggested to remove sec_watch, and I attached a follow-up patch to do
so, however that change causes problems with current bluez-5 releases
where a fd is used after being closed.

See https://bugzilla.kernel.org/show_bug.cgi?id=204275

Signed-off-by: Steven Newbury <steve@snewbury.org.uk>
---
 attrib/interactive.c    | 4 +++-
 profiles/input/device.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 9a7976d34..453ff064e 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -64,6 +64,7 @@ static int opt_psm = 0;
 static int opt_mtu = 0;
 static int start;
 static int end;
+static guint gsrc;
 
 static void cmd_help(int argcp, char **argvp);
 
@@ -193,6 +194,7 @@ static void disconnect_io()
 	attrib = NULL;
 	opt_mtu = 0;
 
+	g_source_remove(gsrc);
 	g_io_channel_shutdown(iochannel, FALSE, NULL);
 	g_io_channel_unref(iochannel);
 	iochannel = NULL;
@@ -415,7 +417,7 @@ static void cmd_connect(int argcp, char **argvp)
 		error("%s\n", gerr->message);
 		g_error_free(gerr);
 	} else
-		g_io_add_watch(iochannel, G_IO_HUP, channel_watcher, NULL);
+		gsrc = g_io_add_watch(iochannel, G_IO_HUP, channel_watcher, NULL);
 }
 
 static void cmd_disconnect(int argcp, char **argvp)
diff --git a/profiles/input/device.c b/profiles/input/device.c
index a711ef527..9abf595f6 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -982,7 +982,8 @@ static int hidp_add_connection(struct input_device *idev)
 		}
 
 		idev->req = req;
-		idev->sec_watch = g_io_add_watch(idev->intr_io, G_IO_OUT,
+		if (!idev->sec_watch)
+			idev->sec_watch = g_io_add_watch(idev->intr_io, G_IO_IN,
 							encrypt_notify, idev);
 
 		return 0;
-- 
2.22.0


