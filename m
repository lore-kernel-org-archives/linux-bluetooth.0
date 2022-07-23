Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77641C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Jul 2022 14:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbiGWO1c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 23 Jul 2022 10:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbiGWO1a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 23 Jul 2022 10:27:30 -0400
X-Greylist: delayed 165413 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Jul 2022 07:27:28 PDT
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C421140DF
        for <linux-bluetooth@vger.kernel.org>; Sat, 23 Jul 2022 07:27:28 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4LqpY70gHTz9sSg
        for <linux-bluetooth@vger.kernel.org>; Sat, 23 Jul 2022 16:27:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1658586443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAlCU+KMzwKsxXbyinTXrh7OuN2VC1JUaBMsl1boB34=;
        b=Ktav5jmJUQYkpN+MEuREn0hOpg3DK5lr1Ts9DG/TdiB0PmFq92hss33rrzYNkOYY+CZbry
        11fd+v8X+Pk4aRJihkocg2pYxSeOA6aP0wl5HoOuBjGyphW3wkbTi/ztQ9zecohCyeeQcR
        BU04mRLIXTqYqTCMgo+tBi82e1agSwYQk+g7WX2p/V+KA+1RoJDlUh3WwSMGVRJB46LUZ3
        l/FRf2KGzKFR7LVxdclE0ISWEBQ5Szogi7qJF6l7WoECQnFs1fGukycv9I44g9RAYrmR+w
        h/OCSuRha30DgwjmvD/2CoxE/P0iaaAKYMpTjeh9B6ewAFvZAxtUcwTRgqs+TA==
Message-ID: <12f7886c687f6b7d2951eecc65daf9d1e236267b.camel@dylanvanassche.be>
Subject: Re: bnep: Can't add bnep0 to the bridge btnap0: Invalid argument(22)
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     linux-bluetooth@vger.kernel.org
Date:   Sat, 23 Jul 2022 16:27:22 +0200
In-Reply-To: <ac4d6df497b85598b0c000d14aa6f102fb5357d1.camel@dylanvanassche.be>
References: <ac4d6df497b85598b0c000d14aa6f102fb5357d1.camel@dylanvanassche.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Answering this myself as I found the solution for my problem for futher
reference:

On Thu, 2022-07-21 at 18:30 +0200, Dylan Van Assche wrote:
> Hi,
>=20
> I'm trying to setup a Bluetooth hotspot using NAP with BlueZ and
> NetworkManager. However, I cannot fix the following error:
>=20
> bnep: Can't add bnep0 to the bridge btnap0: Invalid argument(22)

Turns out that the device I have here has incorrect MAC addresses for
WiFi and Bluetooth. I could lay my hands on a different device and
there bnep0 gets properly added to the bridge since the MAC addresses
were not rejected by the Linux kernel bridge driver.

>=20
> I have created a network bridge as followed:
>=20
> brctl addbr btnap0
>=20
> and used test-nap [1] as followed:
>=20
> test-nap btnap0
>=20
> when the client connect, you can see in the logs that BlueZ tries to
> link the bnep0 interface it is creating with the btnap0 bridge, but
> fails to do that.
>=20
> Logs:
>=20
> profiles/network/server.c:confirm_event() BNEP: incoming connect from
> XX:XX:XX:XX:XX:XX
> profiles/network/bnep.c:bnep_getsuppfeat() supported features: 0x1
> profiles/network/bnep.c:bnep_add_to_bridge() bnep: Can't add bnep0 to
> the bridge btnap0: Invalid argument(22)
> profiles/network/server.c:bnep_setup() BNEP server cannot be added
>=20
> Environment:
>=20
> BlueZ 5.64
> postmarketOS edge / Alpine Linux (musl libc)
> Qualcomm wcn3990 Bluetooth adaptor
> Linux 5.18.3 (arm64)
>=20
> Did I miss something to set this up?
>=20
> Kind regards,
> Dylan Van Assche
>=20
> [1]
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/test-nap

Kind reagards,
Dylan Van Assche
