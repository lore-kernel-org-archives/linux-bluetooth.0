Return-Path: <SRS0=VLRJ=T2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCB2C282E3
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 May 2019 10:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C62820863
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 May 2019 10:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="So1kD4QE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfEZKfC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 May 2019 06:35:02 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:45413 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfEZKfB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 May 2019 06:35:01 -0400
Received: by mail-wr1-f47.google.com with SMTP id b18so13958608wrq.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 May 2019 03:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=3u6c5BQqXApiaoA+yzMsfi2JOXqcurNoEkY8cSsE8C4=;
        b=So1kD4QEQiX5/a6X+8Htk5gneDaOcCzIHM6tU8PICVZ1ku0bDh8QFTjtwcGHd99Gds
         O8bCTaEzT1WSl9a77OdBO//VSBbhxDBs7sD4nfZQclpf/5nmiu+NhPspb1k8F9sFP/xG
         dapfMLF6c1B/ovoJC2VnTc1rDM5fNwtpgLjf4j8be8U4r1BDcFtF4MzFB5LUDDCD6cnb
         RNOcPnAc1kW2mAlfc+RkXaoB+uRxJaP6sC9LVRg6IxQE9I81ShEu4zU5Dtp4B2U2f3Yu
         f+yxK5TX6HEdKEKwWADQBONpdoJHRL5r9bm2koT1gKjEqlIeFPXztI6rrrXXnu4kA4U/
         l5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=3u6c5BQqXApiaoA+yzMsfi2JOXqcurNoEkY8cSsE8C4=;
        b=IIpZIjJS/rJ0D0jSnHWvoNDbRD5zHhdfXRG96AhQScwVe4k1DNhA/dWZfMYJznXe4d
         HixkbyoNWJ8jfOWmtW9aT+Ik8vEWZXseRFs3/qlmaTcTu+3eMtDcDZiqLi0eEVb9ltwb
         aIh1dDQrhrE9XK+dIWLYGWY3rzaR0FFU7UjoudOYxtDiJ+IMrSE9DD0w++PY+azN2YFR
         B2LUpyyEWygy51EJ+7aJNtF3tWl10C5/g2sMwBNldCj5LJAI1JDrvSyBB3Mn/fQ4uNNE
         oI6roTS52oveWCPilcFXj8US8xPccOUIm+PkbEHc/bwUq+3oqWQj8r9Hzsj4YRorybcR
         qgUg==
X-Gm-Message-State: APjAAAU+EBqY72OT58KFF89YnDI/ed/5CkMhxAa1CFte/z2swg45917R
        5rBk6iy0jl9N58v7l+NGHw8dinFs1vU=
X-Google-Smtp-Source: APXvYqwgRh9tj61QWsITLnnKtOXtiZbEaNCMetNhYXTjPDDlQTkHJwOzr74+1MQniEXpQ0EuLoydow==
X-Received: by 2002:adf:e845:: with SMTP id d5mr6163520wrn.154.1558866899813;
        Sun, 26 May 2019 03:34:59 -0700 (PDT)
Received: from [192.168.1.10] (93-34-147-76.ip50.fastwebnet.it. [93.34.147.76])
        by smtp.gmail.com with ESMTPSA id h8sm19052716wmf.5.2019.05.26.03.34.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 03:34:59 -0700 (PDT)
To:     linux-bluetooth@vger.kernel.org
From:   Matteo Formigli <matteo.formigli@gmail.com>
Subject: bluez crashes
Message-ID: <4ea47d0b-391f-1ec5-d8f1-63863f0af022@gmail.com>
Date:   Sun, 26 May 2019 12:34:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all!


I am using Ubuntu 16.04 and there is no way to make the bluetooth work. 
Every time I try to pair to my bluetooth headset bluez crashes. I really 
don't know where to start solving this problem and I really hope that 
someone on this list can help me.

Thanks in advance for your help!

Matteo

P.s. The following is the output of the dpkg --status of the bluez packgage

:~$ dpkg --status bluez
Package: bluez
Status: install ok installed
Priority: optional
Section: admin
Installed-Size: 4119
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: amd64
Multi-Arch: foreign
Version: 5.37-0ubuntu5.1
Replaces: bluez-alsa, bluez-audio (<= 3.36-3), bluez-input, 
bluez-network, bluez-serial, bluez-utils (<= 3.36-3), udev (<< 170-1)
Depends: libc6 (>= 2.15), libdbus-1-3 (>= 1.9.14), libglib2.0-0 (>= 
2.31.8), libreadline6 (>= 6.0), libudev1 (>= 196), init-system-helpers 
(>= 1.18~), lsb-base (>= 4.1+Debian11ubuntu7), kmod, udev (>= 170-1), dbus
Breaks: udev (<< 170-1)
Conflicts: bluez-alsa, bluez-audio (<= 3.36-3), bluez-utils (<= 3.36-3)
Conffiles:
  /etc/bluetooth/input.conf
  /etc/bluetooth/main.conf
  /etc/bluetooth/network.conf
  /etc/bluetooth/proximity.conf
  /etc/dbus-1/system.d/bluetooth.conf
  /etc/init.d/bluetooth
  /etc/init/bluetooth.conf
Description: Bluetooth tools and daemons
  This package contains tools and system daemons for using Bluetooth 
devices.
  .
  BlueZ is the official Linux Bluetooth protocol stack. It is an Open Source
  project distributed under GNU General Public License (GPL).
Homepage: http://www.bluez.org
Original-Maintainer: Debian Bluetooth Maintainers 
<pkg-bluetooth-maintainers@lists.alioth.deb

