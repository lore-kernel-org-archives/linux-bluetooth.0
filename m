Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C49C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 16:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD70206BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 16:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kie3FWvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgFVQBd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgFVQBd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 12:01:33 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759E7C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 09:01:33 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id u23so13454284otq.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oiN7jPDJcCcfafqjkUB/P3rt4KkZ2arIcWmPBx1Rk54=;
        b=kie3FWvn3kQmlzclJ1JZi5vyjqo9gOTKG5yjgERZbpIGx67HRCEfuHBpJgL4HxiFPs
         McrSHLG1sWW7EoSjpLsLd51pZBbnkZ4lXovFlNtFil9PKZRyKYjSpDK7TJZSXaGMfKMc
         dkZuNf7lhpu88VLq+Ea7Z9KwBLX2sT2sXT+TD0g6qD43PgQSWx9OzHc67KbEY450bdM4
         slxd8G5acmsXAI0w1ZRlYAUHC1IKv7Lix/XWiF9pM8xxJVpxTnWG6D0Y+phD0/ir4xMB
         JvJXhBMJywwJMKZ/7yqIBxCtbgTxvjc2NpP/nJvYPICPgxgJorWFyE5ob47NA+Bf+5A6
         b+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oiN7jPDJcCcfafqjkUB/P3rt4KkZ2arIcWmPBx1Rk54=;
        b=AUHeNbwkPptQRjwGGJh0YWniz6DPKsHuRb6b4Rj4NMkTp0wRTWdkj8WCbin5XzJRxR
         0Uk1fFPtovy+KK/1B7EOQj/U81EX/toXyIxGgbWMeV5UYhx1TrVd2RYBur1REL+Xwyo4
         2P85oIxPtHcbQOg/PEo5R94mCOb7QYre4dBCDoYtzpDl4JbB9iCnqArEUazVLbGTcYFD
         +/bMrkqdIvcjV9B44W5f3BtSvVCVPLEtQTWb2zm9s2y/RsDZSa2DXGm2gg0h3Qfnhpog
         2xX5A81N2C+x9FrPaYIc+kpvusq0D1ZVjkDdd5HPNMc5GINnSHCWIBySB35OcZ/1vyia
         4zWw==
X-Gm-Message-State: AOAM530fz7EnOCCs1hywPiODxudLfHIMJGEVy3//yYyHgPy7+SG+GA6w
        8TZs64+Nseh6AmUZoShcJ50834+mh88Rl8Rr340=
X-Google-Smtp-Source: ABdhPJxLUh0/uuPnYbNNEQO4tAMs+czLYRTGVX7cEEIWaCtqTVAlmi+c068RqHNoItkUcdnFNxwsUhpI9fZb2451Xvs=
X-Received: by 2002:a05:6830:8d:: with SMTP id a13mr14404035oto.91.1592841692640;
 Mon, 22 Jun 2020 09:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210659.142284-1-alainm@chromium.org> <C5D30F5E-B50F-4DE7-A909-F48F6C555661@holtmann.org>
 <CALWDO_XLRELJhe1n9AVq2w9fQYkgGLC+bdXQ-1-M4f-cUfEwGQ@mail.gmail.com>
 <CABBYNZLEsUXFW_hrmcvSALRpeZwkmvk=c9SYPt+owO7tn+hMBw@mail.gmail.com>
 <CALWDO_V2Hnc-HHYQQ5LfnW8a2FWzkTBOE1Cti0ZQzyw4CouAgw@mail.gmail.com> <9DA76AAC-F625-408C-8C74-DAE3ED42AC45@holtmann.org>
In-Reply-To: <9DA76AAC-F625-408C-8C74-DAE3ED42AC45@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Jun 2020 09:01:21 -0700
Message-ID: <CABBYNZLJQRCzcrCCVGkeVSDhi8B35dc9z4SAh4dFbgT9DVm4Mg@mail.gmail.com>
Subject: Re: [PATCH v1] bluetooth: use configured params for ext adv
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainmichaud@google.com>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Jun 22, 2020 at 12:14 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Alain,
>
> >>>> please use =E2=80=9CBluetooth: =E2=80=9C prefix for the subject.
> >>>
> >>> ack.
> >>>>
> >>>>
> >>>>> When the extended advertisement feature is enabled, a hardcoded min=
 and
> >>>>> max interval of 0x8000 is used.  This patches fixes this issue by u=
sing
> >>>>> the configured min/max value.
> >>>>>
> >>>>> This was validated by setting min/max in main.conf and making sure =
the
> >>>>> right setting is applied:
> >>>>>
> >>>>> < HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036)=
 plen
