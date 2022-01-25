Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2648DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 02:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353415AbiAYCd7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:33:59 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:64308 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3415509AbiAYBrJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jan 2022 20:47:09 -0500
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4JjTmp2tP4zDdP
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 20:30:02 -0500 (EST)
Received: from [192.168.55.39] (cpe-75-82-21-54.socal.res.rr.com [75.82.21.54])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4JjTmR4mnpzS6w;
        Mon, 24 Jan 2022 20:29:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1643074184; bh=VWcPIC4h1tnCLHP5ubSu/s5I6yi7BdVYX2VwOouCDcY=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=e5kvjtFSU6wPJm8rUM0WE9h8Fic/WncPQ0PLljbwttvwYu6ATPyoLC5FSsm19OMr/
         DODgyVTxM+4GO+CtpXOP1XfVLsQJ7JWS6NAsl130igir+fIR0vrGPPhwP0Q1fA4Fnf
         pikIExDZ8yyaXTrAov9MR/RdBXK85kP5jgAOOG38=
Date:   Mon, 24 Jan 2022 17:29:42 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: Commit ad383c2c6 ("Bluetooth: hci_sync: Enable advertising when
 LL privacy is enabled") breaks my MS ArcTouch mouse
In-Reply-To: <CABBYNZ+t+L=G-X0qt=Cnn7vUpLu2s1=purmAESnCaRvK7XtmdQ@mail.gmail.com>
Message-ID: <6bc3d85b-9b4c-3c18-51dd-7e45c66af2a4@panix.com>
References: <4124ccb8-11f-21e9-982e-7fb07f23225@panix.com> <CABBYNZLt3GmBTmAADa+FF2bdEfzMg_9Horxk2pT85BC+LFgrMQ@mail.gmail.com> <91c1e9ef-4786-b9f5-8bb8-b93c84c0874b@panix.com> <CABBYNZ+t+L=G-X0qt=Cnn7vUpLu2s1=purmAESnCaRvK7XtmdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On Mon, 24 Jan 2022, Luiz Augusto von Dentz wrote:

> It is enabled via main.conf, if you have not modified that shouldn't be enabled.

Seems pretty generic:

----
$ nocomment /etc/bluetooth/*
/etc/bluetooth/input.conf:[General]
/etc/bluetooth/main.conf:[General]
/etc/bluetooth/main.conf:[Policy]
/etc/bluetooth/main.conf:AutoEnable=true
/etc/bluetooth/network.conf:[General]
----

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
