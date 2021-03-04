Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EFAC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 10:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC4564F38
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 10:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbhCDK5D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 05:57:03 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39571 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbhCDK4d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 05:56:33 -0500
X-Originating-IP: 78.199.60.242
Received: from [192.168.1.150] (unknown [78.199.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 22E1260003;
        Thu,  4 Mar 2021 10:55:40 +0000 (UTC)
Message-ID: <0f80d7ef92366fde06f3b24fe060066e01933980.camel@hadess.net>
Subject: Re: Autopairing
From:   Bastien Nocera <hadess@hadess.net>
To:     Mihai Emilian <be.mihai22@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Thu, 04 Mar 2021 11:55:40 +0100
In-Reply-To: <CAP_L5iPNbYrni-U_EH=Yf5Tb3b7tGN6wFKp-h+HNE8ob028k5w@mail.gmail.com>
References: <CAP_L5iPNbYrni-U_EH=Yf5Tb3b7tGN6wFKp-h+HNE8ob028k5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2021-03-02 at 18:07 +0100, Mihai Emilian wrote:
> Dear bluetooth community,
> 
> I am trying to create a pairing agent using bluez API in C.
> 
> The problem that I am trying to solve is autopairing from a known list
> of MAC addresses (i.e auto-accept pairing for known devices in the
> list).
> 
> I tried registering a bluetooth agent with NoInputNoOutput capability.
> However, when I try to access Pair, I receive Authentication Failed
> error.
> 
> Another problem here is that even if I call RequestDefaultAgent after
> registration, it seems that the bluetooth settings agent (UI) is still
> called and prompts me to yes/no.
> 
> I have the following questions:
> 
> From the api doc:
> "Special permission might be required to become the default agent"
> 
> - Is there anything else I have to do to acquire these permissions?
> - The return value from RequestDefaultAgent and RegisterAgent is void.
> How can I check whether my agent has been registered/became default?
> - I also tried trusting the discovered device after registering the
> agent and trying to make it default, which didn't make any difference
> - is this required?

You might want to look at ready made pairing tools, such as bt-agent in
bluez-tools:
https://github.com/khvzak/bluez-tools

This is an example of using static pincode with unattended pairing:
https://github.com/hadess/CHIP-bluetooth-speaker/blob/master/setup.sh#L73

The bt-agent pin code file can accommodate using bluetooth addresses,
so something like:
AA:BB:CC:DD:EE:FF *
in the pin code file should work.

Cheers

> 
> Here's my source code:
> https://pastebin.com/Wj3rdHy3
> 
> Thank you for your time.
> 
> Best regards,
> Mihai


