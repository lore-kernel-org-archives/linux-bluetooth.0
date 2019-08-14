Return-Path: <SRS0=WtLI=WK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C62C0650F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 05:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EAD2064A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 05:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmuq1/yP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725265AbfHNFHV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Aug 2019 01:07:21 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:44777 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725262AbfHNFHU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Aug 2019 01:07:20 -0400
Received: by mail-yw1-f44.google.com with SMTP id l79so40560551ywe.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2019 22:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=YiJwIGqfDBfrquMkM+hGQkSZxoxpZOPRHr2FMtF3rzY=;
        b=Dmuq1/yPlzHzHM417U9U6V0GAIuNNWr+fcSy2ITJhfPm7tXLcggxej8O25iPVT4lzU
         yoYZcoIHnFBC/dhIqk/WuiT4JobgukaXnwn+t+d+/IOYo/qLZdpC88Zw1YFfC5Ke7QN5
         rzckgSizcfov+aLBn7XtGGwnvYsuYNkyRKclN/1zMpbxZAheMCCVF923StnM6VZK9czo
         ETNdb0cDW5ezx7Y4Zr1OV6KavQFHHAGW3/tPxqYYTfMEMtf59XB/VdLHDklQZx4WZtMl
         A/zPq0UpksErsQcJYpxoS4wR/VfzrjVKYtfArMcGVP7L2JaUCwwjgyjp8T1btfHqx4Jm
         SF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=YiJwIGqfDBfrquMkM+hGQkSZxoxpZOPRHr2FMtF3rzY=;
        b=ly1nnwgfQJeDNcWJ2FuSBRF30TwVgmFZKHts4NEt+EbDfQfTdR06JOJyztkbaOoQ4a
         4HAN1h2RP299sy84fXDh4rmz5HXTgRDtjosToNGXbPK66dmtWjdAzu+irBC/uZf9cTby
         uQ2Ka3hAM5tNL8fCB8hasv5ld7xlZJ+nc5sxPxfWQ4KlJiFWC3fY8HWKxwEtyG7XCDBs
         Z8QswWR57dJfRSFw/NcmBXU+KU84EwnSE9RZsUe08Rf70A18v0tSMOYQyGETTDPtcvpn
         xlYKNzWAxUU418ZmGD0FGTfqFaF8Eu8k21ltBW77gdARnX9TDQWwGDPIu1dGBLmklK8s
         HdSQ==
X-Gm-Message-State: APjAAAWn7GUaJu+9T4HlOKuUou9KFS0nk2RV8Zk1lXQEwhISSlHvbOrX
        NISVY42BRzAc5LBayQ2b6Qs/Lgu1OwvTkRU2ZQBF5nWO
X-Google-Smtp-Source: APXvYqyH7GbZTRGKV9taf2kEiR3csSzKCYQuQaNQ+Dc9CdTgu3v2WfM9JmuWQUnq4HE0ccZUaNHKixoCHei9AdJfM40=
X-Received: by 2002:a81:6145:: with SMTP id v66mr10480161ywb.136.1565759239711;
 Tue, 13 Aug 2019 22:07:19 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Wed, 14 Aug 2019 07:07:08 +0200
Message-ID: <CACna6ryOE0E-itqkErj3LF8MLU0QtVKmASejpY8c22UROm8Z9g@mail.gmail.com>
Subject: Missing error handling in the RegisterAdvertisement
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I noticed that RegisterAdvertisement calls may succeed while internally fai=
ling.

Example of *logged* error:
daemon.err bluetoothd[1104]: Failed to add advertisement: Busy (0x0a)
(I'm still debugging that).

Forward-trace to consider:
register_advertisement()
client_create()
client_proxy_added()
parse_advertisement()
add_adv_callback()
add_client_complete()

Explanation:
add_client_complete() may fail and:
1) It doesn't propagate error up
2) Its reply sent using g_dbus_send_message doesn't reach caller

Could someone look at this problem and see if/how it can be fixed,
please? I don't have required BlueZ knowledge & experience to fix
this.

--=20
Rafa=C5=82
