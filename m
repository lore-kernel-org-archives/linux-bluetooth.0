Return-Path: <SRS0=/vUS=V2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A558C433FF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 21:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DD420693
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 21:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfG2VId (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:08:33 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:39757 "EHLO
        9.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfG2VId (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jul 2019 17:08:33 -0400
X-Greylist: delayed 2396 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 17:08:32 EDT
Received: from player693.ha.ovh.net (unknown [10.108.35.95])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id B5A1F7229C
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2019 21:52:35 +0200 (CEST)
Received: from brouillet.org (lneuilly-657-1-117-248.w90-63.abo.wanadoo.fr [90.63.226.248])
        (Authenticated sender: postmaster@brouillet.org)
        by player693.ha.ovh.net (Postfix) with ESMTPSA id 5EF3E8665A0F
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2019 19:52:35 +0000 (UTC)
To:     linux-bluetooth@vger.kernel.org
From:   Marcel Brouillet <marcel@brouillet.org>
Subject: [BlueAlsa] connected but no possibility to record or play
Message-ID: <545763ea-aa51-fe38-e6a7-c6e5dd6adefe@brouillet.org>
Date:   Mon, 29 Jul 2019 21:52:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Ovh-Tracer-Id: 5657365560352029772
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrledugddugeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I have compiled BlueAlsa from git, and followed the README.md.

I disabled pulseaudio (pavucontrol does not connect).

I am able to connect my phone and my linux computer (though only for 
phone-calls, not yet audio).

Bluealsa [as root] outputs the following and remains running :

bluealsa: bluez.c:1010: Called: org.bluez.Profile1.NewConnection()
bluealsa: bluez.c:931: RFCOMM: HSP Audio Gateway configured for device 
74:EB:80:E2:D7:E7
bluealsa: ba-transport.c:592: State transition: 0 -> 2
bluealsa: io.c:2052: Created new IO thread: RFCOMM: HSP Audio Gateway
bluealsa: rfcomm.c:597: Starting loop: RFCOMM: HSP Audio Gateway
bluealsa: ba-transport.c:592: State transition: 0 -> 2
bluealsa: io.c:2052: Created new IO thread: HSP Audio Gateway
bluealsa: io.c:1565: Starting IO loop: HSP Audio Gateway

I have no new device in aplay -l nor arecord -l [as user][nor as root].

I tried calling my phone. The phone displays the bluetooth symbol when 
presenting the call. I pickup the call and there is not output sound in 
the phone (so it seems it channels it through bluetooth).

As suggested in README.md I tried capturing sound which yields an error :

$ arecord -D bluealsa capture.wav

ALSA lib bluealsa-pcm.c:718:(_snd_pcm_bluealsa_open) Couldn't get 
BlueALSA PCM: Rejected send message, 1 matched rules; 
type="method_call", sender=":1.200" (uid=1000 pid=24653 comm="arecord -D 
bluealsa capture.wav " label="unconfined") 
interface="org.bluealsa.Manager1" member="GetPCMs" error name="(unset)" 
requested_reply="0" destination="org.bluealsa" (uid=0 pid=24471 
comm="bluealsa " label="unconfined")
arecord: main:788: audio open error: No such device

Similarly, playing a sound (not relying on my ~/.asoundrc)

$ aplay -D bluealsa:SRV=org.bluealsa,DEV=74:EB:80:E2:D7:E7,PROFILE=a2dp 
/usr/share/sounds/sound-icons/trumpet-1.wav
ALSA lib bluealsa-pcm.c:718:(_snd_pcm_bluealsa_open) Couldn't get 
BlueALSA PCM: Rejected send message, 1 matched rules; 
type="method_call", sender=":1.202" (uid=1000 pid=24698 comm="aplay -D 
bluealsa:SRV=org.bluealsa,DEV=74:EB:80:E2" label="unconfined") 
interface="org.bluealsa.Manager1" member="GetPCMs" error name="(unset)" 
requested_reply="0" destination="org.bluealsa" (uid=0 pid=24471 
comm="bluealsa " label="unconfined")
aplay: main:788: audio open error: No such device

Please help me with these questions :

- Is this more an Alsa issue or a Bluez issue ?

- Where can I get help ? (depending on the latter)

- What is my next debug step ?

- What should I do to allow also connection for general A2DP audio, not 
just phone calls ?

Thank you !!

Marcel.

