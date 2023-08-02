Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5241DC001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 13:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjHBN2N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 09:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjHBN2L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 09:28:11 -0400
X-Greylist: delayed 394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 06:28:10 PDT
Received: from zougloub.eu (zougloub.eu [69.70.16.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5A68E1
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 06:28:10 -0700 (PDT)
Received: from pouet.cJ (exmakhina.com [69.70.16.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by zougloub.eu (Postfix) with ESMTPSA id DA4BF2401A53
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 09:21:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zougloub.eu;
        s=zougloub.eu; t=1690982485;
        bh=sm6mQ/wdF70vY08bxgQ48YOyu++0GIR1/8bsAboMWiU=;
        h=Subject:From:To:Date;
        b=b3hI8u9Ep5Iig4CF+PE4oHhOZhTCxmTuCGJRMnZcEHAQFDe2ghWwOkBwu7Pa6jm46
         2crRoCg0yiiKSESV+rO0EPpxBKHBc4GuwC6M4wY9JcsLBoEs7XX3cN5m+bYpel3gts
         SnpCkD/iPSXfDTeJWLcbmwCTGh0+nSTkI7IL+PSY=
Message-ID: <9f121aaae37f79022bb6d1aa7787e50492f7ee00.camel@zougloub.eu>
Subject: Puzzling software regression (flaky device control, scanning
 issues, scan filter?)
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Carretero <cJ-ko@zougloub.eu>
To:     linux-bluetooth@vger.kernel.org
Date:   Wed, 02 Aug 2023 09:21:25 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi there,


There is something wrong with my software stack or configuration and so
far I can't put my finger on it. This probably has been going on for a
few months. I found a way to express my issue as follows.


When I am running a Fedora Live virtual machine with my bluetooth
dongle shared with it, it runs the following software:
- Linux 6.2.9-300.fc38.x86_64;
- bluez Version 5.66;
- linux-firmware providing intel/ibt-17-16-1.sfi version 108-45.22;

And I can use bluetoothctl and issue "power on", "scan on", "scan off",
"power off" at will, and successfully discover/connect/pair a bluetooth
mouse. That's a working configuration.


In my regular software environment I'm running:
- Linux 6.3.13;
- bluez Version 5.66 or 5.68, I've tried both; the configuration files
are unmodified from defaults (Gentoo package, there are a few
distribution patches but nothing);
- the same linux-firmware blob (I had tried older revisions before
checking the VM idea);
- nothing else than me using the bluetooth dbus interface or command-
line tools;

And when using bluetoothctl "the first time", I can issue "power on",
"power off", "scan on" doesn't seem to work fully, and "scan off" says:
 Failed to stop discovery: org.bluez.Error.InProgress
And a subsequent "scan on" says:
 Failed to start discovery: org.bluez.Error.InProgress

But `hcitool scan` works and shows my mouse.

And in `bluetoothctl` if I fiddle with scan options then scan results
will show my mouse and I can use it ("clear uuids", "clear rssi", and
reapply an rssi filter to not get a gazillion advertisments because I'm
in the city), but it's not clear to me why scan is not originally
working.


I hadn't been able to connect my wireless headseat for weeks, so I was
living wireless-less, but my 20 year old wired mouse started
misclicking and I felt like making the rediscovered 10 year old
wireless one work, and after banging my head on the problem I found
that the VM configuration worked, and iscovered about these scan
filters yesterday, and managed to pair with the mouse.

So I have a workaround, but I'm wondering if someone could help me
understand or diagnose this problem further.


Best regards,

--=20
J=C3=A9r=C3=B4me
