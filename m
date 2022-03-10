Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872B2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Mar 2022 09:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbiCJJwn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Mar 2022 04:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiCJJwn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Mar 2022 04:52:43 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9921D13AA15
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 01:51:39 -0800 (PST)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8E963CECD8;
        Thu, 10 Mar 2022 10:51:38 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RFC] Bluetooth: Adding support for /etc/bluetooth/main.conf.d
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAPBVwTQrcYYauoCXBWdOsPa_vmN=cajYzVFcep_GLC-2OwOwYQ@mail.gmail.com>
Date:   Thu, 10 Mar 2022 10:51:37 +0100
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <3DAED89D-72AC-4D38-A092-D2A52AEEE5BB@holtmann.org>
References: <CAPBVwTQrcYYauoCXBWdOsPa_vmN=cajYzVFcep_GLC-2OwOwYQ@mail.gmail.com>
To:     Katherine Lai <laikatherine@chromium.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Katherine,

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

actually I rather not do this. Let met try to explain this. In modern distribution layout, the /etc directory is purely for the admin of the system. They can do localized changes. Defaults are meant to be in /usr/lib/ actually. And override is also meant that an /etc file can fully replace an /usr/lib file.

We already structured that /etc/bluetooth/main.conf is optional and that package managers / distros should only install it if they really know what they are doing. If an upgrade of a package overwrites /etc/bluetooth/main.conf then it is doing something wrong (mind you we don’t install it by default).

That said, some time ago I discussed with Alain, that fundamentally you first need an option to identify your controller, what firmware etc. and then can decide what to load. That thread ended and got no further discussion. Based on that identification we wanted to allow tweaking certain set of parameters to add known good parameters / workaround to broken hardware.

If you say, that you already know all of this anyway upfront and your filesystem is specific for a given platform, then use tmpfs for /etc/bluetooth/main.conf or alternatively, we actually introduce support for CONFIGURATION_DIRECTORY. We already have this in iwd and it would make sense to just support it.

The CONFIGURATION_DIRECTORY directory comes from systemd (https://www.freedesktop.org/software/systemd/man/systemd.exec.html), but since it is just an environment variable for the bluetoothd process, you can do with any shell by just setting it.

Regards

Marcel

