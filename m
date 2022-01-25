Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F570C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 16:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbiAYQDo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 11:03:44 -0500
Received: from nimbus1.mmprivatehosting.com ([54.208.90.49]:56982 "EHLO
        nimbus1.mmprivatehosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352009AbiAYQCW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 11:02:22 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 11:02:22 EST
Received: from localhost (localhost [127.0.0.1])
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTP id B01F9609B6
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 15:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at mmprivatehosting.com
Received: from dave.mielke.cc (cpe1c697a7445d3-cme0dbd1be3a7a.cpe.net.cable.rogers.com [174.116.66.202])
        (Authenticated sender: relay@dave.mielke.cc)
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTPA
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 15:56:14 +0000 (UTC)
Received: from beta.private.mielke.cc (beta.private.mielke.cc [192.168.0.2])
        by dave.mielke.cc (Postfix) with ESMTPS id E9EB048D
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 10:56:13 -0500 (EST)
Received: from beta.private.mielke.cc (localhost [127.0.0.1])
        by beta.private.mielke.cc (8.17.1/8.15.2) with ESMTPS id 20PFuDQ8416881
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 10:56:13 -0500
Received: (from dave@localhost)
        by beta.private.mielke.cc (8.17.1/8.17.1/Submit) id 20PFuDR3416880
        for linux-bluetooth@vger.kernel.org; Tue, 25 Jan 2022 10:56:13 -0500
Date:   Tue, 25 Jan 2022 10:56:13 -0500
From:   Dave Mielke <Dave@mielke.cc>
To:     Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Subject: bluetoothctl set-alias - how to select the device
Message-ID: <YfAdnWn21MEHnwot@beta.private.mielke.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.1.3 (2021-09-10)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi:

It isn't clear to me how bluetoothctl set-alias decides which device to rename. From a bit of a look at the code, it seemed like it might be the most recent connect, but that proved to be an incorrect conclusion. In the same way that select can be used to pick the active controller, is there a way to explicitly pick the active device?

-- 
I believe the Bible to be the very Word of God: http://Mielke.cc/bible/
Dave Mielke            | 2213 Fox Crescent | WebHome: http://Mielke.cc/
EMail: Dave@Mielke.cc  | Ottawa, Ontario   | Twitter: @Dave_Mielke
Phone: +1 613 726 0014 | Canada  K2A 1H7   |
