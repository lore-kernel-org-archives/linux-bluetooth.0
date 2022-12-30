Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D30C4167B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Dec 2022 19:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiL3THw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Dec 2022 14:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3THu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Dec 2022 14:07:50 -0500
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118001BE88
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Dec 2022 11:07:49 -0800 (PST)
Date:   Fri, 30 Dec 2022 19:07:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1672427267; x=1672686467;
        bh=nRGBbjNdP5c/aWI8BbMDjtf4WPyPYCn+dxJk0BvQmu0=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=n8eM7fm6K9YmUmoiLY7+lbj4E77JIMDs4C0Bk75ZEWO7Ggi0yJBfosigGDWDJ8Aao
         qJmqOTYF91o/X9kZT4dntq5abfgs5JjE70y4LUN/ZgHz5TOdVKF6vq6Ak0DPKsoVBf
         Pg5jcqekZFeP4R6Yw0FzfA06ztQP/npJi7wzbEiJHajRtKz35UBvhuwRc8Y5HDH2Os
         y3G3WcasU2gSanavQtfEkRC5mjFlPVkW/3tsUHHgYGReGLNErctKEvpeggZU9VNIoT
         vSMHjXRtLt2ZqYiDRwMM5/YCxQl4DOIFbWF3lq1iFp/2zMQvIbMJapFFFoH/m/gpnn
         dW6XVW43RjXZA==
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   Ivan Hernandez <theatomicdog@protonmail.com>
Subject: BLE MIDI for Roland GO:KEYS keyboard
Message-ID: <a8adTmncHWSFmL4Xli3lVFJl8b9IWLRfgciG1uvjINTyGlqDESdM5n2V9xavNlApy9FvvNX6Rmdxe6-juPe3C1682iuXWuHhVwvVT9zcUZ4=@protonmail.com>
Feedback-ID: 12176234:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi!
I hope this is the right place to ask, if not, just ignore/redirect.
I'm trying to use a Rolando GO:KEYS keyboard which has bluetooth audio and =
bluetooth MIDI. The Audio works out of the box. The midi (once bluez 5.66=
=C2=A0 is compiled with --enable-midi) is discovered and the midi in-out co=
nnections appear in alsa but there is no midi_io at all.
I compared the debug output with the one from another Bluetooth MIDI device=
 I have and the missing piece seems to be that the working MIDI device send=
s this characteristic:

bluetoothd[7988]: profiles/midi/midi.c:handle_characteristic() Supported ch=
aracteristic: 7772e5db-3868-4112-a1a9-f2669d106bf3


Which triggers the handle_midi_io()

profiles/midi/midi.c:handle_midi_io() MIDI I/O handle: 0x002a


Opposite, the Roland GO:KEYS sends this characteristic


bluetoothd[7263]: profiles/midi/midi.c:handle_characteristic() Unsupported =
characteristic: 00000318-0000-1000-8000-00805f9b34fb



which leads to a lack of midi_io for the connected device.


I tried connecting to an iPhone and the device does actually works both for=
 input and output via bluetooth midi, but I'm not really familiar with the =
details of bluetooth.


How can I debug this further to try to fix or to provide information that i=
s actually helpful for the developers?


Thanks
Ivan
