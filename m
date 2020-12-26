Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A15DC433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Dec 2020 17:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53642184D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Dec 2020 17:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgLZRDp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:03:45 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38237 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbgLZRDp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Dec 2020 12:03:45 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0E7935C00BA
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Dec 2020 12:02:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 26 Dec 2020 12:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kanru.info; h=
        from:to:cc:subject:in-reply-to:date:message-id:mime-version
        :content-type; s=fm2; bh=Wk7w/LOenIlqgCk2A0cOuidIJR20iwpgcOHpT2m
        v8+k=; b=W432qRdJPJSuFMKF6mnOPk/tbAB1H3iRsx3mTvh0bIgDMMufwB+WZlc
        zV5OtChlKF+TOHwof67bIab3afl/iu87vdGXFuwhvjBxKZPnpBhzqeiA/vOjeGuu
        EfZMpwS+elKw9DGH2cZQJjNSlr5TBweX9YIz/kdX3Y9PmiIRvyr5q9/5myPihnzV
        l553SFkIhBao7RxKiw6xDYTo0tgJB3yTfwUBVturIdeny+zlT4e/lpqnNFrwLAet
        bYtFNwiyK2HjrkvnL04JHLQtGUEIUXcDFXJwpURFcrZs9XQdcQ7FiU9kORUqJ+AR
        RX1b6oNVmHemIQn+REKxttu7DIqq9sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Wk7w/LOenIlqgCk2A
        0cOuidIJR20iwpgcOHpT2mv8+k=; b=lUXwKGKaXsODHhMQt/cTekmk37qp3ENMp
        F4Xbtlo4s4JdyI/IIv0PGHYivHAkK8Oa7dRvPjRP9Bgv+n89FzAKK60a8DWGsraM
        omztbLEVDNPPkoJ83uVhoSOzk4CURs+7RzoSq7pHMt5Y6t8Td6dkloEsT78d0Ecf
        LqsOnV5Z0O13+612DqZ25S5DYWaTlQKkXpbaf215jlYitmAAGbthf7zh9o4o9n+8
        TodNs1m7shzO17/p1/lqwBRWV46I9+Vz2aOU3qqxhj1uKuhwTs+np3ZyURhrgDSF
        nPpeTKf/JIpYKvURXfg1CG+QZ6GQwDA12DgddnrnaQszvCRb1yHmw==
X-ME-Sender: <xms:rmznX2oYPSLQ0AbeOmHnwwz6tvIYA7BhbR0TSAk-ILVp2yY6mh063Q>
    <xme:rmznX0q9oC27-Xow0cc_iZOlgos3xuf--AoCENMZs2BuDeIDk8tC2US57_BvxrOCt
    0wjlAyLBQOxlOc67Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdduhedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufgjfffkgggtsehttdertddttddtnecuhfhrohhmpefmrghnqdftuhcu
    vehhvghnuceokhgrnhhruheskhgrnhhruhdrihhnfhhoqeenucggtffrrghtthgvrhhnpe
    eiffejtdejvdetteeihfeuleekfffgtefhledtveefudevudeigeetgeeljeelheenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvvddurddvgeeirddvvdeirdefie
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrghn
    rhhusehkrghnrhhurdhinhhfoh
X-ME-Proxy: <xmx:rmznX7NsGXsbY0OvwG2-QSLz5lg9K5uLPaMfJ67PBWzKZJSvlMpWLg>
    <xmx:rmznX16GY_VOOUAzn_infdvcFkRV5xyv1frLtuFYg_1msdnJCR2Kdw>
    <xmx:rmznX15uBIXullLUkoHAmE9viOui37DrQw0RNC6MJrosZW7bCv5A4w>
    <xmx:r2znX3FmrEUDskAHjXjXAQEL5McDW2Ze3ER0TNb4STUEiWqZJFJdKA>
Received: from shinagawa (221x246x226x36.ap221.ftth.ucom.ne.jp [221.246.226.36])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1444B108005F
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Dec 2020 12:02:37 -0500 (EST)
Received: from kanru (uid 1000)
        (envelope-from kanru@kanru.info)
        id ae475c
        by shinagawa (DragonFly Mail Agent v0.12);
        Sun, 27 Dec 2020 02:02:34 +0900
From:   Kan-Ru Chen <kanru@kanru.info>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     nsathish41@gmail.com, linux-bluetooth@vger.kernel.org,
        chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        kiran.k@intel.com, sathish.narasimman@intel.com
Subject: Re: [PATCH] Bluetooth: Fix: LL PRivacy BLE device fails to connect
In-Reply-To: <4DB44FB6-A6F3-4FBE-A16D-EE3FCB1A6F65@holtmann.org> (message
 from Marcel Holtmann on Mon, 9 Nov 2020 13:41:10 +0100)
Date:   Sun, 27 Dec 2020 02:02:34 +0900
Message-ID: <87mty0bivp.fsf@shinagawa>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Sathish,
>
>> When adding device to white list the device is added to resolving list
>> also. It has to be added only when HCI_ENABLE_LL_PRIVACY flag is set.
>> HCI_ENABLE_LL_PRIVACY flag has to be tested before adding/deleting devices
>> to resolving list. use_ll_privacy macro is used only to check if controller
>> supports LL_Privacy.
>> 
>> https://bugzilla.kernel.org/show_bug.cgi?id=209745
>> 
>> Fixes: 0eee35bdfa3b ("Bluetooth: Update resolving list when updating whitelist")
>> 
>> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
>> ---
>> net/bluetooth/hci_request.c | 12 ++++++++----
>> 1 file changed, 8 insertions(+), 4 deletions(-)
>
> patch has been applied to bluetooth-next tree.

Can we also apply this patch to the 5.10 stable tree?

Thanks,
Kanru
