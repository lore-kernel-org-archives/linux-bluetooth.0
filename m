Return-Path: <SRS0=KJgL=4R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C63C3F2D7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Feb 2020 08:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243D0246AE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Feb 2020 08:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+qA9Q1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgB2Iog (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Feb 2020 03:44:36 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56272 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgB2Iog (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Feb 2020 03:44:36 -0500
Received: by mail-pj1-f68.google.com with SMTP id a18so2264695pjs.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Feb 2020 00:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xunHAu3xzklGPCpHrrO1kdJMTwXyZ17nhyHbttB1Iho=;
        b=h+qA9Q1u5LMvUByQtN4CN546CSJVkOB2lVSXIGY9V82lyNXOXXTbwb8TIMhKf+P2ga
         EDA6n7Rey9qUSC1qKlNiBkOkWjQ3nhDEk/c4RSNjSr5wXbdv4wmZJHe/muGmllvjDqWU
         Us4ds9ckg4yLNLRZ0+pRh2IvKF8BpMNpZdRxnF7pVNBGQSAweln9YpTLGuH8s6HaVAfq
         Xf4GRkYXJtUdfBrHgCN8G6H2KoF6vyuO2Onsb7XO3WUAY4vnCAOgIpxl02K6zkaJYmQz
         VzpXleLrujLSBYiaL2rqEoo8aL7cDO7Km9OJKMG7RYBwUUL03Wjuz85RCzTXEwLgXtB7
         Zrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xunHAu3xzklGPCpHrrO1kdJMTwXyZ17nhyHbttB1Iho=;
        b=bGQ/zjY93MJW9dLFDbqHQUUFxkD8MCuNq63cM5P7h0w+MjgqbcLZhsaepr1c/cicU0
         3HfBdJskz1a8gnvV8gUbFX5kdfsJ5aIEjpYiuGkbMYfikTb/m0OxW2rKJwXYh6ol4+ef
         D8EH/cvE2V5TNUswTjvfMQtG2u1U1vuCkJ9oRQxA1Wy6NAxOViSD1pP5YOLmcdp7C/HJ
         P4+lT4gHB5/8Vv6GcjDo0usnsneAZ9b9RnIQ57YOE2xG91Ly0Z2fz5vnqg2p7+BAkrVe
         8lcHeNAGPlFsvRZWgwYCvHdGYWPtFtE59kySoPBydnRzGtekYEt+/ZV5SFbmgeS0646l
         Ct6g==
X-Gm-Message-State: APjAAAVlgu0KFUrxGCVNFgRx6AnxbjHfhuOC6JZwHDsSrf0+5bizcLvj
        /UORKesIPdPiH20c0QuXAmQ=
X-Google-Smtp-Source: APXvYqyGJHVZbwiYwTNprR7ZYTirBJKBvC14JGwWT+oJB+8juP3+tYWQCCI4mLuM4/4T/0ooUIOKVg==
X-Received: by 2002:a17:90a:2e86:: with SMTP id r6mr8984927pjd.104.1582965873597;
        Sat, 29 Feb 2020 00:44:33 -0800 (PST)
Received: from olalykin-mobl.ccr.corp.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id d4sm4710173pjg.19.2020.02.29.00.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Feb 2020 00:44:32 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v1] bluetooth: guard against controllers sending zero'd
 events
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <788439D3-E0CC-4CBA-99C2-0B9C3703B23D@holtmann.org>
Date:   Sat, 29 Feb 2020 10:44:27 +0200
Cc:     Alain Michaud <alainm@chromium.org>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C59D3CDE-0EA8-4839-A34E-5ADA1BDE4949@gmail.com>
References: <20200228205146.161229-1-alainm@chromium.org>
 <788439D3-E0CC-4CBA-99C2-0B9C3703B23D@holtmann.org>
To:     Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On 29. Feb 2020, at 9.14, Marcel Holtmann <marcel@holtmann.org> wrote:
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -5868,7 +5868,8 @@ void hci_event_packet(struct hci_dev *hdev, =
struct sk_buff *skb)
>> 	u8 status =3D 0, event =3D hdr->evt, req_evt =3D 0;
>> 	u16 opcode =3D HCI_OP_NOP;
>>=20
>> -	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->hci.req_event =3D=3D =
event) {
>> +	if (hdev->sent_cmd && event &&
>> +	    bt_cb(hdev->sent_cmd)->hci.req_event =3D=3D event) {
>=20
> Why are you bothering to check for event here. Do we have requests set =
with hci_req.event =3D=3D 0?

If I remember right, most requests are like that. req.event is only used =
then the request completes in something else than a command =
complete/status.

Johan=
