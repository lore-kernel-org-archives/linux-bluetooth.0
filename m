Return-Path: <SRS0=otBP=MV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF1EC64EB0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Oct 2018 19:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B361214C4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Oct 2018 19:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B361214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chicoree.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJJDEQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:04:16 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:39359 "EHLO
        3.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeJJDEQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Oct 2018 23:04:16 -0400
X-Greylist: delayed 932 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Oct 2018 23:04:15 EDT
Received: from player699.ha.ovh.net (unknown [10.109.160.76])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 8E7FFCE146
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Oct 2018 21:30:13 +0200 (CEST)
Received: from [10.129.36.18] (reverse-177-9.fdn.fr [80.67.177.9])
        (Authenticated sender: sylvain@chicoree.fr)
        by player699.ha.ovh.net (Postfix) with ESMTPSA id AD5B82400B1;
        Tue,  9 Oct 2018 21:30:11 +0200 (CEST)
To:     linux-bluetooth@vger.kernel.org
From:   Sylvain Leroux <sylvain@chicoree.fr>
Subject: Serial communication over BT using the DBus API
Message-ID: <7246fd0d-022f-0d7b-ab09-1030ac06e0fa@chicoree.fr>
Date:   Tue, 9 Oct 2018 21:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 127508165000138382
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudeggddugedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi everyone,

I'm trying to establish a serial communication between two hosts over
Bluetooth.

Things go well if I start the `bluetoothd` on the server in
_compatibility mode_. That way, I can attach the "serial port" profile
to the channel. Then, using `rfcomm watch` and `rfcomm connect` to
establish the connection between the server and the client, I can
receive "raw" data sent by the server:

----
# Server side
/usr/lib/bluetooth/bluetoothd -C
sdptool add --channel=1 SP
rfcomm watch hci0 1 bash -c 'cat somefile > /dev/rfcomm0'
----

----
#Client side
sudo rfcomm connect /dev/rfcomm0 BB:CC:DD:EE:FF:11 1
sudo cat /dev/rfcomm0
-----

If I do _not_ run the `bluetoothd` server in compatibility mode, SDP is
no longer supported and the data I receive seems to modified by the BT
stack, leading to my data being mixed with garbage--exactly like when I
don't set the "serial port" profile while running in compatibility mode.


I don't like the idea of depending on a deprecated interface. And from
what I read, I understand the new way to go is to use the DBus API.  Any
solution using bluetoothctl, busctl, dbus-send or similar tools would do
the trick. But I can't manage to understand the sequence of operations
required to transmit raw data between the server and the client *from a
shell script* using that new API.

Could you give me some example or point me to the relevant documentation?

Regards,
- Sylvain Leroux
