Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C294C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 02:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354242AbiAYCeB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:34:01 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:64305 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3415508AbiAYBrJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jan 2022 20:47:09 -0500
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4JjTk63hlSzDZD
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 20:27:42 -0500 (EST)
Received: from [192.168.55.39] (cpe-75-82-21-54.socal.res.rr.com [75.82.21.54])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4JjTjk4g0hzS2f;
        Mon, 24 Jan 2022 20:27:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1643074043; bh=CI733NiLSOGjRDD9vQohkZAw9bzzflvc16rQaiixL14=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=kQX+FDXAvz4p0RPD87qci7DUFbxunLg1Ceq4hKGYkwfs/3zdd3VujFxBPO+vb+wbY
         Ccthf0SrEWnG3er6FipmubaPsOg5fzBj8Q9PE2v1LZXNe+WTGJvrQU3XHaVDVBvLes
         GX0ucif2SgGlUdm16SzqD/xi9r33f9zO3OXeEgAM=
Date:   Mon, 24 Jan 2022 17:27:21 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: Commit ad383c2c6 ("Bluetooth: hci_sync: Enable advertising when
 LL privacy is enabled") breaks my MS ArcTouch mouse
In-Reply-To: <CABBYNZ+t+L=G-X0qt=Cnn7vUpLu2s1=purmAESnCaRvK7XtmdQ@mail.gmail.com>
Message-ID: <7c5a166-f4e8-ecad-de77-6597b4e9573b@panix.com>
References: <4124ccb8-11f-21e9-982e-7fb07f23225@panix.com> <CABBYNZLt3GmBTmAADa+FF2bdEfzMg_9Horxk2pT85BC+LFgrMQ@mail.gmail.com> <91c1e9ef-4786-b9f5-8bb8-b93c84c0874b@panix.com> <CABBYNZ+t+L=G-X0qt=Cnn7vUpLu2s1=purmAESnCaRvK7XtmdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On Mon, 24 Jan 2022, Luiz Augusto von Dentz wrote:

> Try something like:
> sudo btmon -t

----
$ sudo btmon -t
Bluetooth monitor ver 5.55
= Note: Linux version 5.17.0-rc1-XPS-Kenny+ (x86_64)                                                   17:23:38.260348
= Note: Bluetooth subsystem version 2.22                                                               17:23:38.260349
= New Index: C0:B8:83:1F:F4:45 (Primary,USB,hci0)                                               [hci0] 17:23:38.260349
= Open Index: C0:B8:83:1F:F4:45                                                                 [hci0] 17:23:38.260349
= Index Info: C0:B8:83:1F:F4:45 (Intel Corp.)                                                   [hci0] 17:23:38.260350
@ MGMT Open: bluetoothd (privileged) version 1.21                                             {0x0001} 17:23:38.260350
----

Then nothing else, when I power/move on this MS mouse. If I power on my generic
BT mouse, I get plenty of output. Are there other options to try?

> Also restart the daemon just in case and then do:
>
> bluetoothctl> power on

It was already on:
----
$  sudo bluetoothctl
Agent registered
[bluetooth]# power on
Changing power on succeeded
[bluetooth]# quit
$
----

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
