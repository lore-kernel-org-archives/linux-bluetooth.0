Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DDEC6FD18
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 05:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCaFuj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 01:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCaFuh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 01:50:37 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC66BDF1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 22:50:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id F391F3200960;
        Fri, 31 Mar 2023 01:50:34 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Fri, 31 Mar 2023 01:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680241834; x=1680328234; bh=XC
        /QoaVHxvkX8zYj1rw4rxYZH848ltJ2yZ1cMjwGlB0=; b=JWboz1RS9gXVI27B1W
        jJMDMTHatViLAYEKTtIynHyWc9wLJt+JQnZ3n3n2wFl1lpvODmijIz3Cn9nNGhGt
        DKY31ap+R+L0f1hEo9GD0IXIoq69uIsyoMQyYSzXj/29EBQ8WpShJr3iprzr2gRt
        BztuHUU/ik13JMnqRxqIt1O/m5bAL+T0h5QJMMKEvsEa9f4KpGFcehastzDdzYOM
        3QoRpgCMq4jVEWR3++tCYC0Qnb0/nxXN+wM9OB3wRjCi8I6CNcag+kbIrSWqq69Q
        rNpuolkFfiU5GmMo5CCN//EBn6fVI580MzD6xssEDRABU6jMW2yqPxDNcSpnGGfz
        2cdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680241834; x=1680328234; bh=XC/QoaVHxvkX8
        zYj1rw4rxYZH848ltJ2yZ1cMjwGlB0=; b=q7ESZ0cncnclY0Zszcrkr7+BtIf8c
        qwVzGvOV3td4BVjPXN+h/qVShnDCIC887C6klE7Uo39eLlKDrUHHbgAbilyj82bR
        HvSrSOzmlQfQpF7X+JH1PS2Kck+C5aoeQcZgwghbFbToAoA3F+RTRPbh16KoSlAm
        G4j03SKf0cWBwTPHDQViejCHqR6hPVz2eIrgNMerNC8c7ViPTAsGiILnOa8wCNeP
        +OUzTVZn78/uFzj5FORprR7yxI5CeRh1utlH+ZlCc7hiA4XD301ugF+mj7nDm8aQ
        4Ml5wb43IW6vlL2hYt6f5h0rCHeQZENjI13YOaqR5TzWDIf1Zz1A2ksMQ==
X-ME-Sender: <xms:qnQmZC3_5EdBlQ6V72ynHHdkIg8bBKa8d08L5wrgbcvjdxPysMyU1g>
    <xme:qnQmZFEwNeW3NFdgFS2Nd8_tIfss5Qk_jJv2dxRbF0NpAomxw16GyA9NabcBT9mIZ
    hTdWyi63FbUaLLpt2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeitddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsthhophhhvghrucfunhhofihhihhllhdfuceotghhrhhisheskhhouggvheegrd
    hnvghtqeenucggtffrrghtthgvrhhnpeegtdetkeffudetueegleevleevvdfffeefkeet
    gfffgedttdegkedthfegveelteenucffohhmrghinheplhhoshhnohdrtghonecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrhhisheskhho
    uggvheegrdhnvght
X-ME-Proxy: <xmx:qnQmZK6wGiELjlIAm569hIVqi1eCYsCHR4b4p6IIIBt1g3n4bd7R1Q>
    <xmx:qnQmZD36ZByRARIU3DNB3G2CHAOvF1QArk89dIso9RF89yN7Ccs8Dw>
    <xmx:qnQmZFEeUaIwILd0ZmgXhVrdZqQvb4Hd-mSSuKwQ6ufKM9CpRXhgLg>
    <xmx:qnQmZKREybuYerSd8dxcnXTBnApxNQFYKq07p8a-SGeMeuZDCEPHug>
Feedback-ID: i01794759:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 40D1336A0078; Fri, 31 Mar 2023 01:50:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <126c5bce-6496-4744-9101-6a61f0fff106@app.fastmail.com>
In-Reply-To: <CACk7upyDgd8kCY+8j+RMJz35GXrF=bwRzDNH76Oh8q4nB8i0KQ@mail.gmail.com>
References: <CACk7upyDgd8kCY+8j+RMJz35GXrF=bwRzDNH76Oh8q4nB8i0KQ@mail.gmail.com>
Date:   Thu, 30 Mar 2023 22:50:02 -0700
From:   "Christopher Snowhill" <chris@kode54.net>
To:     "Raul Cheleguini" <raul.cheleguini@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     "Marcel Holtmann" <marcel@holtmann.org>, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com
Subject: Re: unexpected SMP command errors with controller ATS2851
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Would some pcapng logs be useful? It appears this device flags some commands as supported, while indicating their entire feature sets are not supported in the local supported features bitfields. Or that's as near as I can guess.

First is captured from a generic driver that works, the latter is captured from Linux 6.2.9. Included in the working capture is the beginning of an exchange with my Sony headphones. The latter stops logging after the first failed command.

https://f.losno.co/bluetooth_ats2851.pcapng.zst
https://f.losno.co/bluetooth_ats2851_broken.pcapng.zst
