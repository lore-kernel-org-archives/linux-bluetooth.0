Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722DDC761AF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Mar 2023 05:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjC2FHv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Mar 2023 01:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjC2FHu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Mar 2023 01:07:50 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1031E2723
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 22:07:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 93EE95C00CC;
        Wed, 29 Mar 2023 01:07:46 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Wed, 29 Mar 2023 01:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680066466; x=1680152866; bh=sG
        j7/h1KgDuHErGJCYCCanLYWpci9os4n+1e6QdFqeQ=; b=4ELB2St/S4JU8yxDzh
        G0WmvUJhBhD4LZB3zgP7DIdvlbTV/lTQFWU6amlTGKKeUGDLtPV6ONyae7VgUdGh
        NxLcqnWKo0BPMG59wQq5Im/OJQR1vYrvM04ox1bTSfp2KFxWh1aeQwwnp0umPPX0
        p2D05gW4tIX/PtGEEvSahaZplgMlwydbTqvrFZHBCI3RXDAZPN7qjojlRfY9VG4i
        Wkb7n2do0rTa/RJWVSeS9xLVIWTQGrBTICj8YgsTMaXXKmgHZVp5ZtOWN31A2bKR
        6Q8QHYDcfzWv9HrsoETC0w/UtQMi4MMopc1WdxgnF0YrB/qYk1jl9a+k3+I9BYE9
        iJpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680066466; x=1680152866; bh=sGj7/h1KgDuHE
        rGJCYCCanLYWpci9os4n+1e6QdFqeQ=; b=KR9ZgaHpfm0x4usISttjyWmH8xtQJ
        eJ7TQtbd/TgykwXoC9kZkkQku8ODtRqEVYYxBYyeoUxVVCG7bUXv3qp3Tvw1hjAh
        JhqnIFzxBcIbyHoHg2Q94TEWRp5jfMpzOwb5ncQ9mGKLanIauUZwrvba36xyFsd0
        9BqxrAqQN3fW+ieSWXXyn3ZMKi6RaWBDNFhKZv1FmafXm0xvFw54afova2yVaW/Z
        L8IRuJEpQHN0yLZ6xT7puSdNBzuX3MgKT6pyKzvibtdY/qe6eAzbTJiP851s1RS0
        aL0lNh6CE/BzGGe+NykOU/9nXId92HbUVNgCPAmoFCi58K5fpy/iGW7Iw==
X-ME-Sender: <xms:oscjZJCz7wIxQ6Pk8dIEM0KZOHm7MPy31OQ7gRzKzqBRs0slWQehoQ>
    <xme:oscjZHjwGEzmswc3yV6hYbHpVsw12XnupxQDIzbthsDA18fzH2ICxSM8dFXgzorFU
    hlfZFn9QlY5Iqd-3JY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehhedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdevhhhr
    ihhsthhophhhvghrucfunhhofihhihhllhdfuceotghhrhhisheskhhouggvheegrdhnvg
    htqeenucggtffrrghtthgvrhhnpeefteevuedtkeevjeejhffgudehheeiheegteektdef
    gefgfeejkefhleejkeeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegthhhrihhssehkohguvgehgedrnhgvth
X-ME-Proxy: <xmx:oscjZEmLqoTZg-zYJDwNu3Iq4KrJj5xEzZd91MBB7NvE5XcVmAuckg>
    <xmx:oscjZDxQ8K8ROoxJi41UJaRzGNSz00nKT7lUDsRuWIyvCv5wjvkQAw>
    <xmx:oscjZOTV-wy32zBzxR3y_m70RCzV8l8V40P7L-lBn2vlDZhhR3l-Aw>
    <xmx:oscjZH5oWKeUY0e1y_F9CbbLPdmSllCQwH3LgLa24QCfv6N1aUcRPw>
Feedback-ID: i01794759:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 40ED136A0082; Wed, 29 Mar 2023 01:07:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-237-g62623e8e3f-fm-20230327.001-g62623e8e
Mime-Version: 1.0
Message-Id: <dbe9e5b0-951d-446a-8476-f1cd92631704@app.fastmail.com>
In-Reply-To: <20221216201247.297210-1-marcel@holtmann.org>
References: <20221216201247.297210-1-marcel@holtmann.org>
Date:   Tue, 28 Mar 2023 22:07:07 -0700
From:   "Christopher Snowhill" <chris@kode54.net>
To:     "Marcel Holtmann" <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org,
        "Andrew McNaughton" <andrewmcnaughton@me.com>
Subject: Re: [PATCH] Bluetooth: Fix issue with Actions Semi ATS2851 based devices
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Dec 16, 2022, at 12:12 PM, Marcel Holtmann wrote:
> Their devices claim to support the erroneous data reporting, but don't
> actually support the required commands. So blacklist them and add a
> quirk.

This device appears to not support HCI_OP_LE_READ_TRANSMIT_POWER,
either. I get this with the above patch applied:

> Bluetooth: hci0: Opcode 0x204b failed: -56

Then it fails to register as a functioning interface, and bluez thinks
bluetooth is turned off.

In my case, it's a Techkey long range adapter, which is probably a similar
model to the above mentioned Ugreen device, except that it also has a
detachable pole antenna.
