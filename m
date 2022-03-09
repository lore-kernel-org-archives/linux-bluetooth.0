Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15760C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Mar 2022 09:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiCIJSk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Mar 2022 04:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiCIJSj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Mar 2022 04:18:39 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEB41B7B8
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Mar 2022 01:17:40 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 558CB240007;
        Wed,  9 Mar 2022 09:17:38 +0000 (UTC)
Message-ID: <f1ab40c531d81135918e0a05cc8b1721b951e958.camel@hadess.net>
Subject: Re: [RFC] Bluetooth: Adding support for /etc/bluetooth/main.conf.d
From:   Bastien Nocera <hadess@hadess.net>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     Katherine Lai <laikatherine@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Date:   Wed, 09 Mar 2022 10:17:37 +0100
In-Reply-To: <CAO271m=hf0uB1t50t6tTXqDQREVxzX2S=R2rVCGK60xwVKgSYQ@mail.gmail.com>
References: <CAPBVwTQrcYYauoCXBWdOsPa_vmN=cajYzVFcep_GLC-2OwOwYQ@mail.gmail.com>
         <6f8f47ceebfbcfd7fa8b04a4df807ae822e2960c.camel@hadess.net>
         <CAO271m=hf0uB1t50t6tTXqDQREVxzX2S=R2rVCGK60xwVKgSYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2022-03-08 at 14:50 -0800, Sonny Sasaka wrote:
> Hi Bastien,
> 
> 
> On Tue, Mar 8, 2022 at 2:14 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > Hey Katherine,
> > 
> > On Mon, 2022-03-07 at 10:57 -0800, Katherine Lai wrote:
> > > Background
> > > 
> > > It was found that a change to the default settings for
> > > MinConnectionInterval and MaxConnectionInterval in main.conf
> > > broke
> > > some of ChromeOS’s keyboard HID tests for only certain Bluetooth
> > > controllers. These keyboards aren’t able to connect to the
> > > device.
> > > Since those connection parameters improve the connection interval
> > > for
> > > most other chipsets, we want to leave the default values but have
> > > a
> > > way to have an optional override to address problematic models.
> > > 
> > > 
> > > Proposed Solution
> > > 
> > > Adding support to bluetoothd for an additional config directory
> > > /etc/bluetooth/main.conf.d containing multiple files which will
> > > override common params. Override order will be lexically sorted
> > > filename order. This pattern is already used by Linux distros,
> > > for
> > > example there is /etc/sudoers.d which files will override common
> > > params in /etc/sudoers.
> > > 
> > > Users can add override config files to /etc/bluetooth/main.conf.d
> > > rather than directly editing /etc/bluetooth/main.conf. This is
> > > more
> > > friendly to package managers since BlueZ package updates won't
> > > cause
> > > conflict to /etc/bluetooth/main.conf.
> > > 
> > > In bluez’s main.c, merge the params for each *.conf file from
> > > /etc/bluetooth/main.conf.d with the existing
> > > /etc/bluetooth/main.conf
> > > in lexical filename order
> > > 
> > > /etc/bluetooth/main.conf.d will be configurable at build time,
> > > e.g.
> > > with ./configure --main-conf-dir
> > 
> > This isn't quite how the pattern is usually used. With the existing
> > patterns, the OS-supplied stock configuration would be in
> > /usr/lib/bluetooth/main.conf.d (maybe with the default .conf in the
> > same directory as that subdir), with /etc/bluetooth/main.conf.d
> > only
> > used for the user/admin override the default configuration.
> We did a bit of research and found that /etc/X and /etc/X.d is more
> common, e.g. the one described in
> https://www.redhat.com/sysadmin/etc-configuration-directories.

This is documentation for an enterprise distribution, not how the
pattern is now used upstream.

$ ls -d1 /usr/lib/*.d/
/usr/lib/binfmt.d/
/usr/lib/environment.d/
/usr/lib/modprobe.d/
/usr/lib/modules-load.d/
/usr/lib/motd.d/
/usr/lib/pam.d/
/usr/lib/sysctl.d/
/usr/lib/sysusers.d/
/usr/lib/tmpfiles.d/
$ ls -d1 /usr/lib/*/*.d/
/usr/lib/dracut/dracut.conf.d/
/usr/lib/dracut/modules.d/
/usr/lib/fedora-third-party/conf.d/
/usr/lib/gconv/gconv-modules.d/
/usr/lib/kernel/install.d/
/usr/lib/NetworkManager/conf.d/
/usr/lib/NetworkManager/dispatcher.d/
/usr/lib/rpm/macros.d/
/usr/lib/systemd/ntp-units.d/
/usr/lib/udev/hwdb.d/
/usr/lib/udev/rules.d/

> If some distribution wants to organize the conf files to
> /usr/lib/bluetooth (for stock by package managers) and
> /etc/bluetooth/main.conf.d (for admin/users), I guess this is where
> having a configurable path is useful.
> What do you think?

I'm saying this isn't the current pattern, especially for OSes where
/usr is locked-down. I still think this isn't the right way to
implement this feature.
