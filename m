Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08C2C00140
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Aug 2022 10:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiHXK2F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Aug 2022 06:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbiHXK1t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Aug 2022 06:27:49 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF9352E5B
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Aug 2022 03:27:47 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 86450E000F
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Aug 2022 10:27:46 +0000 (UTC)
Message-ID: <c8667a8ff68021acde3a9821b56eb13e40f2e1f6.camel@hadess.net>
Subject: "Powered" transitional state
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Date:   Wed, 24 Aug 2022 12:27:46 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hey,

We're running into problems in GNOME in more recent times with changes
in Bluetooth adapter power either taking a long time, or sometimes
failing. To that end, I added a new "state" API in gnome-bluetooth that
I'll also need to replicate in bluez.

My idea would be to add a property to the org.bluez.Adapter1 interface:

string PowerState

	The power state of an adapter.

	The power state will show whether the adapter is turning off,
	or turning on, as well as being on or off.

	Possible values:
		"on" - powered on
		"off" - powered off
		"turning-on" - transitioning from "off" to "on"
		"turning-off" - transitioning from "on" to "off"

This should allow any program to show the transitional state, not just
the one that requested the change, and will also show transitional
states that were the results of other system changes, like rfkill
changes.

Any comments before I start working on implementing this?

Cheers
