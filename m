Return-Path: <SRS0=wTsk=PW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4334C43444
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 16:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4002087E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 16:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6Vckd7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfANQKP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:10:15 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:42081 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfANQKO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jan 2019 11:10:14 -0500
Received: by mail-oi1-f180.google.com with SMTP id w13so18259190oiw.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jan 2019 08:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7TSGbnUbnf7Nf7OqAIT1iyRsUQMOPOfIJB+Z0EhLKv0=;
        b=I6Vckd7sWuoOLhAjzFF8Rl+nbDzcYK6ysBPixy6oe5GtMmq5u6kWhuIxP299k3JKCZ
         VkByINElKeTo8HRwxerJdC1+A4p2wMxIFUIUpu5FrEfzU2b0FpCMH7gOwGSIG79PbHAj
         0sI6KzymYecOpK5wpE1h/gOdJn9B4j9tJLmsfv5fQRQzSdU1CWnHB6bpI1wi5QItOjGa
         BDBpROZi2Ve5l+4U+u6oliQ92CBzyrIY06lz/1KDYY7QOMztTXEWatBdzDrwvh7uHbKE
         yStn5ajV9kYHWKtl7MjTPIAa6j9yftL4M1BWb2vgXOgLvKb6G/YRiT7VFSjZfQ+wY31a
         8ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7TSGbnUbnf7Nf7OqAIT1iyRsUQMOPOfIJB+Z0EhLKv0=;
        b=cJomkw20aPdeyLxo90OVfB1g7F2Vqxwq1P1R89Gub2iBWvjk432FODqJH0ITqGCQIF
         KRatPT9gl1qYw7xtoNrOS2BctHBGOE2yGiD2ufMNyOjlj6nNep7joS8xADj2EM+fFzMX
         HEHQyBRsLVaX14qsgU0Fggz+Vr+EbBJiekmDhn8Se8yq+faKmsUTc7QC30Jx7CJs2fGb
         M3pcH/OshNeGr0LiPKKsXn4TEZ0oNwKCFyIQohZu0zH7WxBkUDrhfpEhqPdPAnewflbs
         5aPdAbql8XxUd/C6iSDqA6cvOrH9saHReKbajLNmPDdHi790P0ionGFp6KeqabuRfIqA
         G60g==
X-Gm-Message-State: AJcUukcOREb0E0GOSDoqNK61u0CIxNKPITq7FuauZDIr49GRT69myjSK
        2UF1zl4OVCpkhJIbh4mKk47Oi3eDnPNmC8YMqLVMXWzL
X-Google-Smtp-Source: ALg8bN4awog98vohkHcbKGhciI4el6D+jsIGChRyRVYUgsA2NIDK1qHii3+NQELYtYorkOnPIcYsByfeiYBvmm5rQuE=
X-Received: by 2002:a05:6808:97:: with SMTP id s23mr15499626oic.251.1547482213275;
 Mon, 14 Jan 2019 08:10:13 -0800 (PST)
MIME-Version: 1.0
References: <756897232.3954.1547478487424.JavaMail.zimbra@gangsto.cz> <1512791786.3988.1547479324453.JavaMail.zimbra@gangsto.cz>
In-Reply-To: <1512791786.3988.1547479324453.JavaMail.zimbra@gangsto.cz>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Jan 2019 13:10:00 -0300
Message-ID: <CABBYNZ+fYv1LundPmLqgdtn8fYLpxWnD9O2PJXe7=mOnO_c2TA@mail.gmail.com>
Subject: Re: Bash-completion for bluetoothctl
To:     =?UTF-8?Q?Audun_M=2E_Gangst=C3=B8?= <audun@gangsto.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Audun,

On Mon, Jan 14, 2019 at 12:24 PM Audun M. Gangst=C3=B8 <audun@gangsto.org> =
wrote:
>
> Hello,
>
> I've made a simple bash-completion script for bluetoothctl.
>
> I don't know what to do with it now, but I thought I'd share it in case s=
omeone were interested.
>
> Use it (or not) as you wish with no restrictions.

Id like that bt_shell learn a command to generate it like bluetoothctl
--tab-complete/-c [...], that way we don't have to keep updating the
script instead it shall just call using that option.

--=20
Luiz Augusto von Dentz
