Return-Path: <SRS0=Ljem=T4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6CCC04AB6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 May 2019 14:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97162133F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 May 2019 14:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbNmy/JU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfE1OhE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 May 2019 10:37:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38788 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfE1OhE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 May 2019 10:37:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so20520314wrs.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2019 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=UuRSugn3hF3nrFbpNIlzW4Mzvbi9ikb6w2/3ehwfHHc=;
        b=SbNmy/JU5/2dX2X3QUDsgkdFqRLFM+xH7j3MBWdtmNFc7lqDRaQF+e2GgbR2J6ZV52
         y5hin3aFRHK3rkujXeUQHAby+pp/gKKIAWQFvoLC9SGcoq4YGRo5fo06+befpP4XWyjv
         PI1cDVu+4sLo7jZ4Ip+AVgkh+Tth3rynLvQEtC/kql3b9G+cc9NUjhr4DdDrpE+p2lNm
         nCWzEJaerRA7eD2wiZK7lZq9FmvtegvmH3Gtd+14C2UESZExYCUsC9a0CkMgrzzUQ2AM
         F2Mf6Dm+w68cebAmOGA2bKH16XDEQZ9RmpLFYRqBwAGykrm/9gHPT96YC+v0P9G+96cI
         LPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=UuRSugn3hF3nrFbpNIlzW4Mzvbi9ikb6w2/3ehwfHHc=;
        b=hmGsA6LGC7lgrXh2/D1BBxdGRefq85ADijblH5dnygxL/7JYxRQTh5Wt/lQs9JNV9Q
         IRvSdl4McdB0fry3i6kx0T2nw6X72dxJaxbe/W3ptcUs2lEa90fz8uetKDwPGTuBPDGv
         F0zMVPS4RpmCCW/yeuM5ULTgawc2I2kmUVenHQ+laVVBoL8Hx/PUs6IOwgFhVWXtWwSv
         yiGSP3mAf9Tt/37yNkFVm3O6QjxBC4Yh4jzEW6j6NWY8GOC6x1VtgVhea221VbTXIqil
         ay00u8rxc+ww+AftmPtpHubV3HmLX6nqrlugzhtOMJimML7yjP+MNoSypW4M7PYEBCdX
         4RbA==
X-Gm-Message-State: APjAAAWWG7DeOHsJGv/6Zu1OnxbTp1Zb33uGXOnxU29QEJMhZHuIYHwe
        esTKft5WLof9nocwREkVN1hhRPbbLD8=
X-Google-Smtp-Source: APXvYqyHctP53NOKYHgl7unHCgwnS83ePoZGqZZMDbAH7h7G52yNZd7jnjYljrbnq0xgFLb35H2WiA==
X-Received: by 2002:adf:dc12:: with SMTP id t18mr18681239wri.61.1559054220042;
        Tue, 28 May 2019 07:37:00 -0700 (PDT)
Received: from [192.168.1.10] (93-34-147-76.ip50.fastwebnet.it. [93.34.147.76])
        by smtp.gmail.com with ESMTPSA id d17sm19585438wrw.18.2019.05.28.07.36.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 07:36:59 -0700 (PDT)
To:     linux-bluetooth@vger.kernel.org
From:   Matteo Formigli <matteo.formigli@gmail.com>
Subject: Problems with bluez
Message-ID: <f61b05a1-3e87-d09e-6892-ac1999dc6abd@gmail.com>
Date:   Tue, 28 May 2019 16:36:59 +0200
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
  BlueZ is the official Linux Bluetooth protocol stack. It is an Open 
Source
  project distributed under GNU General Public License (GPL).
Homepage: http://www.bluez.org
Original-Maintainer: Debian Bluetooth Maintainers 
<pkg-bluetooth-maintainers@lists.alioth.deb

