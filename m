Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9487C2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 21:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835B82072A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 21:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIzpkEfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgDFVTG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:19:06 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:37982 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFVTF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 17:19:05 -0400
Received: by mail-pl1-f175.google.com with SMTP id w3so363681plz.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NAn0/PmkUxOYiQc03ztb1Nd2wCHPZRZ8x/VsrVOxPI=;
        b=uIzpkEfNuXr3zsnwuQX2rkge3cPgq9L6wcZw9rr264g2HrJ3ooL43n30mf6IHKMOjT
         dkHR7Y6NZhGAQ/7nsb+YSTle8Rm2xY1ZiQhv87DEGbl/8NsX6QeMxmc330OjEzrCadWd
         QwQSKVzsVV993YJvThtnkMDPQDcbo+yopLjvtv9UfJmSaCaGUsoeCeQG1tWGHku90r83
         5KIErLANPiBBbGd39zmi3RYm9Gg0NSOWqsIDWJbjWzOPKqBeWJiOV8aU3tKmGiNFYn6W
         0hfwOhPojYOR7XsZdp1rCuWkX+DfZGX6v0KH/72Muj1/n0XRWr0iwmox/T/YRBWspN0n
         6+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NAn0/PmkUxOYiQc03ztb1Nd2wCHPZRZ8x/VsrVOxPI=;
        b=FVSQYuFEvO/lhkaIbJX+abz96o48XJDUJhmrr+BzGHbUNdyH7mNF1wPXgrcU/fC3uy
         f9r36qUYDXe64fls43hhe/Pn9Fcdhv+xXgn+RUs53//palDJNGyIIBoBEgTvR7jw7BVa
         FlmGpoCnE85i4AZYgKoR+wwSSSbxx9g+p6FJw5JU3ohji/LdkVRbp0eyfrW030auCWEr
         7nse3mRjdJZ0hjGsR95W6EUkdpd9AbJkxKT/LmLJqdjo94S36KzZcotaOMqLa/pHD5AU
         3KQ81W81sBv+uDtLJoOk01b+Z2oz3oQsnbNLZKoYmalY9wwsb6sRvkhtJ9DcPld/Gwe4
         eWaA==
X-Gm-Message-State: AGi0PubEnvQL2l92Atsj+6YZdfpWjzouSj1GuZWfqt3oncy37LzZ/cYZ
        K8zxs9zR+jFe8bEXjevG9mW3NsOaMtM=
X-Google-Smtp-Source: APiQypIhxExFm5NK8b+5KkCEnH8xGvZLBiNJXBmH0ruGU0D13OMtEq7p05rKKXbrnyYugfdDL/ewJQ==
X-Received: by 2002:a17:90a:25c8:: with SMTP id k66mr1362822pje.90.1586207944706;
        Mon, 06 Apr 2020 14:19:04 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x75sm12434585pfc.161.2020.04.06.14.19.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:19:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Fix not sending any data when server supports AcquireWrite
Date:   Mon,  6 Apr 2020 14:19:03 -0700
Message-Id: <20200406211903.12549-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

msg.msg_iovlen should be set to 1 to forward the data received over the
file descriptor.
---
 src/gatt-database.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 483c84341..db67dd3f8 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2396,6 +2396,7 @@ static int sock_io_send(struct io *io, const void *data, size_t len)
 
 	memset(&msg, 0, sizeof(msg));
 	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
 
 	return sendmsg(io_get_fd(io), &msg, MSG_NOSIGNAL);
 }
-- 
2.21.1

