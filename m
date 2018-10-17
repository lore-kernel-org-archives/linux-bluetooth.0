Return-Path: <SRS0=K0Cw=M5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1B6ECDE3B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Oct 2018 22:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B7521473
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Oct 2018 22:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFkj4WTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B7521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeJRGBx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:01:53 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:35409 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJRGBx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Oct 2018 02:01:53 -0400
Received: by mail-it1-f177.google.com with SMTP id p64-v6so4565122itp.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Oct 2018 15:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CRKkAvdbvnAdmiye4hdOS3ngnSAq4/0HmmX21ejzUds=;
        b=fFkj4WTgVMH468EOiE9o2PUBXsCXkR8bK9OqNJkQyJk1CFRdEhCbX1iJMgErGpD507
         tIfnY7VsfXVc75EU1+UfYEUdBdid+WJeyGHb6wihu1Ye2dgXMSQZlDIjkhO4gHRpgu8u
         hwmK7ZelujZBYpX1H+V3p/cLqup1d4R2X5t2Ez0eXvEmV+bcGzIV+BGtiLIm8Gc4T+AW
         kcumbxgOd/XraR4w4+MaJvN5H1aw98MlLYwDqrycjiWjcI1RF4aOeIfs1vU7rLW80rC+
         kx1LHNFBHtP9ShnLf8ezkbumwiYuYPZmvwTn02zqG49GFjG8hlDmmaEiiOtmmiEtZGyi
         /bkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CRKkAvdbvnAdmiye4hdOS3ngnSAq4/0HmmX21ejzUds=;
        b=ietnaEnndOQ198b0w0PgL8W8YoNIQmWshi8Mr5asCj0oCbbXT6oxlsQSyR6sn7aIc7
         EJ0TNuPrE+fRm9XX0OQH5BKQ9Rg4u7n+Frl0dSVM84Q1VsALj968vSfL9xaMAK04aUOb
         zgAgUaC+4S/gH/IkL5IXdzg0FuLntOjO5804CKRQeWkQdU/20AN04QDX6ik9tltUQMea
         zy3UJ5ltU7TU1kSyDeFRSTk3POQa8D9AvKJd396P/1sDBPvSIFlXjq34ao9JfsL0sCTI
         rIpPzX1Lf+esOz+ijNa1vcc6rRihJb+sYsOpTWMdofrvTYjb6BJBZotYFq6I2UM7dUFc
         LhPQ==
X-Gm-Message-State: ABuFfojXJOBOZGXJ4O9rnOXMRQ3V5iv21ZmgjhGRG3W+WDVQle3F8to9
        OGqaIFZzPcZpHJHTID+3VWJF3yVjj80I/yKQHGSyfw==
X-Google-Smtp-Source: ACcGV63yKRWAV/7ge2Lwfha965WPtpY/W6m0ZOvdMIL4kHwbae0Zp2QogaFjyiTiDZvinAd9t4KWEKNFRBnAUoQ6ckE=
X-Received: by 2002:a24:554c:: with SMTP id e73-v6mr2983077itb.157.1539813851421;
 Wed, 17 Oct 2018 15:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAAu3APZEbVricfhZr5jSuAc8wpp31=dxYA305qfG5T_2v=qXGQ@mail.gmail.com>
In-Reply-To: <CAAu3APZEbVricfhZr5jSuAc8wpp31=dxYA305qfG5T_2v=qXGQ@mail.gmail.com>
From:   Barry Byford <31baz66@gmail.com>
Date:   Wed, 17 Oct 2018 23:04:00 +0100
Message-ID: <CAAu3APYGPE9Wtfn3aX1qDBk+E0YpXFBRa_WWRwvhhJrLabo9Eg@mail.gmail.com>
Subject: Register HID Profile
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I am still experiencing difficulties registering a profile and getting
BlueZ to call the NewConnection method when a connection attempt is
made to it.
When I try to connect from another computer, it connects briefly
before disconnecting again.

I am starting the server with the input plugin removed using:
sudo /usr/lib/bluetooth/bluetoothd -P input

A btmon log of the session is available at:
https://drive.google.com/uc?authuser=0&id=1CgPcEtj1g3Um-1qBuQ8hEImKR28bVmnx&export=download

I have looked through the log but there is nothing in there that I am
understanding to be an indicator of the issue.

I have had some success if I set up the sockets to listen for
connections with the code below. However I still don't get the
NewConnection method called in the profile I have setup.

Any guidance would be greatly appreciated.

Thanks,
Barry


        print('Waiting for connections')
        self.scontrol = socket.socket(socket.AF_BLUETOOTH,
                                      socket.SOCK_SEQPACKET,
                                      socket.BTPROTO_L2CAP)
        self.scontrol.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.sinterrupt = socket.socket(socket.AF_BLUETOOTH,
                                        socket.SOCK_SEQPACKET,
                                        socket.BTPROTO_L2CAP)
        self.sinterrupt.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        # bind these sockets to a port
        self.scontrol.bind((self.address, self.P_CTRL))
        self.sinterrupt.bind((self.address, self.P_INTR ))

        # Start listening on the server sockets
        self.scontrol.listen(1)  # Limit of 1 connection
        self.sinterrupt.listen(1)

        self.ccontrol, cinfo = self.scontrol.accept()
        print('Got a connection on the control channel from ' + cinfo[0])

        self.cinterrupt, cinfo = self.sinterrupt.accept()
        print('Got a connection on the interrupt channel from ' + cinfo[0])
