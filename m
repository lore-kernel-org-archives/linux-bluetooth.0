Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8002C2D0E9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 09:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806AD2072E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 09:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="rtt1Fb3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgC3J1Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:27:25 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:41137 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgC3J1Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 05:27:24 -0400
Received: by mail-vs1-f46.google.com with SMTP id a63so10526211vsa.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=g+MPuHyk7KP37PjrXpiyFYSQ8eUGQQaksY9hqdrrflE=;
        b=rtt1Fb3AOPM+yzZ3sO0hOVb3tY2IZQW0hp8EfyidQSjOrbKNKuNTIqfw+bVptdNY7h
         StAI+ND0LjIuwbF6wa1srr7vN5obmio2LGg7YDlBi/nPrIhSy418KWvi/um2ZIRwRHf3
         TgxVzaBclkcERRztnRCPd49qewwp4ond3mBu+TAHo5c+lRa9uak1bzjGd1XoBqEnxfiP
         gW591QeTnyF9hTXr+4XXQ3Kv2MKss7nK/F5FRyhB92WUeTf7JLBJFvuxCxgOUeBa+yq9
         McaRDTA/mkxTTYkK05w8GNdO/t8fw7gF8zuXZQZqj1exZnymGu5+UySOVngCQG1qX16c
         N0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=g+MPuHyk7KP37PjrXpiyFYSQ8eUGQQaksY9hqdrrflE=;
        b=MOaQQ80FllqzoYhqoKNGkYUjqL0bzKK+we1QoNlPpmIUjxFawocxTV/7I6qF6caK6o
         Ij1uXfGsPJLnMrAwO6Wk8w/HMcgByI700nx7pdjCXblZDy3XrjUw+bYw06I9HYD1mlQO
         gw6JfX8yrmAkdZ6shykIYjrSWD61pVf74sFrCIY+MkIMvCgbHqN3/z4il/M7rI6R0t6x
         cf+wMkQC2dbMcbQJfh/i/Lcd7lyTwUty9NJcSXvdw6VlYvb+U7g305oE6v34Y6AAXMzs
         kNa8poWpxPMi+KhFz+zVdX7QBho4UbhIrC6Lvy27iwWMf3znAaX7VMxYUyPGKXt3ZqZZ
         W4Tg==
X-Gm-Message-State: AGi0PuaIyGACFCOru7gMyGmsDZMeA0lWJ/B0+UNYONstxOUwm1i19x8p
        zb24/qXb8ifOn8oeeSJq4X3spTlHQp5qK79cj1yRh8U1fnNbww==
X-Google-Smtp-Source: APiQypK/3I3AMPc3d9xmmZwH/BnLegYF1B7nPNK7Wpy9F+Y7/Id3kXPO3P7oEkYcOz7I73TfAxWy4cGgVJ3lBjdS6a4=
X-Received: by 2002:a67:f34b:: with SMTP id p11mr7226980vsm.14.1585560442393;
 Mon, 30 Mar 2020 02:27:22 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?UmFmYcWCIEdhamRh?= <rafal.gajda@silvair.com>
Date:   Mon, 30 Mar 2020 11:27:11 +0200
Message-ID: <CAFcXi1wcxdckvPhs_Rf-4dB4Ws6wvqiuMjXfc_zP2u+OK9ToPw@mail.gmail.com>
Subject: Incorrect IV update behavior
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

It looks like there is a bug in daemon IV update procedure handling.

When node with iv=3Dn and ivu=3DFalse receives beacon it should:
a. beacon with IV=3Dn+1, IVU=3DTrue - set own IVU=3DTrue, send with IV=3Dn,
don't reset sequence
b. beacon with IV=3Dn+1, IVU=3DFalse - set own IV=3Dn+1, send with IV=3Dn+1
and reset sequence

Currently, when daemon receives beacon with IV=3Dn+1, IVU=3DFalse it will
start sending messages with new IV and set sequence to 0.
However if daemon receives another beacon with IV=3Dn+1, IVU=3DTrue it
will go back to sending messages with old IV=3Dn (IVU will be set to
True).
Because sequence number has been reset those messages will be dropped
by replay protection and node will lose communication.

Once IV is updated daemon should not go back to using the old value.
--=20
Rafa=C5=82 Gajda

Silvair Sp. z o.o.
