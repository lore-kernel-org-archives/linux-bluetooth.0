Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA35C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jan 2022 20:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiA0U6Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jan 2022 15:58:25 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:60867 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiA0U6X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jan 2022 15:58:23 -0500
Received: from [192.168.55.37] (ip68-111-137-238.sd.sd.cox.net [68.111.137.238])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4JlCbx5S9BzLgq;
        Thu, 27 Jan 2022 15:58:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1643317102; bh=Hvghr7JE4BHuqPhI3bxyFplZcVnjczKkxw/4tAV9RV0=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=n+rEiPhWKHJuAYUiIIHNCfYgt5DgPZjzkfMNeTfGZVKqtTxnZQDIMQm9X/mv5vnPT
         zAFxP6qdPnHnSvCsnvKsG8I2/gr5PZiJG1gEAeSb4BpbXys2OReA4rz6NHuIqCOUku
         Bxdtbz5pebyb8c5cHRt6YjJ8sbK8vXU2CFNKSq1c=
Date:   Thu, 27 Jan 2022 12:58:20 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: Commit ad383c2c6 ("Bluetooth: hci_sync: Enable advertising when
 LL privacy is enabled") breaks my MS ArcTouch mouse
In-Reply-To: <76f65c9-e031-3870-9dfb-49f8969534ae@panix.com>
Message-ID: <6f3b9dbb-6ecf-cfea-2127-cb3360d78431@panix.com>
References: <4124ccb8-11f-21e9-982e-7fb07f23225@panix.com> <CABBYNZLt3GmBTmAADa+FF2bdEfzMg_9Horxk2pT85BC+LFgrMQ@mail.gmail.com> <91c1e9ef-4786-b9f5-8bb8-b93c84c0874b@panix.com> <CABBYNZ+t+L=G-X0qt=Cnn7vUpLu2s1=purmAESnCaRvK7XtmdQ@mail.gmail.com>
 <76f65c9-e031-3870-9dfb-49f8969534ae@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Anything else I can do to help you diagnose this regression? One thing I do
(vaguely) remember when building a custom kernel some time ago is that this
device does some sort of "GATT encryption" (I'm sure I'm misremembering this,
it's been a few years) and I couldn't connect to it either unless the
appropriate config setup was used when building the kernel.

Thanks,

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
