Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8E2CCA487
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 16:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiGUQam (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiGUQai (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 12:30:38 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80196459AF
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 09:30:37 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4LpdN81hsRz9sSr
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 18:30:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1658421032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=x3V4SAM0Xt6PqVdOpzXw2PMZwn8ObF/lqcet+/Wo5PE=;
        b=oLmhbTXmH6otRN01iUmlN6aAcJxRnbMathVLusi0HIdE6Vo3oxkLsgcznAlSilAdpzcaQx
        S82mt4KLK1xwgcCg2mNxCYtSnbDP5brNLyXu6vcG5U9S6z9wykC+ZusroGIA5WbQIJFBS1
        AafBh2oMdpp5Y4GpO5fnp+lmhlzN281Vt4daaxS4ovh3oM41iE/TSynQX1oGrRSuzxGiz1
        OPrmp1ycOdEKnxh090fzo0JJ0/J4uCnOgKp3MVBsPJzXBSwxJujaPE7h0UEZP4IZLnykHt
        EdMgrsLIfj9/GK32RMEUx4uTbIqA5bg67l6wXp6cZPc+8alkgjF2fPUYF/rEZg==
Message-ID: <ac4d6df497b85598b0c000d14aa6f102fb5357d1.camel@dylanvanassche.be>
Subject: bnep: Can't add bnep0 to the bridge btnap0: Invalid argument(22)
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     linux-bluetooth@vger.kernel.org
Date:   Thu, 21 Jul 2022 18:30:31 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I'm trying to setup a Bluetooth hotspot using NAP with BlueZ and
NetworkManager. However, I cannot fix the following error:

bnep: Can't add bnep0 to the bridge btnap0: Invalid argument(22)

I have created a network bridge as followed:

brctl addbr btnap0

and used test-nap [1] as followed:

test-nap btnap0

when the client connect, you can see in the logs that BlueZ tries to
link the bnep0 interface it is creating with the btnap0 bridge, but
fails to do that.

Logs:

profiles/network/server.c:confirm_event() BNEP: incoming connect from
XX:XX:XX:XX:XX:XX
profiles/network/bnep.c:bnep_getsuppfeat() supported features: 0x1
profiles/network/bnep.c:bnep_add_to_bridge() bnep: Can't add bnep0 to
the bridge btnap0: Invalid argument(22)
profiles/network/server.c:bnep_setup() BNEP server cannot be added

Environment:

BlueZ 5.64
postmarketOS edge / Alpine Linux (musl libc)
Qualcomm wcn3990 Bluetooth adaptor
Linux 5.18.3 (arm64)

Did I miss something to set this up?

Kind regards,
Dylan Van Assche

[1]
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/test-nap