> >>>>> 25                                          #93 [hci0] 10.953011
> >>>>> =E2=80=A6
> >>>>> Min advertising interval: 181.250 msec (0x0122)
> >>>>> Max advertising interval: 181.250 msec (0x0122)
> >>>>> =E2=80=A6
> >>>>>
> >>>>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >>>>> Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> >>>>>
> >>>>> Signed-off-by: Alain Michaud <alainm@chromium.org>
> >>>>
> >>>> The Reviewed-by lines go after your Signed-off-by.
> >>>
> >>> ack.
> >>>>
> >>>>
> >>>>> ---
> >>>>>
> >>>>> net/bluetooth/hci_request.c | 10 ++++++----
> >>>>> 1 file changed, 6 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_reques=
t.c
> >>>>> index 29decd7e8051..08818b9bf89f 100644
> >>>>> --- a/net/bluetooth/hci_request.c
> >>>>> +++ b/net/bluetooth/hci_request.c
> >>>>> @@ -1799,8 +1799,9 @@ int __hci_req_setup_ext_adv_instance(struct h=
ci_request *req, u8 instance)
> >>>>>      int err;
> >>>>>      struct adv_info *adv_instance;
> >>>>>      bool secondary_adv;
> >>>>> -     /* In ext adv set param interval is 3 octets */
> >>>>> -     const u8 adv_interval[3] =3D { 0x00, 0x08, 0x00 };
> >>>>> +     /* In ext adv set param interval is 3 octets in le format */
> >>>>> +     const __le32 min_adv_interval =3D cpu_to_le32(hdev->le_adv_mi=
n_interval);
> >>>>> +     const __le32 max_adv_interval =3D cpu_to_le32(hdev->le_adv_ma=
x_interval);
> >>>>
> >>>> Scrap the const here.
> >>>
> >>> I'd like to understand why it isn't prefered to use const when you
> >>> don't intend to modify it in the code.
> >>>>
> >>>>
> >>>> And it is wrong since your hdev->le_adv_{min,max}_interval is actual=
ly __u16. So that first needs to be extended to a __u16 value.
> >>>
> >>> The macro actually leads to a function call that has a __u32 as a
> >>> parameter so the __u16 gets upcasted to a __u32 already.
> >>>>
> >>>>
> >>>> That said, if we have this in the Load Default System Configuration =
list, we should extended it to __le32 there as well.
> >>>
> >>> I agree, this means the range of default system configuration may not
> >>> be sufficient to accept all possible values that the newer command
> >>> supports, although I think this is a separate issue from what this
> >>> patch is trying to solve.
> >>>>
> >>>>
> >>>>>      if (instance > 0) {
> >>>>>              adv_instance =3D hci_find_adv_instance(hdev, instance)=
;
> >>>>> @@ -1833,8 +1834,9 @@ int __hci_req_setup_ext_adv_instance(struct h=
ci_request *req, u8 instance)
> >>>>>
> >>>>>      memset(&cp, 0, sizeof(cp));
> >>>>>
> >>>>> -     memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval)=
);
> >>>>> -     memcpy(cp.max_interval, adv_interval, sizeof(cp.max_interval)=
);
> >>>>> +     /* take least significant 3 bytes */
> >>>>> +     memcpy(cp.min_interval, &min_adv_interval, sizeof(cp.min_inte=
rval));
> >>>>> +     memcpy(cp.max_interval, &max_adv_interval, sizeof(cp.max_inte=
rval));
> >>>>
> >>>> This is dangerous and I think it actually break in case of unaligned=
 access platforms.
> >>>
> >>> Since it is in le format already and the 3 bytes from the cmd struct
> >>> are raw, I'm not sure how this can be dangerous.  It effectively
> >>> yields the exact same results as your suggestions below.
> >>
> >> In zephyr we end up doing helper functions for 24 bits:
> >>
> >> https://github.com/zephyrproject-rtos/zephyr/blob/master/include/sys/b=
yteorder.h#L316
> >>
> >> I guess that is safer in terms of alignment access and it would work
> >> independent of the host order which apparently was not the case in the
> >> code above since it doesn't do the conversion to le32 (or perhaps the
> >> intervals are already in le32), anyway having something like that is
> >> probably much simpler to maintain given that most intervals use for
> >> things like ISO are also 24 bits long.
> > I like this. Would you put this in hci.h or keep to a lower scope?
> >
> > static inline void hci_cpu_to_le24(__u32 val, __u8 dst[3])
> > {
> > dst[0] =3D val & 0xff;
> > dst[1] =3D (val & 0xff00) >> 8;
> > dst[2] =3D (val & 0xff0000) >> 16;
> > }
>
> hmmm, how many 24-bit fields do we have in Bluetooth HCI spec? If it is j=
ust one, then lets keep it close to the usage, if not, I have also no objec=
t to put it in a higher level.

These are the instances of 24-bit fields:

include/net/bluetooth/hci.h:    __u8      min_interval[3];
include/net/bluetooth/hci.h:    __u8      max_interval[3];
include/net/bluetooth/hci.h:    __u8    m_interval[3];
include/net/bluetooth/hci.h:    __u8    s_interval[3];
include/net/bluetooth/hci.h:    __u8  cig_sync_delay[3];
include/net/bluetooth/hci.h:    __u8  cis_sync_delay[3];
include/net/bluetooth/hci.h:    __u8  m_latency[3];
include/net/bluetooth/hci.h:    __u8  s_latency[3];

I guess they all could benefit from having such a helper so we don't
have to resort in cpu_to_32 + memcpy.

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
