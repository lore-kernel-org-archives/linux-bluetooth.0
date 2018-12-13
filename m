Return-Path: <SRS0=2Gsy=OW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89A9C65BAE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Dec 2018 21:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F06A2086D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Dec 2018 21:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nestlabs.com header.i=@nestlabs.com header.b="QfxCaLrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F06A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nestlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbeLMVib (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:38:31 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:32960 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLMVib (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Dec 2018 16:38:31 -0500
Received: by mail-it1-f179.google.com with SMTP id m8so17365371itk.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Dec 2018 13:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nestlabs.com; s=google;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to;
        bh=dcCHzc4BOyE7O8KT6NjQrwCd5uwZ1/JCVSQ5e8FgR70=;
        b=QfxCaLrgyihLISNJbyRLk9Gw3XRbmFWtr2JjKNxDhvbA4nbhVpiIJr0JqP8JIFa27a
         FWNDHExZf2G1pG5jka9kPjtAm4HM6uoSepeNbxngAVNlsbUeOTXag+m1S4mDDwB9pMZ3
         5aE5p528za3y1sRYXitxw7InL38jk4GsAU/04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to;
        bh=dcCHzc4BOyE7O8KT6NjQrwCd5uwZ1/JCVSQ5e8FgR70=;
        b=C+uiHbhp0LEmZKMsRxtIBEqWoy25rvM9LY+zM+JctwTVFRNi/V0IKE7sYYrmfyNaez
         6Y4GhG7y356kwNHtBjVr44KqDO6yMk4w5nJfIO/JGqfXx34I1uqA4KuN4hcFxYWQXk5z
         lS2+VduUOinnOaDwt9hD5VNuf7jlop7xNrR12RzoA0IvhOR9YwqJlW4DQJCGHQUIM4Tw
         IlUfGyf7qemBUEsY0D/XlDMHtWtkAmIKF3PeWMb6H8gfR81AmDm+Ai2yKU9LaZDft+2m
         JO1wC+sG+lDFEXO4FMeJc5tlidBj7eMLlxfXfP5X0tcdwRmriapa6PsFkIIAtxLErwr1
         4Ylg==
X-Gm-Message-State: AA+aEWazsnQMNxaOicKXoJTIaZnsoA965+DHdZKVFJ0zYqInEM4OHwwS
        c6iAMLf2Q4xxEKujmjFJuy9WRUo/Ir12DmiKr7E9tA==
X-Google-Smtp-Source: AFSGD/Wehh9zrOj4hQ+xaz8Du0s7MF6HTZAytBZbfY1m+yuZVy1B0HrKTGY1jbljVo4P/E5F7BCzNrMi44kdFyqY1w4=
X-Received: by 2002:a24:b8c6:: with SMTP id m189mr957166ite.72.1544737110427;
 Thu, 13 Dec 2018 13:38:30 -0800 (PST)
MIME-Version: 1.0
References: <CALvjcs9zQ3v9pW6_Sy-VJD4hiX2FDrnqV7xYUNkNGg6mVaoHKQ@mail.gmail.com>
In-Reply-To: <CALvjcs9zQ3v9pW6_Sy-VJD4hiX2FDrnqV7xYUNkNGg6mVaoHKQ@mail.gmail.com>
Reply-To: yunhanw@nestlabs.com
From:   Yunhan Wang <yunhanw@nestlabs.com>
Date:   Thu, 13 Dec 2018 13:38:19 -0800
Message-ID: <CALvjcs9iYvgxN4YWzirw_Fxx30cDKYCyir+ZmpgsuBvcTJN+Zg@mail.gmail.com>
Subject: Re: BLE advertisement re-enabling after ble connection goes away
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Martin Turon <mturon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+Martin

Hi, Luiz and Marcel

When I take a look at the bluetooth code, it seems it is re-enabling
ble advertisement after ble connection goes away. Any idea?

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/hci_event.c#n2634
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/hci_event.c#n2712
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/hci_request.c#n1386
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/hci_request.c#n1734

Thanks
Best wishes
Yunhan
On Wed, Dec 5, 2018 at 6:54 PM Yunhan Wang <yunhanw@nestlabs.com> wrote:
>
> Hi, Luiz and Marcel
>
> May I have a question on ble behavior on BLE re-advertisement?
>
> According to Bluetooth spec Vol. 3 (the host volume), 9.2.4.2, "The
> device shall remain in general discoverable mode until a connection is
> established or the Host terminates the mode."
>
> There is no description on re-enabling the advertising "after"
> disconnection, so the responsibility for re-enabling the advertising
> is bluez or kernel or application code? In other words, does kernel or
> bluez or application would re-enable the ble advertisement after ble
> disconnection happens?
>
> Thanks
> Best wishes
> Yunhan.
