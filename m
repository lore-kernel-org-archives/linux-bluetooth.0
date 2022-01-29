Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9CDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jan 2022 22:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346400AbiA2WHE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Jan 2022 17:07:04 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:54468 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243417AbiA2WHD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Jan 2022 17:07:03 -0500
Received: from [192.168.55.37] (ip68-111-137-238.sd.sd.cox.net [68.111.137.238])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4JmT2F4DQqz18qj;
        Sat, 29 Jan 2022 17:07:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1643494022; bh=8LmrN4IBIbtA+abwAxZ1fL224MqxRnH98lAhrFrQxZU=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=V5I2Y7zGBcaE1xIU8MHYtP1c8jgyW2VyqwMjQKqA1OWIF6uuKqkhpjmiOQYGEX40L
         Y0yveHe9MWN4zJhQS9TdsIAInJOSrt9mhf4dl/TYEtL/8TzlXOAymrHYBQjZRKuakE
         J5a+zYUFSQKFqVTupIt8EVBfQEQL8BrvHMtaQsog=
Date:   Sat, 29 Jan 2022 14:07:00 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: Commit ad383c2c6 ("Bluetooth: hci_sync: Enable advertising when
 LL privacy is enabled") breaks my MS ArcTouch mouse
In-Reply-To: <6f3b9dbb-6ecf-cfea-2127-cb3360d78431@panix.com>
Message-ID: <3bc9bbab-b3cd-4c52-cc33-5d723d973deb@panix.com>
References: <4124ccb8-11f-21e9-982e-7fb07f23225@panix.com> <CABBYNZLt3GmBTmAADa+FF2bdEfzMg_9Horxk2pT85BC+LFgrMQ@mail.gmail.com> <91c1e9ef-4786-b9f5-8bb8-b93c84c0874b@panix.com> <CABBYNZ+t+L=G-X0qt=Cnn7vUpLu2s1=purmAESnCaRvK7XtmdQ@mail.gmail.com>
 <76f65c9-e031-3870-9dfb-49f8969534ae@panix.com> <6f3b9dbb-6ecf-cfea-2127-cb3360d78431@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


So, it turns out that my lack of discoverability is also tied into this last
series of BT commits (and apparently the result of some commit other than the
one named in the Subject: line); while I could take the time to bisect this
issue as well, seems to me that something as basic as not being able to put
an HCI adapter in discoverable mode is a pretty big regression (especially
on something as ubiquitous as Intel BT adapters) that I can't be the only
one who's seeing these issues- have there been any other reports, and are
there any fixes upcoming?

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
