Return-Path: <SRS0=54w9=ZB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FBDC17442
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Nov 2019 00:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC06620869
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Nov 2019 00:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKIAvI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Nov 2019 19:51:08 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:33259 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfKIAvI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Nov 2019 19:51:08 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 478z8p16qpz1qqkV
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Nov 2019 01:51:06 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 478z8p11KVz1qqkJ
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Nov 2019 01:51:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id KUnyWKfVHFC6 for <linux-bluetooth@vger.kernel.org>;
        Sat,  9 Nov 2019 01:51:05 +0100 (CET)
X-Auth-Info: sVt2n47QNja/CUE+8dk5oxWjipNjzziHdVYGDGZ8pSOLyUZbnPMFVwUWEQjGeWy2
Received: from EmacsBook (ppp-93-104-82-64.dynamic.mnet-online.de [93.104.82.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Nov 2019 01:51:05 +0100 (CET)
User-agent: mu4e 1.2.0; emacs 26.3
From:   Raffael Stocker <r.stocker@mnet-mail.de>
To:     linux-bluetooth@vger.kernel.org
Subject: BlueZ/D-Bus: Interpretation of service classes and UUIDs
Date:   Sat, 09 Nov 2019 01:50:59 +0100
Message-ID: <87a795vpn0.fsf@mnet-mail.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I have recently written a bluetooth package for Emacs using the BlueZ
D-Bus interface.  For the interpretation of device and service classes,
and other UUIDs, I hand-scraped the bluetooth.com website, although much
of the information seems to be available somewhere in BlueZ, at least
on a source code/C library interface level, if not on D-Bus.

Have I overlooked any way to query BlueZ for a human-readable
interpretation of UUIDs etc. over D-Bus?

If not, could such an interface be implemented in BlueZ?  I think it
would be very useful if applications building on BlueZ could all offer
the same textual representation of UUIDs without each replicating the
same data over and over again.

Regards,
        Raffael
