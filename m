Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9F5C001B0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Aug 2023 09:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjHNJHF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Aug 2023 05:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbjHNJG5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Aug 2023 05:06:57 -0400
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [IPv6:2001:67c:2050:102:465::203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0A510B
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Aug 2023 02:06:55 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4RPT6h1s09z9tmJ;
        Mon, 14 Aug 2023 11:06:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shiphrah.com;
        s=MBO0001; t=1692004012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M6HN6P9kbnEcnPCbn6IX+7R2jYl3TZUWhsuLCjoxrwI=;
        b=0KZ1gwk3FdQVsZ8gpEXPTcHgkVl7nwoxljNLu2m20BHGdqC/6HrxXnKm3HSsJQ/tunYMXk
        uFV7m58mFHeu1Vr3ANDtceNho773ztmDz5bw71i3OvmAP1NgV4WQ+2WG9vCvdjh+c1od6I
        Hoz3lReY4w1ki9XYmjFVhCNVlohQXlM52br6aMf5kqstCM10t9sLfa/C43LdNInOVJR0xa
        Od3nKXthm9WsvRnd8Ql3kKAajUj51q5wZHnUXJ1A22r47xj4d4KTMfcYFA36LMyHvi1cid
        JnJANEZnk0/0Gmge3WuPLau/g3rvHLrZ2AWEyTKOK3ha8gh5rnJvIymggb6n3w==
Message-ID: <c9dc82bc-71ea-3047-9021-688008376e83@shiphrah.com>
Date:   Mon, 14 Aug 2023 11:06:49 +0200
MIME-Version: 1.0
Subject: Re: Firmware for MT7922 missing in initrd; bluetooth disabled after
 update
Content-Language: de-DE
To:     Paul Menzel <pmenzel@molgen.mpg.de>, Qu Wenruo <wqu@suse.com>
Cc:     linux-bluetooth@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Chris Lu <chris.lu@mediatek.com>, Takashi Iwai <tiwai@suse.de>
References: <8ddaee26-b4d7-f694-ac8b-2aaf4d3c5f8e@shiphrah.com>
 <c69edd3b-bace-42a0-91e5-d8606a443853@molgen.mpg.de>
 <874jl4r30d.wl-tiwai@suse.de>
From:   =?UTF-8?Q?J=c3=bcrgen_Hofmann?= <hofmann@shiphrah.com>
Organization: shiphrah GmbH
In-Reply-To: <874jl4r30d.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Paul, dear Qu,

>>  From Qu’s answer in the thread *[PATCH v3 1/2] Bluetooth: btusb: Add
>> new VID/PID 0489/e102 for MT7922* [1] it sounds to me, support for
>> chip was only added recently, and is going to be in Linux v6.6.
> 
> The problem is rather the lack of MODULE_FIRMWARE() declarations for
> the corresponding device.  The device itself already works fine as is
> with the current upstream kernel as long as the firmware file is
> present on the system.  But as dracut puts only the firmware file
> listed in MODULE_FIRMWARE() into initrd, it starts failing once when
> you build an initrd containing the BT.

from all I can tell (and understand), the analysis from Takashi about 
the missing MODULE_FIRMWARE() declarations is correct.

Thanks,

Jürgen
