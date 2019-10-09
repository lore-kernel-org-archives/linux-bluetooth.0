Return-Path: <SRS0=7chU=YC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A87C47404
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 13:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A421620B7C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 13:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7nHytH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfJINfL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:35:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44459 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731005AbfJINfL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Oct 2019 09:35:11 -0400
Received: by mail-ot1-f66.google.com with SMTP id 21so1703749otj.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Oct 2019 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnxegAEfzr4zIABiKZ2ik9MHE1Cy9dx9lRajU6VfmT4=;
        b=X7nHytH3Lfq2GjtbIvdPDvwPi1RKlXI2YoLqfprdBzo6I6iCma4iRJYbgaFZJhfRs5
         FSCECMCZLT1iB0co/fae9/mRjFtyLMZw/nW42XErnKPgO1DCVnflKZIc4578tuQoo2Sr
         VCVZ0OpygNTKvhAgRTEDPgmJZ4sFUuRL4C1achWztG9b0cQ9QavBpwcyyqIohzaTpKq0
         6kqigoySl3TcahmQwAXpoZH2yJVrN+Mwq0zXJdpn10p4fsc8ODpjMKfkpXzGGt89Krb8
         hZ48FehIj1sy1Svjk/8dq6jJSmUPP5/7jo2FCY8h9OwzBFbEyQDyeLPgqs/w+OslU0cG
         Jp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnxegAEfzr4zIABiKZ2ik9MHE1Cy9dx9lRajU6VfmT4=;
        b=Tr0XL+dPHUiRoFOmdo24/hcXJT87qn49d0HvZjYL6Dqu6B/CqxNdUId21O1PDHvhxc
         rctbrzBTNpIF+1RTPC1v9GCB6fUo/dT9DrOW1MFa3MBHMymbHmV3cSe61riFWahmCRd/
         Szb9tgBXZTaHorx8DUW56nTOkR0Dam3WxKMIpbaiEhcVy0sXccK5wkR0syNh4q7T5+k7
         mX7JpC3znTv1ljtkDjhPGQ6XkHhoYhbjXb0yo0HEQJ6/YnCY3BEMNdhYFldhwQKTnUne
         N54dWpIhqn6ee8TzojB+aakbShuWmShQzLzhSRTCkNOmAIg8dyxBJJpNymt41d26DfSB
         uRiQ==
X-Gm-Message-State: APjAAAUY8IBAe7WKfbaZcGh5DUzh8wxbETmbNOuw5/t0Y6RaEMnaS/AL
        7LeWlPkQsjiebQnWOD0eKtONS9NWK9rRxDKNYe6I27fS+8I=
X-Google-Smtp-Source: APXvYqwipn2DHUUdsHo/Pr1s729I1jj/92rET4LYTTA2InzePp86L3Bj8cmc7wdgQi+T1jNSIJAxBYH7hTTKSIOHG/g=
X-Received: by 2002:a05:6830:1203:: with SMTP id r3mr2842225otp.11.1570628109640;
 Wed, 09 Oct 2019 06:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <a04053d3-6165-5dfa-932c-5a93d2bd1358@einfach.org>
 <CABBYNZLK_rzAf5aPzJHShEVvXSvndZFh5TjyjaaFzAPw_sHoTA@mail.gmail.com> <12b16466-3633-75ff-bf84-9cef44a2358c@einfach.org>
In-Reply-To: <12b16466-3633-75ff-bf84-9cef44a2358c@einfach.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Oct 2019 16:34:57 +0300
Message-ID: <CABBYNZKUmctzTRxix9P-FBK=15v01tkHWMCirFefStpCS2ukBQ@mail.gmail.com>
Subject: Re: bluetoothd: Please don't filter UUIDs
To:     Bruno Randolf <br1@einfach.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bruno,

