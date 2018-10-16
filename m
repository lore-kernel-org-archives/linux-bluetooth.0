Return-Path: <SRS0=78jX=M4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54683C5ACCC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7F120869
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyFu94Hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7F120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeJQEIt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:08:49 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:35980 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQEIt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 00:08:49 -0400
Received: by mail-lj1-f180.google.com with SMTP id p89-v6so22179021ljb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9O+krNfhWZ3vjz6GXnXnl9KtYqkk9TWlzVOq5UtNYVQ=;
        b=GyFu94HzU52f5A0WIhgx///ge87V3D06ggexWeDynV/yO1WsXYb2WKfvrHdgPLK3lH
         nyvWB4ifLTvBLIqBi/fhaR1sHKNqkSfi2X02A6dmE6ZXOApBqX1gwNWgZM5fD8R4oyn/
         Z+O5hNJF8OuPYr1H9akGYblvgXQLl3kKfjfsJjEe88g3C19OibuglQrBPjQAmUgBLizI
         EsiuVZYP4FIP2/o75i3/BAA4GP3VhQ0htzjiArMR0FhaLjrXwefQllNmQdgHOasuC3Kd
         rlwl8p7mIHRqczk50uUUWMF7c4DFAysD6n+7swdRgTF9K2ys3ynpX52UJasEdyIE2sCe
         47pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9O+krNfhWZ3vjz6GXnXnl9KtYqkk9TWlzVOq5UtNYVQ=;
        b=HcKC65Qks8mdUeZFtDifSOr7kQe+Y6ogwbPVcoTH+wmg9PT7hAJ1zRsmZXno026YNv
         s9GHEaf++FvQCmG5y2p0EOQkKAJPINuVkNZEpfcOkPLx+YocHzDqUSYBlPeN2ceewf9t
         vEu1B9uDnf5lhffoq12l2r3UIbvNqtb+LvtS1ASorfJ2NOAbikotxMUD0Dv6JDxgoEce
         26u/OJ1rA2hsIap8RJTzT98RCchBpGO8zSESeeLf/9ot8d9vhwBtVCAPECq+Q83n0suK
         iQlZpZqCRZADllYOhh8p4wMi7tuZhdGR2cJaQ0kT6tmBHu3ve1tJe1+O02w+ToDAG3V1
         JJ0w==
X-Gm-Message-State: ABuFfohrs+yAXuZTkkdiKHj6kqxlwCnT7ZTAf2LSWjYwuaFOW0cBtXh4
        OXUyXApgAL/Ba6x5ndEpnM+SaDgf3WI=
X-Google-Smtp-Source: ACcGV63aN4Dg3m1SP+/xLNU3puxnofbarnBtDdP4FUQKz3b/iWvDHwBdLAYv084F/L4jINtBBUc75A==
X-Received: by 2002:a2e:6598:: with SMTP id e24-v6mr13106977ljf.99.1539721002215;
        Tue, 16 Oct 2018 13:16:42 -0700 (PDT)
Received: from Matias-MacBook-Air.local (85-23-86-144.bb.dnainternet.fi. [85.23.86.144])
        by smtp.gmail.com with ESMTPSA id d126-v6sm3296643lfe.75.2018.10.16.13.16.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 13:16:41 -0700 (PDT)
Date:   Tue, 16 Oct 2018 23:20:08 +0300
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/12] btmon: fix segfault caused by buffer over-read
Message-ID: <20181016202008.GA84991@Matias-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix segmentation fault caused by buffer over-read in packet_ctrl_open().

Fix is to check that ident_len is not bigger than size.

This bug was found by fuzzing btmon with AFL.

Program received signal SIGSEGV, Segmentation fault.
0x0000000000419e88 in packet_hexdump (buf=0x7fffffffda7e "22", len=<optimized out>) at monitor/packet.c:3813
3813			str[((i % 16) * 3) + 1] = hexdigits[buf[i] & 0xf];
(gdb) bt
 #0  0x0000000000419e88 in packet_hexdump (buf=0x7fffffffda7e "22", len=<optimized out>) at monitor/packet.c:3813
 #1  0x000000000041eda4 in packet_ctrl_open (tv=<optimized out>, cred=<optimized out>, index=<optimized out>, data=0x7fffffffda7e, size=<optimized out>) at monitor/packet.c:10286
 #2  0x000000000041b193 in packet_monitor (tv=0x7fffffffda50, cred=<optimized out>, index=65535, opcode=<optimized out>, data=0x7fffffffda60, size=14) at monitor/packet.c:3957
 #3  0x000000000040e177 in control_reader (path=<optimized out>, pager=true) at monitor/control.c:1462
 #4  0x0000000000403b00 in main (argc=<optimized out>, argv=<optimized out>) at monitor/main.c:243
(gdb)
---
 monitor/packet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 64faceca1..3e2a08a1c 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10241,6 +10241,12 @@ void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t index,
 		flags = get_le32(data + 3);
 		ident_len = get_u8(data + 7);
 
+		if (ident_len > size) {
+			print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
+                                "Malformed Control Open packet", NULL, NULL);
+			return;
+		}
+
 		data += 8;
 		size -= 8;
 
-- 
2.17.1

