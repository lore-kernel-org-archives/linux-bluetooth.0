Return-Path: <SRS0=crNx=RJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842F7C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 14:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5088720675
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 14:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0FQ3YhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfCFOOp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:14:45 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34607 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfCFOOp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Mar 2019 09:14:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id 98so10867690oty.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2019 06:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2d6bsOdPYBcgj6fU6q0YSQ9zW2P1sHnNX6Z+x3cIIi0=;
        b=Q0FQ3YhIOQ86xn8InwMyWSphcD95H4dHWuIbhoMsRdqFaIHsFUfH8o+iV9GOKSdmE2
         6r01vhLPUyUDR2XGwtGIp+u/A7HD+NP//3lio8rTugxuVWGBJZsdS+OZg/Qt1zC1fyST
         /qvPuZhW+1XmVJD81BBdokbtyHWjUd/9au2gr+6pCvcNmHz8SvZsMQQaq33bIHxpbkl9
         5024srWwPoast1W3G3Q91//dxtPr6SLG46yxBqYJF0WAI8oNDD3aHdFYeOc2wAxIIsoE
         IiBCrffh++dAT+gOf96hYZ91OgfVFZMAzqVbAEe2xxauoBeChcGaJA/ZPYutKhicp8r9
         GtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2d6bsOdPYBcgj6fU6q0YSQ9zW2P1sHnNX6Z+x3cIIi0=;
        b=ps3ij8efa4pu109jMALACo8bYB9v/9JeP/BkCHI0qZIlUkCCir1jwTyvjPCgBXWUik
         XIvOF38pmXb5H5ovq9Sp3d7VN4gmPYNV9fE6ST4omxS8RzegZNuFM7hfh08KMPEM5BKu
         nxYjRuXiddgAfE1Mfeug5FdGSqx7/TtA4UKXjp05em63OhAVG811+67ZIAB/2WdV8gJ2
         8zFP7TFGiGvaGv9GwBgQHdISlfnu7FSQpJJE1CXODHAKBtYkCJ8vwd0HI50ozsP84oH4
         LJKpdouAuou7bvyOwiml49XqAtGCyVkDvu+YeE+dloZXUMNT5hwIxEEBYt/IaE57mCAN
         Pc2g==
X-Gm-Message-State: APjAAAWroj/pBMXuIbbWrVUymy86KNMh+lyBlcSR+1p41xfsa7bbJOC/
        d0/zdilER6GSRufpNz9j4cbprc0krv4Y3pfCOmkxhDyp
X-Google-Smtp-Source: APXvYqyDMzEzp+f38Oh757PqYSxHVuXK7YULfrMrytm2OOMBegitekIimgyIjsWVsuvnDivy87nzaT+3xBlRK3M4mbU=
X-Received: by 2002:a9d:1f3:: with SMTP id e106mr4512706ote.52.1551881684137;
 Wed, 06 Mar 2019 06:14:44 -0800 (PST)
MIME-Version: 1.0
References: <150d16d9-9149-a463-e285-aaea10bed6e4@gmail.com>
 <CABBYNZJbT3fv8tq7JvBjiDuE2W+p__uceBSkduYtrChq0i8WFA@mail.gmail.com>
 <f2edc2ca-9ed3-c436-b43c-81b0560d7f56@gmail.com> <b6ae709c-e62a-9c03-7abb-a8b4800361e6@gmail.com>
 <CABBYNZL2F3JaZA27azU8Z2OZ_4CsnosT+Scsrhn9YAA-3i=iaQ@mail.gmail.com> <a90cfd1f-95aa-6b2e-9aab-66d5b950bb59@gmail.com>
In-Reply-To: <a90cfd1f-95aa-6b2e-9aab-66d5b950bb59@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 6 Mar 2019 16:14:31 +0200
Message-ID: <CABBYNZ+CQ_RQgxAavzKCyhGcy0rNPnZkG_fW6mSO0j0Q3Y+cTg@mail.gmail.com>
Subject: Re: Error setting UUIDs discovery filter on big endian systems
To:     Matt <mwtaylor@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matt,
On Wed, Mar 6, 2019 at 3:48 PM Matt <mwtaylor@gmail.com> wrote:
>
> On 06/03/2019 11:10, Luiz Augusto von Dentz wrote:
> > Looks like the kernel is indeed assuming the length is in LE:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/mgmt.c#n3958
>
> Thanks for pointing me to this line, removing the __le16_to_cpu() does
> seem to fix the UUIDs filter scanning on my big endian hardware, I'm not
> sure why it is needed, perhaps removing it would break LE hardware or
> some other case but I would imagine __le16_to_cpu() would do nothing in
> the LE case anyway. I have made this patch to my kernel (4.9) that seems
> to be all is needed for me to fix the issue (no changes to bluez):

Check the patch Ive just sent, your initial fix is actually correct
but since you change it to little endian you had to convert it back
when calculating the length of message otherwise you end up with an
invalid size.

The kernel is actually assuming Little Endian as this is a convention
for Bluetooth protocols.

> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index ba24f61..507d996 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3599,7 +3599,7 @@ static int start_service_discovery(struct sock
> *sk, struct hci_dev *hdev,
>           goto failed;
>       }
>
> -    uuid_count = __le16_to_cpu(cp->uuid_count);
> +    uuid_count = cp->uuid_count;
>       if (uuid_count > max_uuid_count) {
>           BT_ERR("service_discovery: too big uuid_count value %u",
>                  uuid_count);
>
>


-- 
Luiz Augusto von Dentz
