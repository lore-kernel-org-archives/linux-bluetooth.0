Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC18C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Jan 2022 02:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiAWCI2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Jan 2022 21:08:28 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:59644 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231614AbiAWCI1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Jan 2022 21:08:27 -0500
X-Greylist: delayed 1007 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Jan 2022 21:08:27 EST
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4JhGLh68sFzDR2
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Jan 2022 20:51:40 -0500 (EST)
Received: from [192.168.42.8] (unknown [172.58.46.212])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4JhGLf2MLPz3sNN;
        Sat, 22 Jan 2022 20:51:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1642902699; bh=RCyGVKh/xLvke+G9ioCkT8EQsOGFmtt3NuWtBmfU62Q=;
        h=Date:From:Reply-To:To:cc:Subject;
        b=fsgC4rKy8AMAITYyJeltxjTRFSAnPUGq5hmEDaZL5fhP/y/y/FXto3DaAIGllGyjX
         0CLVuCy/1DYDEFzQ8BhywnwDhN3WAU0dM2ipjkFEtYvJduf7u8SGnr1TZ8RxyCOyBB
         NDz90wbXQlh34OzrOS90UgEO2wT9cRkM92dp8RKE=
Date:   Sat, 22 Jan 2022 17:51:36 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     luiz.von.dentz@intel.com
cc:     "Kenneth R. Crudup" <kenny@panix.com>,
        linux-bluetooth@vger.kernel.org
Subject: Commit ad383c2c6 ("Bluetooth: hci_sync: Enable advertising when LL
 privacy is enabled") breaks my MS ArcTouch mouse
Message-ID: <4124ccb8-11f-21e9-982e-7fb07f23225@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


I'm running Linus' master (as of today, 1c52283265a462a100). With this commit in
place I get no bluetooth ("hcitool dev" shows no adapters) and/or I can't see my
MS ArcTouch mouse.

I have an Intel 7260 BT adapter (and have the latest linux-firmware version of
intel/ibt-19-32-4.sfi).

I'm sure you'll need more information, so let me know. I'm in the process of
reverting this from my branch, but it's not coming out cleanly so if there's
some code to try (nothing obvious in the linux-bt git), please let me know.

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
