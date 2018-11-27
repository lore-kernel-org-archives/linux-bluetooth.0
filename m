Return-Path: <SRS0=erFC=OG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD836C43441
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 09:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AE82086B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 09:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPEiA4vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AE82086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbeK0UVV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:21:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46650 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbeK0UVV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Nov 2018 15:21:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so19369259ljh.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Nov 2018 01:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sePNTgxfnE/kvrNZzZEa9dIMQvyR7N7DptAEbJ4feeE=;
        b=hPEiA4voPNzwRdr0jmkZ57Uhp5C2sWEaiOg2R1fq1z3Wr169f1ca0Wa8mWOC1bYKmV
         ZupdRWVz0r3vQR7SLg6jCxfwC/0t4ZYz+G763myqRjvXfWa8Ci0B948LK4vxyIsw0zPt
         DPazaiX0MfjS1Cj2iiS2b1WVhEQAAo8BRLNruLhltfRwZhwK0lOJaK3qKHpKa44BeGjD
         cqmpEnQ9DMDurUTQu9insEJCNAerkHgTHqjibOx2fChTDrbQz8Cu7nNt22rp9hLwsvCc
         DROFYRcRinVgBkFHgLZFsVJnanT5XY7H5QWIeFWm806Q3nkmYBjVqynSOwrJTeWIoBCw
         rRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sePNTgxfnE/kvrNZzZEa9dIMQvyR7N7DptAEbJ4feeE=;
        b=KO1RvGy0iNngpRUfKwIuvKYwIHVRtOymnndaQUoA9ZHprO/MAqJGRvthyB53vz0y8j
         WZAdZ8dvpROGaOUg3o62JzHEX2MzSel8rteASDCGc7X9tYi4ql79NBmS2HtTQrb6yEQI
         CT96INqmXTIppPPr4EN5NFYZoOnXyYw63gC6uPdl9hV4nw+EynQIfle9YI+k7J/acyxa
         CQvoz9B+UGQpHMDcjXpd49kKf9zIhVZaYxjeKqs2SYQSE4v0PAzMiqnIGbs4yKFM7l5+
         USXibFE7LPaBgwjCAnqFeo/VpwnCxe73qce4gdvcx1EFFZfQqy1TEkowEA710FMYaDTn
         d97A==
X-Gm-Message-State: AA+aEWbvjjuugCgk/wD/yfnonN3TSu6RTomahAD/EjDju9gNFJCcmZdk
        UMIqAeaDfJkdNUYiv40pfvpFOz5gPOE=
X-Google-Smtp-Source: AFSGD/WZlh28bYw4zlriCgvLa1xebXHN33bz8Gb0BbZaFZkKSpq31WX+7SY05WhpEpvkX6dYUFw1BQ==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr16786968ljo.10.1543310643402;
        Tue, 27 Nov 2018 01:24:03 -0800 (PST)
Received: from jhedberg-mac01.lan (85-76-78-76-nat.elisa-mobile.fi. [85.76.78.76])
        by smtp.gmail.com with ESMTPSA id f11sm491737lfi.12.2018.11.27.01.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 01:24:02 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 1/1 v2] Bluetooth: make the balance of judgement condition
 to fix a false report
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <1542245517-150977-1-git-send-email-zumeng.chen@gmail.com>
Date:   Tue, 27 Nov 2018 11:24:01 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <00BD5234-6645-4E40-9B3C-859C147EEB7C@gmail.com>
References: <5A23C871-B30F-44C4-898B-C138EFDB4893@holtmann.org>
 <1542245517-150977-1-git-send-email-zumeng.chen@gmail.com>
To:     Zumeng Chen <zumeng.chen@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,


> On 15 Nov 2018, at 3.31, Zumeng Chen <zumeng.chen@gmail.com> wrote:
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5217,7 +5217,8 @@ static bool hci_get_cmd_complete(struct hci_dev =
*hdev, u16 opcode,
> 		return true;
> 	}
>=20
> -	if (hdr->evt !=3D HCI_EV_CMD_COMPLETE) {
> +	if (!(hdr->evt =3D=3D HCI_EV_CMD_COMPLETE ||
> +	      hdr->evt =3D=3D HCI_EV_CMD_STATUS)) {
> 		bt_dev_err(hdev, "last event is not cmd complete =
(0x%2.2x)",
> 			   hdr->evt);
> 		return false;

This is not correct. The purpose of this function is to retrieve the =
command complete parameters, or the parameters of a specific event if =
the sending code indicated it (it didn=E2=80=99t in this case). Since =
the event was not command complete the right behaviour for this function =
is to fail, i.e. return false. The only issue here is the bt_dev_err, =
which should probably be downgraded to a BT_DBG. In fact, that=E2=80=99s =
what it used to be in the past - I=E2=80=99m not sure why it was changed =
to bt_dev_err.

Johan

