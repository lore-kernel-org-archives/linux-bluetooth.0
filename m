Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB2CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 13:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862C2610A0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 13:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhKAOBI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 10:01:08 -0400
Received: from tropek.jajcus.net ([31.179.132.94]:40600 "EHLO
        tropek.jajcus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbhKAOBH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 10:01:07 -0400
Received: from mietek.nigdzie (tropek.jajcus.net [31.179.132.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by tropek.jajcus.net (Postfix) with ESMTPSA id 6F36485060;
        Mon,  1 Nov 2021 14:50:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jajcus.net; s=mail;
        t=1635774608; bh=JakGnirxxXJc3Wr0U3rH8RtLjM8R+8p6a7xxNEmFCwQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ahG8dvTfVTKccVbbZcEwndmYP166uNLujSUA3dedjDeBOTtN3VRtKrA47n3vN01bR
         bsUMRX6F0VUPADKiLyN3d/XXoVk9gp2AKW3vX2yWJCkEKCi3weVNdPtS0WY6O6JWS5
         RhHdflSWokxI82Xy/03DKNY3XJXkHksetpR8stLSq1F+vkRjflKMFR9xjTqtGMy+/1
         THH9CMUPbjIqOJTVTzrYKsiv+0HVFiz3iAAlX2snWz7XyZjp2shQ/1glgLAuJNELMk
         R/UieZPe5qfKAuQ7MpzOJslvmTX2/IKY8dQmBaK8anLQq5nl8JTzdlV9aMSKYf41HM
         Ih3QtUEMRHRXA==
From:   Jacek Konieczny <jajcus@jajcus.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jacek Konieczny <jajcus@jajcus.net>
Subject: [PATCH BlueZ 0/1] Free ALSA seq resources in midi_device_remove()
Date:   Mon,  1 Nov 2021 14:49:17 +0100
Message-Id: <20211101134918.69565-1-jajcus@jajcus.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


I am having problem connecting via Bluetooth LE MID to my VOX Adio Air GT
guitar amplifier. I was not able to debug the connection problem yet,
but there was a bigger problem on hand: due to constant
connecting/disconnecting ALSA seq resources were leaking until
bluetoothd hung and ALSA backend crashed.

I have described a bit more in the github issue: https://github.com/bluez/bluez/issues/225

I was able to fix the leak with the following patch. I am not sure if
that is the right way to do this, though. As the relation between
midi_disconnect() and midi_device_remove() functions is not clear to me,
I have just copied some of the cleanup code from one to the other.


Jacek Konieczny (1):
  Free ALSA seq resources in midi_device_remove()

 profiles/midi/midi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.25.1

