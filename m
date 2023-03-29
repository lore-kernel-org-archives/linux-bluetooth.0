Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586A1C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Mar 2023 05:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjC2FKF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Mar 2023 01:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC2FKD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Mar 2023 01:10:03 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560FC272A
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 22:10:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C544C5C012F;
        Wed, 29 Mar 2023 01:10:01 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Wed, 29 Mar 2023 01:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680066601; x=1680153001; bh=qr
        NYJuOhLXiCysIOn6RCkwiKRMEf9xVD3GAk+HYcPo0=; b=S4KIlgjOfzWkcFxK2E
        Jf2k3YYncf84Ocd2yAE5lU5hAMOBXmUJyF2ike1vsq80UFPCFUcKbtW8+zU8/k7y
        045nVEdj0r68C9AjNcayKzk9vaNpRzKXUS+qaCiuBqb+ilvwyP2sDmNDMPX8syiT
        gmOXtonba+CHOK+vYVLI7a/+MW2dtFkd0Cr0TsmNk3yKDnxLhB1usq168LP2Ub/M
        IJ9Nkffai6ItGpqqZHvYtv8k/Mz69z/sKeSioaAfo1WmXNOrU0FVqS1fZKr7i72h
        LKq2Sbho7+fPNG8ScFcswNY5rbdS+3v7IsLvd5H3mff9ki3XdXmJ7MbrofmytrRy
        ERKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680066601; x=1680153001; bh=qrNYJuOhLXiCy
        sIOn6RCkwiKRMEf9xVD3GAk+HYcPo0=; b=ss8u9aTggnwhaoW/gr54QR/r/VfjV
        9tkJlhemHJW62dHmv/rTAaGv72ymDGNQ6tE+8ybdoDHYtEel1sBmlgEYtg2f50LA
        /hsMOePYtkjD4y9Dn8ROTPNv/DoWoirEj/UKkyXF80Ntc6fqEh/OWMo5ydo9p2Kg
        31PEJxexYb6ZiamDnwVt9NYNOTc02PhEvissLCChWh8LCIkPejKVyDROf6DtUv1l
        Nxj9G9oCMQuJTGhB01nBjAjzXxk5dX6ZTu1inTMdx+4pGtf9Rm0jzbdpNBe+VuF/
        9KrMnZoK7sVkpReprKXC6KqWbZ8cLMjM5wY7InN5tAfeF3y4Au2DY3EyQ==
X-ME-Sender: <xms:KcgjZIUSWDiIPSg2tTs4tmVKcxFQczzTbmFLhwHKhdxyxo9VO8BaEA>
    <xme:KcgjZMl8tc4RqEUXf_gclcNDU8fBUIGtVMZpBnLcChJLBAvOhJlSR2PgGice84kqB
    aETAtrArWjiqsm87eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehhedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdevhhhr
    ihhsthhophhhvghrucfunhhofihhihhllhdfuceotghhrhhisheskhhouggvheegrdhnvg
    htqeenucggtffrrghtthgvrhhnpeefteevuedtkeevjeejhffgudehheeiheegteektdef
    gefgfeejkefhleejkeeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegthhhrihhssehkohguvgehgedrnhgvth
X-ME-Proxy: <xmx:KcgjZMYPD2DaKCGD0REVZvb1eLIk4RtbDjRfo1BL2iDwnrLyJmGbTw>
    <xmx:KcgjZHUHAfL--1FkFmRGhbJeVcaKNgl9eJxoHmJ4XkWcnzJxguTxSg>
    <xmx:KcgjZCkPQ4lg5CChyDrBAuYjF3cZEKWuCwH-vsPXQqWMQnTt2Y-zNg>
    <xmx:KcgjZJsfqCa8q777vpx-BbZzRJwWiGX09K7W5JrnBpxVszsc4HQC4w>
Feedback-ID: i01794759:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8D0BB36A0082; Wed, 29 Mar 2023 01:10:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-237-g62623e8e3f-fm-20230327.001-g62623e8e
Mime-Version: 1.0
Message-Id: <c20fa501-9ba1-4ceb-9e7f-fe12c70ac0d4@app.fastmail.com>
In-Reply-To: <dbe9e5b0-951d-446a-8476-f1cd92631704@app.fastmail.com>
References: <20221216201247.297210-1-marcel@holtmann.org>
 <dbe9e5b0-951d-446a-8476-f1cd92631704@app.fastmail.com>
Date:   Tue, 28 Mar 2023 22:09:41 -0700
From:   "Christopher Snowhill" <chris@kode54.net>
To:     "Marcel Holtmann" <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org,
        "Andrew McNaughton" <andrewmcnaughton@me.com>
Subject: Re: [PATCH] Bluetooth: Fix issue with Actions Semi ATS2851 based devices
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

So sorry for the noise, I didn't notice there was a new patch revision.
