Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB3BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Mar 2022 10:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345672AbiCHKPx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Mar 2022 05:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345627AbiCHKPv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Mar 2022 05:15:51 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EFA42A18
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Mar 2022 02:14:54 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id BA62340017;
        Tue,  8 Mar 2022 10:14:52 +0000 (UTC)
Message-ID: <6f8f47ceebfbcfd7fa8b04a4df807ae822e2960c.camel@hadess.net>
Subject: Re: [RFC] Bluetooth: Adding support for /etc/bluetooth/main.conf.d
From:   Bastien Nocera <hadess@hadess.net>
To:     Katherine Lai <laikatherine@chromium.org>,
        linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 08 Mar 2022 11:14:52 +0100
In-Reply-To: <CAPBVwTQrcYYauoCXBWdOsPa_vmN=cajYzVFcep_GLC-2OwOwYQ@mail.gmail.com>
References: <CAPBVwTQrcYYauoCXBWdOsPa_vmN=cajYzVFcep_GLC-2OwOwYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hey Katherine,

On Mon, 2022-03-07 at 10:57 -0800, Katherine Lai wrote:
> Background
> 
> It was found that a change to the default settings for
> MinConnectionInterval and MaxConnectionInterval in main.conf broke
> some of ChromeOS’s keyboard HID tests for only certain Bluetooth
> controllers. These keyboards aren’t able to connect to the device.
> Since those connection parameters improve the connection interval for
> most other chipsets, we want to leave the default values but have a
> way to have an optional override to address problematic models.
> 
> 
> Proposed Solution
> 
> Adding support to bluetoothd for an additional config directory
> /etc/bluetooth/main.conf.d containing multiple files which will
> override common params. Override order will be lexically sorted
> filename order. This pattern is already used by Linux distros, for
> example there is /etc/sudoers.d which files will override common
> params in /etc/sudoers.
> 
> Users can add override config files to /etc/bluetooth/main.conf.d
> rather than directly editing /etc/bluetooth/main.conf. This is more
> friendly to package managers since BlueZ package updates won't cause
> conflict to /etc/bluetooth/main.conf.
> 
> In bluez’s main.c, merge the params for each *.conf file from
> /etc/bluetooth/main.conf.d with the existing /etc/bluetooth/main.conf
> in lexical filename order
> 
> /etc/bluetooth/main.conf.d will be configurable at build time, e.g.
> with ./configure --main-conf-dir

This isn't quite how the pattern is usually used. With the existing
patterns, the OS-supplied stock configuration would be in
/usr/lib/bluetooth/main.conf.d (maybe with the default .conf in the
same directory as that subdir), with /etc/bluetooth/main.conf.d only
used for the user/admin override the default configuration.

I don't think that making it optional, or have the path changeable is
needed, but the rest seems good.

Cheers
