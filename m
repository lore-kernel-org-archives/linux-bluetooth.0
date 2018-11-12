Return-Path: <SRS0=dtqE=NX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82AFC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 03:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C450214E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 03:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU5Bpg06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C450214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbeKLNFc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:05:32 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40397 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbeKLNFb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Nov 2018 08:05:31 -0500
Received: by mail-ot1-f53.google.com with SMTP id s5so6709651oth.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Nov 2018 19:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RCew5d8pOtdSBYGyRjtpL6RYEotpoEv8tSc8NKW371c=;
        b=nU5Bpg06Fwxlq/sBG++Dt1bPuUT2Eem12hYNzs9+9T2zXxsyj6wH+R2AhSPfJR6529
         koa55IR6CUryTJIh2Itb4CiDsX9Zlm4KO1Ywo/sHrY+aBehgnH+8yJo+4sQKTptVvl01
         VnqAkGXiEFqMdjNxjEfDqtkdRwsaGum2Yhx0X6kFyNFjj47lJwospZNBVr2RdmTg6pAj
         Eo44JpnsFNv+H46AlTsDYnmBy1AL3p4YKR1gtuz1Z27XQmMR68gi9bBFzqgcEzqF3dsW
         mEBz+H/1GaMH/nhngA4U5zmeWNEsK9NqfQe6xhsxVbV6kmEEylFkA4iXaAWmWQO6f/jy
         dDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RCew5d8pOtdSBYGyRjtpL6RYEotpoEv8tSc8NKW371c=;
        b=iz7uj/cUtCq6fDeQz6U5dV5H8WsHorJmQMFA7QnUrCmS5k1M5/X4gTB3bto8KtsN9X
         VPfjPDzzhtJcoqIlMxtBsgwlMwO2sxos7YdciYGXS35dXSUBDzlhBQ+/lu3EjY+BhAIq
         hikSC2mQPMYd/O+S+JwcS57SDaACP8LqyhqEqaM4WbobUN70qKGaCH3vEgamRLMyWzsq
         7KecIMA5VArBK4UsbsbaDBp+srp4GDdzkOxuFwsfyrVYIl/+3AG8EPXqi49XYJn4eAaB
         LopazZAqwHAC0rWRN8tp54Y2LfyPH1AgbKMVhfTHlXMY1vfarBV1mV3nwWXY4sKrR8f+
         wJuQ==
X-Gm-Message-State: AGRZ1gLMeuA8CSWTlc3ZsRthTKAMbVqtA2A4i4dk3MA3Z4iIXgI8KIsU
        ZROWOcc8bsHE0uvEBhXMqQQsstfvteqayDAXaVUkzZX9
X-Google-Smtp-Source: AJdET5cev7v3hHUR+rCngu/dSi5nvTI8ThjJYZVYPP7oqIC22kaulewKWx7qsiiO1byUfToSImk2HRulnI9pxeZVuUY=
X-Received: by 2002:a9d:2831:: with SMTP id m46mr10491286otb.291.1541992463970;
 Sun, 11 Nov 2018 19:14:23 -0800 (PST)
MIME-Version: 1.0
From:   Dylan Taft <dylanetaft@gmail.com>
Date:   Sun, 11 Nov 2018 22:14:12 -0500
Message-ID: <CAKz1w-==yXd4EL39ULE6bcYU3fTpZB9D0EqdgRhq4L38kVzYEg@mail.gmail.com>
Subject: Odd l2cap_sock.c Code?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/bluetooth/l2cap_sock.c

Per the bluetooth core spec
https://www.bluetooth.com/specifications/bluetooth-core-specification
Page 2184, section 3.4.2.1 Exchange MTU Request, PDUs may be sent to
negotiate MTU size upon connection

Line 415 in l2cap_sock.c, if address types being used are Bluetooth 2 types,
it looks like setsockopt(xx, SOL_L2CAP, L2CAP_OPTIONS, xx, xx) is
INTENDED to fail with EINVAL errno, but for Bluetooth 2.x connections
it would work fine.

Line 920 - setsockopt(xx,SOL_BLUETOOTH,BT_RCVMTU,xx,xx) looks to be
INTENDED to fail if a connection is already established on the socket

The legacy kernel code goes and sets imtu and omtu without any other code.

Per the bluetooth spec - inbound and outbound MTU should be set to the
minimum MTU between the devices during this ATT PDU handshake.

As it stands right now, it looks like the kernel would require
disconnecting\reconnecting the socket.

I bet it could be changed to mirror the old setsockopt SOL_L2CAP code,
so BT2 behaves like BT4+ - but it's not my code and I'm not a BT guru
so I'd hate to just submit a patch for it.

Is this all intentional?

It seems like both imtu and omtu should be allowed to be set in the
new code, like the legacy code.

Thanks!
Dylan
