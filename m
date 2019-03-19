Return-Path: <SRS0=3ySR=RW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BBCC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 14:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E172075E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 14:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="KUHrYCHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCSOEL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:04:11 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:14710 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfCSOEL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Mar 2019 10:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1553004245;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=6g6vRDYHBX5z0y7MblRJQaxAZs5oqEt3D/41qsYr0rM=;
        b=KUHrYCHyPTf7OhHSTspm6rWldV4mbeX9UrhjuvDxsCxLqOIg0njrhMlAIiDMKh4F2Y
        Qy9Okrv7ZtlRP+HXWI0D+msPjfvfs7hqXSk4N+Gxoe9/Kzmjv1DNOIV+J8+NCkzkZKQ6
        MWayQ2xKoKMxjTxiq/xWhe/Ahm7qQXkHv9AJaxak+4uF37az3E6RDmvNwy/4WMDomfI0
        YJ93YfHhN5K1EEAbfzQWQfP7dNIWCMDWqJas/t0o/AUTYNSLfVNHJjP8raJfJDHwyzlK
        6YZEg3NIGeCooMlERbVTUlrz07K0Ohq/TzrNbVdnxDECqjFhcB0mJz8jWEHem4prsJ8b
        kfnA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJKA0/up1VN"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 44.16 AUTH)
        with ESMTPSA id k0bbe4v2JE44LbI
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 19 Mar 2019 15:04:04 +0100 (CET)
Date:   Tue, 19 Mar 2019 15:03:56 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Ferry Toth <ftoth@exalondelft.nl>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/2] Bluetooth: btbcm: Add default address for BCM2076B1
Message-ID: <20190319140356.GA1076@gerhold.net>
References: <20190305130901.56660-1-stephan@gerhold.net>
 <20190305130901.56660-2-stephan@gerhold.net>
 <7b48753f-f103-f522-68c5-38479feb4552@exalondelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b48753f-f103-f522-68c5-38479feb4552@exalondelft.nl>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Sorry for the late response. I've been quite busy lately...

On Tue, Mar 05, 2019 at 07:26:14PM +0100, Ferry Toth wrote:
> 
> Op 05-03-19 om 14:09 schreef Stephan Gerhold:
> > BCM2076B1 appears to use 20:76:A0:00:56:79 as default address.
> > This address is used by at least 5 devices with the AMPAK AP6476
> > module and is also suspicious because it starts with the chip name
> > 2076 (followed by a different revision A0 for some reason).
> With BCM43340 (Edison) it's the same principle. With the fake address I
> found everything (in user space) seems to work except PAN/NAP (bnep) and no
> decent error message anywhere making this quite hard to debug.

Not familiar with PAN/NAP, but the main reason to avoid default 
addresses is that they will cause issues as soon as you have two of 
those devices next to each other.

> > Add it to the list of default addresses and leave it up to the
> > user to configure a valid one.
> 
> Which way is the user supposed to configure the valid one?
> 

It took me a while to figure this out - there is not much 
documentation for this. The following is only based on my own 
investigations:

As far as the kernel is concerned, HCI_QUIRK_INVALID_BDADDR is exposed 
through the btmgmt API [1]. With the quirk, the BT controller will 
appear as "unconfigured" controller to userspace, and will have the 
public address as missing option. As soon as the address is configured 
with the "Set Public Address Command", the unconfigured controller is
removed and replaced with a regular controller.
  Only then it will be usable through bluetoothd.

The btmgmt API has to be controlled from user space.
As far as I know, the only tool in bluez to set the public address
is the "btmgmt" tool:

  btmgmt -i hci0 public-addr xx:xx:xx:xx:xx:xx

... will run the "Set Public Address Command" described above.

However, it was mentioned several times that "btmgmt" is not
a "stable" tool. In other words, it is not installed by default
and is only intended for debugging. It may change any time.

There was a related discussion on IRC recently: (I was not involved)

  10:50 <Mis012[m]> sjanc: do I need to convince my distro to package 
        btmgmt, or will you revert that commit?
  10:51 <sjanc> Mis012[m]: I'd ask holtmann about this :) but btmgmt 
        was more like testing tool than real end user tool
        (ie, no manpages, rather ad-hoc design and command set etc
  10:53 <sjanc> Mis012[m]: but if you really need this feature,
        I'd consider starting discussion on mailing list
        on how this could be handled by bluetoothd
  10:53 <sjanc> as mentioned, this could be in plugin,
        either common plugin or maybe platform specific,
        which would set public address via mgmt api
  10:54 <sjanc> open point is how bluetootd would extract public address, 
        which is always platform specific
  10:55 <holtmann> Mis012[m]: btmgmt is not a stable tool.
  10:55 <Mis012[m]> holtmann: but it's the only one which can do this
  10:56 <holtmann> Then add support to bluetoothd for it or do it via an 
        external tool / daemon. I wrote a long post to the mailing list 
        about that.

I have such an external daemon for Android (since it does not use bluez) 
at [2]. It would be easy to refactor it to something more portable.

[1]: https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt
[2]: https://github.com/me176c-dev/android_device_asus_K013/blob/lineage-16.0/bluetooth/bdaddr.c

> The only way I found is bd_addr (tool from bluez that is not normally
> built/installed).
> 
> Using this tool requires hci0 to be up and bluetoothd to be restarted if
> that was already running, which is quite inconvenient.
> 

bdaddr does not use the btmgmt API. It sends vendor-specific commands to 
the HCI interface. This might be the reason why you need to restart 
bluetoothd.

With HCI_QUIRK_INVALID_BDADDR set, the BT controller should not show up
at all in bluetoothctl until its public address is configured.
It does not matter if bluetoothd is started too early.

> I also saw there was a patch to put the address in dt.
> 
> But nowhere did I find a kernel parameter to pass the address. Did I miss
> something?
> 

I'm not familiar with setting the address from DT/kernel parameters. 
Sorry :(
