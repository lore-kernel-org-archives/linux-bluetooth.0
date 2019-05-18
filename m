Return-Path: <SRS0=UGHn=TS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D8DC04AAF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 May 2019 18:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977DA20872
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 May 2019 18:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL1yF9Mv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfERSIe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 May 2019 14:08:34 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:43646 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfERSId (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 May 2019 14:08:33 -0400
Received: by mail-pf1-f175.google.com with SMTP id c6so5201259pfa.10
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 May 2019 11:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HD35hMh/PWO3VCJL9dkQrTtSq7LnaqLwyRHNSJD9z2o=;
        b=VL1yF9Mv0HtTqhm1BRor7ZzDZM4nUlu61m8XIYlGNgRHNCqa9XlqdrJjImwtn6lPYx
         F6Ad2LLsg5PNYSFh7QirqyI1TPZ/P9o5UKq7qw8s3Z291moBxVHrPmwz1w4eJDjVvUmL
         CCrmZdfDYMuSdSxSE785yli5NT5J/jYsk64uIpXtXTHiEEUGOQrOS3Oxq4mdFfqZMmdj
         KlGDAASWnYUWcjmQKguojha51qrz8lIpyOteS5DoLsyHZZxBpo3iCj/Jq3LZ4ZIVbsgA
         E/NZp2BnedquZ4J7xQ/w0B4hqt8hLIAHMC/bvLvkiaUdJ3QPH+OysPNT2JoAqL0V5RDV
         8lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HD35hMh/PWO3VCJL9dkQrTtSq7LnaqLwyRHNSJD9z2o=;
        b=HgJ+yeiaDmqv6n+0rnIypvtqWN6VEgPc1cVgPHkP/knW1+FCzZTlcRbgTI5r5Eh9LM
         79TYKdjvthusRaDRbYPAy1lCPRP+ifaLeagco504+Y5kjmLo4QTRNdAUfzv/34GkEkFb
         JupYH81wczbvyDPuxv8DJMXFMjBPO2iYES9qHN60pTFGu/KPDj0IBSt3S3wux6TA0tSY
         H6g6EnVoJrSyyh1khwdHvQBBaiHIwN8Hcbvl7O84YnC/9QLbhIL8SUaoUFFUFB2b/Xi6
         5u5BxtKqqZ4cOWos3BiXdYwF8JRhXVI4wjvVGGCNcgPJl+/sDBiuZkVWLM/P9sCQI7/i
         USOw==
X-Gm-Message-State: APjAAAV4KmlYevN6hxvrG9OqcuhoUQG8RxyFdPrQ3KGfcicY4ufPs8fM
        cTbtE5Dh1ceCKVpIn/JrhZE=
X-Google-Smtp-Source: APXvYqw6f+14MpzSMeApifjtUVNs122w6nVqrVnhrxV5V37ZapPu/OhSu6V4Bdpr6Tc/jnNzF1jgTA==
X-Received: by 2002:a63:6fce:: with SMTP id k197mr65769191pgc.140.1558202912902;
        Sat, 18 May 2019 11:08:32 -0700 (PDT)
Received: from canella-mobl.ger.corp.intel.com ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id 85sm16852466pgb.52.2019.05.18.11.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 11:08:32 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: After kernel update: connect/disconnect forever while attempting
 to auto-reconnect
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <CABBYNZKbWAaO9dTnHcV7vCYodRQYEZT8=PBws+=_iip-7Njo2w@mail.gmail.com>
Date:   Sat, 18 May 2019 21:08:28 +0300
Cc:     Alexandre Pereira Nunes <alexandre.nunes@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0FBE6EB8-B42A-4D24-ACAB-80AB47316B97@gmail.com>
References: <CAELgYhdqAxTGA98RsUEOSEA5WfhxGaVn7C_DegAfU13sHx817A@mail.gmail.com>
 <CANxMttCx4uFeVpM9EsYmfg9VoXG45ihpzw=phJcx0Uy53cGD_A@mail.gmail.com>
 <CABBYNZLGgUL6W=-v+stoaukpN5kvt1AHFBQ_vEdh=sqU9JO0LQ@mail.gmail.com>
 <CAELgYhcCBAUr6oQxTnmjBjQfkc8JeTbkXHea64PN+7cWQSqQ=Q@mail.gmail.com>
 <CANxMttCqEYDZOwTriLqC-q39+JhEJ9KCOsPhRqkjZwE1h-64Gg@mail.gmail.com>
 <CABBYNZKbWAaO9dTnHcV7vCYodRQYEZT8=PBws+=_iip-7Njo2w@mail.gmail.com>
To:     Luiz Von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 18 May 2019, at 19.30, Luiz Augusto von Dentz <luiz.dentz@gmail.com> =
wrote:
> The problem seems to be here:
>=20
> < ACL Data TX: Handle 512 flags 0x00 dlen 16                #87 [hci0] =
9.952984
>      L2CAP: Connection Response (0x03) ident 1 len 8
>        Destination CID: 0
>        Source CID: 65
>        Result: Connection refused - security block (0x0003)
>        Status: No further information available (0x0000)
>=20
> Ruling out encryption since HID don't require it:

When both devices support SSP, encryption is required for any non-SDP =
PSM. The kernel enforces this regardless of what kind of options were =
set for the socket.

Johan=
