Return-Path: <SRS0=E3AB=YU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDD9CA9EAF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Oct 2019 19:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7990B20717
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Oct 2019 19:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfJ0TRX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Oct 2019 15:17:23 -0400
Received: from ec2-52-19-174-175.eu-west-1.compute.amazonaws.com ([52.19.174.175]:39754
        "EHLO rdmp.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfJ0TRX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Oct 2019 15:17:23 -0400
X-Greylist: delayed 966 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Oct 2019 15:17:22 EDT
Received: from [127.0.0.1] (helo=localhost)
        by rdmp.org with esmtp (Exim 4.92)
        (envelope-from <bluez-2hxy5d@rdmp.org>)
        id 1iOnmt-0001wT-Bb
        for linux-bluetooth@vger.kernel.org; Sun, 27 Oct 2019 19:01:15 +0000
Message-ID: <37e50a80d823b267508893db9573a1903c87d0c6.camel@rdmp.org>
Subject: Audio out to phone
From:   Dale Mellor <bluez-2hxy5d@rdmp.org>
To:     linux-bluetooth@vger.kernel.org
Date:   Sun, 27 Oct 2019 19:01:15 +0000
Organization: DM Bespoke Computer Solutions Ltd
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Does anybody know of any tricks needed to get audio to go out through
an ongoing phone call?  Everything in my setup looks good, with all the
right devices and settings in bluetoothctl, pavucontrol (including
correct headset/handsfree profiles) and I can hear the caller, but they
are only getting silence from my end.  I am using the pulseaudio
asynchronous API, which works well enough playing through speakers but
I can't get sound through the telephone (an Android device, which works
perfectly well with my car's headset).

bluez5: 5.51
ofono:  1.30
pulseaudio: 13.0
debian: 10 (stable)
linux: 5.3.0

I'm quite desperate to get this sorted, so if it is an unsolved problem
perhaps some pointers to where the issue might be will help me to help
you debug the situation?  As you see from the updatedness of the
packages, I have built them all from source and can dig if necessary.

Thanks in advance for any help,
Dale


