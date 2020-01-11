Return-Path: <SRS0=d6qz=3A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AD2C282DD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 14:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E5020842
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 14:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgAKOJ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Jan 2020 09:09:59 -0500
Received: from jax4mhob12.myregisteredsite.com ([64.69.218.92]:50402 "EHLO
        jax4mhob12.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729630AbgAKOJ7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Jan 2020 09:09:59 -0500
Received: from mailpod.hostingplatform.com (atl4qobmail02pod5.registeredsite.com [10.30.71.85])
        by jax4mhob12.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 00BE9vEN031333
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jan 2020 09:09:57 -0500
Received: (qmail 141434 invoked by uid 0); 11 Jan 2020 14:09:56 -0000
X-TCPREMOTEIP: 208.85.15.155
X-Authenticated-UID: sbrown@opensat.com
Received: from unknown (HELO 155-15-85-208.altiusbb.net) (sbrown@opensat.com@208.85.15.155)
  by 0 with ESMTPA; 11 Jan 2020 14:09:56 -0000
Received: from localhost (localhost [127.0.0.1])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id E2C0F1540254
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jan 2020 09:09:55 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at ewol.com
Received: from 155-15-85-208.altiusbb.net ([127.0.0.1])
        by localhost (fl-server.ewol.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iyEVrzAg4N0g for <linux-bluetooth@vger.kernel.org>;
        Sat, 11 Jan 2020 09:09:54 -0500 (EST)
Received: from w7.lan (w7.lan [192.168.1.9])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id 0AE9715400CE
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jan 2020 09:09:54 -0500 (EST)
Message-ID: <988d501619da548fff95f1f1afaa6456e18e6dfe.camel@ewol.com>
Subject: mesh: scan params specify random address, but no random address set
From:   Steve Brown <sbrown@ewol.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Sat, 11 Jan 2020 09:09:53 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I'm using the Zephyr hci implementation on a bt dongle. It complains
that no random address is set when scan enable is sent.

My RPi doesn't care if a random address is set or not.

Steve

btmon says:

      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7   #289 [hci0] 409.412208
        Type: Passive (0x00)
        Interval: 10.000 msec (0x0010)
        Window: 10.000 msec (0x0010)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                  #290 [hci0] 409.413191
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2       #291 [hci0] 409.413205
        Scanning: Enabled (0x01)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                  #292 [hci0] 409.429192
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)

