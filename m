Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB842C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 22:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjC3W0D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjC3W0B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 18:26:01 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D609BCA31
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:25:59 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id e9so5905426ljq.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680215158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PgkNQgo8x0DC6BNHtD9VdT/F1pDHbNRv8SasvQmLCM=;
        b=LG6cG8uddXcDf2n33RE7IBBrWMcUsPdFXWCfBghn9+9yT+S8rcraU8Lth8d5EpjLG7
         n9MhyLHoihwj89P+L8oUD4xpoFIpnX0KQFDh2YW1gVTwTEQ8Pr1GGYvV8wrcokoOtWFT
         UNQ3NwFtx50GMTqHk84eWAIS+bZimOiM4rO/iCGFVC7bDCkl27xi8h0Jnw7nIW3gmtqu
         YJ152l4rRwrxE9PBzd2sr5Z0UiIikF+F7hFSh8MYXOteNDPYCi2ffEpo0ZDA8Th16y/0
         Om0nCqSEoWo+kNQZ58bvk2DzpsAXyd7PtMsJkIATHukf6tGFN72mnTdZk0QTaK7L00+D
         a41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680215158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PgkNQgo8x0DC6BNHtD9VdT/F1pDHbNRv8SasvQmLCM=;
        b=IZCM1k0rmQS48qvdDb8Ycee5TICqOV5Vb9QQZYji+48Zetp76J+BjtMh1QA9e5VATC
         SUQMpOKpZ5PXibgy+3vd5bqjC7lHcthSf+j4Lp/zFHEjEL+6IdnzNiCVv89/lM6EaF+C
         vBXZYnln7Hbw42pVO/0clC5KbqXvkAJNczXl50iyzlw88TuONT8OiHoZNtPxayJjnuK9
         SfXQ7i8juWp9PO5O2E42FRqjEEZ3tR/bEU9DIvSexL5z8H4PkoTLHYp57BVTFGQqM6o5
         CDPPD27s4D3LVcwfuKGAVijqcM9QgRMb4YYa82YOuLX8ebdTP/QlCXLziKWzyS1cHftv
         AzzA==
X-Gm-Message-State: AAQBX9c4AOqrIIZIhxeVAC+/HuOIpO7Y4xD266jdRCaFc447Eu4E0RK0
        WLmuE/plIIZC5FEXZrQhkuPG+qHlY5YVcMDXKFuAQUuQ3o8=
X-Google-Smtp-Source: AKy350bY5dYSdxVnG9MyeeUIqI00IO13MafvqdMIyHKDZuRe508w2rBl3oA+pk/N+FSo+Q9tfX71SNU/ivWmgSDIb54=
X-Received: by 2002:a2e:a307:0:b0:2a6:18c0:2b41 with SMTP id
 l7-20020a2ea307000000b002a618c02b41mr1318102lje.0.1680215157568; Thu, 30 Mar
 2023 15:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230330211233.102136-1-hdegoede@redhat.com> <39877b39f5575cbfc89e567cb082741b47d02654.camel@hadess.net>
In-Reply-To: <39877b39f5575cbfc89e567cb082741b47d02654.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 30 Mar 2023 15:25:46 -0700
Message-ID: <CABBYNZ+K9tD3mBNvyzJE0Ls8mqy8N+rjysApc9fR+jZLDMiLcQ@mail.gmail.com>
Subject: Re: [PATCH] adapter: Use regular discovery for filters which only
 have discoverable set
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Thu, Mar 30, 2023 at 3:08=E2=80=AFPM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> Top posting to comment on the subject. It should have "[BlueZ PATCH]"
> as the prefix so that the user-space CI runs on it.

It should be fine in this case CI seem to have figured it out without it:

https://patchwork.kernel.org/project/bluetooth/patch/20230330211855.102798-=
1-hdegoede@redhat.com/

