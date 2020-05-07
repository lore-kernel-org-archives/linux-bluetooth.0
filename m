Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E479FC38A24
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 19:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86B12184D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 19:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="fSgIo6Zo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="el5qOluu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgEGT1c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 15:27:32 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:42896 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGT1c (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 15:27:32 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2020 15:27:31 EDT
Received: by mail.z3ntu.xyz (Postfix, from userid 182)
        id 9268CC4227; Thu,  7 May 2020 19:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1588879147; bh=Z/q7gayyVSKR/HAz9vDlc8la3PeqqTFWL3j8FQQphSE=;
        h=From:To:Subject:Date;
        b=fSgIo6ZoLqX2YgDIK34//vrqTAwq4v8uhglKVViX6igIQ8gAnWG8OXIXCHUMt/njO
         U4/U0s3TTuhTNggWI0xPXoe4zhsRKAxgDOSpCHBilh7zfRJd1bb8UkxiAERQC0ok6H
         Se7cGuf8mvnPG1JiLW1XcHzF9BueSOZMEnb5g5W8=
Received: from g550jk.localnet (80-110-124-168.cgn.dynamic.surfer.at [80.110.124.168])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 0E9FBC2604
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2020 19:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1588879146; bh=Z/q7gayyVSKR/HAz9vDlc8la3PeqqTFWL3j8FQQphSE=;
        h=From:To:Subject:Date;
        b=el5qOluuQ4Yp7LoZxc3K2jeD5Myv8PcXdhPxth3ugJBCSsYyGYpczCkBmcBR/4zxW
         XI1X5wDGSCPKeJ1qy9OJIg8zTP1wev7MUSwdVMxqKzn9lUZo1TZZojTQiPcXfK9+a7
         SZ29Jv4vwROpkjEiFl5USmW6O5XtW8L8PcxXQKiU=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-bluetooth@vger.kernel.org
Subject: ManufacturerData while discovering
Date:   Thu, 07 May 2020 21:19:05 +0200
Message-ID: <3057615.CFlnn7pYAm@g550jk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,
I've been trying to get frequent manufacturer data from advertisements from a 
BLE device into an application of mine. Unfortunately it looks like I only get 
new ManufacturerData about every 15 seconds while discovering/scanning. The 
manufacturer data from the device changes frequently (at least once per 
second) so I need updates to this data more frequently than the 15 seconds.

I couldn't find any reference on how I could achieve this in the documentation 
so any help would be welcome.

Regards
Luca


