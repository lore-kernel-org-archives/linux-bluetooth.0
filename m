Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A96C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 03:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC296113B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 03:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhDODsc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Apr 2021 23:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhDODsc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Apr 2021 23:48:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D91C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Apr 2021 20:48:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w8so28365912lfr.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Apr 2021 20:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FZCSSHtw1WoIqt3XaKyqydiVfHgb9N2SQusHdX7BDVo=;
        b=aQb9tWM4TXoxN+blGBXFDvpHf632nGMryqeAP9DQzrK6daDrVeU0YAHPJE/bqo6gMG
         socD0dFKGXBsMFN5kSkATkh35DigDaQ1AESHZD4ezZtoAVas0Y6UcsEgUbGL5bEJLU3b
         +bSAsSu825z2FjsKjqiEc65UZeUzUKgM9Ji8b+D9V6/dAHoNX8KJ4hjvOGb7o0YgxrgY
         jvfQloFvQHejZEaGb49wHBCLfBJbjF5f7Vg6yeKeVBh4KMHN/Dt3D9JuVT1PoaEMBuvb
         o0vHQF/kImxqRZe/8QW4QnkDtiSSeIIAb55r/I+5cJAmmBxzOYxPGMK5C1LVp/VfxRrp
         Rqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FZCSSHtw1WoIqt3XaKyqydiVfHgb9N2SQusHdX7BDVo=;
        b=kzXN7FAO2KF7PD/1BOYWKKXcuHLCborkZgDWiHRONsgktCwIfl0RDqYmdIFz9TxB13
         +6kCkJdFI4yNRvNJi45Xwb6XwM4fdFU7QhF3wFd3gmxeYIbddeHiMlF01hiyJ+VkrZ3F
         2hifVo3ol2UWRBm/kf3+DsDvSePRiUDvuodGscqeU70E13WY2buJULcChnDVO3jXDEVC
         XP7SRfBcp++kUsGrean+l8by9AJgfpaOhbc5YdD1dIHjKLbxd4TBY7yOD8rOfx8KrBfz
         Tu+E+pwuI8oI5yTvzc7vyFg19Rbv02cEppOovhD7D0VHSRD7Iodp9eS/kRVDPQqB3tTV
         4JdQ==
X-Gm-Message-State: AOAM530XZJPnq3IDa/56/HBQGr1TYgrHDrk2juvqPG7twyrfT9Fp7i6O
        6WQytN1QRSHr6EGzxo480y6E2nlP1QvXefsiiDBt1bI7vfKuiads
X-Google-Smtp-Source: ABdhPJxGYIKyumtzTNqcj4tNixkwmb5bT6eN6Pe7yUbU73JPogNY8dbm+75Tr0fRkpdcYlK1/JWkbtglTH3nW+K9awc=
X-Received: by 2002:a19:ee13:: with SMTP id g19mr973345lfb.451.1618458486772;
 Wed, 14 Apr 2021 20:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <tedd.an@intel.com> <20210414043857.371176-1-hj.tedd.an@gmail.com>
 <6D9FBA0A-3058-4C96-8CFD-6BE5B585DE8E@holtmann.org> <34494443-5CE2-40F1-95DF-EF05914BD741@intel.com>
In-Reply-To: <34494443-5CE2-40F1-95DF-EF05914BD741@intel.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 15 Apr 2021 11:47:55 +0800
Message-ID: <CAJQfnxFirWC+ned2sCrJb7nAiBqjCkO6guMNZU_5NCqkAdKzpg@mail.gmail.com>
Subject: Re: [BlueZ] monitor: Fix the incorrect vendor name
To:     "An, Tedd" <tedd.an@intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Thu, 15 Apr 2021 at 10:26, An, Tedd <tedd.an@intel.com> wrote:
>
> Hi Marcel,
>
> =EF=BB=BFOn 4/14/21, 3:09 AM, "Marcel Holtmann" <marcel@holtmann.org> wro=
te:
>
>     Hi Tedd,
>
>     > This patch fixes the vendor name is alwasy shown as "Microsoft" eve=
n
>     > though a different vendor.
>     >
>     > < HCI Command: Microsoft Secure Send (0x3f|0x0009) plen 249
>     >        Type: Data fragment (0x01)
>     >> HCI Event: Command Complete (0x0e) plen 4
>     >      Microsoft Secure Send (0x3f|0x0009) ncmd 31
>     >        Status: Success (0x00)
>     > ---
>     > monitor/packet.c | 12 +++---------
>     > 1 file changed, 3 insertions(+), 9 deletions(-)
>     >
>     > diff --git a/monitor/packet.c b/monitor/packet.c
>     > index d729a01cc..91d2294ff 100644
>     > --- a/monitor/packet.c
>     > +++ b/monitor/packet.c
>     > @@ -9325,18 +9325,12 @@ static const char *get_supported_command(in=
t bit)
>     >
>     > static const char *current_vendor_str(void)
>     > {
>     > - uint16_t manufacturer, msft_opcode;
>     > + uint16_t manufacturer;
>     >
>     > - if (index_current < MAX_INDEX) {
>     > + if (index_current < MAX_INDEX)
>     >           manufacturer =3D index_list[index_current].manufacturer;
>     > -         msft_opcode =3D index_list[index_current].msft_opcode;
>     > - } else {
>     > + else
>     >           manufacturer =3D fallback_manufacturer;
>     > -         msft_opcode =3D BT_HCI_CMD_NOP;
>     > - }
>     > -
>     > - if (msft_opcode !=3D BT_HCI_CMD_NOP)
>     > -         return "Microsoft";
>
>     seems we have a bug here, but the fix can not be correct either. If w=
e are running on Intel firmware and the Microsoft extension is used, it sho=
uld show Microsoft and not Intel for the vendor commands.
>
> I submitted v2 and I think I took care of the msft_opcode handling but I =
realized that the msft_event_opcode is also like msft_opcode - each vendor =
will have a different value.
> I know the msft_event_code for Intel, which is 0x50, but don't know for R=
ealtek. (Do you happen to know?)

On my Realtek device the msft_event_code is 8 bytes long: 0x23 0x79
0x54 0x33 0x77 0x88 0x97 0x68.

localhost ~ # hcitool cmd 0x3f 0xf0 0x00
< HCI Command: ogf 0x3f, ocf 0x00f0, plen 1
  00
> HCI Event: 0x0e plen 22
  02 F0 FC 00 00 3F 00 00 00 00 00 00 00 08 23 79 54 33 77 88
  97 68

> I changed the v2 to RFC for your further comments.
>
>     Regards
>
>     Marcel
>
> Regards,
> Tedd
>

Cheers,
Archie
