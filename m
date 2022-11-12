Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC3FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Nov 2022 10:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiKLK2g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Nov 2022 05:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLK2e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Nov 2022 05:28:34 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207582618
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Nov 2022 02:28:33 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8AD735C00DF;
        Sat, 12 Nov 2022 05:28:32 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 12 Nov 2022 05:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1668248912; x=1668335312; bh=Ft
        e2rxiySVM+JOc1hNbK+MPRv06a8DHftjYoXjxIs70=; b=jDuFzzWx3qf1GKRNoW
        ML/6QjLodvYJYI74a+B0oTUobXL+YNdAhRApC3L2eHigTkxg3gKgXfZJuBCvQ7P9
        6C0hzh21IPf6+lCKGuyFVVHdmT/2Npv1hXyTkUMUXcCSnx/Jbv1HhwShr5FMLTNU
        qUIr6jt50hz4XCBZqbB3oM9A51HQ/ZOYHnqFHYNcJu9c5YTde9OAWVZ5MM8cImcB
        7/jjg0/66dDCp2ijmVc/XQehblcglh/Oa25U1t2Vysqf7KRBbJff5HBpP0iQjatL
        zbsdo41Bq6vYrPs109usHPnSvYjrMe7qZ/b75kYdOLIqPpGKqFgjsIF97glaqQII
        jvLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668248912; x=1668335312; bh=Fte2rxiySVM+JOc1hNbK+MPRv06a
        8DHftjYoXjxIs70=; b=uFCZOany+NfPA5B9WykctUZCqLezFA6ocS5Lg/BEcpRu
        AEorQ0L0djWn6L3awhlKccsyB0I2IHsRimAWnMMtXvYP70coAHE6T6Vv19yd1DwO
        6qvSnTcUP97v86/kljUpx3doYWHTyHYPscwAeEfrqckc+0IcLqYeeCEFJhCIQdeH
        jdfo4os6Mvj2rSNMVk5vfPWjN0OUPlnE6cuJPtJqSCSDUWu9IKhBRc5zjp/xS5ED
        EyWrLYSqrFbAvGaxyqSgMzVKF0YEqsSbt7qILIx4DWkNH9fozGNWZa60uhlpt+Zg
        TKT8VKLNoi0zkOMjrPb5JJ5F9QHLvGVOo9n5eLRFPg==
X-ME-Sender: <xms:UHVvY132I7gSMD-fpBA_weHJc9ngQB0c5_FAEcCWX9tgfKptXYoeEg>
    <xme:UHVvY8GPWcJyE5htWPknvIO7lGzHhJPrM6nD0LC4dURMn9Po08Ozcp-JcFOHUofQm
    1JRYA7btz2NliMOoAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeekgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:UHVvY17zlRJ2uiYFRWIbKt2L3BdUdy-Y7Rx9gZLy7r8gO3nnjGm_9w>
    <xmx:UHVvYy1_CsZFRpO585HZ7pAz2G79wut8hy8KTVr7zHAYQ37WwcQSWQ>
    <xmx:UHVvY4FYekAguFxt1eUDrmsagHNDoUElmTMsDYDbmZmLjRA73FYPPA>
    <xmx:UHVvYzPeXj59DhIL7mb-X9v1zLr6Y-OKWd3TlqII0rew8T6bpSp5fw>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 760E9A6007C; Sat, 12 Nov 2022 05:28:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <2d282d22-20be-4e27-b3ef-3048779f939b@app.fastmail.com>
In-Reply-To: <20221112090437.3591380-1-yangyingliang@huawei.com>
References: <20221112090437.3591380-1-yangyingliang@huawei.com>
Date:   Sat, 12 Nov 2022 11:28:10 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Yang Yingliang" <yangyingliang@huawei.com>,
        linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com
Subject: Re: [PATCH -next] Bluetooth: hci_bcm4377: Fix missing pci_disable_device() on
 error in bcm4377_probe()
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,


On Sat, Nov 12, 2022, at 10:04, Yang Yingliang wrote:
> pci_disable_device() need be called while module exiting, switch to use
> pcim_enable(), pci_disable_device() will be called in pcim_release()
> after probe() failure.
>
> Fixes: ab80b2cec05f ("Bluetooth: hci_bcm4377: Add new driver for 
> BCM4377 PCIe boards")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Good catch, thanks!

Reviewed-by: Sven Peter <sven@svenpeter.dev>


Best,


Sven
