Return-Path: <SRS0=NumT=SO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76043C10F0E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Apr 2019 12:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6C120652
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Apr 2019 12:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfDLMmy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:42:54 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:46959 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfDLMmx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Apr 2019 08:42:53 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A205020016
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2019 12:42:51 +0000 (UTC)
Message-ID: <e585165b3f4232a1912733767b72bb6ebc593544.camel@hadess.net>
Subject: PS3 Wireless Keypad pairing (CECHZK1)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Date:   Fri, 12 Apr 2019 14:42:50 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hey,

Yesterday, I rebased and re-tested some old patches I had to support
the "Wireless Keypad" for the PS3.

Manual is here:
https://www.playstation.com/en-nz/content/dam/support/manuals/scee/web-manuals/peripherals/ps3/ps3-wireless-keypad/CECHZK1GB.pdf

There are 2 ways to pair it.

- The "standard Bluetooth way" explained in the manual under "Using the
wireless keypad with other products". I couldn't get the device to stay
connected/usable using current bluez git master, but I also had
problems getting an old Bluetooth input device to connect after
initially pairing, so it might be a more general problem in my setup or
in bluez/kernel land.

- I implemented "Cable pairing", this overwrites the computer to
connect to on the keypad, but it asks for a passkey when connecting
after that, which we obviously don't know.

I don't know what else would be needed to make the pairing complete and
keys be exchanged, when cable pairing, but in case this helps somebody
integrate a solution they hadn't made public before, here's my git tree
to give it a whirl:
https://github.com/hadess/bluez/commits/ps3-keypad-pairing

Cheers

