Return-Path: <SRS0=BBV2=6L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CC1C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 17:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703B420738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 17:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDf2QB08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgD0RTG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgD0RTF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Apr 2020 13:19:05 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089FAC0610D5
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 10:19:05 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g19so27510175otk.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ceKPg61AsVaTacet3A4zvMXMR0GDk0sXth07QgSYNjA=;
        b=MDf2QB089XzCECnkY1IUJbUZs6RBDM73nNG0Z4IckIDtIK75HgfHslG8P7vabXYdsV
         iTuUFXjFeVYgCZC9647OgXlz9KB+78Q5Bhfu/fC977b946MbTIZKf7UgcMysTD6X/j31
         kIfClvaSH3LC2glorVHb9fchJhqPz/gKAYAHZuQdH6adhLFfSX2LiNSXj5h5RWa2ut4I
         EKfBYOcYH0a+ZpOGUd3QGlhXFLi+wxJ6T0TKSSw8hVAMCCUM74BmzQCmHKGfS/Fvt4SU
         SVFwuNGPphV1AsLg2u0uqFhd1i2yCJRWfoQ41TR4G719OtSU3l7ucqMWWGGYJqp+WJKe
         jTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ceKPg61AsVaTacet3A4zvMXMR0GDk0sXth07QgSYNjA=;
        b=FRjRrwqhEb9l4l09oTGrWg1iuoeYmd0MfnSHNz8Nf4jLXyTtTTW+jebkOHOaUAutVr
         uclJG+/IwbGFUhv2g1Hcwe2felxCSCzCYd0j8CPBlL4p8OgzNpReN2h+6NbE7sfWDvYW
         I8MPt+05NtuKk2j3wQ/Zl1PG7yQCB/QGAkHdbsbPt8tBiQTE9ZRNXk1mYlouYc9fPhFr
         nx9A6EurjRFt/ISCttnX+Mvq40DdZ+NcWguBdfPhhVkN2SF4MaQap4OqHTJVH7iR0UwD
         K9nE7L6Zn80BXVjADFp9rRUIhVlPp8wqHvfjje86jJx6h6NccybJhlyCv+s/aBv6QaMk
         23hg==
X-Gm-Message-State: AGi0Pube/v7i5Mxt+wKrh0sQ1W8/ExobipFNcuOvcCl76FDAUYQOGsOy
        3V/cY75Wg/zEt17hEsalOqv/wyGAt4CI6pSZ0K1DxRi2uDg=
X-Google-Smtp-Source: APiQypII7kFWQ+s5ohSOLB7t1PBBSfA+zGTlS2YH3tmuNair6FFsngfaTVCMcV+mDytMhPlDaft56O+xcUkFR7lBqHQ=
X-Received: by 2002:a9d:57cb:: with SMTP id q11mr12188203oti.11.1588007944359;
 Mon, 27 Apr 2020 10:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <319b239d-3739-63e9-9fe4-f8b4215097b2@vontaene.de>
In-Reply-To: <319b239d-3739-63e9-9fe4-f8b4215097b2@vontaene.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Apr 2020 10:18:52 -0700
Message-ID: <CABBYNZ+1DytMUg6B7CrGNaNTz55_a6EDQAL58gD_xq4upz0Ctw@mail.gmail.com>
Subject: Re: HID device with multiple collections does not work
To:     Erik Andresen <erik@vontaene.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Erik,

On Thu, Apr 23, 2020 at 11:07 AM Erik Andresen <erik@vontaene.de> wrote:
>
> Hi,
>
>
> I have a simple bluetooth hid device which does work in Android but not w=
ith Linux 4.19/Bluez 5. It does have two collections in its hid description=
:
> 0xA1, 0x01,        // Collection (Application)
> 0x85, 0x02,        //   Report ID (2)
> (...)
> 0xC0,              // End Collection
> 0xA1, 0x01,        // Collection (Application)
> 0x85, 0x01,        //   Report ID (1)
> (...)
> 0xC0,              // End Collection
>
> Complete description is attached.
>
> Since there are multiple collections I understand that every report has t=
o be prefixed with the id, so I send
> [2,0,0,0x52,0,0,0,0,0] (9 bytes) for the keycode 0x52, ID is 2.
>
> Output from btmon is:
> > ACL Data RX: Handle 3585 flags 0x02 dlen 16                            =
                                                                           =
                                                                           =
                          #2072 [hci0] 485.047387
>        ATT: Handle Value Notification (0x1b) len 11
>          Handle: 0x0015
>            Data: 020000520000000000
>
> This looks good for me so far, unfortunately Linux does not pick it up, i=
n dmesg I get:
> drivers/hid/hid-core.c: undefined report_id 0 received
>
> cat /sys/kernel/debug/hid/0005:0000:0000.000=C2=AD3/events # gives me:
> report (size 10) (numbered) =3D 00 02 00 00 52 00 00 00 00 00
> so I get 10 bytes instead the 9 I send
>
> So far I traced it to hog-lib.c, report_value_cb() of bluez where this ex=
tra 0 is prepended in the if (hog->has_report_id) block.
> report->id is 0 at this point. If I skip this extra addition of the zero =
or manually set id=3D2 here it works as expected. Does someone has an idea =
what I do wrong or what I'm missing?

Afaik each report ID will need to have its own characteristic, at
least that is how HIDS has put the spec, but if I got you right the
report->id is never initialized on report_reference_cb so this might
be how Android is detecting if there is a report ID or not, we should
be able to confiirm this if we have access to the HCI trace when
discovering the services.

> greetings,
> Erik Andresen



--=20
Luiz Augusto von Dentz
