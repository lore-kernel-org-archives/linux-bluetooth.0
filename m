Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698D0C432C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 09:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3DA219F6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 09:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scewo-ch.20150623.gappssmtp.com header.i=@scewo-ch.20150623.gappssmtp.com header.b="lxcRQjKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKSJKT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:10:19 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36783 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfKSJKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 04:10:18 -0500
Received: by mail-io1-f66.google.com with SMTP id s3so22341515ioe.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2019 01:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scewo-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zIDr5J2Yg7tMf+RLWCV3YC/Oi0E4vefOQxXVhy+PepM=;
        b=lxcRQjKRdKxddw4+eCPV9CM3qltYsJEdgWLwbkgA6f5NKrHi9Z9Sb75jkj6Lel679K
         peOHspS4ZkayV1c8NBZKPsemqtVSR3Rx2n+0sQNsZD256IvwnECluieziMJPbBV1jmih
         4OFZULk2+LjtpP4HfZRGWIJyQDyluO6sXIPtmKQ92oOt5cweS8MpMOvJ9v705Ml256Bl
         VFFke6I9c+Y8rbC4WQ2NsQB9H09Qa0rpSlwOcoXr4g0WqDA5/OPG3U0fgcfSXkbbyWdT
         L1dGHIXSaAThSycNhMmKlAbfo4YNpE6kYtUEn9hDU3s9jttnOv44wnKL+lYaR4D8nGhI
         yrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zIDr5J2Yg7tMf+RLWCV3YC/Oi0E4vefOQxXVhy+PepM=;
        b=fqWfkEdihFVU1qAChn96DNVvBq+wnKw/CSLnfzcQDauDHRZtyDU7l4rRCTtIE60Ngu
         hJzk2l8i4pI/WnTros5JNjpf0tgI4Mk5Q6517R3Jt95fL1jpcRrLmNJLnQGCAVQrYhfX
         c43ORbQjCJSak48xgbKR+UzjaUiRairsoNDBIdTtW+2EFMcVRC3DsMOo2vOuFOlomVbS
         jNP5ih5zMi2D0efkfJP6jzaZs6MPguFThEJgf3Fqi4foQdYA+m5xN2E5AQlKkChEDEw6
         BSG52PsazmfWBqnTcB9kmpN2EETSZD8G+lLulbyxAHeHGbPHyBf5kNXsAT1SM/ixZLX3
         /xUQ==
X-Gm-Message-State: APjAAAUJMUPMD2amJzxwlFPIbh+TebhrBF+exLJdL3gQG4znqC0UCTta
        HWqVL920yLW9Ui08PVyyU2/lahuv4u2H2OCqTZSsLg==
X-Google-Smtp-Source: APXvYqyPM0AujVk1+miC76sR7XKezF5plXWVqkOB1chmL6xqCx1AQZDrvEk/JZBsyh/rqx68cM1CJnWVTbGzFZG7jVc=
X-Received: by 2002:a02:3f10:: with SMTP id d16mr17367239jaa.139.1574154617401;
 Tue, 19 Nov 2019 01:10:17 -0800 (PST)
MIME-Version: 1.0
References: <CAGssATiS=dpA=WOSfLek385o2g=C5sb0z+z=V7CDswn9_5Eu-g@mail.gmail.com>
 <CABBYNZ+VfyOeWjfdE64bVQM0eAJE789NRBjy+wgKa_Dka2ZZJg@mail.gmail.com> <F827D8AB-4404-4C81-9368-A18AB87D9292@holtmann.org>
In-Reply-To: <F827D8AB-4404-4C81-9368-A18AB87D9292@holtmann.org>
From:   Guy Morand <g.morand@scewo.ch>
Date:   Tue, 19 Nov 2019 10:09:58 +0100
Message-ID: <CAGssATiZsC28X06aVQDTO=8va-0dtoe-1a2Mi6JZv4P9UMdGqg@mail.gmail.com>
Subject: Re: Bluetooth disconnect event / Link layer monitoring
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks everyone for your quick answers!

I tried this already but unfortunately, it seems that the gamepad
doesn't allow that:
$ hcitool lst ec:83:50:de:02:3c 1
HCI write_link_supervision_timeout request failed: Input/output error

< HCI Command: Write Link Supervision Timeout (0x03|0x0037) plen 4
    handle 70 timeout 1
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Supervision Timeout (0x03|0x0037) ncmd 1
    status 0x0c handle 70
    Error: Command Disallowed

Yes, if it was me, I would never use bluetooth!

I guess the only place where I can do something is in the kernel space.
I would like to send the error to the user when this happens:
Bluetooth: hci0 link tx timeout

Do you think that would be possible and make sense?

Best regards,

Guy

On Tue, Nov 19, 2019 at 6:06 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> >> We are developing a wheelchair that we can controle with a bluetooth
> >> gamepad, the XBOX 360 controller to be more precise. It basically work=
s
> >> fine but when I remove the battery, I get the disconnect event in the
> >> user space around 10 seconds later. That is not acceptable since the
> >> wheelchair will keep rolling to potentially dangerous places!
> >>
> >> I tried to implement a ping mechanism on the bluetooth layer, inspired
> >> from bluez sources somewhere:
> >>  int _socket_fd =3D socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_L2CAP);
> >>  // bind on AF_BLUETOOTH
> >>  // connect with AF_BLUETOOTH
> >>
> >>  send_cmd->ident =3D PING_IDENT;
> >>  send_cmd->len =3D htobs(PING_DATA_SIZE);
> >>  send_cmd->code =3D L2CAP_ECHO_REQ;
> >>  if (send(_socket_fd, send_buffer, PING_PACKET_SIZE, 0) <=3D 0) {
> >>    // ...
> >>  }
> >>
> >> It basically works fine except when the signal gets bad. This will get
> >> printed by the kernel:
> >> [  859.629431] Bluetooth: hci0 link tx timeout
> >> [  859.635482] Bluetooth: hci0 killing stalled connection 9c:aa:1b:6b:=
51:c9
> >>
> >> In that case, I don't get event from the /dev/jsX device but the gamep=
ad
> >> seems to still answer to pings??!!
> >>
> >> Since I haven't found any acceptable workaround and always find the sa=
me
> >> pages again and again, I'm asking here:
> >> * Is it possible to achieve what I want?
> >> * Does it make sense that the ping work but the HID layer seems dead?
> >> * Any recommendation, pointers?
> >
> > Id look into adjusting the link supervision timeout instead of
> > creating a raw socket, you can use hcitool to do that, neither is
> > really great since it require root but at least the supervision
> > timeout is something a lot more reliable for this.
>
> we can add an option to L2CAP sockets to adjust the link supervision time=
out.
>
> Anyway, these days, I would _not_ use Bluetooth BR/EDR for controlling an=
ything. I would find a Gamepad that utilizes Bluetooth LE and focus on that=
.
>
> Regards
>
> Marcel
>


--=20

Guy Morand

Software Engineer

=E2=80=93

Scewo AG, Technoparkstrasse 2, 8406 Winterthur

Office +41 (0)44 500 86 03


www.scewo.ch

www.facebook.com/scewo

www.instagram.com/scewo_official
