Return-Path: <SRS0=Cqm8=VG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A44C73C53
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5670C2082A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 16:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=adventurousmachines.com header.i=@adventurousmachines.com header.b="E/aS97+j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nW3ui2DZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfGIQ51 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:57:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37415 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbfGIQ50 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jul 2019 12:57:26 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 14C5921C39
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2019 12:57:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 09 Jul 2019 12:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        adventurousmachines.com; h=message-id:subject:from:reply-to:to
        :date:content-type:mime-version:content-transfer-encoding; s=
        mesmtp; bh=Tr8dYaS0fk53siF4oMMHbsdfO611ueEhHWOexD03h2k=; b=E/aS9
        7+jO+Tj7cdRfGT/oH4+2veqxSYkkbLUIpXoOfmwy5/Qi/IWP1powrGfQQVH/ibLc
        +mptVA5Ypi/x1VbPUO9lxyTNE6IXs6E3ND1LvWp4Zot1u2HZpHTr+MzOficPSzNV
        kEdN3DxOUhS+pzmQ+QVkI6sfxv10S5gIIjTVBE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:reply-to:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Tr8dYaS0fk53siF4oMMHbsdfO611ueEhHWOexD03h2k=; b=nW3ui2DZ
        B2CKItvAkZrW0OYs6S5r+IDfJS3UHEaKolRO8dtOzhIX3po/QA3zNtFrlgprUPTg
        Q93lJExzVCi71Xt4Zp8ke+dvpSjR+z4Rh9VI9K0Gb8MBammk0w344OFBxETJKly0
        WqpYQbAT/XjvhwWHUsRWKNRIwgcKJ2XVPBk1zXfeWnzn3JOZPyH7fF8NE77+jK+A
        hAEKJixzyFxPyFUgUvv446qV034E9fJWBRu1skMHhagfWLokFEjT780e4sbQwp/s
        9Vh9lCdabSQiLaAS2B5C1xCbBljp+uwo+vqkM2oeAKVofgoopv8dzPiiqpFoRSav
        1EIf4f7wZ2vDxA==
X-ME-Sender: <xms:dMckXcc75wqvuhPj4tBqFvvEwwr-qybZCKRuA6AmR-w7c5V4r1RwdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgedvgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhrhfvffhotggfggfgsehtje
    ertddtreejnecuhfhrohhmpeftohgsucfuphgrnhhtohhnuceorhhosgesrgguvhgvnhht
    uhhrohhushhmrggthhhinhgvshdrtghomheqnecukfhppeelgedrudeljedruddvtddrud
    eiheenucfrrghrrghmpehmrghilhhfrhhomheprhhosgesrgguvhgvnhhtuhhrohhushhm
    rggthhhinhgvshdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:dMckXTEx7hONHv43UNVlyKQZ6hu-eWvU-UsfV5mo4B5ZfFJphWZ_9Q>
    <xmx:dMckXbEI9augZXiQka0k1gm2bExftWymO_tSjksNOyyoR00d3qOuLw>
    <xmx:dMckXUCJ8updozZmMBpEm-qCoO9HwZP5cFYUHz8u5SwDaSaIdts2lg>
    <xmx:dcckXWbih5HmMrssZZxrjTJZts6Hk6hG20bU-fVliOxsEZJXkyUEMA>
Received: from zarniwoop (94.197.120.165.threembb.co.uk [94.197.120.165])
        by mail.messagingengine.com (Postfix) with ESMTPA id C03F5380079
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2019 12:57:23 -0400 (EDT)
Message-ID: <5730d9a34cc331e46ad86c2073f2cb5a94c80807.camel@adventurousmachines.com>
Subject: [PATCH BlueZ] gatt: Fix failure of repeated AcquireNotify calls
From:   Rob Spanton <rob@adventurousmachines.com>
Reply-To: rob@adventurousmachines.com
To:     linux-bluetooth@vger.kernel.org
Date:   Tue, 09 Jul 2019 17:57:22 +0100
Organization: Adventurous Machines Ltd
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes a problem that can be encountered if a DBUS client
performs the following steps:

 1) Calls AcquireNotify on a characteristic
 2) Closes the fd produced by AcquireNotify
 3) Immediately calls AcquireNotify again on the same characteristic
 4) Disconnects DBUS client (does not have to be immediately)
 5) Reconnects DBUS client and call AcquireNotify

If these steps are followed, then the third call to AcquireNotify
will often be responded to with an error message stating "Notify
acquired".  Furthermore, the second call to AcquireNotify will not be
provided with an fd.

It turns out that the following was happening:  Closing the fd causes
bluez to disable notifications on that characteristic by writing to
the CCC.  If the second call to AcquireNotify is made before that CCC
write has completed, then a new write to the CCC to re-enable
notifications is enqueued.  Once that first write has completed, the
second write is then taken from the queue and started in
`disable_ccc_callback()`.  Unfortunately `disable_ccc_callback()` was
not actually using the data from the queue, but was instead just
re-using the data that it had been passed (`notify_data` instead of
`next_data`).

This meant that the write to the CCC to enable notifications would
happen, but the callback that needed to be made to the code that was
waiting for the enqueued operation to complete would never happen.  In
this AcquireNotify case, the register_notify_io_cb() function would
not be called, resulting in no socket creation and no response to the
second AcquireNotify call.  Instead it would leave some state
hanging around on bluez's representation of the characteristic, and so
subsequent calls to AcquireNotify by any DBUS client would fail with
the aforementioned error.

The fix is simple here -- make `disable_ccc_callback()` pass the
correct data through.
---
 src/shared/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 858209c24..2c104097e 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1947,7 +1947,7 @@ static void disable_ccc_callback(uint8_t opcode, const void *pdu,
 	 */
 	while (1) {
 		next_data = queue_pop_head(notify_data->chrc->reg_notify_queue);
-		if (!next_data || notify_data_write_ccc(notify_data, true,
+		if (!next_data || notify_data_write_ccc(next_data, true,
 							enable_ccc_callback))
 			return;
 	}
-- 
2.21.0


