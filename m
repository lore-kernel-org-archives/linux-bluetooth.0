Return-Path: <SRS0=1j7M=2I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BDEC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 04:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A8221582
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 04:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiWd0X6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLRE7j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 23:59:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37538 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLRE7j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 23:59:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id k14so839148otn.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2019 20:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eqQlNOND9PUs/tei5S5rlwmQKbV0rbOU/chfAMQaE5A=;
        b=XiWd0X6ey5+VHu78OP4ovj+DfklGp4imHfZdFDXkP/fFE5K03DtSXkb8ZlSrKFqu81
         3SLDTrBDfVciULu0H4oKjOOohP4FvdwuYCub/rGKU4GNEzB2P3uuj42wYa3cgueDFfzx
         Cln39rJzAZaNJXA+IyV50yiQkA2piJ+Qq4yofRCStMg4dR4w7szAja60ml+ORk9G5vDQ
         JDlJEpExXjIPIoeldjP4wOKUBt3DX03cOSi8zXn+jrJ5nqRCvsWTRl7Dcox2ZuHYkCbF
         gJOlukJhXUBv7KfBbzIyqNs0ENrhY3LmtQufXmR8yIezX0qD9xYgUOTppCYXS+pZjtre
         2x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eqQlNOND9PUs/tei5S5rlwmQKbV0rbOU/chfAMQaE5A=;
        b=F2jpK4x01zqZy2ns1Lx/DVaEcNk5lME2cXcOXn2wcCjh8xqjAYthKs5x3aQ3riNpRB
         V4zCSS9TeKGud3yrKu+vJbNJg3fIlTNnBI2P7K3JSFGpbaX9oU2KQpSfsLgzREZdQfAv
         SoF24f/D3C7f9zMMvGs951Zntlt0p2eFrw4Nxu0rHiaEcsGJGg4W2lmBqLe2B7sAspAR
         TiOpjrru+v6D5d7Pn09gvtVz2b74zs55vLZOCXq4tXAHl+ScXvueLt9YBYAnhRGaUPpw
         ucnRTzs3MTui4eqtuB8NoADidR7UpE/BBDLmSir3QVCdaZgPBUEjq+iZ12o5WIrJm92C
         8THw==
X-Gm-Message-State: APjAAAXAqhRqL53i+AZcihL37G3AYNK+LqvZGdLVz+6U8R4h5m/LnRvO
        jxHks4DgLM2LKq2IHeLNfiIPYmVaPnZq2xSCQ8YVvghC
X-Google-Smtp-Source: APXvYqy0dqb180zcAQm6IU33a3J2eHx7v122/pLMXHm/6wnN6yVOazM5RUQjCnVQ1sXjUVwzEiWC+iFtfut4es/WSnQ=
X-Received: by 2002:a9d:eea:: with SMTP id 97mr501558otj.177.1576645178506;
 Tue, 17 Dec 2019 20:59:38 -0800 (PST)
MIME-Version: 1.0
References: <mail.64efb14f-e4e1-4c80-87cc-4be3dc523401@storage.wm.amazon.com> <0101016f14605796-116b8ce0-8cf1-447d-92a6-4549587b23fe-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016f14605796-116b8ce0-8cf1-447d-92a6-4549587b23fe-000000@us-west-2.amazonses.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 17 Dec 2019 20:59:26 -0800
Message-ID: <CABBYNZ+QLm2NwCT8a0nOpK6PgoA4Z+3u6xCcB1dQQS4mUtbo4A@mail.gmail.com>
Subject: Re: meshctl fails with 'Failed to AcquireWrite'
To:     Yury Galustov <yury@ygsoftware.com.au>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yury,

On Tue, Dec 17, 2019 at 7:47 AM Yury Galustov <yury@ygsoftware.com.au> wrot=
e:
>
> Hi,
> I=E2=80=99m trying to use BlueZ 5.52 installed on Raspberry Pi 4 to provi=
sion mesh network.
>
> The initial provisioning works fine and I=E2=80=99m able to provision and=
 control device, but if I close meshctl and then open it again then all com=
mands related to data transmission fail with =E2=80=98Failed to AcquireWrit=
e=E2=80=99 error here gatt.c:367
>
> I=E2=80=99ve googled a lot and checked the source code and see that the p=
roblem might be somehow related to the OS itself and file descriptor lock, =
but I haven=E2=80=99t found any solution yet.
> Currently digging into g_dbus_proxy_call with no luck =E2=80=A6
>
> Steps to reproduce:
>
> 1. run meshctl
> 2. discover-unprovisioned on
> 3. provision <uuid>
> 4. menu config
> 5. target 0101 (newly added device unicast address)
> 6. ttl-get
> Steps 1-6 work fine
>
> 7.      exit meshctl and launch it again
> 8.      connect  <newly added device unicast address>
> 9.      target <newly added device unicast address>
> 10.     ttl-get (or any command that transmits data) fails with =E2=80=98=
Failed to AcquireWrite=E2=80=99
>
> I've also tried the latest code from master branch but got the same error=
.
> Any ideas where I need to look )?

2 things that might help, closing the all fds when exiting, though the
kernel should have done that already if the process is really
terminated properly, perhaps it is not which is why the daemon still
things there is a process holding on the fd, the second thing is to
check if there is code in place to monitor if process disconnects from
D-Bus and cleanup the socket pairs, though if the process is not
really exiting that would have the same result since the D-Bus
connection may still remain as well.

> Thanks,
> Yury
>
>


--=20
Luiz Augusto von Dentz
