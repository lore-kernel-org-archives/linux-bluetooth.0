Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F36C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 May 2023 21:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239214AbjEKVPQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 May 2023 17:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbjEKVPP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 May 2023 17:15:15 -0400
X-Greylist: delayed 457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 14:15:08 PDT
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [IPv6:2001:67c:2050:102:465::206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02E01FFF
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 May 2023 14:15:08 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4QHPbw3hlnz9tNr
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 May 2023 23:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
        t=1683839244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jrLR+1yLbK1qCY4Ljqzrwb1k6u6CXn9WTj69hXLv6zs=;
        b=F6NAUNChjwatfbOe9rmsVZynEU+XqvcEc2oHoROZEkF7DxIDASZQgdXQzENF5CSWgyCJTh
        pOlrx+wa77RbBGjoYS8zsDiFBBrnXP39fDMt81lPl8QaVH7VAfrYDzgKdONnL09iiSbNSg
        0Y4i53On5c+OYtdf5hPS8h+Y6TRnaaCzpwd2XguIGMmWZDF2FIS0b/QeJiUaCR2U07XJ8B
        7xH0syzXjHBv15jYnwyKmzDQmfWwN7eJG2xYqoMZos/3PIOaAszJIow8WZLwQ/7E7E+rdy
        pUECK3OHj0T1KZL1+PXVciAuD2AhuX5ydh+K1IsNoiC9aI1fvHD8HyiaekD/Jw==
Message-ID: <06c029bd-1c95-9eb5-c0e7-79a7545f93dd@tavla.de>
Date:   Thu, 11 May 2023 23:07:23 +0200
MIME-Version: 1.0
To:     linux-bluetooth@vger.kernel.org
Content-Language: en-GB
From:   Martin Petzold <martin.petzold@tavla.de>
Subject: What is the correct properties map when I register the HID profile
 with the local object manager
Organization: TAVLA Technology GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4QHPbw3hlnz9tNr
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I have some problems with a BLE remote control which only issues 
"connected=true" without "servicesResolved=true" on the first button 
pressed. Only on the second buttonPressed it also issues the 
"servicesResolved=true" together with "connected=true". So I miss the 
first button (think about the power button for the TV). I am trying to 
implement the HID profile directly, I have "hog" and "input" disabled 
for bluetoothd. I am using BlueZ 5.55 and currently I have to stick to 
kernel 5.10. It does work with another remote control. I only know about 
one difference, the newer one uses MAC address randomization. But I 
don't know if this is relevant.

As I did not find an answer in StackOverflow, I asked ChatGPT. But of 
course after some dialogues the answers change. However, it seems it may 
be required to register more than just the HID service UUID with the 
local object manager. Do I also need to register the characteristic 
UUIDs and maybe related read / write flags?

Thanks,

Martin

