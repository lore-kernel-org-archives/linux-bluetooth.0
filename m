Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85666C19F28
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 17:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiHCRBG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbiHCRBB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 13:01:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545175FEC
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 10:01:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id tk8so32544754ejc.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 10:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sxhiDReJuekk9nGdYJoYy6Cx5kn8xwHHm5Q9kyYHa+I=;
        b=GrqtsmWNfu4x39svOJNUHnzjoZiLFietMq4Fj9j5RM23/UeLdtMh02oIib7ek8yJv+
         DxFTwah6YrCbjHWXjzDbN7YkirgF7MhZKQhl66ZY/GqQQidzjHOWx/mYk1Fec87SpbAJ
         RRslry1mWv1q4oU2ejApp5ptu3hBWs3Mx14PuI5qQgDyKANCatKa6thVtL8MrFLTux5W
         pFUt0YtmYZHLyYaDV/SKeg7Lp8X4OwQemUCi58YvmKDMhs8INdDs85e5rgOaRISRRVlL
         rP48b2+15UrtV9WKSgXuw7avWTJY2GihmZcoSuvYpdJFNbKBjzxEgDs88wtSw4pG1U3O
         d3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sxhiDReJuekk9nGdYJoYy6Cx5kn8xwHHm5Q9kyYHa+I=;
        b=3Q0JznAGfWcVI782qbUhECPzGRRoiLJ5lolBTdFz39rDSIkw3Qv6x47njCAwIgsWIF
         JGO2P3cDir0tBZ0vgwxU7VkZAzBMgdmkNkV66JCeHrJtVj1VQaNnjQjXfG1czITgUAaT
         KK5QLTFozqYDCFttS2YgXJwqL2y24nXB1Hu66hIZiCanP3eM79Pj5FwSOXOEYvwDopWi
         Hxx9stnB8j4W/gs+Wp07BT4dK80hOGWmBEzktu+aoaxf///VNkaNEYE7i409mzril69N
         R7/U5V3LFOsZMKp0ZXkVWbGFbmJyCvGYDO5va7oE1K/RCfc97CdC0BQjgpOY30yDQa4t
         CU5A==
X-Gm-Message-State: AJIora9WECtnECAvrFc8UBxFNC+p0JqQkWrnhYrO1T7TIqs4EkXyUhB1
        xldsTfPQ/G19iTkUFu46zI3wJZSoJQAkXKLHx/LQQnTtPVNywmWa
X-Google-Smtp-Source: AGRyM1tWG9YyeXMT8/GsYX64D+QA0vgSsS7EstWLyax/R2inKWeQUwBlVrdOv6ChOQ6Q6rkBF21SIY6Sw0ffDBlK7w8=
X-Received: by 2002:a17:907:a40d:b0:72b:7f56:650 with SMTP id
 sg13-20020a170907a40d00b0072b7f560650mr21192634ejc.132.1659546058767; Wed, 03
 Aug 2022 10:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR14MB387122AE48F0A1870EDED496FB9C9@DM6PR14MB3871.namprd14.prod.outlook.com>
In-Reply-To: <DM6PR14MB387122AE48F0A1870EDED496FB9C9@DM6PR14MB3871.namprd14.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Aug 2022 10:00:47 -0700
Message-ID: <CABBYNZ+vJ5UJdz1KH+34QtR8qGj6x4sRp4CDj0Z=vMX0VYPYWg@mail.gmail.com>
Subject: Re: Connection Event Length
To:     Chris Laplante <Chris.Laplante@lairdconnect.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chris,

On Wed, Aug 3, 2022 at 9:28 AM Chris Laplante
<Chris.Laplante@lairdconnect.com> wrote:
>
> Hi,
>
> Can someone tell me if the Connection Event Min and Max lengths can be se=
t in BlueZ? I have a customer using BlueZ and their throughput is less than=
 optimal. It looks like from their sniffer logs that there is a single PDU =
sent every 18.75mS connection interval. Looking at the mgmt-api.txt doc in =
the BlueZ-5.64 release it doesn't seem the conn event length parameters can=
 be changed.
>
> New Connection Parameter Event
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
>         Event Code:             0x001c
>         Controller Index:       <controller id>
>         Event Parameters:       Store_Hint (1 Octet)
>                                 Param {
>                                         Address (6 Octets)
>                                         Address_Type (1 Octet)
>                                         Min_Connection_Interval (2 Octets=
)
>                                         Max_Connection_Interval (2 Octets=
)
>                                         Connection_Latency (2 Octets)
>                                         Supervision_Timeout (2 Octets)
>                                 }
>
>         This event indicates a new set of connection parameters from
>         a peripheral device.
>
>         The Store_Hint parameter indicates whether the host is expected
>         to store this information persistently or not.
>
>         Possible values for the Address_Type parameter:
>                 0       Reserved (not in use)
>                 1       LE Public
>                 2       LE Random
>
>         The Min_Connection_Interval, Max_Connection_Interval,
>         Connection_Latency and Supervision_Timeout parameters are
>         encoded as described in Core 4.1 spec, Vol 2, 7.7.65.3.
>
> I am a novice BlueZ user so if for one I am not looking in the right plac=
e please point me to where I should be looking for this info. And also if i=
t is supported please could you provide details on how it can be supported.

You can set the preferred parameter via main.conf:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n202

That said if the peripheral changes these parameters it might cause
them to stored and in that case that is used instead of the global
ones, btw it looks like some peripherals have started to set very high
values for interval in order to save power, the problem is that the
central has no idea about that and will not restore to the normal
settings once there is any traffic. We might need to start handling
the likes of PPCP characteristic in order to determine exactly what is
the prefered settings and when acting as peripheral we shall set it
based on what is configured over main.conf so the central can tell
what is our preferred settings as well.

> Thank you in advance!
>
> Chris
> THIS MESSAGE, ANY ATTACHMENT(S), AND THE INFORMATION CONTAINED HEREIN MAY=
 BE PROPRIETARY TO LAIRD CONNECTIVITY, LLC. AND/OR ANOTHER PARTY, AND MAY F=
URTHER BE INTENDED TO BE KEPT CONFIDENTIAL. IF YOU ARE NOT THE INTENDED REC=
IPIENT, PLEASE DELETE THE EMAIL AND ANY ATTACHMENTS, AND IMMEDIATELY NOTIFY=
 THE SENDER BY RETURN EMAIL. THIS MESSAGE AND ITS CONTENTS ARE THE PROPERTY=
 OF LAIRD CONNECTIVITY, LLC. AND MAY NOT BE REPRODUCED OR USED WITHOUT THE =
EXPRESS WRITTEN CONSENT OF LAIRD CONNECTIVITY, LLC.



--=20
Luiz Augusto von Dentz
