Return-Path: <SRS0=nDLV=Y7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB3CC5DF60
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 13:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BE32178F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 13:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbfKGNXB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:23:01 -0500
Received: from hall.aurel32.net ([195.154.113.88]:41556 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730980AbfKGNXB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Nov 2019 08:23:01 -0500
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1iShka-0004AO-A6
        for linux-bluetooth@vger.kernel.org; Thu, 07 Nov 2019 14:23:00 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
        (envelope-from <aurelien@aurel32.net>)
        id 1iShkZ-0007IP-VG
        for linux-bluetooth@vger.kernel.org; Thu, 07 Nov 2019 14:22:59 +0100
Date:   Thu, 7 Nov 2019 14:22:59 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-bluetooth@vger.kernel.org
Subject: Bluez mesh-cfgclient: provisioning not working with OOB number/string
Message-ID: <20191107132259.GA26507@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I gave a try to the new mesh-cfgclient tool addition, that's a really
nice addition. I have tried to provision a Zephyr based Bluetooth Mesh
node, basically the Mesh OnOff Model sample for the nRF52 chip [1].

Unfortunately I have not been able to provision it, it fails around the
string OOB authentication:

| [mesh-cfgclient]# discover-unprovisioned on
| Unprovisioned scan started
| Scan result:
|         rssi = -73
|         UUID = ECB1EC84E1E500000000000000000000
| Scan result:
|         rssi = -57
|         UUID = ECB1EC84E1E500000000000000000000
| Scan result:
|         rssi = -56
|         UUID = ECB1EC84E1E500000000000000000000
| [mesh-cfgclient]# provision ECB1EC84E1E500000000000000000000
| Provisioning started
| Provisioning failed:
|         UUID = ECB1EC84E1E500000000000000000000
|         bad-pdu
| [mesh-cfgclient]#

On the Zephyr node, the OOB string has been correctly displayed:

| uart:~$ OOB String P4Z77K

I have tried also with an OOB number, it also failed the same way. I
have then tried doing a provisioning with OOB authentication and it
worked fine. After that everything I tried in the mesh-cfgclient tool
worked as expected: adding appkey, binding it, getting/setting the
subscription list and the publish address, etc.

Note that provisioning works fine even with OOB string/number using
meshctl and the GATT provisionner.

Any idea what is the issue and how to debug it?

Thanks,
Aurelien

[1] https://docs.zephyrproject.org/latest/samples/boards/nrf52/mesh/onoff-app/README.html

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
