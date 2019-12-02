Return-Path: <SRS0=9PGa=ZY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05122C432C3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 14:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C702420833
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 14:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scewo-ch.20150623.gappssmtp.com header.i=@scewo-ch.20150623.gappssmtp.com header.b="xX+4H+sY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfLBORl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:17:41 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36002 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBORl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Dec 2019 09:17:41 -0500
Received: by mail-io1-f66.google.com with SMTP id l17so14447271ioj.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Dec 2019 06:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scewo-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=ttwX5YlkawcLlRdnsDNXMQn/cy+r8metTAs296y6sfs=;
        b=xX+4H+sYCzEEZ09sxoPLxW0WtjfNcwX0mzMyBrbVXUQgsbC1fczRGdCX0+ynb7f0z/
         jUTeoFBkVDY4lzTsTCreiQQUVxYP0RgZPM+H3g4ReIaMh8aKMEluAp509G8UOztymP2t
         Fzahvn80uCSPNoMWdSbN3iT6rr7OEf7sjA9DD2U7+FidEeJNI4I75yFCEchEmkKcUoK9
         82X/B/O8R+aRoewXkZnVDK1XK34Oz9t96cg+lNdjNd7Nks8bS0gZO3hmssv2qTMqcVxr
         NRxRTOkKYVLlyL6nhEdhLZwqduKLiWniocMAX5oc70Gj0bHXcnCPlB8TMy70hmpP/5Rl
         VKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=ttwX5YlkawcLlRdnsDNXMQn/cy+r8metTAs296y6sfs=;
        b=EpEhx/BnuPBUFq9aOUeG8nEIcbJ7CDa8nOn8PTg3X+Scl8tmA/dTsINqH/NYNng6Bp
         OL4PzpOceEiWXWleUE8qK2ThMIEd6BfbKS87K3IKkjBZmkxpQZk47tC7CRJ1IaSNMNDS
         /ryinxAHMTHfAfWkXwgc4N701bgbrZv1XcuIoz9Ae/CO/FrP6JncvYfUv3MMTWrXXhpd
         NJkRq7Rbm3376m2Pnwvj5LYB65PlcY5jXzB0qpvQIq/BENp7IOkEg1w7ciALYpy3H/nk
         U4VqW1pnqlBzb+n8kYAw+s+MWUtc0q+ppu0b94fSpy0J2m8DTqfoxDTFKBBcJOVlP3sK
         sIDg==
X-Gm-Message-State: APjAAAWS1CPp+7PeBHCwQ2B+YAOAmlUc5zGLsBT0xeXsi6c60/mr5yPo
        5Cw7f4KzrvTK9veHzJEyVW93kl+sJMuycN5vYnwtm0mccV9Eaw==
X-Google-Smtp-Source: APXvYqwlapBsjg7NuBX/r7J7zQ0cYb8B3fHbpjSPUtKdV4qQjX4DyksEjNq7n5gM3OoiTP7kfjkAuqZX6sEF51nSMp8=
X-Received: by 2002:a6b:6e18:: with SMTP id d24mr12092971ioh.301.1575296258512;
 Mon, 02 Dec 2019 06:17:38 -0800 (PST)
MIME-Version: 1.0
References: <CAGssATiS=dpA=WOSfLek385o2g=C5sb0z+z=V7CDswn9_5Eu-g@mail.gmail.com>
 <CABBYNZ+VfyOeWjfdE64bVQM0eAJE789NRBjy+wgKa_Dka2ZZJg@mail.gmail.com>
 <F827D8AB-4404-4C81-9368-A18AB87D9292@holtmann.org> <CAGssATiZsC28X06aVQDTO=8va-0dtoe-1a2Mi6JZv4P9UMdGqg@mail.gmail.com>
 <CAGssAThL-EYEDLm8+aGqV_+sM0m8Gu7NdZ-jJOCMh3YgxJdq6A@mail.gmail.com>
In-Reply-To: <CAGssAThL-EYEDLm8+aGqV_+sM0m8Gu7NdZ-jJOCMh3YgxJdq6A@mail.gmail.com>
From:   Guy Morand <g.morand@scewo.ch>
Date:   Mon, 2 Dec 2019 15:17:27 +0100
Message-ID: <CAGssATjZw9x3hro0m+BX_=zRKTuMeBG1WFvFT26j92zpJzcFzg@mail.gmail.com>
Subject: Re: Bluetooth disconnect event / Link layer monitoring
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Bluetooth developers,

To give some feedbacks on my problem and hopefully that could help
someone else who is also struggling...

I compared the connection with my desktop and my device using btmon and
noticed that during the connection, my desktop was configured as master
that is set to slave on my device:

# On host
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
        Address: EC:83:50:DE:02:3C (Microsoft Corporation)
        Role: Master (0x00)

# On target
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
        Address: EC:83:50:DE:02:3C (OUI EC-83-50)
        Role: Slave (0x01)

So I applied this quick and dirty patch and now I can change the link
supervision timeout without error:
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e17aacbc5630..c83f66066ce0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2286,10 +2286,7 @@ static void hci_conn_request_evt(struct hci_dev
*hdev, struct sk_buff *skb)

                bacpy(&cp.bdaddr, &ev->bdaddr);

-               if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
-                       cp.role =3D 0x00; /* Become master */
-               else
-                       cp.role =3D 0x01; /* Remain slave */
+               cp.role =3D 0x00; /* Become master */

                hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &cp)=
;
        } else if (!(flags & HCI_PROTO_DEFER)) {

It's weird that in the latest kernel, this part of the file didn't
change and there is for sure a better fix! bluetooth poeple?

Anyway, if this helps or gives some clue to someone else, I'm always
glad for a free beer, even virtually :D!

Happy hacking!

Guy

On Thu, Nov 21, 2019 at 6:37 PM Guy Morand <g.morand@scewo.ch> wrote:
>
> I found out that the hcitool lst command was working perfectly fine on
> my desktop and is doing what I expect!
>
> Unfortunately, on my device it only works after pairing, then I always
> get the "Command Disallowed" error. This is weird as I'm  using the same
> USB dongle and bluez version (5.50). The only thing that changes is the
> kernel version that is why I think there is something weird here:
> * 4.9 (Yocto) -> Doesn't work
> * 4.14 (Yocto) -> Doesn't work
> * 4.19 (Debian) -> works!
> * 5.0.0 (Ubuntu) -> works!
>
> I know it's  boring but updating the kernel is not straightforward, we
> use the kernel provided  but our silicium vendor (embedded).
>
> I was just wondering if one of you remember a similar bug (and fix?) or
> this was just automagically solved without someone noticing it? Or maybe
> I'm just missing something else important...
>
> All the best!
>
> Guy



--=20

Guy Morand

Software Engineer

=E2=80=93

Scewo AG, Technoparkstrasse 2, 8406 Winterthur

Office +41 (0)44 500 86 03


www.scewo.ch

www.facebook.com/scewo

www.instagram.com/scewo_official
