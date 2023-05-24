Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F5AC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 May 2023 19:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjEXTLZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 May 2023 15:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEXTLY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 May 2023 15:11:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3EB12B
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 12:11:23 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2af2db78b38so16631081fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 12:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684955481; x=1687547481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kHhy/KjkX7HKvd1sjw8RkovkQ8NO20aP5vVF4eORGY=;
        b=WpkE4JpD9r43JYiObEzzDslGHXiOriDbDDa9icWNWxrwWA8OZKulijsrpgxdDh0rlv
         /U+O1HyigAOP+mkvmxF2t7lAqNbxmnIvZvC7JTT62z8bL4QzsoWWCG8wydXWoPXlO0fZ
         BBuQBdDSahCRfobYJeLWwShie2U/7Kiz51Ob0O24Bo+Z0owS32VB+vhXgoLSKZO/RNFI
         wK5aWkwdM+Q6qMPceYwffkPpqRiYN8kberkWijFlUfx/2HZKTSvJkzvTKsJ5ggMDX+7L
         KvQ7q3qUaM6EaM/N3X+q2yRaBSCCRwGfCif6TO6R3RWHvDgq7/l5PxY4QLmbINihWXDs
         QNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684955481; x=1687547481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kHhy/KjkX7HKvd1sjw8RkovkQ8NO20aP5vVF4eORGY=;
        b=k7EsfLXun+xrDiYI8Iooh/HEOGDlgCbixv5j56BejwIU8GRzM5AcNXtnk84dt10Ss/
         GK9doOBXvCSfkpz6u9T7OWvPa0jxV5tL4ZllDflB+7RRWbpX6+AmwqI9GtKKU7F0jjPe
         UrLc18+P+gDAqqSA6VpacEVxYgr9+OIWVkzH0Cztj1hYfoA3NnoN+4OuN4ZfIG0vMTLl
         q5M5+8VAvPbG+itWVYZ5rdq6DTmcP7jm9Xcd20WiXgZqd5+1daDGBon9dRnmIFAsDi3Z
         Cpwb7sbhjEzNyhoSBPRJiwApCX0qU4nW5oB66wtbmyptJkrB0JkGznQ5BkGigdDQyDqc
         1Yew==
X-Gm-Message-State: AC+VfDzAtDIYZkYiTuLHJnq58meG2ehjOH/PuPmqMXzZ2DCmgTm0TDL/
        cNTojIo3uOKiMIIEi7EzpS5kI62XTPewuCaw8JQ=
X-Google-Smtp-Source: ACHHUZ4iaSNWRTSCmdaKLhldmBNJ0qspLPNngAUB8uTQn26rXkX62c5h2kmGzsLiwZiYLwXL2EpA9nP0Rx0tHH4bauc=
X-Received: by 2002:a2e:7004:0:b0:2a7:974d:a461 with SMTP id
 l4-20020a2e7004000000b002a7974da461mr216275ljc.34.1684955480871; Wed, 24 May
 2023 12:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <e52365b8-f5ee-48d9-ba86-34c4b350c8e3@kili.mountain> <744fd69a-c5a3-4e0f-8c47-33096a1cd374@kili.mountain>
In-Reply-To: <744fd69a-c5a3-4e0f-8c47-33096a1cd374@kili.mountain>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 24 May 2023 12:11:08 -0700
Message-ID: <CABBYNZJ2WSHKiQ0ZtqfNZdxaPY+FVO1=gDeNPwSz2zcKWX6ZMA@mail.gmail.com>
Subject: Re: [bug report] Bluetooth: Add initial implementation of BIS connections
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

On Tue, May 23, 2023 at 11:52=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Wed, May 24, 2023 at 09:38:34AM +0300, Dan Carpenter wrote:
> > Hello Luiz Augusto von Dentz,
> >
> > The patch eca0ae4aea66: "Bluetooth: Add initial implementation of BIS
> > connections" from Mar 9, 2022, leads to the following Smatch static
> > checker warning:
> >
> >       net/bluetooth/hci_conn.c:943 hci_le_remove_cig()
> >       warn: passing zero to 'ERR_PTR'
> >
> > net/bluetooth/hci_conn.c
> >     939 static int hci_le_remove_cig(struct hci_dev *hdev, u8 handle)
> >                                                            ^^^^^^^^^^
> >
> >     940 {
> >     941         bt_dev_dbg(hdev, "handle 0x%2.2x", handle);
> >     942
> > --> 943         return hci_cmd_sync_queue(hdev, remove_cig_sync, ERR_PT=
R(handle), NULL);
> >                                                                        =
  ^^^^^^
> > handle is a u8.  It can hold error codes.
>
> s/can/cannot/.

This is not used as an error though, it is more like INT_PTR, that
said I'm fine changing it if that is triggering static analyzer
errors.

> regards,
> dan carpenter
>


--=20
Luiz Augusto von Dentz
