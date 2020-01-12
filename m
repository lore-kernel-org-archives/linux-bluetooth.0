Return-Path: <SRS0=Kc/b=3B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4FDC33CA7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Jan 2020 00:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6D920866
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Jan 2020 00:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hexchain.org header.i=@hexchain.org header.b="fPNbIQrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbgALArl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Jan 2020 19:47:41 -0500
Received: from m228-7.mailgun.net ([159.135.228.7]:45234 "EHLO
        m228-7.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731805AbgALArl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Jan 2020 19:47:41 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jan 2020 19:47:40 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=hexchain.org; q=dns/txt;
 s=smtp; t=1578790060; h=Content-Type: MIME-Version: Reply-To:
 Message-ID: Subject: To: From: Date: Sender;
 bh=rYCZu6Eok81Ajb6yeUmuuIcg1MqLJjSYtM85jON/MGU=; b=fPNbIQrJlqNOO2J2hmybBUHEZ7i8IHD0Hl8dDtzTskDqP6b3kwz+i9JFGjUUB1k8C8x5duaZ
 Y7Pef8s+AdjPcMfFDHiEOwQMhqls19E/B9QZxJLFNfrN1E7UGBwRUJswIyho3LFZr093cANS
 1tA8+n5gPZGfeQqxccl2nXmnrRG6tVHwc+fHbZWyJBbziakYs+K/Dri5hsw7cUi2AOAcDVq0
 kGY74BO/IuH5AInbDQw1bJI42KTRSAEHAbjnZm+yNapesyf/SbCtjyvt2RJ1Zxz9M3bOD5T0
 MfOzaZ+2rUWD6VBmzRfJ306RqUMNzmxswydb3aQXk27FfW96GAaRdQ==
X-Mailgun-Sending-Ip: 159.135.228.7
X-Mailgun-Sid: WyJiNzllYSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgIjE5MjUxOCJd
Received: from localhost (ip-80-113-22-187.ip.prioritytelecom.net [80.113.22.187])
 by mxa.mailgun.org with ESMTP id 5e1a6b75.7f2add0eade0-smtp-out-n03;
 Sun, 12 Jan 2020 00:42:29 -0000 (UTC)
Date:   Sun, 12 Jan 2020 01:42:26 +0100
From:   Haochen Tong <i@hexchain.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] avctp: Fix EINVAL on uinput creation
Message-ID: <20200112004226.GA432297@kotori.hexchain.org>
Reply-To: i@hexchain.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The struct uinput_dev variable is on stack, so clear its content to
avoid accidentally writing garbage values to kernel. This fixes "Can't
create uinput device: Invalid argument (22)" in some cases.

Signed-off-by: Haochen Tong <i@hexchain.org>
---
 profiles/audio/avctp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index d3b5dfab9..f7a3de211 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1182,6 +1182,8 @@ static int uinput_create(struct btd_device *device, const char *name,
 		}
 	}
 
+	memset(&dev, 0, sizeof(struct uinput_dev));
+
 	if (name) {
 		strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE);
 		dev.name[UINPUT_MAX_NAME_SIZE - 1] = '\0';

base-commit: b4270d79e19ee70ccab6c087a7b470dad8a8a8bf
-- 
2.24.1