On Wed, Oct 9, 2019 at 4:09 PM Bruno Randolf <br1@einfach.org> wrote:
>
> On 03/10/2019 14:04, Luiz Augusto von Dentz wrote:
> > Well I guess you are forgetting that other users of the GATT may
> > interfere with plugin which is why we do the claim APIs in the first
> > place.
>
> Okay, I understand your arguments from your perspective, which seems to
> focus on specific use cases with Desktop Linux.
>
> But how do you suppose should application programmers or solution
> providers access GATT characteristics under Linux in a predictable way
> then? Not using BlueZ does not seem like a realistic option. Building
> patched versions of bluetoothd isn't practical either.

Right, so I assume then every application interested on battery would
then attempt to subscribe for the battery level on the own instead of
using org.bluez.Battery1? Either way that would be done via D-Bus but
dealing with a characteristic seem quite a bit more expensive not to
mention is another object the daemon has to maintain.

> At the very least there should be a build option to deactivate all
> plugins, but I think something more flexible would be better. Could it
> be a user choice? E.g. only claim services which the User has actively
> connected to and activated that service?

There are runtime switches to disable plugins i.e.: bluetoothd -P
battery and we can add build time switches as well, btw patches are
welcome if you want to disable battery plugin.

> In general I don't need to poll the battery status of every device I
> happened to connect to, even though it might export a Battery service...
> so I'd consider it more traffic if BAS is polled even though I didn't
> ask for it. On the other hand on a Bluetooth device I have paired with,
> something like a Headphone or Keyboard it obviously is the right choice.

If the system don't have any need for battery it can disable it just
like I said, but depending on the system it is probably better to
leave the daemon to subscribe since there could be several
applications interested on the battery status, simply reading
org.bluez.Battery1 is a _lot_ simpler than enumerating all attributes
and then subscribing to one characteristic.

> I hope there is a way to support both use cases.

There should be but it up for the system to decide if it wants a
dedicated plugin to deal with the battery status or not, for the
desktop usecase it is most likely simpler to support.

> Regards,
> bruno
>
> >> It surely makes sense to provide this more generic API, but I'd argue
> >> that all services and characteristics should be available via the normal
> >> GATT-based API using org.bluez.GattCharacteristic1 as well.
> >
> > Not if the service has security implication, for instance we don't
> > want application to be able to access the keys presses coming from a
> > HoG device, or other things like changing the settings bluetoothd has
> > configured.
> >
> >> One of my clients, for example, uses Linux/bluez as an interface for
> >> Server-based reading and writing of GATT characteristics of several
> >> managed devices. So I can read all those UUIDs, but why not the battery
> >> level? What happens when Bluez learns other GATT services, will their
> >> characteristics then also disappear? I think there is a strong argument
> >> for maintaining a generic API for GATT reading/writing characteristics
> >> independently.
> >
> > But there is even a stronger argument if something breaks because the
> > app access something it shouldn't, even if there are no conflicts
> > between the plugin the very least it would cause is duplicating the
> > traffic.
> >
> >> I made the following change to the bluetoothd code to get access again
> >> to all UUIDs, and I would like you to consider to include it upstream to
> >> enable us to access all characteristics via the normal GATT API:
> >>
> >> --- a/src/gatt-client.c
> >> +++ b/src/gatt-client.c
> >> @@ -2006,9 +2006,6 @@ static void export_service(struct
> >> gatt_db_attribute *attr, void *user_data)
> >>         struct btd_gatt_client *client = user_data;
> >>         struct service *service;
> >>
> >> -       if (gatt_db_service_get_claimed(attr))
> >> -               return;
> >> -
> >>         service = service_create(attr, client);
> >>         if (!service)
> >>                 return;
> >>
> >> Thank you,
> >> bruno
> >>
> >>
> >> [1] I published parts of that as an open source library:
> >> https://github.com/infsoft-locaware/blzlib
> >>
> >> [2]
> >> https://stackoverflow.com/questions/49078659/check-battery-level-of-connected-bluetooth-device-on-linux
> >>
> >>
> >
> >



-- 
Luiz Augusto von Dentz