> On Thu, 2023-03-30 at 23:12 +0200, Hans de Goede wrote:
> > discovery_filter_to_mgmt_cp() does not add
> > discovery_filter.discoverable
> > to the created mgmt_cp_start_service_discovery struct.
> >
> > Instead update_discovery_filter() seprately checks
> > client->discovery_filter->discoverable for all clients.
>
> "separately".
>
> > This means that for discovery-filters which only have the
> > discoverable
> > flag set, to put the adapter in discoverable mode while discovering,
> > the created mgmt_cp_start_service_discovery struct is empty.
> >
> > This empty mgmt_cp_start_service_discovery struct then gets send
>
> "sent"
>
> > to the kernel as part of a MGMT_OP_START_SERVICE_DISCOVERY msg
> > by start_discovery_timeout().
> >
> > This use of an empty filter with MGMT_OP_START_SERVICE_DISCOVERY
> > causes some bluetooth devices to not get seen with some (most?)
> > Broadcom bluetooth adapters. This problem has been observed with
> > the following Broadcom models: BCM4343A0, BCM43430A1, BCM43341B0 .
> >
> > On these models the following 2 devices were not being discovered
> > when starting a scan with a filter with just discoverable set
> > in the filter (as gnome-bluetooth does):
> >
> > Device 09:02:01:03:0F:87 (public)
> >         Name: Bluetooth 3.0 Keyboard
> >         Alias: Bluetooth 3.0 Keyboard
> >         Class: 0x00000540
> >         Icon: input-keyboard
> >         Paired: yes
> >         Bonded: yes
> >         Trusted: yes
> >         Blocked: no
> >         Connected: yes
> >         WakeAllowed: yes
> >         LegacyPairing: yes
> >         UUID: Service Discovery Serve.. (00001000-0000-1000-8000-
> > 00805f9b34fb)
> >         UUID: Human Interface Device... (00001124-0000-1000-8000-
> > 00805f9b34fb)
> >         UUID: PnP Information           (00001200-0000-1000-8000-
> > 00805f9b34fb)
> >         Modalias: bluetooth:v05ACp022Cd011B
> >
> > Device 00:60:D1:00:00:34 (public)
> >         Name: Bluetooth Mouse
> >         Alias: Bluetooth Mouse
> >         Class: 0x00002580
> >         Icon: input-mouse
> >         Paired: yes
> >         Bonded: yes
> >         Trusted: yes
> >         Blocked: no
> >         Connected: yes
> >         WakeAllowed: yes
> >         LegacyPairing: no
> >         UUID: Human Interface Device... (00001124-0000-1000-8000-
> > 00805f9b34fb)
> >         UUID: PnP Information           (00001200-0000-1000-8000-
> > 00805f9b34fb)
> >         Modalias: usb:v0103p0204d001E
> >
> > Since setting the discoverable flag on a filter only is a way to
> > automatically put the adapter in discoverable mode itself while
> > it is discovering; and since this does not any device filtering
> > at all; modify merge_discovery_filters() to treat discovery with
> > such filters as regular unfiltered discovery.
> >
> > This results in start_discovery_timeout() starting regular
> > discovery through a MGMT_OP_START_DISCOVERY message and this
> > fixes these 2 example devices not getting discovered by the
> > mentioned Broadcom BT adapter models.
> >
> > Link:
> > https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/merge_requests/163
> > ---
> > Note the same argument can be made for the pattern and duplicate part
> > of
> > the filters which also get handled outside of the kernel filter.
> > But I prefer to keep the first patch small and targetted at solving
> > things
> > not working with the gnome-bluetooth filter settings.
> >
> > Also I'm not familiar enough with the code to say with certainty that
> > filters with just a pattern or the duplicate flag set (or a
> > combination)
> > should also be treated as unfiltered discovery.
> > ---
> >  src/adapter.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 7947160a6..cc7f891d9 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -2192,6 +2192,7 @@ static int merge_discovery_filters(struct
> > btd_adapter *adapter, int *rssi,
> >         bool empty_uuid =3D false;
> >         bool has_regular_discovery =3D false;
> >         bool has_filtered_discovery =3D false;
> > +       uint8_t adapter_scan_type =3D get_scan_type(adapter);
> >
> >         for (l =3D adapter->discovery_list; l !=3D NULL; l =3D
> > g_slist_next(l)) {
> >                 struct discovery_client *client =3D l->data;
> > @@ -2202,6 +2203,20 @@ static int merge_discovery_filters(struct
> > btd_adapter *adapter, int *rssi,
> >                         continue;
> >                 }
> >
> > +               /*
> > +                * Detect empty filter with only discoverable
> > +                * (which does not require a kernel filter) set.
> > +                */
> > +               if (item->uuids =3D=3D NULL &&
> > +                   item->pathloss =3D=3D DISTANCE_VAL_INVALID &&
> > +                   item->rssi =3D=3D DISTANCE_VAL_INVALID &&
> > +                   item->type =3D=3D adapter_scan_type &&
> > +                   item->duplicate =3D=3D false &&
> > +                   item->pattern =3D=3D NULL) {
>
> I would have split this chunky "if" into a separate function, but
> otherwise the logic looks good.
>
> Reviewed-by: Bastien Nocera <hadess@hadess.net>
>
> > +                       has_regular_discovery =3D true;
> > +                       continue;
> > +               }
> > +
> >                 has_filtered_discovery =3D true;
> >
> >                 *transport |=3D item->type;
> > @@ -2251,7 +2266,7 @@ static int merge_discovery_filters(struct
> > btd_adapter *adapter, int *rssi,
> >                  * It there is both regular and filtered scan
> > running, then
> >                  * clear whole fitler to report all devices.
> >                  */
> > -               *transport =3D get_scan_type(adapter);
> > +               *transport =3D adapter_scan_type;
> >                 *rssi =3D HCI_RSSI_INVALID;
> >                 g_slist_free(*uuids);
> >                 *uuids =3D NULL;
>


--=20
Luiz Augusto von Dentz
