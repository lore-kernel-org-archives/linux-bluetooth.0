Return-Path: <SRS0=w4jJ=6R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F869C28CBC
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 May 2020 11:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C28D2071C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 May 2020 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588504263;
	bh=MWzknOHXjm+2+xMnNuHwFdOoGHPEI6ZlsvXldm3iUNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h//W16nhSffQKxyRdW51eOmanFo4i/rhpY9hEou6eb90ywIwcEwPYFQjh2W4XLN/C
	 D2SWvYESILi2A6XRmEC4Wq37QyJzdxnGvenlbrUFpzy1v8spgWs3KT47rVL7EOAMHA
	 avJXP354oZU/WO1oz6O3dU4tkeLpHy1PPqmzKauE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgECLLC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 May 2020 07:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgECLLC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 May 2020 07:11:02 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 217E62071C;
        Sun,  3 May 2020 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588504262;
        bh=MWzknOHXjm+2+xMnNuHwFdOoGHPEI6ZlsvXldm3iUNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmBAVjV7YCxLt91yu52fS4hn1tlL8wiM9V5wcYIPBUnFdYFnNt3WVxbn9LgC2Wpzb
         Nv9qHtbg4tL9W4NpsiJFLmttiWE7jMrQSgJ1dhz4sp4MZYRO7MXqQ0vGz3nU0K9BX5
         e6ZywbXcFsBzH3oa1EaUBlLYsBa2lO0OfCxR8xPg=
Received: by pali.im (Postfix)
        id 33962A1E; Sun,  3 May 2020 13:11:00 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2] device: Return error when ConnectProfile DBus method fails (second fix)
Date:   Sun,  3 May 2020 13:10:55 +0200
Message-Id: <20200503111055.11321-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426210247.757-1-pali@kernel.org>
References: <20200426210247.757-1-pali@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is fixup of commit 3aa815a31017 ("device: Return error when
ConnectProfile DBus method fails"). There is another place which needs
to distinguish between Connect and ConnectProfile DBus method.
---
 src/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 229579378..7b0eb256e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1861,7 +1861,9 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 	dev->pending = create_pending_list(dev, uuid);
 	if (!dev->pending) {
 		if (dev->svc_refreshed) {
-			if (find_service_with_state(dev->services,
+			if (dbus_message_is_method_call(msg, DEVICE_INTERFACE,
+							"Connect") &&
+				find_service_with_state(dev->services,
 						BTD_SERVICE_STATE_CONNECTED))
 				return dbus_message_new_method_return(msg);
 			else
-- 
2.20.1

