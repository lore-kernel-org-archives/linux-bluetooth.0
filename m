Return-Path: <SRS0=erFC=OG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C20C43441
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 09:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBB520989
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 09:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL7j72vW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBB520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbeK0UcJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:32:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38654 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbeK0UcJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Nov 2018 15:32:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so19429766lja.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Nov 2018 01:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j5KPyIQeaHkNhwyA/qDcB7JBs7UNCp0EAgyLNEV9mq0=;
        b=BL7j72vWI20401M1yf6mTejr9vKunBLncB0g/cHmxUGkDTPXv7F+L3/cBPkr08Fqhy
         abgWFLJzVcJTgazk8qGwrJBKjGDH5JB6Bwr9A7nFwsQ4sfIPpnV3k10xwx6ShQRnGSHM
         f4DTbZsyAoALS7PItmRwhrvZv4ccJDKatQbmIWRU8sUSpx4ozegUlJBgxePJ7kC9fVES
         3N8m3SSXqwf2TEzS+YonjkmgJ3osUFyV8hs/CRhRtPkglf6TnR/tK6fubaXR6dFz64dC
         fekX3btV/+t3qfb4WR3uwMnHE/3JiyoWA5ZptGOtt1d10rJigfFy2EpHlEOH6auFdle1
         tcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j5KPyIQeaHkNhwyA/qDcB7JBs7UNCp0EAgyLNEV9mq0=;
        b=tKTriMMjUJIZRSPpXQK+H/WvEtthwKCtlssxR3Zppmlkmhg55AsnHfPE8S9JIWHJ5h
         QQvG9zuPaPx+9aLBEPppx2O7OTDmY4W6Imd3MZBJzex/fNbeGafSnisYeqXcUex0Leu9
         WZEdjZC+PU2xrMeSiNn5eY7nDw6HE39qbCUvsS1v+ZtqLmj6NXCzL3lZWRCZ+4SPU/sZ
         qUUro0ZUIpPFTSEdIanv82e/xiD8tm1hUQkW9sWsIkQeEXAs8lwtXvtKLP90oxTuHOUL
         4BnarLCKRymv9zfy6NvBp4TqcrdF/XT5++zkYhArdepigKT5AXXYzm33LkZKSXYYgQOo
         8R9A==
X-Gm-Message-State: AA+aEWYki2vRIM4p/FKYgf58rL5D9T6dKy2QOY+mJPV6ticZeUXqJ7XD
        Udf9ULzBVuM3ThrhxzuZ/+g=
X-Google-Smtp-Source: AFSGD/UYRDM50O6ztnYgTHm89p/DdwOM4IUOJcrtI6bIopATP9k49/ygcHko05csEHonLs1Jgcivpg==
X-Received: by 2002:a2e:449c:: with SMTP id b28-v6mr18829076ljf.47.1543311289601;
        Tue, 27 Nov 2018 01:34:49 -0800 (PST)
Received: from jhedberg-mac01.lan (85-76-78-76-nat.elisa-mobile.fi. [85.76.78.76])
        by smtp.gmail.com with ESMTPSA id g17sm488110lfg.78.2018.11.27.01.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 01:34:48 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 1/1 v2] Bluetooth: make the balance of judgement condition
 to fix a false report
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <00BD5234-6645-4E40-9B3C-859C147EEB7C@gmail.com>
Date:   Tue, 27 Nov 2018 11:34:47 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D63F92F-1BA5-415D-AED4-A38FB2E29C00@gmail.com>
References: <5A23C871-B30F-44C4-898B-C138EFDB4893@holtmann.org>
 <1542245517-150977-1-git-send-email-zumeng.chen@gmail.com>
 <00BD5234-6645-4E40-9B3C-859C147EEB7C@gmail.com>
To:     Zumeng Chen <zumeng.chen@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 27 Nov 2018, at 11.24, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> On 15 Nov 2018, at 3.31, Zumeng Chen <zumeng.chen@gmail.com> wrote:
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -5217,7 +5217,8 @@ static bool hci_get_cmd_complete(struct hci_dev =
*hdev, u16 opcode,
>> 		return true;
>> 	}
>>=20
>> -	if (hdr->evt !=3D HCI_EV_CMD_COMPLETE) {
>> +	if (!(hdr->evt =3D=3D HCI_EV_CMD_COMPLETE ||
>> +	      hdr->evt =3D=3D HCI_EV_CMD_STATUS)) {
>> 		bt_dev_err(hdev, "last event is not cmd complete =
(0x%2.2x)",
>> 			   hdr->evt);
>> 		return false;
>=20
> This is not correct. The purpose of this function is to retrieve the =
command complete parameters, or the parameters of a specific event if =
the sending code indicated it (it didn=E2=80=99t in this case). Since =
the event was not command complete the right behaviour for this function =
is to fail, i.e. return false. The only issue here is the bt_dev_err, =
which should probably be downgraded to a BT_DBG. In fact, that=E2=80=99s =
what it used to be in the past - I=E2=80=99m not sure why it was changed =
to bt_dev_err.

The one improvement I=E2=80=99d make however, is to silently return from =
the function in case of a Command Status event, since that just means =
that the request is complete, however there are no extra parameters to =
be retrieved. I=E2=80=99ll be sending a patch for that in a moment.

Johan

